package com.example.boardtest.mapper;

import com.example.boardtest.BoardDto.BoardDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/*
 * [매퍼 인터페이스]
 */
@Mapper
public interface BoardMapper {
    List<BoardDto> getBoardList(BoardDto vo);		// 글 목록 조회
    List<BoardDto> getListPagingAndSearching(BoardDto vo);	// 글 목록 조회(Criteria 객체 사용)
    int insertBoard(BoardDto vo);				// 글 등록
    void updateBoard(BoardDto vo);				// 글 수정
    void deleteBoard(BoardDto vo);				// 글 삭제
    BoardDto getBoardById(BoardDto vo);			// 글 상세 조회
    //void updateHit(BoardDto vo);					// 글조회수 증가
    //int getTotalBoardCount(Criteria cri);					// 전체 게시물 숫자

}