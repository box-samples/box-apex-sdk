public class BoxUploadEmail extends BoxResource {

    public BoxUploadEmail(BoxApiConnection api, String id) {
        super(api, id);
    }

    public override String getObjectType() {
        return 'uploademail';
    }

    public override void setInfo(BoxJsonObject jsonObject) {
        this.information = (BoxUploadEmail.Info) jsonObject;
    }

    public class Info extends BoxResource.Info {

        public BoxUploadEmail.Access access {get; private set;}
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

        @testvisible
        private void parseMember(String key, String value) {
            super.parseResourceMember(key, value);
            if (key != null) {
                if (key == 'access') {
                    this.access = BoxUploadEmail.parseAccess(value);
                } else if (key == 'email') {
                    this.email = value;
                }
            }
        }
    }

    public enum Access {
        /**
         * Anyone can send an upload to this email address.
         */
        OPEN,

        /**
         * Only collaborators can send an upload to this email address.
         */
        COLLABORATORS
    }

    public static BoxUploadEmail.Access parseAccess(String value) {
        if (value == 'open') {
            return BoxUploadEmail.Access.OPEN;
        } else if (value == 'collaborators') {
            return BoxUploadEmail.Access.COLLABORATORS;
        }
        return null;
    }

    public static String getAccessAsString(BoxUploadEmail.Access value) {
        if (value == BoxUploadEmail.Access.OPEN) {
            return 'open';
        } else if (value == BoxUploadEmail.Access.COLLABORATORS) {
            return 'collaborators';
        }
        return null;
    }
}