package com.icia.goodfood.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
public class MemberDTO {
    private Long id;
    private String memberEmail;
    private String memberDomain;
    private String memberEmailFull;
    private String memberPassword;
    private String memberName;
    private String memberNickname;
    private String memberMobileAgency;
    private String memberMobile;
    private int profileAttached;
    private MultipartFile memberProfile;
}
