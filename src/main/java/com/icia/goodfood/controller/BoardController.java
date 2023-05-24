package com.icia.goodfood.controller;

import com.icia.goodfood.dto.BoardDTO;
import com.icia.goodfood.dto.BoardPageDTO;
import com.icia.goodfood.dto.MemberDTO;
import com.icia.goodfood.dto.PageDTO;
import com.icia.goodfood.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;

    @GetMapping("/list")
    public String list(@RequestParam(value = "boardCategory", required = false, defaultValue = "0") int boardCategory,
                       @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                       @RequestParam(value = "q", required = false, defaultValue = "") String q,
                       Model model) {
        List<BoardDTO> boardDTOList = null;
        PageDTO pageDTO = null;
        if (boardCategory == 0) {
            if (q.equals("")) {
                boardDTOList = boardService.pagingList(page);
                pageDTO = boardService.pagingParam(page);
            } else {
                boardDTOList = boardService.searchList(page, q);
                pageDTO = boardService.pagingSearchParam(page, q);
            }
        } else {
            if (q.equals("")) {
                boardDTOList = boardService.categoryPagingList(boardCategory, page);
                pageDTO = boardService.categoryPagingParam(boardCategory, page);
            } else {
                boardDTOList = boardService.categorySearchList(boardCategory, page, q);
                pageDTO = boardService.categoryPagingSearchParam(boardCategory, page, q);
            }
        }
        model.addAttribute("boardList", boardDTOList);
        model.addAttribute("paging", pageDTO);
        model.addAttribute("q", q);
        model.addAttribute("boardCategory", boardCategory);
        return "boardPages/boardList";
    }

    @GetMapping("/save")
    public String saveForm() { return "boardPages/boardSave"; }

    @PostMapping("/double-check")
    public ResponseEntity doubleCheck(@ModelAttribute BoardDTO boardDTO) {
        BoardDTO dto = boardService.doubleCheck(boardDTO);
        if (dto == null) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
    }

    @PostMapping("/save")
    public String save(HttpSession session, @ModelAttribute BoardDTO boardDTO) throws IOException {
        // 세션에 들어있는 로그인된 id 가져와서 boardDTO에 담기
        Long loginId = (Long) session.getAttribute("loginId");
        boardDTO.setMemberId(loginId);
//        boardDTO.setMemberId((Long) session.getAttribute("LoginId"));
        boardService.save(boardDTO);
        return "redirect:/board/list?boardCategory=" + boardDTO.getBoardCategory();
    }
}
