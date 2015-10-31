public class BoxFile extends BoxItem {
    public static final list<String> ALL_FIELDS = new list<String> {'type', 'id', 'sequence_id', 'etag', 'sha1', 'name', 'description',
        'size', 'path_collection', 'created_at', 'modified_at', 'trashed_at', 'purged_at', 'content_created_at',
        'content_modified_at', 'created_by', 'modified_by', 'owned_by', 'shared_link', 'parent', 'item_status',
        'version_number', 'comment_count', 'permissions', 'tags', 'lock', 'extension', 'is_package', 'file_version'};
    
    private static String COPY_FILE_URL = 'files/{0}/copy';
    private static String FILE_INFO_URL = 'files/{0}';
    private static String GET_COMMENTS_URL = 'files/{0}/comments';
    private static String GET_VERSIONS_URL = 'files/{0}/versions';
    private static string ADD_COMMENT_URL =  'comments';
    
    public BoxFile(BoxApiConnection api, String id) {
        super(api, id);
        this.information = new BoxFile.Info();
    }
    
    public override String getObjectType() {
        return 'file';
    }
    
    public override void setInfo(BoxJsonObject jsonObject) {
        this.information = new BoxFile.Info(jsonObject);
    }
    
    public BoxFile.Info getFileInfo() {
        String url = this.api.baseUrl + String.format(FILE_INFO_URL, new String[] {this.getId()});
        BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_GET);
        request.setTimeout(this.api.timeout);
        request.addJsonContentTypeHeader();
        
        HttpResponse response = request.send();
        String responseBody = BoxApiRequest.getBoxResourceResponseBody(response, 'BoxFile.getFileInfo');
        return new BoxFile.Info(responseBody);
    }
    
    public BoxFile.Info updateFileInfo(BoxFile.Info info) {
        String url = this.api.baseUrl + String.format(FILE_INFO_URL, new String[] {this.getId()});
        BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_PUT);
        request.setTimeout(this.api.timeout);
        request.addJsonContentTypeHeader();
        request.setBody(info.getJsonString());
        
        HttpResponse response = request.send();
        String responseBody = BoxApiRequest.getBoxResourceResponseBody(response, 'BoxFile.Info');
        BoxFile.Info fileInfo = new BoxFile.Info(responseBody);
        this.setInfo(fileInfo);
        return fileInfo;
	}
	
	// ToDo
	//public BoxSharedLink.Info createSharedLink() {
	//}
    
    public override BoxItem.Info copy(BoxFolder destination) {
        return this.copy(destination, null);
    }
	
	public override BoxItem.Info copy(BoxFolder destination, String newName) {
		String url = this.api.baseUrl + String.format(COPY_FILE_URL, new String[] {this.getId()});
		BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_POST);
		
		BoxFolder.Info parent = new BoxFolder.Info();
		parent.addValue('id', destination.getId());
		
		BoxFile.Info copyInfo = new BoxFile.Info();
		copyInfo.addValue('parent', parent.getJsonString());
		if (newName != null) {
			copyInfo.addValue('name', newName);
		}
		
		request.setBody(copyInfo.getJsonString());
		request.setTimeout(this.api.timeout);
		request.addJsonContentTypeHeader();
		
		HttpResponse response = request.send();
		String responseBody = BoxApiRequest.getBoxResourceResponseBody(response, 'BoxFile.copy');
		return new BoxFile.Info(responseBody);
	}
	
	public override BoxItem.Info move(BoxFolder destination) {
		return this.move(destination, null);
	}
	
	public override BoxItem.Info move(BoxFolder destination, String newName) {
		String url = this.api.baseUrl + String.format(FILE_INFO_URL, new String[] {this.getId()});
		BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_PUT);
		
		BoxFolder.Info parent = new BoxFolder.Info();
		parent.addValue('id', destination.getId());
		
		BoxFile.Info moveInfo = new BoxFile.Info();
		moveInfo.addValue('parent', parent.getJsonString());
		if (newName != null) {
			moveInfo.addValue('name', newName);
		}
		
		request.setBody(moveInfo.getJsonString());
		request.setTimeout(this.api.timeout);
		request.addJsonContentTypeHeader();
		
		HttpResponse response = request.send();
		String responseBody = BoxApiRequest.getBoxResourceResponseBody(response, 'BoxFile.move');
		return new BoxFile.Info(responseBody);
	}
	
	public Boolean deleteFile() {
		return this.deleteFile(null);
	}
	
	public Boolean deleteFile(string eTag) {
		String url = this.api.baseUrl + String.format(FILE_INFO_URL, new String[] {this.getId()});
		BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_DELETE);
		
		BoxFile.Info fileInfo = new BoxFile.Info();
		fileInfo.addValue('id', this.getId());
		if(eTag != null) {
			fileInfo.addValue('eTag', eTag);
		}
		
		request.setBody(fileInfo.getJsonString());
		request.setTimeout(this.api.timeout);
		request.addJsonContentTypeHeader();
		
		HttpResponse response = request.send();
		return BoxApiRequest.ensureBoxResourceResponseCode(response, 'BoxFile.deleteFile', new set<Integer> {204});
	}
	
	public Boolean rename(string newName) {
		String url = this.api.baseUrl + String.format(FILE_INFO_URL, new String[] {this.getId()});
		BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_PUT);
		
		BoxFile.Info fileInfo = new BoxFile.Info();
		fileInfo.addValue('id', this.getId());
		if(newName != null) {
			fileInfo.addValue('name', newName);
		}
		
		request.setBody(fileInfo.getJsonString());
		request.setTimeout(this.api.timeout);
		request.addJsonContentTypeHeader();
		
		HttpResponse response = request.send();
		
		return BoxApiRequest.ensureBoxResourceResponseCode(response, 'BoxFile.rename', new set<Integer> {200});
	}
	
	/**
     * Gets a list of comments on BoxFile.
     * @return a list of comments on BoxFile.
     */
	public list<BoxComment.Info> getComments() {
		String url = this.api.baseUrl + String.format(GET_COMMENTS_URL, new String[] {this.getId()});
		BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_GET);
		
		request.setTimeout(this.api.timeout);
		request.addJsonContentTypeHeader();
		
		HttpResponse response = request.send();
		String responseBody = BoxApiRequest.getBoxResourceResponseBody(response, 'BoxFile.getComments');
		
		BoxGenericJsonObject responseObject = new BoxGenericJsonObject(responseBody);
        list<String> commentEntries = BoxJsonObject.parseJsonObjectArray(responseObject.getValue('entries'));
        list<BoxComment.Info> comments = new list<BoxComment.Info>();
        for (String commentEntry : commentEntries) {
        	comments.add(new BoxComment.Info(commentEntry));
        }
        return comments;
	}
	
	/**
     * Gets any previous versions of this file. 
     * @return a list of previous file versions.
     */
	public list<BoxFileVersion.Info> getVersions() {
		String url = this.api.baseUrl + String.format(GET_VERSIONS_URL, new String[] {this.getId()});
		BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_GET);

		request.setTimeout(this.api.timeout);
		request.addJsonContentTypeHeader();

		HttpResponse response = request.send();
		String responseBody = BoxApiRequest.getBoxResourceResponseBody(response, 'BoxFile.getVersions');
		
		BoxGenericJsonObject responseObject = new BoxGenericJsonObject(responseBody);
        list<String> versionEntries = BoxJsonObject.parseJsonObjectArray(responseObject.getValue('entries'));
        list<BoxFileVersion.Info> versions = new list<BoxFileVersion.Info>();
        for (String versionEntry : versionEntries) {
        	versions.add(new BoxFileVersion.Info(versionEntry));
        }
        return versions;
	}
	
	/**
     * Adds a comment to this file. The message can contain @mentions by using the string @[userid:username] anywhere
     * within the message, where userid and username are the ID and username of the person being mentioned.
     * @see    <a href="https://developers.box.com/docs/#comments-add-a-comment-to-an-item">the tagged_message field
     *         for including @mentions.</a>
     * @param  message the comment's message.
     * @return information about the newly added comment.
     */
    public BoxComment.Info addComment(String message) {
    	String url = this.api.baseUrl + String.format(ADD_COMMENT_URL, new String[] {this.getId()});
		BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_POST);
    	
    	BoxGenericJsonObject itemObject = new BoxGenericJsonObject();
		itemObject.addValue('type', 'file');
        itemObject.addValue('id', this.getId());
		
		BoxComment.Info commentInfo = new BoxComment.Info();
		commentInfo.addValue('item', itemObject);
		
		if (BoxComment.messageContainsMention(message)) {
            commentInfo.addValue('tagged_message', message);
        } else {
            commentInfo.addValue('message', message);
        }
		
		request.setBody(commentInfo.getJsonString());
		request.setTimeout(this.api.timeout);
		request.addJsonContentTypeHeader();
		
		HttpResponse response = request.send();
		String responseBody = BoxApiRequest.getBoxResourceResponseBody(response, 'BoxFile.addComment');
		return new BoxComment.Info(responseBody);
    }
    
    public class Info extends BoxItem.Info {
    	public String sha1;
        public String versionNumber;
        public long commentCount;
        //ToDo: Java SDK has EnumSet<Permission>, whats apex equivalent of EnumSet?
        //private enum<Permission> permissions;
        public String extension;
        public boolean isPackage;
        public BoxFileVersion version;
        
        public Info() {
            super();
        }
        
        public Info(String jsonString) {
            super(jsonString);
            for (String key : this.children.keySet()) {
           		this.parseMember(key, this.children.get(key));
            }
        }
        
        public Info(BoxJsonObject jsonObject) {
            super(jsonObject);
            for (String key : this.children.keySet()) {
            	this.parseMember(key, this.children.get(key));
            }
        }
        
        public override void addValue(String key, String value) {
        	super.addValue(key, value);
        	if (key != null) {
        		this.parseMember(key, value);
        		this.rebuildJsonString = true;
        	}
        }
        
        public override void addValue(String key, BoxJsonObject value) {
        	this.addValue(key, value.getJsonString());
        }
        
        private void parseMember(String key, String value) {
        	super.parseItemMember(key, value);
        	if (key != null) {
                if (key == 'sha1') {
                	this.sha1 = value;
                }else if (key == 'version_number') {
                    this.versionNumber = value;
                } else if (key == 'comment_count') {
                    this.commentCount = long.valueOf(value);
                } else if (key == 'extension') {
                	this.extension = value;
                } else if (key == 'is_package') {
                	this.isPackage = Boolean.valueOf(value);
                } else if(key == 'file_version') {
                	this.version = this.parseFileVersion(value);
                }
            }
        }
        
        private BoxFileVersion parseFileVersion(string fileVersions) {
        	//Todo: implement the method after FileVersion class is complete
        	return null;
        }
        
        private BoxFile.Permission parseFilePermissions(String value) {
     		if (value != null) {
            	if (value == 'can_download') {
               		return BoxFile.Permission.CAN_DOWNLOAD;
            	} else if (value == 'can_upload') {
               		return BoxFile.Permission.CAN_UPLOAD;
            	} else if (value == 'can_rename') {
               		return BoxFile.Permission.CAN_RENAME;
            	} else if (value == 'can_delete') {
               		return BoxFile.Permission.CAN_DELETE;
            	} else if (value == 'can_share') {
               		return BoxFile.Permission.CAN_SHARE;
            	} else if (value == 'can_set_share_access') {
               		return BoxFile.Permission.CAN_SET_SHARE_ACCESS;
            	} else if (value == 'can_preview') {
               		return BoxFile.Permission.CAN_PREVIEW;
            	} else if (value == 'can_comment') {
               		return BoxFile.Permission.CAN_COMMENT;
            	}
           }
           return null;
       }
    }
    
    /**
     * Enumerates the possible permissions that a user can have on a file.
     */
    public enum Permission {
        /**
         * The user can download the file.
         */
        CAN_DOWNLOAD,

        /**
         * The user can upload new versions of the file.
         */
        CAN_UPLOAD,

        /**
         * The user can rename the file.
         */
        CAN_RENAME,

        /**
         * The user can delete the file.
         */
        CAN_DELETE,

        /**
         * The user can share the file.
         */
        CAN_SHARE,

        /**
         * The user can set the access level for shared links to the file.
         */
        CAN_SET_SHARE_ACCESS,

        /**
         * The user can preview the file.
         */
        CAN_PREVIEW,

        /**
         * The user can comment on the file.
         */
        CAN_COMMENT
	}
}