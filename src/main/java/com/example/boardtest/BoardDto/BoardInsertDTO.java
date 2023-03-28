package com.example.boardtest.BoardDto;

import lombok.Data;

@Data
public class BoardInsertDTO {
    private String writer;

    private String title;

    private String content;
}
