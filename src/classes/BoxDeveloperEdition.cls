public class BoxDeveloperEdition {
	public enum DeveloperEditionEntityType {
		/**
	     * Represents the entity type enterprise.
	     */
	    ENTERPRISE,
	
	    /**
	     * Represents the entity type user.
	     */
	    USER
	}
	
	public static BoxDeveloperEdition.DeveloperEditionEntityType parseDeveloperEditionEntityType(String value) {
		if (value == 'enterprise') {
			return BoxDeveloperEdition.DeveloperEditionEntityType.ENTERPRISE;
		} else if (value == 'user') {
			return BoxDeveloperEdition.DeveloperEditionEntityType.USER;
		}
		return null;
	}
	
	public static String getDeveloperEditionEntityTypeAsString(BoxDeveloperEdition.DeveloperEditionEntityType value) {
		if (value == BoxDeveloperEdition.DeveloperEditionEntityType.ENTERPRISE) {
			return 'enterprise';
		} else if (value == BoxDeveloperEdition.DeveloperEditionEntityType.USER) {
			return 'user';
		}
		return null;
	}
}