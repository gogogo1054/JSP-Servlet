package membership;

public class myMemberDTO 
{
	private String id;
	private String name;
	private String pwd;
	private String nickname;
	private String phone;
	private String email;
	private String postcode;
	private String post;
	private String ban;
	
	public myMemberDTO() {
		super();
	}

	public String getBan() {
		return ban;
	}

	public void setBan(String ban) {
		this.ban = ban;
	}


	public myMemberDTO(String id2, String name2, String pwd2, String nickname2, String phone2, String email2,
			String postcode2, String post2, String ban2) {
		// TODO Auto-generated constructor stub
		
		this.id = id2;
		this.name = name2;
		this.pwd = pwd2;
		this.nickname = nickname2;
		this.phone = phone2;
		this.email = email2;
		this.postcode = postcode2;
		this.post = post2;
		this.ban = ban2;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}

	
	
	
	
	

}
