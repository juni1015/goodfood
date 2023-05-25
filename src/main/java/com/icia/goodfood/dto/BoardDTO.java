package com.icia.goodfood.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
@ToString
public class BoardDTO {
    private Long id;
    private int boardCategory;
    private String boardStoreName;
    private String boardStoreAddress;
    private String boardStoreKind;
    private String boardStoreNumber;
    private String boardStoreTime;
    private String boardStoreHomepage;
    private int boardStoreHits;
    private int boardStoreChoice;
    private int boardStoreReview;
    private int boardStoreLike;
    private int boardStoreUnlike;
    private int FileAttached;
    private Long memberId;
    private MultipartFile boardFile;
//    private List<MultipartFile> boardFile;  //위에서 list로 타입을 바꿔주면 여러개의 파일 값 저장 가능
}
