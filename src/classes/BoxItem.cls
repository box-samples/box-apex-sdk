public abstract class BoxItem extends BoxResource {
    public static final list<String> ALL_FIELDS = new list<String> 
        {'type', 'id', 'sequence_id', 'etag', 'sha1', 'name', 'description',
        'size', 'path_collection', 'created_at', 'modified_at', 'trashed_at', 'purged_at', 'content_created_at',
        'content_modified_at', 'created_by', 'modified_by', 'owned_by', 'shared_link', 'parent', 'item_status',
        'version_number', 'comment_count', 'permissions', 'tags', 'lock', 'extension', 'is_package',
        'folder_upload_email', 'item_collection', 'sync_state', 'has_collaborations', 'can_non_owners_invite',
        'file_version'};
        
    
    public BoxItem(BoxApiConnection api, String id) {
        super(api, id);
    }
    
    public static BoxItem.Info getSharedItem(BoxApiConnection api, String sharedLink) {
        return getSharedItem(api, sharedLink, null);
    }
    
    public static BoxItem.Info getSharedItem(BoxApiConnection api, String sharedLink, String password) {
        return null;
    }
  
    /**
     * Copies this item to another folder.
     * @param  destination the destination folder.
     * @return             info about the copied item.
     */    
    public abstract BoxItem.Info copy(BoxFolder destination);
    
    /**
     * Copies this item to another folder and gives it a new name. If the destination is the same folder as the item's
     * current parent, then newName must be a new, unique name.
     * @param  destination the destination folder.
     * @param  newName     a new name for the copied item.
     * @return             info about the copied item.
     */
    public abstract BoxItem.Info copy(BoxFolder destination, String newName);
    
    /**
     * Moves this item to another folder.
     * @param  destination the destination folder.
     * @return             info about the moved item.
     */
    public abstract BoxItem.Info move(BoxFolder destination);
    
    /**
     * Moves this item to another folder and gives it a new name.
     * @param  destination the destination folder.
     * @param  newName     a new name for the moved item.
     * @return             info about the moved item.
     */
    public abstract BoxItem.Info move(BoxFolder destination, String newName);
        
    public abstract class Info extends BoxResource.Info {
        private String sequenceID;
        private String etag;
        private String name;
        private String description;
        private String itemStatus;
        
        private List<String> tags;
        
        private long size;
        
        private DateTime createdAt;
        private DateTime modifiedAt;
        private DateTime trashedAt;
        private DateTime purgedAt;
        private DateTime contentCreatedAt;
        private DateTime contentModifiedAt;
        
        private BoxUser.Info createdBy;
        private BoxUser.Info modifiedBy;
        private BoxUser.Info ownedBy;
        
        private List<BoxFolder.Info> pathCollection;
        
        //private BoxSharedLink sharedLink;
        
        private BoxFolder.Info parent;
        
        
        public Info() {
            super();
        }
        
        public Info(String jsonString) {
            super(jsonString);
        }
        
        public Info(BoxJsonObject jsonObject) {
            super(jsonObject);
        }
                
        public String getName() {
            return this.name;
        }
        
        protected void parseItemMember(String key, String value) {
            super.parseResourceMember(key, value);
            if (key != null) {
                if (key == 'sequence_id') {
                	this.sequenceId = value;
                }else if (key == 'etag') {
                    this.etag = value;
                } else if (key == 'name') {
                    this.name = value;
                } else if (key == 'description') {
                	this.description = value;
                } else if (key == 'item_status') {
                	this.itemStatus = value;
                } else if (key == 'tags') {
                	this.tags = this.parseTags(value);
                } else if (key == 'size') {
                	this.size = long.valueOf(value);
                } else if (key == 'created_at') {
                	this.createdAt = BoxDateFormat.parseBoxDateTimeString(value);
                } else if (key == 'modified_at') {
                	this.modifiedAt = BoxDateFormat.parseBoxDateTimeString(value);
                } else if (key == 'trashed_at') {
                	this.trashedAt = BoxDateFormat.parseBoxDateTimeString(value);
                } else if (key == 'purged_at') {
                	this.purgedAt = BoxDateFormat.parseBoxDateTimeString(value);
                } else if (key == 'content_created_at') {
                	this.contentCreatedAt = BoxDateFormat.parseBoxDateTimeString(value);
                } else if (key == 'content_modified_at') {
                	this.contentModifiedAt = BoxDateFormat.parseBoxDateTimeString(value);
                } 
                
                // todo: add the rest of the values to be evaluated.
            }
        }
        
        private list<String> parseTags(String tagsList) {
        	return parseJsonStringArray(tagsList);
        }
    }
        
}