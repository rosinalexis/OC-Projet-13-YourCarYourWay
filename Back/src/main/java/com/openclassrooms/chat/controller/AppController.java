package com.openclassrooms.chat.controller;

import com.openclassrooms.chat.model.Message;
import com.openclassrooms.chat.model.OutputMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class AppController {
    @MessageMapping("/chat")
    @SendTo("/topic/public")
    public OutputMessage send(@Payload Message message) throws Exception {
        String time = new SimpleDateFormat("HH:mm").format(new Date());
        return new OutputMessage(message.getFrom(), message.getText(), time);
    }
}
