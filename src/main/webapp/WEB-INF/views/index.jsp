<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		const createItemElem = function(list) {
			const tr = document.createElement('tr');
			
			const title = document.createElement('td');
			title.textContent = list[0];
			
			const filename = document.createElement('td');
			const a1 = document.createElement('a');
			a1.href = `upload/\${list[2]}`;
			a1.target = '_blank';
			a1.textContent = list[1];
			filename.appendChild(a1);
			
			const del = document.createElement('td');
			const a2 = document.createElement('a');
			a2.href = `delete/\${list[0]}`;
			a2.textContent = '삭제';
			del.appendChild(a2);
			
			let tdList = [title, filename, del];
			
			for(item of tdList){
				tr.appendChild(item);
			}
			return tr;
		};
		const insertItem = function(item){
			const list = item.split(':');
			if(document.getElementById('noitem')){
				document.getElementById('wrapper').removeChild(document.getElementById('noitem'));	
			} 
			document.getElementById('wrapper').appendChild(createItemElem(list));
		};
		
		$('#upload').on('click', function() {

			const form = document.getElementById('uploadForm');
			const formData = new FormData(form);

			$.ajax('upload_ajax', {
				type : 'POST',
				enctype : 'multipart/form-data',
				contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
				data : formData,
				async : true,
				cache : false,
				processData : false,
				contentType : false,
				success : function(result) {
					alert('업로드 성공');
					insertItem(result);
				},
				error : function(xhr, status, err) {
					alert('업로드 실패: ' + err);
				}
			});
		});
	});
</script>
</head>
<body>
	<div>
		<h3>이미지 업로드 갤러리</h3>
		<div>
			<table border="1" >
				<thead>
					<tr>
						<th>제목</th>
						<th>파일명</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody id="wrapper">
					<c:if test="${list.size() < 1}">
						<tr id="noitem">
							<td colspan="3">등록된 이미지가 없습니다</td>
						</tr>
					</c:if>
					<c:forEach var="item" items="${list}">
						<tr>
							<td>${item.title}</td>
							<td><a href="upload/${item.filecode}" target="_blank">${item.filename}</a></td>
							<td><a href="delete/${item.title}">삭제</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div>
			<form action="upload" method="post" enctype="multipart/form-data" id="uploadForm">
				<div>
					<label for="">제목:</label> <input type="text" name="title">
				</div>
				<div>
					<label for="">첨부파일:</label> <input type="file" name="uploadFile" />
				</div>
				<div>
					<button>[FORM]등록</button>
				</div>
			</form>
		</div>
		<div>
			<button id="upload" type="button">[AJAX]등록</button>
		</div>
	</div>
</body>
</html>