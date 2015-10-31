@IsTest
public class BoxUploaddEmailTests {
 	public static testmethod void testParseAccess() {
		System.assertEquals(BoxUploadEmail.Access.OPEN, BoxUploadEmail.parseAccess('open'));
		System.assertEquals(BoxUploadEmail.Access.COLLABORATORS, BoxUploadEmail.parseAccess('collaborators'));
 	}
     
    public static testmethod void testGetAccessAsString() {
		System.assertEquals('open', BoxUploadEmail.getAccessAsString(BoxUploadEmail.Access.OPEN));
		System.assertEquals('collaborators', BoxUploadEmail.getAccessAsString(BoxUploadEmail.Access.COLLABORATORS));
    }
}