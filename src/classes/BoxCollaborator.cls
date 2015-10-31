public abstract class BoxCollaborator extends BoxResource {
    public BoxCollaborator(BoxApiConnection api, String id) {
        super(api, id);
    }
    
    
    public abstract class Info extends BoxResource.Info {
        public String name {get; protected set;}
        public DateTime createdAt {get; protected set;}
        public DateTime modifiedAt {get; protected set;}
        
        public Info() {
            super();
        }
        
        public Info(String jsonString) {
            super(jsonString);
        }
        
        public Info(BoxJsonObject jsonObject) {
            super(jsonObject);
        }
                
        protected void parseCollaboratorMember(String key, String value) {
        	super.parseResourceMember(key, value);
        	if (key != null) {
        	    if (key == 'name') {
            		this.name = value;
            	} else if (key == 'created_at') {
            		this.createdAt = BoxDateFormat.parseBoxDateTimeString(value);
            	} else if (key == 'modified_at') {
            		this.modifiedAt = BoxDateFormat.parseBoxDateTimeString(value);
            	}
        	}
        }
    }
}