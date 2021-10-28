package kr.co.erion.common.auth;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserAuth {
	private String EMAIL;
	private String NICK_NAME;
	private String GRP_CD;
	private int DIR_NO;
	private int PDIR_NO;
	private String DIR_REALNAME;
	
	@Builder
	public UserAuth(String EMAIL, String NICK_NAME, String GRP_CD, int DIR_NO, int PDIR_NO, String DIR_REALNAME) {
		this.EMAIL = EMAIL;
		this.NICK_NAME = NICK_NAME;
		this.GRP_CD = GRP_CD;
		this.DIR_NO = DIR_NO;
		this.PDIR_NO = PDIR_NO;
		this.DIR_REALNAME = DIR_REALNAME;
	}

}
