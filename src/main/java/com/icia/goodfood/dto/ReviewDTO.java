package com.icia.goodfood.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewDTO {
    private Long id;
    private String reviewContents;
    private Long boardId;
    private Long memberId;
}
