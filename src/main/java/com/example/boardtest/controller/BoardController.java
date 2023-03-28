package com.example.boardtest.controller;

import com.example.boardtest.BoardDto.BoardDto;
import com.example.boardtest.BoardDto.BoardInsertDTO;
import com.example.boardtest.service.IBoardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {
    @Resource(name = "BoardService")
    private IBoardService boardService;

    //게시글 메인을 띄어주는 메소드 board
    @GetMapping("/boardList")
    public String boardList(BoardDto vo, Model model) {
        List<BoardDto> boardList = boardService.getBoardList(vo);
        model.addAttribute("boardList", boardList);
        return "board";
    }

    // 게시물 작성 폼을 띄워주는 메소드
    @GetMapping("/boardWriteForm")
    public String boardWriteForm() {
        return "boardWriteForm";    // boardWriteForm.jsp
    }

    //글쓰기 팝업창
    @GetMapping("/insertPopup")
    public String insertPopup() {
        return "boardWriteForm";
    }

    @RequestMapping("/test")
    public String test() {
        return "test";
    }

    @PostMapping("/boardWrite")
    public String boardWrtie(@RequestBody BoardInsertDTO boardInsertDTO) {

        BoardDto dto = BoardDto.builder()
                .writer(boardInsertDTO.getWriter())
                .content(boardInsertDTO.getContent())
                .title(boardInsertDTO.getTitle())
                .build();

        boardService.insertBoard(dto);

        return "board";
    }

    //게시글 상세보기
    //게시글 상세보기
    @GetMapping("/boardView")
    public String getBoardById(@RequestParam(value = "no", defaultValue = "1") int no, Model model) {
        BoardDto dto = new BoardDto();
        dto.setNo(no);
        BoardDto boardDto = boardService.getBoardById(dto);
        model.addAttribute("board", boardDto);
        return "boardView";
    }

    @GetMapping("/boardModify")
    public String updateBoardForm(BoardDto vo,
                                  Model model) {

        BoardDto boardVo = boardService.getBoardById(vo);
        model.addAttribute("board", boardVo);
        return "/boardModifyForm";    // boardModify.jsp
    }

    // 수정한 내용을 데이터베이스에 반영하는 메소드
    @PostMapping("/boardModify")
    public String boardModify(BoardDto vo) {

        boardService.updateBoard(vo); // 수정
        return "redirect:/board/boardList";// 저장후 목록 출력 컨트롤러 호출
    }

    // 게시물을 삭제해주는 메소드(핸들러)
    @RequestMapping(value = "/boardDelete", method = RequestMethod.GET)
    public String boardDelete(BoardDto vo) {
        boardService.deleteBoard(vo);
        return "redirect:/board/boardList"; // 저장후 목록 출력 컨트롤러 호출
    }


}