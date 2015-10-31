public class BoxComment extends BoxResource {
	private static Pattern MENTION_REGEX = Pattern.compile('@\\[.+:.+\\]');
	
    public BoxComment(BoxApiConnection api, String id) {
        super(api, id);
    }
    
    public override String getObjectType() {
        return 'comment';
    }
    
    public override void setInfo(BoxJsonObject jsonObject) {
        this.information = (BoxComment.Info) jsonObject;
    }
    
    /**
     * Determines if a comment message contains an @mention.
     * @param  message the comment message.
     * @return true if the message contains an @mention; otherwise false.
     */
    public static boolean messageContainsMention(String message) {
        return MENTION_REGEX.matcher(message).find();
    }

    public class Info extends BoxResource.Info {
    	public String id;
    	public boolean isReplyComment;
        public String message;
        public String taggedMessage;
        public BoxUser.Info createdBy;
        public DateTime createdAt;
        public DateTime modifiedAt;
        public BoxResource.Info item;
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
        
        private void parseMember(String key, String value) {
            if (key != null) {
                if (key == 'is_reply_comment') {
                	this.isReplyComment = Boolean.valueOf(value);
                }else if (key == 'message') {
                    this.message = value;
                } else if (key == 'tagged_message') {
                    this.taggedMessage = value;
                } else if (key == 'created_by') {
                	this.createdBy = new BoxUser.Info(value);
                } else if (key == 'created_at') {       
                	this.createdAt = BoxDateFormat.parseBoxDateTimeString(value);
                } else if (key == 'modified_at') {
                	this.modifiedAt = BoxDateFormat.parseBoxDateTimeString(value);
                } else if (key == 'item') {
                	// If type=file parse item as BoxFile.Info  
                	// else if type=comment parse item as BoxComment.Info
                	this.item = BoxResource.parseBoxResource(value);                	
                } else if (key == 'modified_by') {
                	this.modifiedBy = new BoxUser.Info(value);
                }
            } 
         }
    }
}