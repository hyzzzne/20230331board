package com.example.boardtest.service;

import java.util.List;

import com.example.boardtest.BoardDto.BoardDto;

public interface IBoardService {

    List<BoardDto> getBoardList(BoardDto vo);	// 글 목록 조회
//    //List<Dto> getListPagingAndSearching(Criteria cri);	// 글 목록 조회(페이징)
//    BoardDto getBoardById(BoardDto vo);			// 글 상세 조회
    int insertBoard(BoardDto vo);				// 글 등록

    BoardDto getBoardById(BoardDto vo);

    //BoardDto getBoardById(int no);
    void updateBoard(BoardDto vo);				// 글 수정

    //String getBoardById(BoardDto vo);
    void deleteBoard(BoardDto vo);				// 글 삭제
//    void updateHit(BoardDto vo);					// 글조회수 증가
    //int getTotalBoardCount(Criteria cri);					// 전체 게시물 숫자

    List<BoardDto> getListPagingAndSearching(BoardDto vo);
}
