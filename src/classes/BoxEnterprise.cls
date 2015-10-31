public class BoxEnterprise extends BoxResource {
    public BoxEnterprise(BoxApiConnection api, String id) {
        super(api, id);
    }
            
    public override String getObjectType() {
        return 'enterprise';
    }
    
    public override void setInfo(BoxJsonObject jsonObject) {
        this.information = (BoxEnterprise.Info) jsonObject;
    }
    
    public class Info extends BoxResource.Info {
    	public String name {get; private set;}
    	
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
	    	super.parseResourceMember(key, value);
	    	if (key != null) {
	    		if (key == 'name') {
	    			this.name = value;
	    		}
	    	}
	    }
    }
}