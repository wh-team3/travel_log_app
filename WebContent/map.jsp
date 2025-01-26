<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ include file="WEB-INF/header.jsp"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>旅行記録 - 地図</title>
<link rel="stylesheet" href="css/style.css">

<!-- HighchartsとProj4jsをロード -->
<script src="https://code.highcharts.com/maps/highmaps.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.8.0/proj4.js"></script>
<script>
    Highcharts.maps["proj4"] = window.proj4; // Proj4jsをHighchartsに関連付け
</script>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background: url('images/map-background.png') no-repeat center center
		fixed;
	background-size: cover;
	color: #fff;
}

.left-panel {
	position: fixed;
	top: 30px; /* 上部からの位置 */
	left: 20px; /* 左からの位置 */
	width: 300px; /* 幅を固定 */
	margin-bottom: 100px;
	background: none; /* 背景を削除 */
	box-shadow: none; /* ボックス影を削除 */
	border-radius: 0; /* ボックス角丸を削除 */
}

.left-panel h1 {
	font-size: 2.5em;
	margin: 10;
	padding: 0;
	color: #f9f9e2;
}

.search-container {
	display: flex;
	gap: 10px;
}

.search-container select, .search-container button {
	padding: 15px;
	font-size: 1em;
	border: none;
	border-radius: 5px;
	font-weight: bold;
}

.search-container select {
	background: #fff;
	color: #333;
}

.search-container button {
	padding: 10px 20px;
	font-size: 20px;
	background-color: #e6a770;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	letter-spacing: 15px; /* 文字間隔を広げる */
	text-align: center;
	font-weight: bold;
}

.search-container button:hover {
	background-color: #ff8c00;
}

.legend {
	position: fixed; /* 固定 */
	bottom: 20px;
	left: 20px;
	width: 130px;
	height: auto;
	background-color: rgba(255, 255, 255, 0.9);
	border: 1px solid #ccc;
	border-radius: 8px;
	padding: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	font-family: Arial, sans-serif;
}

.legend h3 {
	position: absolute;
	top: -40px;
	left: -10px;
	background-color: #a39078;
	color: white;
	padding: 7px 20px;
	border-radius: 5px;
	font-size: 15px;
	font-weight: bold;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

.legend ul {
	list-style: none;
	padding: 0;
	margin: 0;
	text-align: left;
}

.legend li {
	display: flex;
	align-items: center;
	margin-left: 15px;
	margin: 5px 0;
	font-size: 22px;
	color: #333;
}

.legend li span {
	display: inline-block;
	width: 22px;
	height: 22px;
	margin-right: 15px;
	border: 1px solid #000;
	box-sizing: border-box;
}

#map-container {
	margin-left: 320px; /* 左パネルの幅 + 余白 */
	flex-grow: 1;
	height: 150vh;
	background: transparent;
}

header {
	position: fixed; /* 固定する */
	top: 0; /* 上部に配置 */
	left: 0; /* 左端に配置 */
	width: 100%; /* ヘッダーを画面幅いっぱいに広げる */
	background-color: #fff; /* 背景色（任意） */
	z-index: 1000; /* 他の要素よりも前面に表示 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 軽い影を追加（オプション） */
}
</style>
</head>
<body>
	<div class="container">
		<!-- 左側パネル -->
		<div class="left-panel">
			<h1>記録を表示</h1>
			<div class="search-container">
				<select id="prefecture" required>
					<option value="" disabled selected>訪問した県を選択</option>
					<option value="北海道">北海道</option>
					<option value="青森県">青森県</option>
					<option value="岩手県">岩手県</option>
					<option value="宮城県">宮城県</option>
					<option value="秋田県">秋田県</option>
					<option value="山形県">山形県</option>
					<option value="福島県">福島県</option>
					<option value="茨城県">茨城県</option>
					<option value="栃木県">栃木県</option>
					<option value="群馬県">群馬県</option>
					<option value="埼玉県">埼玉県</option>
					<option value="千葉県">千葉県</option>
					<option value="東京都">東京都</option>
					<option value="神奈川県">神奈川県</option>
					<option value="新潟県">新潟県</option>
					<option value="富山県">富山県</option>
					<option value="石川県">石川県</option>
					<option value="福井県">福井県</option>
					<option value="山梨県">山梨県</option>
					<option value="長野県">長野県</option>
					<option value="岐阜県">岐阜県</option>
					<option value="静岡県">静岡県</option>
					<option value="愛知県">愛知県</option>
					<option value="三重県">三重県</option>
					<option value="滋賀県">滋賀県</option>
					<option value="京都府">京都府</option>
					<option value="大阪府">大阪府</option>
					<option value="兵庫県">兵庫県</option>
					<option value="奈良県">奈良県</option>
					<option value="和歌山県">和歌山県</option>
					<option value="鳥取県">鳥取県</option>
					<option value="島根県">島根県</option>
					<option value="岡山県">岡山県</option>
					<option value="広島県">広島県</option>
					<option value="山口県">山口県</option>
					<option value="徳島県">徳島県</option>
					<option value="香川県">香川県</option>
					<option value="愛媛県">愛媛県</option>
					<option value="高知県">高知県</option>
					<option value="福岡県">福岡県</option>
					<option value="佐賀県">佐賀県</option>
					<option value="長崎県">長崎県</option>
					<option value="熊本県">熊本県</option>
					<option value="大分県">大分県</option>
					<option value="宮崎県">宮崎県</option>
					<option value="鹿児島県">鹿児島県</option>
					<option value="沖縄県">沖縄県</option>
				</select>
				<button type="button" id="searchButton">検索</button>
			</div>
			<div class="legend">
				<h3>訪問回数</h3>
				<ul>
					<li><span style="background-color: #ADD8E6;"></span> <label>1~3</label>
					</li>
					<li><span style="background-color: #90EE90;"></span> <label>4~6</label>
					</li>
					<li><span style="background-color: #FFD700;"></span> <label>7~9</label>
					</li>
					<li><span style="background-color: #FF4500;"></span> <label>10+</label>
					</li>
				</ul>
			</div>
		</div>

		<!-- 地図のコンテナ -->
		<div id="map-container"></div>
	</div>

	<script>
        document.addEventListener('DOMContentLoaded', function () {
            fetch('/WebApp/GetVisitCountsServlet')
                .then(response => response.json())
                .then(visitCounts => {
                    return fetch('mapdata/jp-all.topo.json')
                        .then(response => response.json())
                        .then(mapData => ({ mapData, visitCounts }));
                })
                .then(({ mapData, visitCounts }) => {
                	const colorScale = [
                	    { threshold: 3, color: '#ADD8E6' }, // 1～3: 水色
                	    { threshold: 6, color: '#90EE90' }, // 4～6: 黄緑
                	    { threshold: 9, color: '#FFD700' }, // 7～9: 黄色
                	    { threshold: Infinity, color: '#FF4500' } // 10以上: 赤
                	];

                	// データに色を設定
                	const data = Object.entries(visitCounts).map(([prefecture, count]) => {
                	    const color = colorScale.find(scale => count <= scale.threshold).color;
                	    return { 'hc-key': prefectureMap[prefecture], value: count, color };
                	});

                    Highcharts.mapChart('map-container', {
                        chart: {
                            map: mapData,
                            backgroundColor: 'transparent'
                        },
                        title: {
                            text: null
                        },
                        tooltip: {
                            enabled: true
                        },
                        series: [{
                            data,
                            name: '訪問回数',
                            joinBy: 'hc-key', // 必要に応じてキーを指定
                            states: {
                                hover: {
                                    color: false // ホバー時の色
                                }
                            },
                            dataLabels: {
                                enabled: false
                            },
                            colorKey: 'color' // カスタムカラーキーを有効にする
                        }]
                    });
                })
                .catch(error => console.error('エラー:', error));

            const prefectureMap = {
            		"北海道": "jp-hk",
        	        "青森県": "jp-ao",
        	        "岩手県": "jp-iw",
        	        "宮城県": "jp-mg",
        	        "秋田県": "jp-ak",
        	        "山形県": "jp-yt",
        	        "福島県": "jp-fs",
        	        "茨城県": "jp-ib",
        	        "栃木県": "jp-tc",
        	        "群馬県": "jp-gu",
        	        "埼玉県": "jp-st",
        	        "千葉県": "jp-ch",
        	        "東京都": "jp-tk",
        	        "神奈川県": "jp-kn",
        	        "新潟県": "jp-ni",
        	        "富山県": "jp-ty",
        	        "石川県": "jp-is",
        	        "福井県": "jp-fi",
        	        "山梨県": "jp-yn",
        	        "長野県": "jp-nn",
        	        "岐阜県": "jp-gf",
        	        "静岡県": "jp-sz",
        	        "愛知県": "jp-ai",
        	        "三重県": "jp-me",
        	        "滋賀県": "jp-sh",
        	        "京都府": "jp-ky",
        	        "大阪府": "jp-os",
        	        "兵庫県": "jp-hg",
        	        "奈良県": "jp-nr",
        	        "和歌山県": "jp-wk",
        	        "鳥取県": "jp-tt",
        	        "島根県": "jp-sm",
        	        "岡山県": "jp-oy",
        	        "広島県": "jp-hs",
        	        "山口県": "jp-yc",
        	        "徳島県": "jp-ts",
        	        "香川県": "jp-kg",
        	        "愛媛県": "jp-eh",
        	        "高知県": "jp-kc",
        	        "福岡県": "jp-fo",
        	        "佐賀県": "jp-sg",
        	        "長崎県": "jp-3461",
        	        "熊本県": "jp-km",
        	        "大分県": "jp-ot",
        	        "宮崎県": "jp-mz",
        	        "鹿児島県": "jp-3457",
        	        "沖縄県": "jp-3302"

            };

            document.getElementById('searchButton').addEventListener('click', function () {
                const selectedPrefecture = document.getElementById('prefecture').value;
                if (selectedPrefecture) {
                    window.location.href = 'viewRecords.jsp?prefecture=' + encodeURIComponent(selectedPrefecture);
                } else {
                    alert('都道府県を選択してください！');
                }
            });
        });
    </script>
</body>
</html>
