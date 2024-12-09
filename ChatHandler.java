package websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/ChatingServer")
public class ChatHandler {

	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	// 순서를 유지하지 않고 저장하며, 중복 저장이 불가능하다.

	@OnOpen // 클라이언트 접속 시 실행
	public void onOpen(Session session) {
		clients.add(session); // 세션 추가
		System.out.println("웹소켓 연결: " + session.getId());
	}

	@OnMessage // 메시지를 받으면 실행
	public void onMessage(String message, Session session) throws IOException {
		System.out.println("메시지 전송: " + session.getId() + ": " + message);
		// ddddd@안녕하세요_3
		String adminId = message.split("@")[0];
		String sendId = message.split("_")[1];
		message = message.split("@")[1].split("_")[0];
		
		synchronized (clients) {
			for (Session client : clients) { // 모든 클라이언트에게 메시지 전달
				// 어드민이 사용자에게 보내는 메세지
				if(adminId.length() > 0 && adminId != "admin" && client.getId().equals(sendId)) {
					client.getBasicRemote().sendText(message);
					break;
				}
				// 사용자가 어드민에게 보내는 메세지
				if (!client.equals(session)) {
					// 메시지를 보낸 클라이언트는 제외하고 전달
					client.getBasicRemote().sendText(message + "to_admin" + session.getId());
				}
			}
		}
	}

	@OnClose // 클라이언트와의 연결이 끊기면 실행
	public void onClose(Session session) {
		clients.remove(session);
		System.out.println("웹소켓 종료: " + session.getId());
	}

	@OnError
	public void onError(Throwable e) {
		System.out.println("에러 발생");
		e.printStackTrace();
	}
}