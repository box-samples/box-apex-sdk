public class BoxEmailAlias extends BoxResource {
    
    public BoxEmailAlias(BoxApiConnection api, String id) {
        super(api, id);
    }
    
    public override String getObjectType() {
        return 'emailalias';
    }
    
    public override void setInfo(BoxJsonObject jsonObject) {
        this.information = (BoxEmailAlias.Info) jsonObject;
    }

    public class Info extends BoxResource.Info {
        public Boolean isConfirmed {get; private set;}
        public String email {get; private set;}
        
        public Info() { 
            super();
        }
        
        public Info(String jsonString) {
            super(jsonString);
        }
        
        public Info(BoxJsonObject jsonObject) {
            super(jsonObject);
        }
        
        public override void addValue(String key, String value) {
            super.addValue(key, value);
            if (key != null) {
                this.parseMember(key, value);
            }
        }
        
        public override void addValue(String key, BoxJsonObject value) {
            this.addValue(key, value.getJsonString());
        }
        
        public void parseMember(String key, String value) {
            super.parseResourceMember(key, value);
            if (key != null) {
                if (key == 'is_confirmed') {
                    this.isConfirmed = Boolean.valueOf(value);
                } else if (key == 'email') {
                    this.email = value;
                }
            }
        }
    }
}