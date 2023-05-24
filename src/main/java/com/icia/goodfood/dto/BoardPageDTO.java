package com.icia.goodfood.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardPageDTO {
    private int category;
    private int page;
    private String q;
    private String type;
}
