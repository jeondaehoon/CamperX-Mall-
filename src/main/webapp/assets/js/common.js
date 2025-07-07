function getTimeZoneOffset(){
 	var date = new Date();
	var offset = date.getTimezoneOffset();
	return offset;
}

function getLocalTimeZone(){
	return Intl.DateTimeFormat().resolvedOptions().timeZone;	
}


function call_server(f,url, cbFunc){
	
	var formData = new FormData($(f)[0]);
	console.log(formData);
	$.ajax({
			data : formData,
			type : "POST",
			url : url,
			cache : false,
			processData: false,
			contentType: false,
			success : function(data) {
				if(data){
					cbFunc(data);
				}else{
					alert("오류가 발생하였습니다.");
				}
		    }
		});
		
	
}


function alertShow(obj){
	$(obj).show();
}

function alertClose(obj){
	$(obj).hide();
}

function addComma(value){
	if(value==undefined || value=='' || value==null){
		return "";
	}
    value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return value; 
}

function getNullToEmpty(str){
	if(str==undefined){
		return "";
	}else{
		return str;
	}
}

function getToday(){
	var d = new Date();

	var month = d.getMonth()+1;
	var day = d.getDate();

	return d.getFullYear() + '-' + (month<10 ? '0' : '') + month + '-' +(day<10 ? '0' : '') + day;
}


 function inputNumberFormat(obj) {
     obj.value = comma(uncomma(obj.value));
 }

 function comma(str) {
     str = String(str);
     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
 }

 function uncomma(str) {
     str = String(str);
     return str.replace(/[^\d]+/g, '');
 }
 
 

function set_server(url, cbFunc) {
    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        success: function(data) {
            if(data) {
                cbFunc(data);
            } else {
                alert("오류가 발생하였습니다.");
            }
        },
        error: function(xhr, status, error) {
            console.error("Error:", error);
            alert("오류가 발생하였습니다.");
        }
    });
}

function post_server(url, data, cbFunc) {
    console.log('Sending POST request to:', url);
    console.log('Request data:', data);
    
    $.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify(data),
        contentType: "application/json",
        dataType: "json",
        success: function(data) {
            console.log('Response received:', data);
            cbFunc(data);
        },
        error: function(xhr, status, error) {
            console.error("Error details:", {
                status: status,
                error: error,
                response: xhr.responseText
            });
            $('#repliesData').text('');
        }
    });
}
 
 

function exportToExcel(tableSelector, filename) {
    // 현재 테이블의 데이터를 가져옴
    var table = document.querySelector(tableSelector);
    var rows = Array.from(table.querySelectorAll('tbody tr'));
    
    // 엑셀 데이터 준비
    var excelData = [];
    
    // 헤더 추가
    var headers = Array.from(table.querySelectorAll('thead th')).map(th => th.textContent);
    headers = headers.filter(header => header !== ''); // 빈 헤더 제거
    excelData.push(headers);
    
    // 데이터 행 추가
    rows.forEach(row => {
        var rowData = Array.from(row.querySelectorAll('td')).map(td => {
            // 링크가 있는 경우 텍스트만 추출
            var link = td.querySelector('a');
            return link ? link.textContent : td.textContent;
        });
        excelData.push(rowData);
    });
    
    // 워크북 생성
    var wb = XLSX.utils.book_new();
    var ws = XLSX.utils.aoa_to_sheet(excelData);
    
    // 워크북에 워크시트 추가
    XLSX.utils.book_append_sheet(wb, ws, "Sheet1");
    
    // 엑셀 파일 다운로드
    XLSX.writeFile(wb, filename + "_" + new Date().toISOString().split('T')[0] + ".xlsx");
}
 
 

// 날짜 포맷팅 함수 (YYYY-MM-DD)
function formatDate(dateString) {
    if (!dateString) return '';
    const date = new Date(dateString);
    return date.getFullYear() + '-' + 
        String(date.getMonth() + 1).padStart(2, '0') + '-' + 
        String(date.getDate()).padStart(2, '0');
}

// 날짜와 시간 포맷팅 함수 (YYYY-MM-DD HH:mm:ss)
function formatDateTime(dateString) {
    if (!dateString) return '';
    const date = new Date(dateString);
    return formatDate(dateString) + ' ' +
        String(date.getHours()).padStart(2, '0') + ':' +
        String(date.getMinutes()).padStart(2, '0') + ':' +
        String(date.getSeconds()).padStart(2, '0');
}

// 테이블 데이터 표시 함수
function displayTableData(data, tableId, columns, options = {}) {
    const $table = $(tableId);
    $table.find('tbody').empty();
    
    if (!data || data.length === 0) {
        $table.find('tbody').append(`<tr><td colspan="${columns.length}" class="no-data">데이터가 없습니다.</td></tr>`);
        return;
    }
    
    data.forEach(function(item) {
        let row = '<tr>';
        columns.forEach(function(col) {
            if (col.formatter) {
                row += `<td>${col.formatter(item[col.field])}</td>`;
            } else {
                row += `<td>${item[col.field] || ''}</td>`;
            }
        });
        row += '</tr>';
        $table.find('tbody').append(row);
    });
}

// 검색 기능 공통 함수
function handleSearch(searchUrl, searchInput, callback) {
    const searchText = $(searchInput).val().trim();
    
    if (!searchText) {
        callback([]);
        return;
    }
    
    set_server(searchUrl + '?searchText=' + encodeURIComponent(searchText), callback);
}

// 페이지네이션 초기화 공통 함수
function initPagination(options) {
    return new Pagination({
        container: $(options.container),
        itemsPerPage: options.itemsPerPage || 10,
        onPageChange: options.onPageChange,
        totalItems: options.totalItems || 0
    });
}

// 알림 메시지 표시 함수
function showNotification(message, type = 'info') {
    const notification = $(`
        <div class="notification ${type}">
            <div class="notification-content">
                <i class="fas ${type === 'success' ? 'fa-check-circle' : 
                              type === 'error' ? 'fa-exclamation-circle' : 
                              'fa-info-circle'}"></i>
                <span>${message}</span>
            </div>
            <button class="notification-close">
                <i class="fas fa-times"></i>
            </button>
        </div>
    `);
    
    $('body').append(notification);
    
    // 3초 후 자동으로 사라짐
    setTimeout(() => {
        notification.fadeOut(300, function() {
            $(this).remove();
        });
    }, 3000);
    
    // 닫기 버튼 클릭 이벤트
    notification.find('.notification-close').on('click', function() {
        notification.fadeOut(300, function() {
            $(this).remove();
        });
    });
}

// 데이터 유효성 검사 함수
function validateData(data, rules) {
    const errors = {};
    
    for (const field in rules) {
        const value = data[field];
        const rule = rules[field];
        
        if (rule.required && !value) {
            errors[field] = rule.message || '필수 입력 항목입니다.';
        }
        
        if (rule.pattern && value && !rule.pattern.test(value)) {
            errors[field] = rule.message || '올바른 형식이 아닙니다.';
        }
        
        if (rule.minLength && value && value.length < rule.minLength) {
            errors[field] = rule.message || `최소 ${rule.minLength}자 이상 입력해주세요.`;
        }
        
        if (rule.maxLength && value && value.length > rule.maxLength) {
            errors[field] = rule.message || `최대 ${rule.maxLength}자까지 입력 가능합니다.`;
        }
    }
    
    return {
        isValid: Object.keys(errors).length === 0,
        errors: errors
    };
}

// 로딩 인디케이터 표시/숨김 함수
function showLoading() {
    if ($('#loading-indicator').length === 0) {
        $('body').append(`
            <div id="loading-indicator">
                <div class="spinner"></div>
            </div>
        `);
    }
    $('#loading-indicator').fadeIn(200);
}

function hideLoading() {
    $('#loading-indicator').fadeOut(200);
}
 
 
