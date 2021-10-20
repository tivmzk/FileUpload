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

	function appendItem(title, filename, filecode){
		if(!$("input[name='title']").val()){
			alert('입력하세요');
			return;
		}
		else if(!$("input[name='uploadFile']")[0].files[0]){
			alert('입력하세요2');
			return;
		}
		
		const tr = $('<tr>');
		const td_title = $('<td>').text(title);
		const td_filename = $('<td>');
		const td_delete = $('<td>');
		
		const a_filename = $('<a>')
		.attr({'href':'upload/'+filecode, 'target':'_blank'})
		.text(filename);
		
		const a_delete = $('<a>')
		.attr('href', 'delete/'+title)
		.text('삭제');
		
		td_filename.append(a_filename);
		td_delete.append(a_delete);
		
		tr.append(td_title);
		tr.append(td_filename);
		tr.append(td_delete);
		
		$('#noitem').remove();
		
		$('tbody').append(tr);
	}

	$(function(){
		$('#list_code').click(function(){
			if(!$("input[name='title']").val()){
				alert('입력하세요');
				return;
			}
			else if(!$("input[name='uploadFile']")[0].files[0]){
				alert('입력하세요2');
				return;
			}
				
			const title = $("input[name='title']").val();
			const filename = $("input[name='uploadFile']")[0].files[0].name;
			
			const tr = $('<tr>');
			const td_title = $('<td>').text(title);
			const td_filename = $('<td>').text(filename);
			const td_delete = $('<td>').text('삭제');
			
			
			tr.append(td_title);
			tr.append(td_filename);
			tr.append(td_delete);
			
			$('#noitem').remove();
			
			$('tbody').append(tr);
		});
		
		$('#list').click(function() {
			const item = {
					title:$('input[name="title"]').val(),
					filename:$(`input[name='uploadFile']`)[0].files[0].name
			}
			console.log(inputItem.title, inputItem.filename);
			
			let html = `
			<tr>
				<td>\${inputItem.title}</td>
				<td><a href="upload/" target="_blank">\${inputItem.filename}</a></td>
				<td><a href="delete/\${inputItem.title}">삭제</a></td>
			</tr>
			`;
			
			console.log(html);
			const tbody = $('tbody').html();
			$('tbody').html(tbody+html);
		});
		
		$('#upload').on('click', function() {

			const form = document.getElementById('uploadForm');
			const formData = new FormData(form);

			$.ajax('upload_ajax', {
				type : 'POST',
				enctype : 'multipart/form-data',
				data : formData,
				async : true,
				cache : false,
				processData : false,
				contentType : false,
				success : function(result) {
					alert('업로드 성공');
					appendItem(form.title.value, form.uploadFile.files[0].name, result);
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
				<tbody>
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
		<div>
			<button id="list" type="button">[LIST_HTML]등록</button>
		</div>
		<div>
			<button id="list_code" type="button">[LIST_CODE]등록</button>
		</div>
	</div>
</body>
</html>