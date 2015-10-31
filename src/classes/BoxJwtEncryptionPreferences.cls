public class BoxJwtEncryptionPreferences {
	private String publicKeyId {get; set;}
	private String privateKey {get; set;}
	private String privateKeyPassword {get; set;}
	private BoxJwtEncryptionPreferences.EncryptionAlgorithm algorithm {get; set;}
	
	public BoxJwtEncryptionPreferences() {
		
	}
	
	public String getPublicKeyId() {
		return this.publicKeyId;
	}
	
	public void setPublicKeyId(String publicKeyId) {
		this.publicKeyId = publicKeyId;
	}
	
	public String getPrivateKey() {
		return this.privateKey;
	}
	
	public void setPrivateKey(String privateKey) {
		this.privateKey = privateKey;
	}
	
	public String getPrivateKeyPassword() {
		return this.privateKeyPassword;
	}
	
	public void setPrivateKeyPassword(String privateKeyPassword) {
		this.privateKeyPassword = privateKeyPassword;
	}
	
	public BoxJwtEncryptionPreferences.EncryptionAlgorithm getEncryptionAlgorithm() {
		return this.algorithm;
	}
	
	public void setEncryptionAlgorithm(BoxJwtEncryptionPreferences.EncryptionAlgorithm algorithm) {
		this.algorithm = algorithm;
	}
	
	public enum EncryptionAlgorithm {
		/**
	     * RSA with SHA 256.
	     */
	    RSA_SHA_256,
	
	    /**
	     * RSA with SHA 384.
	     */
	    RSA_SHA_384,
	
	    /**
	     * RSA with SHA 512.
	     */
	    RSA_SHA_512
	}
}