public class BoxGroup extends BoxCollaborator {
    
    public BoxGroup(BoxApiConnection api, String id) {
        super(api, id);
    }
    
    public override String getObjectType() {
        return 'group';
    }
    
    public override void setInfo(BoxJsonObject jsonObject) {
        this.information = (BoxGroup.Info) jsonObject;
    }
    
    public class Info extends BoxCollaborator.Info {
        public Info() {
            super();
        }
        
        public Info(String jsonString) {
            super(jsonString);
        }
        
        public Info(BoxJsonObject jsonObject) {
            super(jsonObject);
        }
    }
   

}