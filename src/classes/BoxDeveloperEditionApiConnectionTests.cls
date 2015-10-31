@isTest
public class BoxDeveloperEditionApiConnectionTests {
	private static String accessToken = 'accesstoken';
    private static String refreshToken = 'refreshtoken';
    private static String clientId = 'clientid';
    private static String clientSecret = 'clientsecret';
    private static String authCode = 'authcode';
    private static String entityId = 'entityid';
    private static String userId = 'userid';
    private static String enterpriseId = 'enterpriseid';
    private static String publicKeyId = 'publicKeyId';
    private static String privateKey = BoxTestJsonResponseFactory.AUTH_PRIVATE_KEY;
    private static String privateKeyPassword = 'privateKeyPassword';
    private static BoxJwtEncryptionPreferences.EncryptionAlgorithm algorithm = BoxJwtEncryptionPreferences.EncryptionAlgorithm.RSA_SHA_256;
	
	private static BoxJwtEncryptionPreferences constructEncryptionPrefs() {
		BoxJwtEncryptionPreferences prefs = new BoxJwtEncryptionPreferences();
		prefs.setEncryptionAlgorithm(algorithm);
		prefs.setPrivateKey(privateKey);
		prefs.setPrivateKeyPassword(privateKeyPassword);
		prefs.setPublicKeyId(publicKeyId);
		return prefs;
	}
	
	public static testmethod void testValidConstructors() {
		BoxDeveloperEdition.DeveloperEditionEntityType entityType = BoxDeveloperEdition.DeveloperEditionEntityType.USER;
		BoxJwtEncryptionPreferences encryptionPref = constructEncryptionPrefs();
		
		Test.startTest();
		BoxDeveloperEditionApiConnection api = new BoxDeveloperEditionApiConnection(entityId, entityType, clientId, clientSecret, encryptionPref);
		Test.stopTest();
		
		System.assertEquals(entityId, api.entityId);
	}
	
	public static testmethod void testInvalidConstructors() {
		Test.startTest();
		try {
			BoxDeveloperEditionApiConnection api = new BoxDeveloperEditionApiConnection(accessToken);
			System.assert(false, 'BoxApiConnection.BoxApiConnectionException expected for invalid constructor call.');
		} catch (BoxApiConnection.BoxApiConnectionException e) {
			System.assert(e.getMessage().contains('This constructor is not available'), 'Exception message unexpected: ' + e.getMessage());
		}
		
		try {
			BoxDeveloperEditionApiConnection api = new BoxDeveloperEditionApiConnection(clientId, clientSecret);
			System.assert(false, 'BoxApiConnection.BoxApiConnectionException expected for invalid constructor call.');
		} catch (BoxApiConnection.BoxApiConnectionException e) {
			System.assert(e.getMessage().contains('This constructor is not available'), 'Exception message unexpected: ' + e.getMessage());
		}
		
		try {
			BoxDeveloperEditionApiConnection api = new BoxDeveloperEditionApiConnection(clientId, clientSecret, authCode);
			System.assert(false, 'BoxApiConnection.BoxApiConnectionException expected for invalid constructor call.');
		} catch (BoxApiConnection.BoxApiConnectionException e) {
			System.assert(e.getMessage().contains('This constructor is not available'), 'Exception message unexpected: ' + e.getMessage());
		}
		
		try {
			BoxDeveloperEditionApiConnection api = new BoxDeveloperEditionApiConnection(clientId, clientSecret, accessToken, refreshToken);
			System.assert(false, 'BoxApiConnection.BoxApiConnectionException expected for invalid constructor call.');
		} catch (BoxApiConnection.BoxApiConnectionException e) {
			System.assert(e.getMessage().contains('This constructor is not available'), 'Exception message unexpected: ' + e.getMessage());
		}
		Test.stopTest();
	}
	
	public static testmethod void testAuthenticate() {
		BoxDeveloperEdition.DeveloperEditionEntityType entityType = BoxDeveloperEdition.DeveloperEditionEntityType.USER;
		BoxJwtEncryptionPreferences encryptionPref = constructEncryptionPrefs();
		String authResponse = BoxTestJsonResponseFactory.AUTH_APP_USER_TOKEN;
		Test.setMock(HttpCalloutMock.class, (new BoxTestMockCallout(authResponse, 'OK', 200)));
		
		Test.startTest();
		BoxDeveloperEditionApiConnection api = new BoxDeveloperEditionApiConnection(entityId, entityType, clientId, clientSecret, encryptionPref);
		api.authenticate();
		Test.stopTest();
		
		System.assertEquals('mNr1FrCvOeWiGnwLL0OcTL0Lux5jbyBa', api.accessToken);
	}
	
	public static testmethod void testInvalidAuthenticate() {
		BoxDeveloperEdition.DeveloperEditionEntityType entityType = BoxDeveloperEdition.DeveloperEditionEntityType.USER;
		BoxJwtEncryptionPreferences encryptionPref = constructEncryptionPrefs();
		
		Test.startTest();
		BoxDeveloperEditionApiConnection api = new BoxDeveloperEditionApiConnection(entityId, entityType, clientId, clientSecret, encryptionPref);
		try {
			api.authenticate(authCode);
			System.assert(false, 'BoxApiConnection.BoxApiConnectionException expected for invalid authenticate call.');
		} catch (BoxApiConnection.BoxApiConnectionException e) {
			System.assert(e.getMessage().contains('does not allow authenticating with an auth code'), 'Exception message unexpected: ' + e.getMessage());
		}
		Test.stopTest();
	}
	
	public static testmethod void testRefresh() {
		BoxDeveloperEdition.DeveloperEditionEntityType entityType = BoxDeveloperEdition.DeveloperEditionEntityType.USER;
		BoxJwtEncryptionPreferences encryptionPref = constructEncryptionPrefs();
		String authResponse = BoxTestJsonResponseFactory.AUTH_APP_USER_TOKEN;
		Test.setMock(HttpCalloutMock.class, (new BoxTestMockCallout(authResponse, 'OK', 200)));
		
		Test.startTest();
		BoxDeveloperEditionApiConnection api = new BoxDeveloperEditionApiConnection(entityId, entityType, clientId, clientSecret, encryptionPref);
		System.assertEquals(true, api.canRefresh());
		api.refresh();
		Test.stopTest();
		
		System.assertEquals('mNr1FrCvOeWiGnwLL0OcTL0Lux5jbyBa', api.accessToken);
	}
	
	public static testmethod void testFactoryConstructors() {
		BoxJwtEncryptionPreferences encryptionPref = constructEncryptionPrefs();
		String authResponse = BoxTestJsonResponseFactory.AUTH_APP_USER_TOKEN;
		Test.setMock(HttpCalloutMock.class, (new BoxTestMockCallout(authResponse, 'OK', 200)));
		
		Test.startTest();
		BoxDeveloperEditionApiConnection entApi = BoxDeveloperEditionApiConnection.getAppEnterpriseConnection(enterpriseId, clientId, clientSecret, encryptionPref);
		BoxDeveloperEditionApiConnection userApi = BoxDeveloperEditionApiConnection.getAppUserConnection(userId, clientId, clientSecret, encryptionPref);
		Test.stopTest();
		
		System.assertEquals(enterpriseId, entApi.entityId);
		System.assertEquals(userId, userApi.entityId);
	}
}