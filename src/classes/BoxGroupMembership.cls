public class BoxGroupMembership extends BoxResource {
    private static final String MEMBERSHIP_URL_TEMPLATE = 'group_memberships/{0}';
    
    public BoxGroupMembership(BoxApiConnection api, String id) {
        super(api, id);
    }
    
    public override String getObjectType() {
        return 'group_membership';
    }
    
    public override void setInfo(BoxJsonObject jsonObject) {
        this.information = (BoxGroupMembership.Info) jsonObject;
    }
    
    public BoxGroupMembership.Info getMembership() {
    	String url = this.api.getBaseUrl() + String.format(MEMBERSHIP_URL_TEMPLATE, new String[] {this.getId()});
    	BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_GET);
    	request.addJsonContentTypeHeader();
    	request.setTimeout(this.api.getTimeout());
    	
    	HttpResponse response = request.send();
    	String responseBody = BoxApiRequest.getBoxResourceResponseBody(response, 'BoxGroupMembership.getMembership');
    	return new BoxGroupMembership.Info(responseBody);
    }
    
    public BoxGroupMembership.Info updateMembership(BoxGroupMembership.Info infoToUpdate) {
    	String url = this.api.getBaseUrl() + String.format(MEMBERSHIP_URL_TEMPLATE, new String[] {this.getId()});
    	BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_PUT);
    	request.addJsonContentTypeHeader();
    	request.setTimeout(this.api.getTimeout());
    	request.setBody(infoToUpdate.getJsonString());
    	
    	HttpResponse response = request.send();
    	String responseBody = BoxApiRequest.getBoxResourceResponseBody(response, 'BoxGroupMembership.updateMembership');
    	return new BoxGroupMembership.Info(responseBody);
    }
    
    public Boolean deleteMembership() {
    	String url = this.api.getBaseUrl() + String.format(MEMBERSHIP_URL_TEMPLATE, new String[] {this.getId()});
    	BoxApiRequest request = new BoxApiRequest(this.api, url, BoxApiRequest.METHOD_DELETE);
    	request.addJsonContentTypeHeader();
    	request.setTimeout(this.api.getTimeout());
    	
    	HttpResponse response = request.send();
    	return BoxApiRequest.ensureBoxResourceResponseCode(response, 'BoxGroupMembership.deleteMembership', new set<Integer> {204});
    }
    
    public class Info extends BoxResource.Info {
    	
    	public BoxUser.Info userInfo {get; private set;}
    	public BoxGroup.Info groupInfo {get; private set;}
        public Role role {get; private set;}
        public DateTime createdAt {get; private set;}
        public DateTime modifiedAt {get; private set;}

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
        
        @testvisible
        private void parseMember(String key, String value) {
            super.parseResourceMember(key, value);
            if (key != null) {
            	if (key == 'user') {
            		this.userInfo = new BoxUser.Info(value);
            	} else if(key == 'group') {
            	   this.groupInfo = new BoxGroup.Info(value);
            	} else if(key == 'role') {
            		this.role = BoxGroupMembership.parseRole(value);
            	} else if (key == 'created_at') {
                    this.createdAt = BoxDateFormat.parseBoxDateTimeString(value);
                } else if (key == 'modified_at') {
                    this.modifiedAt = BoxDateFormat.parseBoxDateTimeString(value);
                }
            }
        }
    }
    
   /**
     * Enumerates the possible roles that a user can have within a group.
    */
   public enum Role {
        /**
         * The user is an administrator in the group.
         */
        ADMIN,

        /**
         * The user is a regular member in the group.
         */
        MEMBER
    }
    
    public static BoxGroupMembership.Role parseRole(String value) {
		if (value != null) {
			if (value == 'admin') {
               	return BoxGroupMembership.Role.ADMIN;
            } else if  (value == 'member') {
             	return BoxGroupMembership.Role.MEMBER;
            }
     	}
     	return null;
    }
    
    public static String getRoleAsString(BoxGroupMembership.Role value) {
    	if (value == BoxGroupMembership.Role.ADMIN) {
    		return 'admin';
    	} else if (value == BoxGroupMembership.Role.MEMBER) {
    		return 'member';
    	}
    	return null;
    }
}