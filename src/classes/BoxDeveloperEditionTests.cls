@isTest
public class BoxDeveloperEditionTests {
	public static testmethod void testParseDeveloperEditionEntityType() {
		System.assertEquals(BoxDeveloperEdition.DeveloperEditionEntityType.ENTERPRISE, BoxDeveloperEdition.parseDeveloperEditionEntityType('enterprise'));
		System.assertEquals(BoxDeveloperEdition.DeveloperEditionEntityType.USER, BoxDeveloperEdition.parseDeveloperEditionEntityType('user'));
		System.assertEquals(null, BoxDeveloperEdition.parseDeveloperEditionEntityType('invalid_value'));
	}
	
	public static testmethod void testGetDeveloperEditionEntityTypeAsString() {
		System.assertEquals('enterprise', BoxDeveloperEdition.getDeveloperEditionEntityTypeAsString(BoxDeveloperEdition.DeveloperEditionEntityType.ENTERPRISE));
		System.assertEquals('user', BoxDeveloperEdition.getDeveloperEditionEntityTypeAsString(BoxDeveloperEdition.DeveloperEditionEntityType.USER));
		System.assertEquals(null, BoxDeveloperEdition.getDeveloperEditionEntityTypeAsString(null));
	}
}