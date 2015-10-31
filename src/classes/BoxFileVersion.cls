public class BoxFileVersion extends BoxResource {
	
	private static String VIEW_FILE_VERSIONS_URL = 'files/{0}/versions';
    private static String FILE_VERSIONS_URL = 'files/{0}/versions/{1}';
    private static String FILE_PROMOTE_VERSION_URL = 'files/{0}/versions/current';
    
	
    public BoxFileVersion(BoxApiConnection api, String id) {
        super(api, id);
    }
    
    public override String getObjectType() {
        return 'fileversion';
    }
    
    public override void setInfo(BoxJsonObject jsonObject) {
        this.information = (BoxFileVersion.Info) jsonObject;
    }
    
    public Boolean deleteVersion(string versionId) {
		return this.deleteVersion(versionId, null);
	}
	
    public Boolean deleteVersion(String versionId, String eTag) {	
    	String url = this.api.baseUrl + String.format(FILE_VERSIONS_URL, new String[] {this.getId(), versionId});
		BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_DELETE);
		
		if(eTag != null) {
			BoxGenericJsonObject jsonObject = new BoxGenericJsonObject();
			jsonObject.addValue('eTag', eTag);
			request.setBody(jsonObject.getJsonString());
		}
		
		request.setTimeout(this.api.timeout);
		request.addJsonContentTypeHeader();
		
		HttpResponse response = request.send();
		return BoxApiRequest.ensureBoxResourceResponseCode(response, 'BoxFile.deleteVersion', new set<Integer> {204});
    }

  	public BoxFileVersion.Info promoteFileVersion(String versionId) {	
  		return this.promoteVersion('file_version', versionId);
  	}
  	
  	public BoxFileVersion.Info promoteVersion(String itemType, String versionId) {	
    	String url = this.api.baseUrl + String.format(FILE_PROMOTE_VERSION_URL, new String[] {this.getId()});
		BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_POST);
		
		BoxGenericJsonObject jsonObject = new BoxGenericJsonObject();
		jsonObject.addValue('type', itemType);
		jsonObject.addValue('id', versionId);
		request.setBody(jsonObject.getJsonString());
		
		request.setTimeout(this.api.timeout);
		request.addJsonContentTypeHeader();
		
		HttpResponse response = request.send();
		String responseBody = BoxApiRequest.getBoxResourceResponseBody(response, 'BoxFileVersion.promoteVersion');
		return new BoxFileVersion.Info(responseBody);
    }
     
    public class Info extends BoxResource.Info {
    	
    	public final String fileID;
  	    public String versionID;
    	public String sha1;
    	public String name;
    	public long size;
    	public DateTime createdAt;
    	public DateTime modifiedAt;
    	public BoxUser.Info modifiedBy;	
     
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
    	
        @testvisible
     	private void parseMember(String key, String value) {
      		if (key != null) {
                if (key == 'id') {
                	this.versionID = value;
                } else if (key == 'sha1') {
                    this.sha1 = value;
                } else if (key == 'name') {
                    this.name = value;
                } else if (key == 'size') {
                    this.size = long.valueOf(value);
                } else if (key == 'created_at') {
                    this.createdAt = BoxDateFormat.parseBoxDateTimeString(value);
                } else if (key == 'modified_at') {
                    this.modifiedAt = BoxDateFormat.parseBoxDateTimeString(value);
                } else if (key == 'modified_by') {
                	this.modifiedBy = new BoxUser.Info(value);
                }
      		}
     	}
    }
}