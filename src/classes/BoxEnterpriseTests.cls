@IsTest
public class BoxEnterpriseTests {
	public static testmethod void testParseMember() {
        BoxApiConnection api = new BoxApiConnection('accesstoken');
		BoxEnterprise enterprise = new BoxEnterprise(api,'10543463');
		BoxEnterprise.Info enterpriseInfo = new BoxEnterprise.Info();
		enterpriseInfo.addValue('name', 'test enterprise');
		
		Test.startTest();
		enterpriseInfo.parseMember('name', 'test enterprise');
        Test.stopTest();

		System.assertEquals('test enterprise', enterpriseInfo.name);
     }
}