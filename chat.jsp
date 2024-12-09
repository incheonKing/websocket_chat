<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	.chatDiv {
		z-index: 10;
		border: 0px solid;
		border-radius: 15px;
		position: fixed;
		right: 100px;
		bottom: 200px;
		width: 400px;
		height: 600px;
		background-color: antiquewhite;
	}
	
	.chat_head {
		margin: 15px;
		padding: 5px;
		width: auto;
		height: 80px;
	}
	
	.chatList {
		border: 0px solid;
		border-radius: 15px;
		background-color: floralwhite;
		margin-left: 10px;
		margin-right: 10px;
		padding: 10px;
		height: 400px;
		overflow: auto;
	}
	
	.chatUser {
		border: 1px solid black;
		border-radius: 10px;
		min-height: 40px;
	    display: flex;
	    align-items: center;
	    padding: 10px;
	    margin-bottom: 5px;
	    font-size: 18px;
	    cursor: pointer;
	}
	
	.chatUser:hover {
		background-color: bisque;
	}
	
	.chat_content {
		border: 0px solid;
		border-radius: 15px;
		background-color: floralwhite;
		margin-left: 10px;
		margin-right: 10px;
		padding: 5px;
		height: 400px;
		overflow: auto;
	}
	
	.chat_send {
		border: 0px solid;
		border-radius: 15px;
		background-color: white;
		margin-left: 10px;
		margin-right: 10px;
		height: 50px;
		margin-top: 20px;
		padding: 5px;
		display: flex;
		align-items: center;
	}
	
	.admin_comment {
	    padding: 5px;
	    margin-top: 10px;
	}
	
	.admin_profile {
		display: flex;
		align-items: center;
	}
	
	.admin_textbox {
		border-radius: 10px;
		background-color: white;
		padding: 5px;
	    width: auto;
	    max-width: 60%;
	    display: table;
	    margin-bottom: 5px;
	}
	
	.my_comment {
	    display: table;
	    justify-content: end;
	    background-color: yellow;
	    border-radius: 10px;
	    width: auto;
	    max-width: 60%;
	    padding: 5px;
	    margin-top: 10px;
	    margin-left: auto;
	}
	
	.chat_msg {
		border: 0px solid;
		padding-left: 10px;
	    width: 85%;
	    overflow: hidden scroll;
	    background-color: transparent;
	}
	
	.send_btn {
		border: none;
		border-radius: 15px;
		width: 12%;
		height: 80%;
		cursor: pointer;
	}
	
	.chatBtnDiv {
		position: fixed;
	    z-index: 10;
	    display: flex;
	    flex-wrap: nowrap;
	    width: auto;
	    overflow: visible;
	    background: transparent;
	    bottom: 100px;
	    right: 100px;
	}

	.chatBtn {
		border: 0px solid;
		position: relative;
	    display: flex;
	    align-items: center;
	    -webkit-box-pack: center;
	    justify-content: center;
	    overflow: visible;
	    background: transparent;
	    cursor: pointer;
	}
	
	.btnImg {
		width: 100px;
	    height: 100px;
	}
	
	.menuDiv {
		border: 1px solid black;
	    border-radius: 15px;
	    min-height: 30px;
	    margin-bottom: 10px;
	    border-color: gray;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    text-align: center;
	}
	
	.backBtn {
		border: 1px solid black;
	    border-radius: 10px;
	    min-width: 50px;
	    min-height: 30px;
	    margin-left: 5px;
	    margin-top: 5px;
	    margin-bottom: 5px;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    cursor: pointer;
	    background-color: antiquewhite;
	}
	
	.backBtn:hover {
		background-color: darksalmon;
	}
	
</style>
</head>
<body>
	<div id="logingId__" class="d-none">
		<c:choose>
			<c:when test="true">
				admin
			</c:when>
	
			<c:otherwise>
				user
			</c:otherwise>
		</c:choose>
	</div>
	<c:choose>
		<c:when test="true">
			<div id="chating" class="chatDiv d-none">
				<div class="chat_head">
					<div class="logo_container">
						<a href="#">PC<span>Mall</span><div style="font-size: 18px;">관리자님 환영합니다.</div></a>
					</div>
				</div>
				
				<div class="chatList d-none">
					
				</div>
				
				
				<div class="chat_content">
					<div id="nowCst" class="d-flex justify-content-center my-2">아직 상담 문의가 없습니다.</div>
				</div>
				
				<div class="chat_send d-none">
					<input class="chat_msg" type="text" onkeyup="enterKey(this)" placeholder="메시지를 입력해 주세요.">
					<button class="send_btn" type="button" onclick="socketMsgSend(this)" value="전송"><i class="fa-regular fa-paper-plane"></i></button>
				</div>
			</div>
		</c:when>
		
		<c:otherwise>
			<div id="chating" class="chatDiv d-none">
				<div class="chat_head">
					<div class="logo_container">
						<a href="home.jsp">PC<span>Mall</span></a>
					</div>
				</div>
				
				<div class="chat_content">
					<div class="admin_comment">
						<div class="admin_profile">
						    <i class="fa-solid fa-headset fa-lg"></i>&nbsp;상담원
						</div>
					    <div class="admin_textbox">안녕하세요. 무엇을 도와드릴까요?</div>
					</div>
				</div>
				
				<div class="chat_send">
					<input class="chat_msg" type="text" onkeyup="enterKey(this)" placeholder="메시지를 입력해 주세요.">
					<button class="send_btn" type="button" onclick="socketMsgSend(this)" value="전송"><i class="fa-regular fa-paper-plane"></i></button>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	
	<div class="chatBtnDiv" onclick="chatBtnClick(this)">
		<button type="button" class="chatBtn">
			<img alt="" src="https://cf.channel.io/pub-file/107383/63d754fc724ce80f189f/chting.png" class="btnImg">
			<%-- https://static.thenounproject.com/png/1374602-200.png --%>
		</button>
	</div>

</body>

<script src="https://kit.fontawesome.com/b213412e2c.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script type="text/javascript">
	function chatBtnClick(obj){
		let imgSrc = obj.querySelector('img').getAttribute('src');
		if(imgSrc == 'https://cf.channel.io/pub-file/107383/63d754fc724ce80f189f/chting.png'){
			obj.querySelector('img').setAttribute('src', 'https://static.thenounproject.com/png/1374602-200.png');
			document.querySelector('#chating').classList.remove('d-none');
		}
		else {
			obj.querySelector('img').setAttribute('src', 'https://cf.channel.io/pub-file/107383/63d754fc724ce80f189f/chting.png');
			document.querySelector('#chating').classList.add('d-none');
		}
	}
</script>

<script type="text/javascript">

	let nowChatId = '';

	$(document).ready(function(){
	    // 웹 소켓 초기화
	  	webSocketInit();
	});
	
	//웹소켓 생성
	var webSocket;

	function webSocketInit(){
	    webSocket = new WebSocket("ws://localhost:8080/ShoppingMall/ChatingServer");
		webSocket.onopen = function(event) { socketOpen(event);};
		webSocket.onclose = function(event) { socketClose(event);};
		webSocket.onmessage = function(event) { socketMessage(event);};
		webSocket.onerror = function(event) { socketError(event);};
	}
	
	//웹소켓 연결
	function socketOpen(event){
		console.log("연결 완료");
	}
	  
	//웹소켓 닫힘
	function socketClose(event){
	  	console.log("웹소켓이 닫혔습니다.");
	    // 웹소켓이 닫혀있으면 재연결을 시도합니다.
	    // webSocket이 close되면 오브젝트의 속성, 메서드가 사라지기 때문에,
	    // 해당 함수를 호출하여 초기화하여 줍니다.
	    webSocketInit(); 
	}
	  
	//메시지를 송신할 때 사용
	function socketMsgSend(btnObj){
		
		let chatContent = btnObj.previousElementSibling.value;
		
		if(chatContent.length > 0 && chatContent != null){
			//전송 내용 보여주기
			
			var msg;
			// 어드민이 사용자에게 보낼 때
			if(document.querySelector('#logingId__').innerText.trim() == 'admin'){
				let adminId = document.querySelector('#logingId__').innerText.trim();
				
			    msg = adminId+'@'+chatContent+'_'+nowChatId;
			    
				let chatDiv = document.getElementsByClassName('chat_'+nowChatId)[0];
				
				let myChat = document.createElement('div');
				myChat.classList.add('my_comment');
				
				let myChatText = document.createElement('div');
				myChatText.classList.add('my_textbox');
				myChatText.innerText = chatContent;
				
				myChat.appendChild(myChatText);
				
				chatDiv.appendChild(myChat);
				
				chatDiv.scrollTop = chatDiv.scrollHeight;
			}
			// 사용자가 어드민에게 보낼 때
			else {
				msg = 'user@' + chatContent + '_A';
				
				let chatDiv = document.querySelector('.chat_content');
				
				let myChat = document.createElement('div');
				myChat.classList.add('my_comment');
				
				let myChatText = document.createElement('div');
				myChatText.classList.add('my_textbox');
				myChatText.innerText = chatContent;
				
				myChat.appendChild(myChatText);
				
				chatDiv.appendChild(myChat);
				
				chatDiv.scrollTop = chatDiv.scrollHeight;
			}
		    // 세션리스트에 메시지를 송신한다.
		    webSocket.send(msg);
		}
		
	    btnObj.previousElementSibling.value = '';
	}
	
	// 엔터 키 입력 처리
	function enterKey(inputObj) {
		if (window.event.keyCode == 13) { // 13 = Enter 키의 코드값
			socketMsgSend(inputObj.nextElementSibling);
		}
	}
	
	//웹소켓 메시지 수신
	function socketMessage(event){
		
	  	var receiveData = event.data; // 수신 data
		let loginId = document.querySelector('#logingId__').innerText;
	  	
	  	// 어드민이 받았을 때
	  	if(loginId.trim() == 'admin' && receiveData.split("to_admin")[1] != null){
	  		if(receiveData.length > 0 && receiveData != null){
	  			
	  			sendedId = receiveData.split('to_admin')[1];
	  			
		  		let chatList = document.querySelector('.chatList');
		  		let chat_content = document.querySelector('.chat_content');
		  		
	  			if(document.getElementsByClassName(sendedId+'').length == 0){
		  			
		  			if(!chat_content.classList.contains('d-none')){
		  				chat_content.classList.add('d-none');
		  			}
		  			if(chatList.classList.contains('d-none')){
		  				chatList.classList.remove('d-none');
		  			}
		  			
		  			let chatUser = document.createElement('div');
		  			chatUser.classList.add('chatUser');
		  			chatUser.classList.add(sendedId+'');
		  			chatUser.addEventListener('click',(e)=>{
		  				chatList.classList.add('d-none');
		  				chat_content.classList.remove('d-none');
		  				let chatId = e.target.querySelector('.userId').innerText;
		  				document.getElementsByClassName('chat_'+chatId)[0].classList.remove('d-none');
		  				document.querySelector('.chat_send').classList.remove('d-none');
		  				nowChatId = chatId;
		  			});
		  			
		  			let img = document.createElement('i');
		  			img.classList.add('fa-regular');
		  			img.classList.add('fa-user');
		  			
		  			let userId = document.createElement('div');
		  			userId.innerText = receiveData.split('to_admin')[1];
		  			userId.classList.add('userId');
		  			
		  			chatUser.appendChild(img);
		  			chatUser.appendChild(userId);
		  			
		  			chatList.appendChild(chatUser);
	  			}
	  			
	  			document.querySelector('#nowCst').innerHTML = '';
	  			document.querySelector('#nowCst').classList.remove('my-2');
	  			
	  			if(document.getElementsByClassName('chat_'+sendedId).length == 0){
			  		let chatDiv = document.createElement('div');
			  		chatDiv.classList.add('chat_'+sendedId);
			  		chatDiv.classList.add('d-none');
			  		
			  		let menuDiv = document.createElement('div');
			  		menuDiv.classList.add('menuDiv');
			  		menuDiv.innerText = sendedId+'님과 대화 중입니다.'
			  		
			  		let backBtn = document.createElement('button');
			  		backBtn.classList.add('backBtn');
			  		backBtn.setAttribute('type', 'button');
			  		backBtn.addEventListener('click',(e)=>{
			  			chat_content.classList.add('d-none');
			  			chatList.classList.remove('d-none');
			  			document.querySelector('.chat_send').classList.add('d-none');
			  			chatDiv.classList.add('d-none');
		  			});
			  		
			  		let backImg = document.createElement('i');
			  		backImg.classList.add('fa-solid');
			  		backImg.classList.add('fa-right-to-bracket');
			  		
			  		backBtn.appendChild(backImg);
			  		
			  		let yourChat = document.createElement('div');
			  		yourChat.classList.add('admin_textbox');
			  		yourChat.innerText = receiveData.split("to_admin")[0].split('_')[0];
			  		
			  		chatDiv.appendChild(backBtn);
			  		chatDiv.appendChild(menuDiv);
			  		chatDiv.appendChild(yourChat);
			  		chat_content.appendChild(chatDiv);
	  			}
	  			
	  			else {
	  				let yourChat = document.createElement('div');
			  		yourChat.classList.add('admin_textbox');
			  		yourChat.innerText = receiveData.split("to_admin")[0].split('_')[0];
			  		
	  				document.getElementsByClassName('chat_'+sendedId)[0].appendChild(yourChat);
	  				document.getElementsByClassName('chat_'+sendedId)[0].scrollTop = document.getElementsByClassName('chat_'+sendedId)[0].scrollHeight;
	  			}
		  		
		  	}
	  	}
	  	
	  	// 사용자가 받았을 때
	  	else if(receiveData.split('to_admin')[1] == null) {
	  		let chatDiv = document.querySelector('.chat_content');
	  		
	  		let yourChat = document.createElement('div');
	  		yourChat.classList.add('admin_textbox');
	  		yourChat.innerText = receiveData.split('to_admin')[0].split('_')[0];
	  		
	  		chatDiv.appendChild(yourChat);
	  		chatDiv.scrollTop = chatDiv.scrollHeight;
	  	}
	  	
	    //웹소켓 에러
	    function socketError(event){
	    	alert("에러가 발생하였습니다.");
	    }
	  
	    //웹소켓 종료
	    function disconnect(){
		  	webSocket.close();	    	
	    }
	    
	}
</script>

</html>