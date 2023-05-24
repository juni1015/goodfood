package com.icia.goodfood.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {    int page; // 현재 페이지
    int maxPage; // 전체페이지갯수
    int startPage; // 하단에 보여지는 시작 페이지 번호
    int endPage; // 하단에 보여지는 마지막 페이지 번호
    int blockLimit; // 한화면에 보여줄 피이지 번호 갯수
    int boardCount; // 보드에 필요한 필드
    int pageLimit; // 한화면에 보여줄 게시글
    int pageStart; // 게시글 시작번호

    public void setPage(int page) {
        this.page = page;
    }
    public void setPageLimit(int pageLimit) {
        this.pageLimit = pageLimit;
        this.pageStart = (page -1) * this.pageLimit;
    }
    public void setBlockLimit(int blockLimit) {
        this.blockLimit = blockLimit;
        this.startPage =(((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
    }
    public  void setBoardCount(int boardCount) {
        this.boardCount = boardCount;
        this.maxPage = (int)(Math.ceil((double)boardCount / this.pageLimit));
        this.endPage = this.startPage + this.blockLimit -1;
    }
}
