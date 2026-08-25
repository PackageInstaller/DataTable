__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = "解像度を切り替えた後、クライアントを再起動する必要がありますが、よろしいですか？"
  },
  TipsType_100001_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_100001_RightBtnDesc = {Text = "確認"},
  TipsType_100001_Title = {
    Text = "解像度切り替え確認"
  },
  TipsType_100002_Desc = {
    Text = "{s1} が再戦の招待を受け取るのを待っています。"
  },
  TipsType_100002_RightBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_100002_Title = {Text = "再戦"},
  TipsType_100003_Desc = {
    Text = "{s1} が再戦に招待しています。"
  },
  TipsType_100003_LeftBtnDesc = {Text = "拒否"},
  TipsType_100003_RightBtnDesc = {Text = "承諾"},
  TipsType_100003_Title = {Text = "再戦"},
  TipsType_100004_Desc = {
    Text = "現在の寮の背景です。"
  },
  TipsType_100005_Desc = {
    Text = "対人戦はまだ未開放です。"
  },
  TipsType_100006_Desc = {
    Text = "相手はまだ対人戦が未開放です。"
  },
  TipsType_100007_Desc = {
    Text = "相互フォローでフレンドマッチができます。"
  },
  TipsType_100008_Desc = {
    Text = "相手はオフラインです。"
  },
  TipsType_100009_Desc = {
    Text = "相手は探索中です。"
  },
  TipsType_100010_Desc = {
    Text = "フレンドマッチの待機時間が切れました。"
  },
  TipsType_100011_Desc = {
    Text = "フレンドマッチをキャンセルしました。"
  },
  TipsType_100012_Desc = {
    Text = "フレンドマッチの招待が拒否されました。"
  },
  TipsType_100012_LeftBtnDesc = {Text = "確認"},
  TipsType_100012_Title = {Text = "ヒント"},
  TipsType_100013_Desc = {
    Text = "相手はオフラインです。"
  },
  TipsType_100014_Desc = {
    Text = "相手は他のモードに入りました。"
  },
  TipsType_100015_Desc = {
    Text = "招待が多すぎます、{s1}秒後に再試行してください。"
  },
  TipsType_100016_Desc = {
    Text = "相手がフレンドマッチをキャンセルしました。"
  },
  TipsType_100016_LeftBtnDesc = {Text = "確認"},
  TipsType_100016_Title = {Text = "ヒント"},
  TipsType_100017_Desc = {
    Text = "このプレイヤーはフレンドマッチ中です。"
  },
  TipsType_100017_LeftBtnDesc = {Text = "確認"},
  TipsType_100017_Title = {Text = "ヒント"},
  TipsType_100018_Desc = {
    Text = "現在の編成に期限付きのカードが含まれています。\n今シーズンの核心課題を解放することで、\n継続して使用することが可能です。\n核心課題の解放画面へ移動しますか？"
  },
  TipsType_100018_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_100018_RightBtnDesc = {Text = "確認"},
  TipsType_100018_Title = {
    Text = "核心課題の期限終了"
  },
  TipsType_100020_Desc = {
    Text = "調査中にアプリが終了しました。調査を継続しますか？"
  },
  TipsType_100020_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_100020_RightBtnDesc = {Text = "確認"},
  TipsType_100020_Title = {Text = "ヒント"},
  TipsType_10002_Desc = {
    Text = "配置表エラー"
  },
  TipsType_10003_Desc = {
    Text = "クライアントデータエラー"
  },
  TipsType_10004_Desc = {
    Text = "サーバー未起動"
  },
  TipsType_10005_Desc = {
    Text = "キャラクターデータエラー"
  },
  TipsType_10006_Desc = {
    Text = "覚醒体データが見つかりません"
  },
  TipsType_10007_Desc = {
    Text = "覚醒体が最大レベルに達しています"
  },
  TipsType_10008_Desc = {
    Text = "課題ポイントが不足しています"
  },
  TipsType_10009_Desc = {
    Text = "覚醒体が最大レベルに達していないため、霊知啓発できません"
  },
  TipsType_100100_Desc = {
    Text = "ゲームのバージョンが更新されました。自動更新されない場合は、Steamを再起動して更新を確認してください。"
  },
  TipsType_100100_RightBtnDesc = {Text = "確認"},
  TipsType_100100_Title = {
    Text = "更新のヒント"
  },
  TipsType_10010_Desc = {
    Text = "霊知啓発完了"
  },
  TipsType_10011_Desc = {
    Text = "キャラクターが未作成です"
  },
  TipsType_10012_Desc = {
    Text = "現在キャラクターがいます"
  },
  TipsType_10013_Desc = {
    Text = "キャラクター名が重複しています"
  },
  TipsType_10014_Desc = {
    Text = "密境エリアエラー"
  },
  TipsType_10015_Desc = {
    Text = "密境エリアを特定できません"
  },
  TipsType_10016_Desc = {
    Text = "現在のスタミナが低すぎます"
  },
  TipsType_10017_Desc = {
    Text = "{s1}から{s2}で解放可能"
  },
  TipsType_10018_Desc = {
    Text = "この密境の第2層に1回到達後、即時完了可能"
  },
  TipsType_10019_Desc = {
    Text = "事件完了"
  },
  TipsType_10020_Desc = {
    Text = "事件設定表のタイプ記入エラー"
  },
  TipsType_10021_Desc = {
    Text = "事件が存在しません"
  },
  TipsType_10022_Desc = {
    Text = "黒章が不足しているため購入できません"
  },
  TipsType_10023_Desc = {
    Text = "このカードは強化できません"
  },
  TipsType_10024_Desc = {
    Text = "このカードは強化上限に達しています"
  },
  TipsType_10025_Desc = {
    Text = "行商人はこの商品を販売していません"
  },
  TipsType_10026_Desc = {
    Text = "この報酬はありません"
  },
  TipsType_10027_Desc = {
    Text = "報酬を受け取りました"
  },
  TipsType_10028_Desc = {
    Text = "事件データエラー"
  },
  TipsType_10029_Desc = {
    Text = "商品は購入済みです"
  },
  TipsType_10030_Desc = {
    Text = "現在のエネルギーではポータルを起動できません。ポータルの起動には{s1}点のエネルギーが必要です。"
  },
  TipsType_10031_Desc = {
    Text = "ストーリーイベントが見つかりません"
  },
  TipsType_10032_Desc = {
    Text = "事件選択指令カードが不足しています"
  },
  TipsType_10033_Desc = {
    Text = "事件選択指令カードが多すぎます"
  },
  TipsType_10034_Desc = {
    Text = "事件選択指令カードが存在しません"
  },
  TipsType_10035_Desc = {
    Text = "ランダムイベントプールにデータなし"
  },
  TipsType_10036_Desc = {
    Text = "行商人はこの商品を販売していません"
  },
  TipsType_10037_Desc = {
    Text = "事件選択遺物が不足しています"
  },
  TipsType_10038_Desc = {
    Text = "事件選択遺物が多すぎます"
  },
  TipsType_10039_Desc = {
    Text = "事件選択遺物が存在しません"
  },
  TipsType_10040_Desc = {
    Text = "このイベントノードは見つかりません"
  },
  TipsType_10041_Desc = {
    Text = "行商の更新回数が尽きました"
  },
  TipsType_10042_Desc = {
    Text = "戦闘でのドロップ指令カードの更新回数が尽きました"
  },
  TipsType_10043_Desc = {
    Text = "戦闘でのドロップ遺物の更新回数が尽きました"
  },
  TipsType_10044_Desc = {
    Text = "休憩所の機能がロックされています"
  },
  TipsType_10045_Desc = {
    Text = "事件エリアが一致しません。現在のエリア：{s1}、事件設定エリア：{s2}"
  },
  TipsType_10046_Desc = {
    Text = "事件ショップのカード削除回数が尽きました。"
  },
  TipsType_10047_Desc = {
    Text = "課題ユニットデータが見つかりません"
  },
  TipsType_10048_Desc = {
    Text = "ユニットは提出済みです、再提出は不要です"
  },
  TipsType_10049_Desc = {
    Text = "ユニット内の課題がすべて完了していないため、提出できません"
  },
  TipsType_10050_Desc = {
    Text = "課題モジュールが見つかりません"
  },
  TipsType_10051_Desc = {
    Text = "ステージに課題データがありません"
  },
  TipsType_10052_Desc = {
    Text = "この密境に対応する課題はありません"
  },
  TipsType_10053_Desc = {
    Text = "クレジットが足りず、報酬を受け取れません"
  },
  TipsType_10054_Desc = {
    Text = "クレジット報酬の受け取り条件に達していません"
  },
  TipsType_10055_Desc = {
    Text = "課題分の任務が見つかりません"
  },
  TipsType_10056_Desc = {
    Text = "課題分の任務が完了しました"
  },
  TipsType_10057_Desc = {
    Text = "課題分の任務のサブタスクが未完了です"
  },
  TipsType_10058_Desc = {
    Text = "NPCがトリガーされました"
  },
  TipsType_10059_Desc = {
    Text = "NPCデータエラー"
  },
  TipsType_10060_Desc = {
    Text = "NPCが存在しません"
  },
  TipsType_10061_Desc = {
    Text = "密境内で発見されませんでした"
  },
  TipsType_10062_Desc = {
    Text = "共鳴データが見つかりません"
  },
  TipsType_10063_Desc = {
    Text = "共鳴が最大レベルに達しました"
  },
  TipsType_10064_Desc = {
    Text = "共鳴レベル関連データが見つかりません"
  },
  TipsType_10065_Desc = {
    Text = "リセット回数がありません"
  },
  TipsType_10066_Desc = {
    Text = "共鳴の起動条件が未達成です"
  },
  TipsType_10067_Desc = {
    Text = "共鳴粒子が不足しています"
  },
  TipsType_10068_Desc = {
    Text = "霊知啓発が完了しており、再度行えません"
  },
  TipsType_10069_Desc = {
    Text = "霊知啓発に必要な素材が不足しています"
  },
  TipsType_10070_Desc = {
    Text = "覚醒体のレベルアップに必要な素材が不足しています"
  },
  TipsType_10071_Desc = {
    Text = "覚醒体のレベルアップに必要な金券が不足しています"
  },
  TipsType_10072_Desc = {
    Text = "覚醒体のレベルアップに必要な金券が不足しています。"
  },
  TipsType_10073_Desc = {
    Text = "覚醒体のスキルがありません。"
  },
  TipsType_10074_Desc = {
    Text = "覚醒体のスキルが未解放です。"
  },
  TipsType_10075_Desc = {
    Text = "覚醒に必要なシルバーコアが不足しています。"
  },
  TipsType_10076_Desc = {
    Text = "アイテムが不足しています。"
  },
  TipsType_10077_Desc = {
    Text = "本日の購入回数が上限に達しました。"
  },
  TipsType_10078_Desc = {
    Text = "アイテムは使用できません。"
  },
  TipsType_10079_Desc = {
    Text = "アイテムの使用数が間違っています。"
  },
  TipsType_10080_Desc = {
    Text = "スキルは最大レベルに達しています。"
  },
  TipsType_10081_Desc = {
    Text = "素材不足のため、強化できません。"
  },
  TipsType_10082_Desc = {
    Text = "通貨不足のため、強化できません。"
  },
  TipsType_10083_Desc = {
    Text = "覚醒体の同調率が最大レベルに達しました。"
  },
  TipsType_10084_Desc = {
    Text = "この覚醒体のリソースが不足しています。"
  },
  TipsType_10085_Desc = {
    Text = "アップグレードルートにキャラIDが設定されていません"
  },
  TipsType_10086_Desc = {
    Text = "指定された専用カード情報が見つかりません。"
  },
  TipsType_10087_Desc = {
    Text = "指定された専用カードが解放されていません。"
  },
  TipsType_10088_Desc = {
    Text = "この専用カードのUUIDが見つかりません。"
  },
  TipsType_10089_Desc = {
    Text = "章の報酬がポイントに達していません。"
  },
  TipsType_10090_Desc = {
    Text = "章の報酬は既に受け取り済みです。"
  },
  TipsType_10091_Desc = {
    Text = "選択したストーリーラインは未解放です。"
  },
  TipsType_10092_Desc = {
    Text = "選択したステージは未解放です。"
  },
  TipsType_10093_Desc = {
    Text = "ステージエリア未解放です。"
  },
  TipsType_10094_Desc = {
    Text = "未解放です。"
  },
  TipsType_10095_Desc = {
    Text = "ステージチャレンジのストーリーラインが見つかりません"
  },
  TipsType_10096_Desc = {
    Text = "ステージチャレンジのストーリーライン任務が見つかりません"
  },
  TipsType_10097_Desc = {
    Text = "挑戦任務は完了済み、報酬を再度受け取れません。"
  },
  TipsType_10098_Desc = {
    Text = "挑戦任務は未完了、報酬を受け取れません。"
  },
  TipsType_10099_Desc = {
    Text = "建物が存在しません。"
  },
  TipsType_10100_Desc = {
    Text = "建物は最大レベルに達しています。"
  },
  TipsType_10101_Desc = {
    Text = "建物のアップグレード/建設条件が不足しています。"
  },
  TipsType_10102_Desc = {
    Text = "建物は既に存在します。再建設できません。"
  },
  TipsType_10103_Desc = {
    Text = "アップグレード/建設に必要なアイテムが不足しています。"
  },
  TipsType_10104_Desc = {
    Text = "位置に覚醒体が既に存在し、入居できません。"
  },
  TipsType_10105_Desc = {
    Text = "合成に必要な他のアイテムが不足しています。"
  },
  TipsType_10106_Desc = {
    Text = "合成に必要な通貨が不足しています。"
  },
  TipsType_10107_Desc = {
    Text = "合成道具が未解放です。"
  },
  TipsType_10108_Desc = {
    Text = "サーバー接続に失敗しました。ネットワークを確認して再試行してください。"
  },
  TipsType_10109_Desc = {
    Text = "選択したキャンプ機能は再度選択できません。"
  },
  TipsType_10110_Desc = {
    Text = "キャンプ機能の使用回数がありません。"
  },
  TipsType_10111_Desc = {
    Text = "専用カードがアップグレードされていないため、切り替えできません。"
  },
  TipsType_10112_Desc = {
    Text = "専用カードに変化がないため、切り替えできません。"
  },
  TipsType_10113_Desc = {
    Text = "専用カードの切り替えに失敗しました。"
  },
  TipsType_10114_Desc = {
    Text = "覚醒体{s1}を獲得"
  },
  TipsType_10115_Desc = {
    Text = "{s1}を重複取得、{s2}{s3}に変換済み。"
  },
  TipsType_10116_Desc = {
    Text = "{s1}証が上限を超え、{s2}{s3}に変換されました。"
  },
  TipsType_10117_Desc = {
    Text = "ログのアップロードに成功しました。"
  },
  TipsType_10118_Desc = {
    Text = "指令が一致しません、現在の指令は {s1}、入力されたのは {s2}"
  },
  TipsType_10119_Desc = {
    Text = "カードを失いました:{s1}; uid:{s2}"
  },
  TipsType_10120_Desc = {
    Text = "解放不可"
  },
  TipsType_10121_Desc = {
    Text = "このスキルはありません。"
  },
  TipsType_10122_Desc = {
    Text = "スキルはクールダウン中です。"
  },
  TipsType_10123_Desc = {
    Text = "スキル回数が尽きました。"
  },
  TipsType_10124_Desc = {
    Text = "建物Tid {s1} の関連建物のアップグレード順序が循環しているか確認する。"
  },
  TipsType_10125_Desc = {
    Text = "建物Tid {s1} の関連設定がないか確認する。"
  },
  TipsType_10126_Desc = {
    Text = "建物Tid {s1} の実際のレベルは {s2} で、設定は {s3}"
  },
  TipsType_10127_Desc = {
    Text = "建物タイプの設定が見つかりません。"
  },
  TipsType_10128_Desc = {
    Text = "建物の設定が見つからないか、建物タイプがありません。"
  },
  TipsType_10129_Desc = {
    Text = "このストーリーラインの課題は未開放です。"
  },
  TipsType_10130_Desc = {
    Text = "削除成功"
  },
  TipsType_10131_Desc = {
    Text = "「エンフェリン」× {s1} の増加に成功しました"
  },
  TipsType_10132_Desc = {
    Text = "修復完了"
  },
  TipsType_10133_Desc = {
    Text = "GM アイテム追加：アイテム名【\"..arg1..\"】に該当するアイテムが見つかりません"
  },
  TipsType_10134_Desc = {
    Text = "事件【\"..arg1..\"】は存在しません。"
  },
  TipsType_10135_Desc = {
    Text = "現在：{s1}を押す"
  },
  TipsType_10136_Desc = {
    Text = "スキルアップ成功"
  },
  TipsType_10138_Desc = {
    Text = "サーバー時間の変更成功"
  },
  TipsType_10139_Desc = {
    Text = "サーバー時間の変更失敗"
  },
  TipsType_10140_Desc = {
    Text = "建物総数：17\nこの仮バージョンでは一部の建物のみ開放"
  },
  TipsType_10141_Desc = {
    Text = "建物の解放条件未達成"
  },
  TipsType_10142_Desc = {
    Text = "建物:{s1}配置の画面が存在しません {s2}"
  },
  TipsType_10143_Desc = {
    Text = "この合成素材のレシピはまだ解放されていません。"
  },
  TipsType_10144_Desc = {
    Text = "素材が不足しています。"
  },
  TipsType_10146_Desc = {
    Text = "レベルアップ成功"
  },
  TipsType_10147_Desc = {
    Text = "敵リストが空です。戦闘に入れません"
  },
  TipsType_10148_Desc = {
    Text = "「エンフェリン」回復"
  },
  TipsType_10149_Desc = {
    Text = "入力されたキャラクターIDが重複しているため、戦闘に入れません。"
  },
  TipsType_10150_Desc = {
    Text = "入力されたID{s1}は存在しないため、戦闘に入れません"
  },
  TipsType_10151_Desc = {
    Text = "敵に対応する動作がありません"
  },
  TipsType_10152_Desc = {
    Text = "未開放です。"
  },
  TipsType_10153_Desc = {
    Text = "現在のデッキにカードがありません"
  },
  TipsType_10154_Desc = {
    Text = "他のカードが有効中のため、カードを出せません"
  },
  TipsType_10155_Desc = {
    Text = "手札にないため、出せません。"
  },
  TipsType_10156_Desc = {
    Text = "このカードは出せない"
  },
  TipsType_10157_Desc = {
    Text = "このカードはスキルが設定されていません"
  },
  TipsType_10158_Desc = {
    Text = "このカードは出せない"
  },
  TipsType_10159_Desc = {
    Text = "行動力不足"
  },
  TipsType_10160_Desc = {
    Text = "場に対応する覚醒体がいません。"
  },
  TipsType_10161_Desc = {
    Text = "残り回数不足"
  },
  TipsType_10162_Desc = {
    Text = "探索スキルを使用"
  },
  TipsType_10163_Desc = {
    Text = "%d枚の指令カードを選択済み"
  },
  TipsType_10164_Desc = {
    Text = "数量上限に達しました"
  },
  TipsType_10165_Desc = {Text = "未選択"},
  TipsType_10166_Desc = {
    Text = "このカードは行動力を消費して使用できません"
  },
  TipsType_10167_Desc = {
    Text = "総消費量が超過しています。"
  },
  TipsType_10168_Desc = {
    Text = "{s1}枚のカードを選択済み"
  },
  TipsType_10169_Desc = {
    Text = "触腕の数が上限に達しました。"
  },
  TipsType_10170_Desc = {
    Text = "削除成功"
  },
  TipsType_10171_Desc = {
    Text = "強化成功"
  },
  TipsType_10172_Desc = {
    Text = "変更成功"
  },
  TipsType_10173_Desc = {
    Text = "クリップボードにコピーしました。"
  },
  TipsType_10174_Desc = {
    Text = "指令カード取得成功"
  },
  TipsType_10175_Desc = {
    Text = "削除回数が尽きました。"
  },
  TipsType_10176_Desc = {
    Text = "強化回数が尽きました。"
  },
  TipsType_10177_Desc = {
    Text = "変更回数が尽きました。"
  },
  TipsType_10178_Desc = {
    Text = "コピー回数が尽きました。"
  },
  TipsType_10179_Desc = {
    Text = "指令カードの選択数が上限に達しました。"
  },
  TipsType_10180_Desc = {
    Text = "指令カードが未選択です。"
  },
  TipsType_10181_Desc = {
    Text = "ショップは近日オープン予定です！"
  },
  TipsType_10182_Desc = {
    Text = "お楽しみに！"
  },
  TipsType_10183_Desc = {
    Text = "課題の目標エリアが遠く特定できません。"
  },
  TipsType_10184_Desc = {
    Text = "目標エリアを外れ、完了できません。"
  },
  TipsType_10185_Desc = {
    Text = "この課題はまだ解放されていません。"
  },
  TipsType_10186_Desc = {
    Text = "密境を探索して、さらに調査を解放"
  },
  TipsType_10187_Desc = {
    Text = "前提任務を完了して、さらに調査を解放"
  },
  TipsType_10188_Desc = {
    Text = "提出成功、課題ポイント+{s1}"
  },
  TipsType_10189_Desc = {
    Text = "提出できる課題がありません。"
  },
  TipsType_10190_Desc = {
    Text = "まだ開始されていません。ステージの開始時間に注意してください。"
  },
  TipsType_10191_Desc = {
    Text = "まだステージ解放条件に達していません。"
  },
  TipsType_10192_Desc = {
    Text = "{s1}は空にできません"
  },
  TipsType_10193_Desc = {
    Text = "{s1}と{s2}は空にできません"
  },
  TipsType_10194_Desc = {
    Text = "更新回数が尽きました、更新できません。"
  },
  TipsType_10195_Desc = {
    Text = "取得方法は未解放です。"
  },
  TipsType_10196_Desc = {
    Text = "取得方法は開放時間外です。"
  },
  TipsType_10197_Desc = {
    Text = "変更する遺物を選択してください。"
  },
  TipsType_10198_Desc = {
    Text = "削除成功"
  },
  TipsType_10199_Desc = {
    Text = "削除回数が尽きました。"
  },
  TipsType_10200_Desc = {
    Text = "変更回数が尽きました。"
  },
  TipsType_10201_Desc = {
    Text = "削除する遺物を選んでください。"
  },
  TipsType_10202_Desc = {
    Text = "数量が上限に達しました。"
  },
  TipsType_10203_Desc = {
    Text = "少なくとも{s1}個の遺物を選んでください。"
  },
  TipsType_10204_Desc = {
    Text = "現在の切り替え回数が0のため、切り替えができません。"
  },
  TipsType_10205_Desc = {
    Text = "すべての専用カードがレベル上限に達しています。"
  },
  TipsType_10206_Desc = {
    Text = "現在の警戒度が0のため、これ以上下げられません。"
  },
  TipsType_10207_Desc = {
    Text = "未開放です。"
  },
  TipsType_10208_Desc = {
    Text = "魂縛の錨が不足しており、強化できません。"
  },
  TipsType_10209_Desc = {
    Text = "{s1}の{s2}レベル到達が必要"
  },
  TipsType_10210_Desc = {
    Text = "{s1} 不足"
  },
  TipsType_10211_Desc = {
    Text = "「{s1}」を持っていません。"
  },
  TipsType_10212_Desc = {
    Text = "レベル上限に達しました。"
  },
  TipsType_10213_Desc = {
    Text = "素材を選んでください。"
  },
  TipsType_10214_Desc = {
    Text = "{s1} 不足"
  },
  TipsType_10215_Desc = {
    Text = "レベルアップ成功"
  },
  TipsType_10216_Desc = {
    Text = "霊知の薬剤増加"
  },
  TipsType_10217_Desc = {
    Text = "霊知啓発の上限に達しました。"
  },
  TipsType_10218_Desc = {
    Text = "レベルアップ失敗"
  },
  TipsType_10219_Desc = {
    Text = "アイテム不足でレベルアップできません。"
  },
  TipsType_10221_Desc = {
    Text = "スキルアップ成功"
  },
  TipsType_10222_Desc = {
    Text = "黒章が不足していて購入できません。"
  },
  TipsType_10223_Desc = {
    Text = "売り切れ"
  },
  TipsType_10224_Desc = {
    Text = "黒章が不足しているため、指令カードを削除できません。"
  },
  TipsType_10225_Desc = {
    Text = "指令カードを{s1}枚削除"
  },
  TipsType_10226_Desc = {
    Text = "この個所は未開放です。強化できません。"
  },
  TipsType_10227_Desc = {
    Text = "この個所は既に最大レベルに強化されています。"
  },
  TipsType_10228_Desc = {
    Text = "専用カードの強化個所を選んでください。"
  },
  TipsType_10229_Desc = {
    Text = "魂縛の錨が不足しており、強化できません。"
  },
  TipsType_10230_Desc = {
    Text = "この界域の覚醒体をまだ持っていないため、選択できません。"
  },
  TipsType_10231_Desc = {
    Text = "チームを作成する。"
  },
  TipsType_10232_Desc = {
    Text = "チーム名は{s1}文字以内にしてください。"
  },
  TipsType_10233_Desc = {
    Text = "チーム名を入力してください。"
  },
  TipsType_10234_Desc = {
    Text = "交換成功。"
  },
  TipsType_10235_Desc = {
    Text = "「シルバーコア」が足りません。"
  },
  TipsType_10236_Desc = {
    Text = "これ以上減らせません。"
  },
  TipsType_10237_Desc = {
    Text = "{s1} まだ開放されていません。"
  },
  TipsType_10238_Desc = {
    Text = "召喚はまだ開始されていません。"
  },
  TipsType_10239_Desc = {
    Text = "キャンパスのミニマップ機能はまだ利用できません。"
  },
  TipsType_10240_Desc = {
    Text = "課題レベル{s1}で解放"
  },
  TipsType_10241_Desc = {
    Text = "条件に合うカードがありません。"
  },
  TipsType_10242_Desc = {
    Text = "すべての界域カードがアップグレードされました。"
  },
  TipsType_10243_Desc = {
    Text = "強化可能な指令カードがありません。"
  },
  TipsType_10244_Desc = {
    Text = "新しい転送ポイントを発見！{s1}へ移動可能です。"
  },
  TipsType_10245_Desc = {
    Text = "この遺物はすでに取得済みで、再取得できません。"
  },
  TipsType_10246_Desc = {
    Text = "回復成功"
  },
  TipsType_10247_Desc = {
    Text = "削除成功"
  },
  TipsType_10248_Desc = {
    Text = "所持品画面を開く"
  },
  TipsType_10249_Desc = {
    Text = "前回異常終了が検出されました。「エンフェリン」と取得物資が返されましたので、所持品画面で確認してください。"
  },
  TipsType_10250_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10251_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10252_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10253_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10254_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10255_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10256_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10257_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10258_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10259_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10260_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10261_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10262_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10263_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10264_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10265_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10266_Desc = {
    Text = "AVG版では一部の建物のみ提供され、ここでは建物の総数が17であることを示します。"
  },
  TipsType_10267_Desc = {
    Text = "使用条件を満たしていません。"
  },
  TipsType_10268_Desc = {
    Text = "調査レベル2で即時完了を解放"
  },
  TipsType_10269_Desc = {
    Text = "接続中断"
  },
  TipsType_10270_Desc = {
    Text = "サーバー接続が切断されました。しばらくしてログインページに戻ります。"
  },
  TipsType_10271_Desc = {Text = "確認"},
  TipsType_10272_Desc = {
    Text = "サーバーは未開放です。しばらくしてからお試しください。"
  },
  TipsType_10274_Desc = {
    Text = "対応する密境が見つかりません"
  },
  TipsType_10275_Desc = {
    Text = "密境事件が完了しました。"
  },
  TipsType_10276_Desc = {
    Text = "密境事件の配置タイプが間違っています。"
  },
  TipsType_10277_Desc = {
    Text = "密境事件は存在しません。"
  },
  TipsType_10278_Desc = {
    Text = "黒章が不足しているため、購入できません。"
  },
  TipsType_10279_Desc = {
    Text = "このカードは強化できません。"
  },
  TipsType_10280_Desc = {
    Text = "このカードは強化上限に達しています。"
  },
  TipsType_10281_Desc = {
    Text = "行商人はこの商品を販売していません。"
  },
  TipsType_10282_Desc = {
    Text = "この報酬はありません。"
  },
  TipsType_10283_Desc = {
    Text = "報酬を受け取りました"
  },
  TipsType_10284_Desc = {
    Text = "配置表エラー"
  },
  TipsType_10285_Desc = {
    Text = "イベントデータエラー"
  },
  TipsType_10286_Desc = {
    Text = "商品購入済み"
  },
  TipsType_10287_Desc = {
    Text = "課題ユニットデータが見つかりません。"
  },
  TipsType_10288_Desc = {
    Text = "ユニットは提出済み、再提出は不要です。"
  },
  TipsType_10289_Desc = {
    Text = "ユニットの課題がすべて完了していないため、提出できません。"
  },
  TipsType_10290_Desc = {
    Text = "課題にモジュールがありません。"
  },
  TipsType_10291_Desc = {
    Text = "ステージに課題データがありません。"
  },
  TipsType_10292_Desc = {
    Text = "クライアントデータエラー"
  },
  TipsType_10293_Desc = {
    Text = "サービスが起動していません。"
  },
  TipsType_10294_Desc = {
    Text = "キャラクターデータエラー"
  },
  TipsType_10295_Desc = {
    Text = "キャラクターがいません、作成が必要です。"
  },
  TipsType_10296_Desc = {
    Text = "キャラクターが既に存在します、再作成は不要です。"
  },
  TipsType_10297_Desc = {
    Text = "キャラクター名が重複しています。"
  },
  TipsType_10298_Desc = {
    Text = "密境エラー"
  },
  TipsType_10299_Desc = {
    Text = "このストーリーラインは未解放で、入れません。"
  },
  TipsType_10300_Desc = {
    Text = "ここで地形効果や敵情報を確認できます。"
  },
  TipsType_10301_Desc = {
    Text = "{s1}が{s2}に達すると{s3}が解放されます。"
  },
  TipsType_10302_Desc = {
    Text = "{s1}が{s2}に達すると{s3}が解放されます。"
  },
  TipsType_10303_Desc = {
    Text = "建物の解放条件未達成"
  },
  TipsType_10304_Desc = {
    Text = "建物のアップグレード条件未達成"
  },
  TipsType_10305_Desc = {
    Text = "建物のアップグレード素材が不足しています。"
  },
  TipsType_10306_Desc = {
    Text = "受け取れる任務報酬があります。"
  },
  TipsType_10307_Desc = {
    Text = "（ライフが<Negative:10%%>減少します）"
  },
  TipsType_10308_Desc = {
    Text = "各ターン終了時、現在の加護ターン数に等しい<BuffTipBlock:シールド>を獲得。ダメージを受けるたびに加護が<BuffTip:1>ターン減少します"
  },
  TipsType_10309_Desc = {
    Text = "多重加護"
  },
  TipsType_10310_Desc = {
    Text = "スタミナが警戒値以下、調査リスクが高いです。"
  },
  TipsType_10311_Desc = {
    Text = "スタミナが警戒値以下、調査リスクが非常に高いです。強行しますか？"
  },
  TipsType_10312_Desc = {
    Text = "現在のスタミナが低すぎて密境に入れません。"
  },
  TipsType_10313_Desc = {
    Text = "同ランクの専用カードを選択してください。"
  },
  TipsType_10314_Desc = {
    Text = "覚醒体霊知啓発2段後に解放"
  },
  TipsType_10315_Desc = {
    Text = "覚醒体霊知啓発3段後に解放"
  },
  TipsType_10316_Desc = {Text = "現在"},
  TipsType_10317_Desc = {
    Text = "すべての覚醒体がスキルを解放しておらず、チャージできない。"
  },
  TipsType_10318_Desc = {
    Text = "すべての覚醒体スキルのエネルギーが満タン。"
  },
  TipsType_10319_Desc = {
    Text = "使用済み"
  },
  TipsType_10320_Desc = {
    Text = "黒章が不足しています。"
  },
  TipsType_10321_Desc = {
    Text = "黒章が不足しています。"
  },
  TipsType_10322_Desc = {
    Text = "黒章が不足しています。"
  },
  TipsType_10323_Desc = {
    Text = "既存の遺物は重複取得不可"
  },
  TipsType_10324_Desc = {
    Text = "更新回数不足"
  },
  TipsType_10325_Desc = {
    Text = "味方に{s1}ダメージを与える。"
  },
  TipsType_10326_Desc = {Text = "攻撃"},
  TipsType_10327_Desc = {
    Text = "ここではステージのミニマップが表示され、プレイヤーは事前に戦略を立てることができます。"
  },
  TipsType_10328_Desc = {
    Text = "日常ステージを10分でクリアし、独自のプレイ体験を得て流派への理解を深めました。"
  },
  TipsType_10329_Desc = {
    Text = "現在、最大ライフの50%未満です！注意してください。"
  },
  TipsType_10330_Desc = {
    Text = "覚醒体の存在を維持するエネルギー。ダメージを受けるとライフが減少し、ライフがゼロになると調査失敗となります。"
  },
  TipsType_10331_Desc = {
    Text = "覚醒体の攻撃力。力が強いほど、指令カード使用時の敵へのダメージが高くなります。"
  },
  TipsType_10332_Desc = {
    Text = "覚醒体の防御力。警戒が高いほど、指令カードを使用する際に獲得するシールドが増加。"
  },
  TipsType_10333_Desc = {
    Text = "タップで続行"
  },
  TipsType_10334_Desc = {
    Text = "任務の調査項目はまだ完了していません。"
  },
  TipsType_10335_Desc = {
    Text = "調査評価"
  },
  TipsType_10336_Desc = {
    Text = "専用カード1枚に啓示の力を付与"
  },
  TipsType_10337_Desc = {
    Text = "専用カードの強化個所を選択"
  },
  TipsType_10338_Desc = {
    Text = "メイン都市のミニマップはまだ開放されていません。"
  },
  TipsType_10339_Desc = {
    Text = "{s1}{s2}値"
  },
  TipsType_10340_Desc = {
    Text = "{s1}基本デッキレベルアップ"
  },
  TipsType_10342_Desc = {
    Text = "覚醒体との感情的なつながりを示す。好感度が深まると、覚醒体をより深く理解できる。"
  },
  TipsType_10343_Desc = {
    Text = "<Positive:現在のレベル：>{s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:基本デッキ：>"
  },
  TipsType_10345_Desc = {
    Text = "この界域に入るときの初期デッキ。"
  },
  TipsType_10346_Desc = {
    Text = "<Positive:デッキ最大レベル：>{s1}レベル"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:デッキレベル：>"
  },
  TipsType_10348_Desc = {
    Text = "この界域で指定された数の覚醒体が指定の好感度レベルに達すると、基本デッキをアップグレードできます。"
  },
  TipsType_10349_Desc = {
    Text = "<Positive:アップグレード内容：>"
  },
  TipsType_10350_Desc = {
    Text = "レベルアップするたびに、1つの指令カードの基本値が増加する。"
  },
  TipsType_10351_Desc = {
    Text = "{s1}好感度アップ"
  },
  TipsType_10352_Desc = {
    Text = "密境は静寂の中"
  },
  TipsType_10353_Desc = {
    Text = "密境は侵入者を排除する"
  },
  TipsType_10354_Desc = {
    Text = "密境の警戒度が増加"
  },
  TipsType_10355_Desc = {
    Text = "警戒度が{s1}に達し、密境があなたを見ている"
  },
  TipsType_10356_Desc = {
    Text = "霊知啓発1"
  },
  TipsType_10357_Desc = {
    Text = "このスキルを習得する"
  },
  TipsType_10358_Desc = {
    Text = "同時に存在できる触腕の最大数。"
  },
  TipsType_10359_Desc = {
    Text = "触腕の攻撃力です。触腕の力が強いほど、触腕発動時のダメージが高くなります。"
  },
  TipsType_10360_Desc = {
    Text = "指令カード未選択"
  },
  TipsType_10361_Desc = {
    Text = "変化成功"
  },
  TipsType_10362_Desc = {
    Text = "指令カード未選択"
  },
  TipsType_10363_Desc = {
    Text = "コピー成功"
  },
  TipsType_10364_Desc = {
    Text = "{s1}枚の指令カードを選択しました"
  },
  TipsType_10365_Desc = {
    Text = "指令カードが未選択です"
  },
  TipsType_10366_Desc = {
    Text = "指令カードが未選択です"
  },
  TipsType_10367_Desc = {
    Text = "レベルアップ成功"
  },
  TipsType_10368_Desc = {
    Text = "遺物バックパック画面開発中。"
  },
  TipsType_10369_Desc = {
    Text = "変更する遺物を選択してください。"
  },
  TipsType_10370_Desc = {
    Text = "バージョンが更新されました。再度インストールパッケージをダウンロードしてください"
  },
  TipsType_10371_Desc = {
    Text = "上級効果"
  },
  TipsType_10372_Desc = {
    Text = "密境情報"
  },
  TipsType_10373_Desc = {
    Text = "ダメージカードを1枚使用するごとに、触腕がランダムな敵に{s1}ダメージを与える。"
  },
  TipsType_10374_Desc = {
    Text = "現在、未完了の課題はありません。"
  },
  TipsType_10375_Desc = {
    Text = "現在、アーカイブされた課題はありません。"
  },
  TipsType_10376_Desc = {
    Text = "今回の調査は未完了です"
  },
  TipsType_10377_Desc = {
    Text = "戻れません"
  },
  TipsType_10378_Desc = {
    Text = "(以下の課題は自動的にアーカイブされました)"
  },
  TipsType_10379_Desc = {
    Text = "目標課題が完了しました。"
  },
  TipsType_10380_Desc = {
    Text = "このアイテムは持っていません"
  },
  TipsType_10381_Desc = {
    Text = "誤ったインデックス値"
  },
  TipsType_10382_Desc = {Text = "未解放"},
  TipsType_10383_Desc = {
    Text = "専用カードのレベルアップ回数がありません"
  },
  TipsType_10384_Desc = {
    Text = "遺物の所持枠を1つ解放！"
  },
  TipsType_10385_Desc = {
    Text = "同調率アップ"
  },
  TipsType_10386_Desc = {
    Text = "スロット情報なし"
  },
  TipsType_10387_Desc = {
    Text = "通貨不足"
  },
  TipsType_10388_Desc = {
    Text = "最大レベルに到達"
  },
  TipsType_10389_Desc = {
    Text = "開発中です。"
  },
  TipsType_10390_Desc = {
    Text = "手動スロット強化の回数なし"
  },
  TipsType_10391_Desc = {
    Text = "商店またはキャンプで封印解放後に使用可能"
  },
  TipsType_10392_Desc = {
    Text = "この戦闘で{s1}スタミナを消耗"
  },
  TipsType_10393_Desc = {
    Text = "覚醒体のエネルギーが満タンです。これ以上は増やせません。"
  },
  TipsType_10394_Desc = {
    Text = "すべての覚醒体のエネルギーを最大まで上げました。"
  },
  TipsType_10395_Desc = {
    Text = "「眼」を使って解放が必要です。"
  },
  TipsType_10396_Desc = {
    Text = "刻印に成功しました。"
  },
  TipsType_10397_Desc = {
    Text = "{s1}覚醒体を配置しました。チームは{s2}界域特性を持ちます。"
  },
  TipsType_10398_Desc = {
    Text = "チームは中立となり、界域特性を持ちません。"
  },
  TipsType_10399_Desc = {
    Text = "小循環システムは第4章のステージで解放されます。"
  },
  TipsType_10400_Desc = {
    Text = "最大で{s1}個の遺物を継承できます。選択数を減らしてください。"
  },
  TipsType_10401_Desc = {
    Text = "選択されていない遺物は継承できません。"
  },
  TipsType_10405_Desc = {
    Text = "{s1}を獲得しました。"
  },
  TipsType_10406_Desc = {
    Text = "出撃中の覚醒体が上限に達しました。"
  },
  TipsType_10407_Desc = {
    Text = "この黄金塔は挑戦不可："
  },
  TipsType_10408_Desc = {
    Text = "この黄金塔は未解放：指定された調査任務を完了してください。"
  },
  TipsType_10409_Desc = {
    Text = "出場する覚醒体を選択してください。"
  },
  TipsType_10410_Desc = {
    Text = "覚醒体は派遣任務中のため、後で受け取りに来てください。"
  },
  TipsType_10411_Desc = {
    Text = "{s1}薔薇金券を受け取りました。"
  },
  TipsType_10412_Desc = {
    Text = "時間報酬は時間と共に蓄積されます"
  },
  TipsType_10413_Desc = {
    Text = "「シルバーコア」不足"
  },
  TipsType_10414_Desc = {
    Text = "挑戦回数がありません"
  },
  TipsType_10415_Desc = {
    Text = "挑戦クールダウン中"
  },
  TipsType_10416_Desc = {
    Text = "対人戦相手がいません。"
  },
  TipsType_10417_Desc = {
    Text = "出陣する覚醒体を選択してください"
  },
  TipsType_10418_Desc = {
    Text = "霊知の薬剤が不足しており、レベルを上げられません。"
  },
  TipsType_10419_Desc = {
    Text = "現在のレベルが上限に達しています。"
  },
  TipsType_10420_Desc = {
    Text = "覚醒体はまだ解放されていません。"
  },
  TipsType_10421_Desc = {
    Text = "コレクション解放成功"
  },
  TipsType_10422_Desc = {
    Text = "ストーリーチャレンジの購入回数が不足しています。"
  },
  TipsType_10423_Desc = {
    Text = "ストーリーの星評価が足りず、掃討できません。"
  },
  TipsType_10424_Desc = {
    Text = "調査ステージのチーム編成が間違っています。"
  },
  TipsType_10425_Desc = {
    Text = "「シルバーコア」不足"
  },
  TipsType_10426_Desc = {
    Text = "今日の購入回数上限に達しました。"
  },
  TipsType_10427_Desc = {
    Text = "三つ星クリアで解放"
  },
  TipsType_10428_Desc = {
    Text = "{s1}枚の証を取得成功"
  },
  TipsType_10429_Desc = {
    Text = "{s1}回の挑戦回数を獲得成功"
  },
  TipsType_10430_Desc = {
    Text = "調査4-6をクリアで解放"
  },
  TipsType_10431_Desc = {
    Text = "証が不足しています。"
  },
  TipsType_10432_Desc = {
    Text = "購入回数が不足しています。"
  },
  TipsType_10433_Desc = {
    Text = "霊知啓発レベルが上限に達しました。"
  },
  TipsType_10434_Desc = {
    Text = "{s1} 不足"
  },
  TipsType_10435_Desc = {
    Text = "この商品は販売していません。"
  },
  TipsType_10436_Desc = {
    Text = "このタイプのショップはありません"
  },
  TipsType_10437_Desc = {
    Text = "販売商品は在庫切れです。"
  },
  TipsType_10438_Desc = {
    Text = "商店のデータがありません。"
  },
  TipsType_10439_Desc = {
    Text = "更新回数がありません"
  },
  TipsType_10440_Desc = {
    Text = "本日の「エンフェリン」購入回数上限に達しました。"
  },
  TipsType_10441_Desc = {
    Text = "覚醒体の欠片が不足しています。"
  },
  TipsType_10442_Desc = {
    Text = "霊知啓発ポイントは既に起動完了しています。"
  },
  TipsType_10443_Desc = {
    Text = "前の霊知啓発ポイントが未起動です。"
  },
  TipsType_10444_Desc = {
    Text = "「エンフェリン」× {s1} の購入に成功しました。"
  },
  TipsType_10445_Desc = {
    Text = "「エンフェリン」所持上限"
  },
  TipsType_10446_Desc = {
    Text = "調査1-12をクリアで解放"
  },
  TipsType_10447_Desc = {
    Text = "序章をクリアで解放"
  },
  TipsType_10448_Desc = {
    Text = "序章をクリアで解放"
  },
  TipsType_10449_Desc = {
    Text = "調査2-4をクリアで解放"
  },
  TipsType_10450_Desc = {
    Text = "このスキルのレベルは上限に達しています。"
  },
  TipsType_10451_Desc = {
    Text = "覚醒体のランクが不足しています。"
  },
  TipsType_10452_Desc = {
    Text = "スキル強化素材が不足しています。"
  },
  TipsType_10453_Desc = {
    Text = "調査3-15をクリアで解放"
  },
  TipsType_10454_Desc = {
    Text = "調査3-7をクリアで解放"
  },
  TipsType_10455_Desc = {
    Text = "スキルアップ条件未達成"
  },
  TipsType_10456_Desc = {
    Text = "テスト版の各チャージ項目は1回のみチャージ可能"
  },
  TipsType_10457_Desc = {
    Text = "この覚醒体は真貌顕現中、次のターンで再度使用可能"
  },
  TipsType_10458_Desc = {
    Text = "チャージ設定表にこの設定はありません"
  },
  TipsType_10459_Desc = {
    Text = "無料チャージ済みのため再チャージ不可"
  },
  TipsType_10460_Desc = {
    Text = "共鳴は既に起動完了済みのため、再度起動する必要はありません"
  },
  TipsType_10461_Desc = {
    Text = "アイテム{s1}の価格が変更されました、ご確認ください"
  },
  TipsType_10462_Desc = {
    Text = "薔薇金券が不足しています。"
  },
  TipsType_10463_Desc = {
    Text = "「演習勲章」が不足しています。"
  },
  TipsType_10464_Desc = {
    Text = "調査3-4をクリアで解放"
  },
  TipsType_10465_Desc = {
    Text = "調査2-16をクリアで解放"
  },
  TipsType_10466_Desc = {
    Text = "調査3-16をクリアで解放"
  },
  TipsType_10467_Desc = {
    Text = "調査4-12をクリアで解放"
  },
  TipsType_10468_Desc = {
    Text = "調査5-12をクリアで解放"
  },
  TipsType_10469_Desc = {
    Text = "調査6-12をクリアで解放"
  },
  TipsType_10470_Desc = {
    Text = "調査1-7をクリアで解放"
  },
  TipsType_10471_Desc = {
    Text = "装備成功"
  },
  TipsType_10472_Desc = {
    Text = "解放成功"
  },
  TipsType_10473_Desc = {
    Text = "最大レベルに到達しました。"
  },
  TipsType_10474_Desc = {
    Text = "薔薇金券が不足しています。"
  },
  TipsType_10475_Desc = {
    Text = "素材を選択してください。"
  },
  TipsType_10476_Desc = {
    Text = "ロックされています。解放してください。"
  },
  TipsType_10477_Desc = {
    Text = "ステージは未開放です。"
  },
  TipsType_10478_Desc = {
    Text = "戦闘外では未開放です。"
  },
  TipsType_10479_Desc = {
    Text = "捨て札が空です。"
  },
  TipsType_10480_Desc = {
    Text = "RPG戦闘調整中、現在は直接勝利を決定"
  },
  TipsType_10482_Desc = {
    Text = "運命の札はロックされています。"
  },
  TipsType_10483_Desc = {
    Text = "運命の札が見つかりません。"
  },
  TipsType_10484_Desc = {
    Text = "運命の札は最大ランクに達しています。"
  },
  TipsType_10485_Desc = {
    Text = "運命の札は装備されています。"
  },
  TipsType_10486_Desc = {
    Text = "運命の札が一致しません。"
  },
  TipsType_10487_Desc = {
    Text = "運命の札は未解放です。"
  },
  TipsType_10488_Desc = {
    Text = "「チーム」「救援」「密約セット」にある密約は分解できません。"
  },
  TipsType_10489_Desc = {
    Text = "「チーム」「救援」にある運命の札は分解できません。"
  },
  TipsType_10490_Desc = {
    Text = "狂気値不足、狂気解放できません。"
  },
  TipsType_10491_Desc = {
    Text = "先に前のギフトを取得してください"
  },
  TipsType_10492_Desc = {
    Text = "現在密約がロックされています、ロックを解放して使用しますか？"
  },
  TipsType_10493_Desc = {
    Text = "現在運命の札はロックされています、ロックを解放して使用しますか？"
  },
  TipsType_10494_Desc = {
    Text = "調査1-7をクリアで解放"
  },
  TipsType_10495_Desc = {
    Text = "調査1-13をクリアで解放"
  },
  TipsType_10496_Desc = {
    Text = "現在の密約レベルは上限に達しています。"
  },
  TipsType_10497_Desc = {
    Text = "ショップがリセットされました。"
  },
  TipsType_10498_Desc = {
    Text = "変更成功"
  },
  TipsType_10499_Desc = {
    Text = "お気に入りに追加しました。"
  },
  TipsType_10500_Desc = {
    Text = "強化成功"
  },
  TipsType_10501_Desc = {
    Text = "現在のチャレンジは未解放です。"
  },
  TipsType_10502_Desc = {
    Text = "現在の覚醒体は{s1}の他のステージで挑戦中のため、再出撃できません。"
  },
  TipsType_10503_Desc = {
    Text = "出陣覚醒体が4体未満で、挑戦できません。"
  },
  TipsType_10504_Desc = {
    Text = "調査3-7をクリアで解放"
  },
  TipsType_10505_Desc = {
    Text = "第1層で三つ星を達成すると解放"
  },
  TipsType_10506_Desc = {
    Text = "第2層で三つ星を達成すると解放"
  },
  TipsType_10507_Desc = {
    Text = "第3層で三つ星を達成すると解放"
  },
  TipsType_10508_Desc = {
    Text = "第4層で三つ星を達成すると解放"
  },
  TipsType_10509_Desc = {
    Text = "第5層で三つ星を達成すると解放"
  },
  TipsType_10510_Desc = {
    Text = "第6層で三つ星を達成すると解放"
  },
  TipsType_10511_Desc = {
    Text = "第7層で三つ星を達成すると解放"
  },
  TipsType_10512_Desc = {
    Text = "第8層で三つ星を達成すると解放"
  },
  TipsType_10513_Desc = {
    Text = "強化したい密約を選択してください。"
  },
  TipsType_10514_Desc = {
    Text = "受領済み"
  },
  TipsType_10515_Desc = {
    Text = "調査2-14をクリアで解放"
  },
  TipsType_10516_Desc = {
    Text = "調査4-7をクリアで解放"
  },
  TipsType_10517_Desc = {
    Text = "調査4-7をクリアで解放"
  },
  TipsType_10518_Desc = {
    Text = "チームが保存されました"
  },
  TipsType_10519_Desc = {
    Text = "光るエリアをタップして移動してください。"
  },
  TipsType_10520_Desc = {
    Text = "チーム名に使用できるのは漢字、英字、数字のみです。"
  },
  TipsType_10521_Desc = {
    Text = "チーム名の長さは8文字以下にしてください。"
  },
  TipsType_10522_Desc = {
    Text = "チームに覚醒体が{s1}体不足しており、調査ができません。"
  },
  TipsType_10523_Desc = {
    Text = "覚醒体は「闇の境界」の他の密境で戦闘済みです。"
  },
  TipsType_10524_Desc = {
    Text = "チームに2種の界域の覚醒体がいるため、他の界域の覚醒体を選べません。"
  },
  TipsType_10525_Desc = {
    Text = "覚醒体を選択してください。"
  },
  TipsType_10526_Desc = {
    Text = "これ以上覚醒体を選択できません。"
  },
  TipsType_10527_Desc = {
    Text = "育成注意：幻夢の深奥では、覚醒体のレベルとスキルレベルが1に調整されます"
  },
  TipsType_10528_Desc = {
    Text = "チーム名は空にできません。"
  },
  TipsType_10529_Desc = {
    Text = "チームの覚醒体は疲弊しているため、戦う事ができません。"
  },
  TipsType_10530_Desc = {
    Text = "メールボックス内の添付ファイルはすべて受け取り済みです。"
  },
  TipsType_10531_Desc = {
    Text = "序章をクリアで解放"
  },
  TipsType_10532_Desc = {
    Text = "バッグが満杯です。受け取り未完了。バッグを整理してから続行してください。"
  },
  TipsType_10533_Desc = {
    Text = "バッグが満杯です。報酬はメールボックスに送られます。"
  },
  TipsType_10534_Desc = {
    Text = "バッグが満杯です。物資がすべて受け取れていません。バッグを整理してから続行してください。"
  },
  TipsType_10535_Desc = {
    Text = "受け取れる添付ファイルはありません。"
  },
  TipsType_10536_Desc = {
    Text = "まずは遺物を交換してください"
  },
  TipsType_10537_Desc = {
    Text = "調査2-4をクリアで解放"
  },
  TipsType_10538_Desc = {
    Text = "調査1-12をクリアで解放"
  },
  TipsType_10539_Desc = {
    Text = "調査1-12をクリアで解放"
  },
  TipsType_10540_Desc = {
    Text = "調査1-12をクリアで解放"
  },
  TipsType_10541_Desc = {
    Text = "第9層で三つ星を達成すると解放"
  },
  TipsType_10542_Desc = {
    Text = "第10層で三つ星を達成すると解放"
  },
  TipsType_10543_Desc = {
    Text = "第11層で三つ星を達成すると解放"
  },
  TipsType_10544_Desc = {
    Text = "第12層で三つ星を達成すると解放"
  },
  TipsType_10545_Desc = {
    Text = "第13層で三つ星を達成すると解放"
  },
  TipsType_10546_Desc = {
    Text = "第14層で三つ星を達成すると解放"
  },
  TipsType_10547_Desc = {
    Text = "この機能はまもなく削除されます"
  },
  TipsType_10548_Desc = {
    Text = "調査1-7をクリアで解放"
  },
  TipsType_10549_Desc = {
    Text = "遺物の取得が上限に達しました、これ以上取得できません。"
  },
  TipsType_10550_Desc = {
    Text = "{s1}のリンクが完了しました、彼女を指揮できます！"
  },
  TipsType_10551_Desc = {
    Text = "{s1}のレベルとスキルレベルが上限に達しているため、使用できません。"
  },
  TipsType_10552_Desc = {
    Text = "覚醒体のレベルとスキルレベルが上限に達しているため、使用できません。"
  },
  TipsType_10553_Desc = {
    Text = "お楽しみに"
  },
  TipsType_10554_Desc = {
    Text = "前のステージをクリアすると解放"
  },
  TipsType_10555_Desc = {
    Text = "脆弱な道は戻れません。"
  },
  TipsType_10556_Desc = {
    Text = "未開放です。乞うご期待"
  },
  TipsType_10557_Desc = {
    Text = "この遺物は既に所有しています。再取得はできません。"
  },
  TipsType_10558_Desc = {
    Text = "システムクリップボードの内容を取得して<Positive:【貼り付け】>を行います。\n確定しますか？"
  },
  TipsType_10558_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10558_RightBtnDesc = {Text = "確認"},
  TipsType_10558_Title = {
    Text = "貼り付け機能を有効にする"
  },
  TipsType_10559_Desc = {
    Text = "昇格に必要な素材が不足しています。"
  },
  TipsType_10560_Desc = {
    Text = "現在は初期状態です。"
  },
  TipsType_10561_Desc = {
    Text = "薔薇金券が不足しています。"
  },
  TipsType_10562_Desc = {Text = "未昇格"},
  TipsType_10563_Desc = {
    Text = "共鳴リセット成功"
  },
  TipsType_10564_Desc = {
    Text = "調査レベルが{s1}に到達で解放"
  },
  TipsType_10565_Desc = {
    Text = "封印された狂気は解放できない"
  },
  TipsType_1056601_Desc = {
    Text = "サーバーへ接続できません\nネットワークを確認して再試行してください({s1})"
  },
  TipsType_10566_Desc = {
    Text = "サーバーへ接続できません\nしばらくしてから再試行してください({s1})"
  },
  TipsType_10567_Desc = {
    Text = "サーバー情報の取得に失敗しました！{s1}"
  },
  TipsType_10568_Desc = {
    Text = "サーバーを選択してください。"
  },
  TipsType_10569_Desc = {
    Text = "未解放です。"
  },
  TipsType_10570_Desc = {
    Text = "アカウントを入力してください。"
  },
  TipsType_10571_Desc = {
    Text = "共鳴起動素材が不足しています。"
  },
  TipsType_10572_Desc = {
    Text = "前提の共鳴が未アップグレードです。"
  },
  TipsType_10573_Desc = {
    Text = "最大レベル"
  },
  TipsType_10574_Desc = {
    Text = "レベルアップ成功"
  },
  TipsType_10575_Desc = {
    Text = "この覚醒体は変更不可"
  },
  TipsType_10576_Desc = {
    Text = "この位置には配置できません。"
  },
  TipsType_10577_Desc = {
    Text = "覚醒体の数が不足しており、挑戦できません。"
  },
  TipsType_10578_Desc = {
    Text = "次のステージはまだ解放されていません。"
  },
  TipsType_10579_Desc = {
    Text = "最後のステージです。"
  },
  TipsType_10580_Desc = {
    Text = "現在の経験値上限に達しているため追加できません。"
  },
  TipsType_10581_Desc = {
    Text = "運命の札のスロットが満杯で追加できません。"
  },
  TipsType_10582_Desc = {
    Text = "現在、素早く配置できる素材がありません。"
  },
  TipsType_10583_Desc = {
    Text = "素材を運命の札のスロットに置いてください。"
  },
  TipsType_10584_Desc = {
    Text = "装備可能な運命の札がありません。"
  },
  TipsType_10585_Desc = {
    Text = "調査2-8をクリアで解放"
  },
  TipsType_10586_Desc = {
    Text = "調査2-14をクリアで解放"
  },
  TipsType_10587_Desc = {
    Text = "調査3-16をクリアで解放"
  },
  TipsType_10588_Desc = {
    Text = "調査4-12をクリアで解放"
  },
  TipsType_10589_Desc = {
    Text = "調査5-12をクリアで解放"
  },
  TipsType_10590_Desc = {
    Text = "調査6-12をクリアで解放"
  },
  TipsType_10591_Desc = {
    Text = "調査2-12をクリアで解放"
  },
  TipsType_10592_Desc = {
    Text = "このユーザーはログイン禁止になりました。問題がある場合はカスタマーサポートに連絡してください。"
  },
  TipsType_10593_Desc = {
    Text = "ログインセッションが期限切れです。再度ログインしてください。"
  },
  TipsType_10594_Desc = {
    Text = "エンフェリンが不足しています"
  },
  TipsType_10595_Desc = {
    Text = "“{s1}”を起動しますか？"
  },
  TipsType_10595_Title = {
    Text = "才能を起動"
  },
  TipsType_10596_Desc = {
    Text = "この覚醒体はまだ入手していません。"
  },
  TipsType_10597_Desc = {
    Text = "強化可能な運命の札がありません。"
  },
  TipsType_10598_Desc = {
    Text = "このアカウントは規則違反のために{s1}までログイン禁止です。問題がある場合はカスタマーサポートに連絡してください。"
  },
  TipsType_10599_Desc = {
    Text = "調査2-15をクリアで解放"
  },
  TipsType_10600_Desc = {
    Text = "レベル上限に達しました。これ以上追加できません"
  },
  TipsType_10601_Desc = {
    Text = "調査1-7を完了すると守秘者成長記録が開放されます。"
  },
  TipsType_10602_Desc = {
    Text = "調査1-7を完了すると界域知識任務が開放されます。"
  },
  TipsType_10603_Desc = {
    Text = "素材が未選択です。"
  },
  TipsType_10604_Desc = {
    Text = "長時間操作がないため、自動的に退出します。"
  },
  TipsType_10605_Desc = {
    Text = "アンケートの記入が完了しました、ご協力ありがとうございました！"
  },
  TipsType_10606_Desc = {
    Text = "起動に必要な素材が不足しています。"
  },
  TipsType_10607_Desc = {
    Text = "今週の報酬受取回数が尽きました。挑戦しても報酬は得られませんが挑戦しますか？"
  },
  TipsType_10607_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10607_RightBtnDesc = {Text = "確認"},
  TipsType_10607_Title = {
    Text = "挑戦ヒント"
  },
  TipsType_10608_Desc = {
    Text = "現在メンテナンス中です\n完了するまでお待ちください"
  },
  TipsType_10609_Desc = {
    Text = "成功！{s1}があなたの宿舎に入りました"
  },
  TipsType_10610_Desc = {
    Text = "{s1}はすでにあなたの宿舎にいます"
  },
  TipsType_10611_Desc = {
    Text = "現在Wi-Fiネットワークではありません。データ通信を使用してダウンロードを続行しますか？"
  },
  TipsType_10611_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10611_RightBtnDesc = {Text = "確認"},
  TipsType_10611_Title = {
    Text = "ダウンロード確認"
  },
  TipsType_10612_Desc = {
    Text = "すべてのカードが刻印されました。"
  },
  TipsType_10613_Desc = {
    Text = "ネットワーク異常、しばらくお待ちください。"
  },
  TipsType_10614_Desc = {
    Text = "現在のチャレンジは解放されていません。"
  },
  TipsType_10615_Desc = {
    Text = "クールダウン中、次のターンで解放可能。"
  },
  TipsType_10616_Desc = {
    Text = "選択中です。選択完了後に解放できます。"
  },
  TipsType_10617_Desc = {
    Text = "現在の狂気解放は解放条件を満たしていないため、放すことができません。"
  },
  TipsType_10618_Desc = {
    Text = "現在のチーム平均レベル：{s1}　推奨レベル：{s2}\n調査で大きな困難に直面するかもしれませんが続行しますか？"
  },
  TipsType_10618_LeftBtnDesc = {
    Text = "レベルアップへ"
  },
  TipsType_10618_RightBtnDesc = {Text = "確認"},
  TipsType_10618_Title = {
    Text = "調査確認"
  },
  TipsType_10619_Desc = {
    Text = "調査レベル {s1} から使用可能"
  },
  TipsType_10620_Desc = {
    Text = "ネットワーク接続が不安定です。Steamの接続を確認するか、Steamを再起動して再試行してください"
  },
  TipsType_10621_Desc = {
    Text = "<WeaponEffect_Num:{s1}>をあなたの名前として使用しますか？"
  },
  TipsType_10621_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10621_RightBtnDesc = {Text = "確認"},
  TipsType_10621_Title = {
    Text = "刻印確認"
  },
  TipsType_10622_Desc = {
    Text = "クールダウン中、{s1}時間{s2}分後に再度名前の変更が可能"
  },
  TipsType_10623_Desc = {
    Text = "名前を変更しました。"
  },
  TipsType_10624_Desc = {
    Text = "名前には漢字、英語、数字のみを含めることができます。"
  },
  TipsType_10625_Desc = {
    Text = "このカードはまもなく破棄されます。"
  },
  TipsType_10626_Desc = {
    Text = "Steamで以下のオプションを有効にしてください：\n【Steamの設定→ゲーム中→ゲーム中にSteamオーバーレイを有効にする】\n有効後、ゲームを再起動すると反映されます。"
  },
  TipsType_10626_RightBtnDesc = {Text = "確認"},
  TipsType_10626_Title = {Text = "ヒント"},
  TipsType_10628_Desc = {
    Text = "新しい名前は現在の名前と重複できません。"
  },
  TipsType_10629_Desc = {
    Text = "{s1}～{s2}文字を入力してください"
  },
  TipsType_10630_Desc = {
    Text = "{s1}が三つ星を達成するとリプレイ可能です。"
  },
  TipsType_10631_Desc = {
    Text = "アカウントが規約違反のため強制ログアウトされました。"
  },
  TipsType_10631_RightBtnDesc = {Text = "確認"},
  TipsType_10631_Title = {
    Text = "お知らせ"
  },
  TipsType_10632_Desc = {
    Text = "チャレンジ完了後、今日再挑戦可能"
  },
  TipsType_10633_Desc = {
    Text = "以下の物資を消費します。<Blue:分解後は復元できません。>分解を確定しますか？"
  },
  TipsType_10633_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10633_RightBtnDesc = {Text = "確認"},
  TipsType_10633_Title = {
    Text = "分解確認"
  },
  TipsType_10634_Desc = {
    Text = "現在の残り日数が{s1}日を超えているため、購入できません。"
  },
  TipsType_10635_Desc = {
    Text = "必要なプラチナジェルが不足しています。チャージしますか？"
  },
  TipsType_10635_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10635_RightBtnDesc = {Text = "確認"},
  TipsType_10635_Title = {
    Text = "プラチナジェル不足"
  },
  TipsType_10636_Desc = {
    Text = "現在、空きの運命の札はありません"
  },
  TipsType_10637_Desc = {
    Text = "現在、空きの密約はありません"
  },
  TipsType_10638_Desc = {
    Text = "現在、装備可能な個所がありません。密約を解放してからお試しください。"
  },
  TipsType_10640_Desc = {
    Text = "この覚醒体のすべての密約を解放しますか？"
  },
  TipsType_10640_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10640_RightBtnDesc = {Text = "確認"},
  TipsType_10640_Title = {Text = "ヒント"},
  TipsType_10641_Desc = {
    Text = "言語を切り替えた後、アプリを再起動する必要があります。確定しますか？"
  },
  TipsType_10641_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10641_RightBtnDesc = {Text = "確認"},
  TipsType_10641_Title = {
    Text = "言語切り替え確認"
  },
  TipsType_10642_Desc = {
    Text = "プレイヤーレベルが不足しています。"
  },
  TipsType_10643_Desc = {
    Text = "融蝕のエリアに入ると、ライフ値が{s1}減少します"
  },
  TipsType_10644_Desc = {
    Text = "このキーオーダーを選択済み"
  },
  TipsType_10645_Desc = {
    Text = "このキーオーダーを未取得"
  },
  TipsType_10646_Desc = {
    Text = "{s1} 不足"
  },
  TipsType_10647_Desc = {
    Text = "事件の調査はまだ開始されていません、{s1}"
  },
  TipsType_10648_Desc = {
    Text = "輪転の隙間が更新されました。"
  },
  TipsType_10649_Desc = {
    Text = "現在の派遣可能数が上限に達しました。"
  },
  TipsType_10650_Desc = {
    Text = "現在解放されたSSR覚醒体はいません。"
  },
  TipsType_10651_Desc = {
    Text = "一定数集めると使用可能です。"
  },
  TipsType_10652_Desc = {
    Text = "未取得のアイコンやスタンプはありません。"
  },
  TipsType_10701_Desc = {
    Text = "現在、運命の札を装備しています。解放してから再試行してください。"
  },
  TipsType_10702_Desc = {
    Text = "SSR運命の札の追加強化が12に達した時、2つのSSR運命の札を同時に装備可能です。"
  },
  TipsType_10703_Desc = {
    Text = "覚醒体に同じ運命の札が装備されており、重複装備できません。"
  },
  TipsType_10704_Desc = {
    Text = "密約レベルが上限に達しました。"
  },
  TipsType_10705_Desc = {
    Text = "素材の数が上限に達した。"
  },
  TipsType_10706_Desc = {
    Text = "最大で2つのサブ能力をロック可能"
  },
  TipsType_10707_Desc = {
    Text = "転写素材が不足しています。"
  },
  TipsType_10708_Desc = {
    Text = "覚醒体が{s1}階に昇格後に解放"
  },
  TipsType_10709_Desc = {
    Text = "{s1} 不足"
  },
  TipsType_10710_Desc = {
    Text = "売り切れ"
  },
  TipsType_10711_Desc = {
    Text = "この商品は解放されていません。"
  },
  TipsType_10712_Desc = {
    Text = "材料が満杯です。"
  },
  TipsType_10713_Desc = {
    Text = "運命の札の強化が上限に達しました。"
  },
  TipsType_10714_Desc = {
    Text = "事件条件を満たしていないため選択できません。"
  },
  TipsType_10715_Desc = {
    Text = "対応するアプリをインストールしてから共有してください。"
  },
  TipsType_10716_Desc = {
    Text = "これ以上運命の札を選択できません。"
  },
  TipsType_10717_Desc = {
    Text = "これ以上キーオーダーを選択できません。"
  },
  TipsType_10718_Desc = {
    Text = "起動成功"
  },
  TipsType_10719_Desc = {
    Text = "千面印章が不足しています。\n「変換設定」で素材を選択して変換できます。"
  },
  TipsType_10720_Desc = {
    Text = "1倍速に切り替えました。"
  },
  TipsType_10721_Desc = {
    Text = "2倍速に切り替えました。"
  },
  TipsType_10722_Desc = {
    Text = "キャンパスの入口が混雑しています。しばらくしてから再試行してください。"
  },
  TipsType_10724_Desc = {
    Text = "保存失敗、アルバムの権限が未設定かメモリ不足です。"
  },
  TipsType_10725_Desc = {
    Text = "素材が不足しています。"
  },
  TipsType_10726_Desc = {
    Text = "カードを選択してください。"
  },
  TipsType_10727_Desc = {
    Text = "この覚醒体は使用できません"
  },
  TipsType_10728_Desc = {
    Text = "真貌形態は派遣不可、再選択してください。"
  },
  TipsType_10736_Desc = {
    Text = "エンフェリンは満たされているため、補充は不要です。"
  },
  TipsType_10737_Desc = {
    Text = "新しいゲームバージョンを検出しました。正常な体験のためにゲームを更新してください。"
  },
  TipsType_10738_Desc = {
    Text = "現在、未読のヘルプはありません。"
  },
  TipsType_10739_Desc = {
    Text = "{s1}は{s2}で既に挑戦済みのため、再出場できません"
  },
  TipsType_10740_Desc = {
    Text = "現在の調査レベル：{s1}　推奨レベル：{s2}\n調査で大きな困難に直面するかもしれませんが続行しますか？"
  },
  TipsType_10740_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10740_RightBtnDesc = {Text = "確認"},
  TipsType_10740_Title = {
    Text = "調査確認"
  },
  TipsType_10741_Desc = {
    Text = "現在のチーム平均レベル{s1}、調査レベル{s2}です。\n推奨レベルより低いため、調査で大きな困難に直面するかもしれませんが続行しますか？"
  },
  TipsType_10741_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10741_RightBtnDesc = {Text = "確認"},
  TipsType_10741_Title = {
    Text = "調査確認"
  },
  TipsType_10742_Desc = {
    Text = "同じ運命の札の効果は重複しないため、現在<Blue:{s1}>には無効の運命の札があります。再調整後に調査を続けますか？\nそれでも調査を行いますか？"
  },
  TipsType_10742_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10742_RightBtnDesc = {Text = "確認"},
  TipsType_10742_Title = {
    Text = "調査確認"
  },
  TipsType_10743_Desc = {
    Text = "融災禁区の救援回数が残っていません。"
  },
  TipsType_10744_Desc = {
    Text = "フォロー人数が上限に達しました"
  },
  TipsType_10745_Desc = {
    Text = "誕生日が間違っているため、設定できません。"
  },
  TipsType_10746_Desc = {
    Text = "クリップボードにコピーしました。"
  },
  TipsType_10747_Desc = {
    Text = "いいねしました"
  },
  TipsType_10748_Desc = {
    Text = "{s1}はすでに救援覚醒体です。"
  },
  TipsType_10749_Desc = {
    Text = "救援覚醒体は空にできません。"
  },
  TipsType_10750_Desc = {
    Text = "今日はこの守秘者にすでに「いいね！」しました。"
  },
  TipsType_10751_Desc = {
    Text = "最大4名の覚醒体を表示可能"
  },
  TipsType_10752_Desc = {
    Text = "チームの界域が条件を満たしていないため、出場できません。"
  },
  TipsType_10753_Desc = {
    Text = "{s1}は既に出陣中のため、選択できません。"
  },
  TipsType_10754_Desc = {
    Text = "{s1}がリセットされました。"
  },
  TipsType_10755_Desc = {
    Text = "解放成功"
  },
  TipsType_10756_Desc = {
    Text = "現在、セット可能な循環基盤がありません。"
  },
  TipsType_10757_Desc = {
    Text = "{s1}は本日のこのイベントで既に挑戦済みです。"
  },
  TipsType_10758_Desc = {
    Text = "チームの界域が条件を満たしていません。"
  },
  TipsType_10761_Desc = {
    Text = "真貌形態の覚醒体は通常形態と同時に出撃できません。"
  },
  TipsType_10762_Desc = {
    Text = "真貌形態の覚醒体は通常形態と同時に表示できません。"
  },
  TipsType_10799_Desc = {
    Text = "現在<Blue:{s1}>の密約6件のセット効果が<Blue:チーム内で1つ>の制限で発生していません、密約を再調整してから調査を行うことをお勧めします。\n調査を続けますか？"
  },
  TipsType_10799_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10799_RightBtnDesc = {Text = "確認"},
  TipsType_10799_Title = {
    Text = "調査確認"
  },
  TipsType_10801_Desc = {
    Text = "密約セットの数が上限に達しています。"
  },
  TipsType_10802_Desc = {
    Text = "{s1}は他の密約セットで使用中のため、保存できません。"
  },
  TipsType_10803_Desc = {
    Text = "密約セット名は空にできません。"
  },
  TipsType_10804_Desc = {
    Text = "不正な文字が含まれています。再入力してください。"
  },
  TipsType_10805_Desc = {
    Text = "保存しました。"
  },
  TipsType_10806_Desc = {
    Text = "現在の密約は{s1}で適用されています。"
  },
  TipsType_10807_Desc = {
    Text = "装備済み"
  },
  TipsType_10808_Desc = {
    Text = "装備解放済み"
  },
  TipsType_10809_Desc = {
    Text = "現在のチームは出撃中です。"
  },
  TipsType_10810_Desc = {
    Text = "密約セットは空にできません。"
  },
  TipsType_10811_Desc = {
    Text = "現在このセットを装備しています。"
  },
  TipsType_10812_Desc = {
    Text = "装備済み"
  },
  TipsType_10813_Desc = {
    Text = "セット【{s1}】を削除しますか？"
  },
  TipsType_10813_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10813_RightBtnDesc = {Text = "確認"},
  TipsType_10814_Desc = {
    Text = "今回の調査に参加した覚醒体はチームの要件を満たしていません。"
  },
  TipsType_10815_Desc = {
    Text = "現在の覚醒体はストーリー専用設定となり、詳細は確認できません。"
  },
  TipsType_10816_Desc = {
    Text = "代理証明が不足しています"
  },
  TipsType_10817_Desc = {
    Text = "前回の清算記録がありません。「挑戦」を行い、翌日15:00の清算後に再度実行してください。"
  },
  TipsType_10818_Desc = {
    Text = "本日の代理は完了しました。再度代理はできません。"
  },
  TipsType_10821_Desc = {
    Text = "現在、物資がありません。しばらくしてから再度お試しください。"
  },
  TipsType_10822_Desc = {
    Text = "イベント終了"
  },
  TipsType_10823_Desc = {
    Text = "特殊種子が売り切れた後にのみ、ショップに補充を依頼できます。"
  },
  TipsType_10824_Desc = {
    Text = "補充回数が終了しました。これ以上の在庫はありません。"
  },
  TipsType_10825_Desc = {
    Text = "{s1} 不足"
  },
  TipsType_10826_Desc = {
    Text = "特殊種子が売り切れました。播種を選択してリセットできます。"
  },
  TipsType_10827_Desc = {
    Text = "特殊種子がリセットされました。"
  },
  TipsType_10828_Desc = {
    Text = "アイテムはすべて交換済みです。リセットを選択してください。"
  },
  TipsType_10829_Desc = {
    Text = "リセット成功"
  },
  TipsType_10830_Desc = {
    Text = "チームに出場できない覚醒体がいるため、調査できません。"
  },
  TipsType_10831_Desc = {
    Text = "チームに同じ運命の札があるため、融災禁区に入れません。"
  },
  TipsType_10832_Desc = {
    Text = "チームがキーオーダーを装備していないため、調査できません。"
  },
  TipsType_10833_Desc = {
    Text = "チームに装備できない運命の札があるため、調査できません。"
  },
  TipsType_10834_Desc = {
    Text = "救援覚醒体に運命の札は装備できません。"
  },
  TipsType_10835_Desc = {
    Text = "救援覚醒体に密約は装備できません。"
  },
  TipsType_10836_Desc = {
    Text = "ストーリー設定の覚醒体に運命の札は装備できません。"
  },
  TipsType_10837_Desc = {
    Text = "ストーリー設定の覚醒体に密約は装備できません。"
  },
  TipsType_10838_Desc = {
    Text = "スタンプセットのスタンプ数が上限に達しました。"
  },
  TipsType_10839_Desc = {
    Text = "スタンプは使用中です。スタンプセットのスタンプをタップして解放してください。"
  },
  TipsType_10840_Desc = {
    Text = "スタンプの送信が速すぎます。"
  },
  TipsType_10841_Desc = {
    Text = "スタンプセットは空にできません。"
  },
  TipsType_10842_Desc = {
    Text = "スタンプセットが更新されました。"
  },
  TipsType_10843_Desc = {
    Text = "この項目は未解放です。"
  },
  TipsType_10844_Desc = {
    Text = "まだ解放されていません。"
  },
  TipsType_10850_Desc = {
    Text = "チームに装備できないキーオーダーがあり、調査できません。"
  },
  TipsType_10901_Desc = {Text = "麻痺"},
  TipsType_10902_Desc = {Text = "混乱"},
  TipsType_10903_Desc = {
    Text = "未所持：{s1}"
  },
  TipsType_10904_Desc = {
    Text = "この章の「通常」モードをクリアすると、「夢を遡る」でストーリーを観賞できます。"
  },
  TipsType_10905_Desc = {
    Text = "「調査」1-15・通常をクリアすると、「夢を遡る」でストーリーを観賞できます。"
  },
  TipsType_10906_Desc = {
    Text = "起点装置が不足しています。"
  },
  TipsType_10907_Desc = {
    Text = "解放済み"
  },
  TipsType_10908_Desc = {
    Text = "{s1}の霊知啓発は完了済です。続けると<TipsHighlightText:純粋な霊核の欠片×2>と<TipsHighlightText:根源の澱×250>に変換されます。召喚を確認しますか？"
  },
  TipsType_10908_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10908_RightBtnDesc = {Text = "確認"},
  TipsType_10908_Title = {
    Text = "召喚確認"
  },
  TipsType_10909_Desc = {
    Text = "{s1}は既に召喚済みです。続けると<TipsHighlightText:欠片・{s2}×1>と<TipsHighlightText:根源の澱×50>に変換されます。召喚を確認しますか？"
  },
  TipsType_10909_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10909_RightBtnDesc = {Text = "確認"},
  TipsType_10909_Title = {
    Text = "召喚確認"
  },
  TipsType_10910_Desc = {
    Text = "<TipsHighlightText:{s1}>を召喚しますか？"
  },
  TipsType_10910_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10910_RightBtnDesc = {Text = "確認"},
  TipsType_10910_Title = {
    Text = "召喚確認"
  },
  TipsType_10911_Desc = {
    Text = "スペース不足"
  },
  TipsType_10912_Desc = {
    Text = "超次元空間に指令カードがないため、使用できません。"
  },
  TipsType_10913_Desc = {
    Text = "このターンでは再使用できません。"
  },
  TipsType_10914_Desc = {
    Text = "<TipsHighlightText:{s1}>を選択しますか？"
  },
  TipsType_10914_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10914_RightBtnDesc = {Text = "確認"},
  TipsType_10914_Title = {
    Text = "選択確認"
  },
  TipsType_10915_Desc = {
    Text = "編成の解放は順番に行う必要があり、未解放の編成を飛ばせません。"
  },
  TipsType_10916_Desc = {
    Text = "<Blue: {s1} × {s2}> を消費して解放しますか？"
  },
  TipsType_10916_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10916_RightBtnDesc = {Text = "確認"},
  TipsType_10916_Title = {
    Text = "解放確認"
  },
  TipsType_10917_Desc = {
    Text = "{s1}の解放に成功しました。"
  },
  TipsType_10918_Desc = {
    Text = "{s1}の解放に成功しました。チームはすべて解放済みです。"
  },
  TipsType_10919_Desc = {
    Text = "[{s1}：{s2}]を完了すると解放されます、[{s1}]に向かいますか？"
  },
  TipsType_10919_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10919_RightBtnDesc = {Text = "確認"},
  TipsType_10919_Title = {Text = "未解放"},
  TipsType_10920_Desc = {
    Text = "期間限定イベント「位相逆転」で「魔法オーク」× {s1} を集めることでロック解放できます。「位相逆転」に進みますか？"
  },
  TipsType_10920_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_10920_RightBtnDesc = {Text = "確認"},
  TipsType_10920_Title = {Text = "未解放"},
  TipsType_10921_Desc = {
    Text = "同じメイン能力の運命の札を同時に装備できません"
  },
  TipsType_20001_Desc = {
    Text = "重複チェックあり"
  },
  TipsType_20001_LeftBtnDesc = {Text = "確定"},
  TipsType_20001_Title = {Text = "称号"},
  TipsType_20002_Desc = {
    Text = "重複チェックなし"
  },
  TipsType_20002_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20002_RightBtnDesc = {Text = "確定"},
  TipsType_20002_Title = {Text = "称号"},
  TipsType_20003_Desc = {
    Text = "あなたのアカウントが他のデバイスでログインされました。"
  },
  TipsType_20003_RightBtnDesc = {Text = "確認"},
  TipsType_20003_Title = {
    Text = "通信エラー"
  },
  TipsType_20004_Desc = {
    Text = "サーバーとの接続が切れました。再ログインしてください。"
  },
  TipsType_20004_RightBtnDesc = {Text = "確認"},
  TipsType_20004_Title = {
    Text = "通信エラー"
  },
  TipsType_20005_Desc = {
    Text = "通信が切断されました。再接続します"
  },
  TipsType_20005_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20005_RightBtnDesc = {Text = "確認"},
  TipsType_20005_Title = {
    Text = "通信失敗"
  },
  TipsType_20006_Desc = {
    Text = "通信が切断されました。ログイン画面に戻ります。"
  },
  TipsType_20006_RightBtnDesc = {Text = "確認"},
  TipsType_20006_Title = {
    Text = "通信失敗"
  },
  TipsType_20007_Desc = {
    Text = "通信が切断されました。ログイン画面に戻ります。"
  },
  TipsType_20007_RightBtnDesc = {Text = "確認"},
  TipsType_20007_Title = {
    Text = "通信失敗"
  },
  TipsType_20008_Desc = {
    Text = "今回の調査でスタミナを <Positive:{s1}> 消耗しました。終了しますか？"
  },
  TipsType_20008_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20008_RightBtnDesc = {Text = "確認"},
  TipsType_20008_Title = {
    Text = "探査終了"
  },
  TipsType_20009_Desc = {
    Text = "更新すると刻印と低級遺物が更新されますが、\n「覚醒体を覚醒」と、「指令カードの売却回数」はリセットされません。\nよろしいですか？"
  },
  TipsType_20009_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20009_RightBtnDesc = {Text = "確認"},
  TipsType_20009_Title = {
    Text = "更新確認"
  },
  TipsType_20010_Desc = {
    Text = "この界域の覚醒体の数が不足しています。チームを作成しますか？"
  },
  TipsType_20010_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20010_RightBtnDesc = {Text = "確認"},
  TipsType_20011_Desc = {
    Text = "覚醒体が選択されていないため、編成は保存されません。"
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "退出する"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "編成を続ける"
  },
  TipsType_20012_Desc = {
    Text = "覚醒体が選択されていません。"
  },
  TipsType_20012_RightBtnDesc = {Text = "確認"},
  TipsType_20013_Desc = {
    Text = "チームに空きがあります。出発しますか？"
  },
  TipsType_20013_LeftBtnDesc = {Text = "戻る"},
  TipsType_20013_RightBtnDesc = {Text = "出発"},
  TipsType_20014_Desc = {
    Text = "チームの人数が上限に達しました。"
  },
  TipsType_20014_RightBtnDesc = {Text = "確認"},
  TipsType_20015_Desc = {
    Text = "このチームを削除しますか？"
  },
  TipsType_20015_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20015_RightBtnDesc = {Text = "確認"},
  TipsType_20016_Desc = {
    Text = "{s1}クリアで解放"
  },
  TipsType_20016_RightBtnDesc = {Text = "確認"},
  TipsType_20017_Desc = {
    Text = "ここでマップ情報と倒した敵の情報を確認できますが、現在のバージョンでは未実装です"
  },
  TipsType_20017_RightBtnDesc = {Text = "確認"},
  TipsType_20018_Desc = {
    Text = "まだステージ解放条件を満たしていません。"
  },
  TipsType_20018_RightBtnDesc = {Text = "確認"},
  TipsType_20018_Title = {
    Text = "即時完了"
  },
  TipsType_20019_Desc = {
    Text = "シルバーコアが不足しています。ショップで購入しますか？"
  },
  TipsType_20019_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20019_RightBtnDesc = {Text = "移動"},
  TipsType_20020_Desc = {
    Text = "進級{s1}クリア後にこの上級難易度が解放されます。"
  },
  TipsType_20020_RightBtnDesc = {Text = "確認"},
  TipsType_20021_Desc = {
    Text = "{s1}通常モードクリア後に上級訓練が解放されます。"
  },
  TipsType_20021_RightBtnDesc = {Text = "確認"},
  TipsType_20022_Desc = {
    Text = "シルバーコアが不足しています。購入しますか？"
  },
  TipsType_20022_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20022_RightBtnDesc = {Text = "確認"},
  TipsType_20022_Title = {
    Text = "シルバーコア不足"
  },
  TipsType_20023_Desc = {
    Text = "今回のアップグレードで{s1}ポイントの経験値が超過します（返還されません）。キャラクターがレベル上限に達すると経験値を獲得できなくなります。続行しますか？"
  },
  TipsType_20023_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20023_RightBtnDesc = {Text = "確認"},
  TipsType_20024_Desc = {
    Text = "チームメンバーが満員ではないため、ステージに入れません。"
  },
  TipsType_20024_RightBtnDesc = {Text = "確認"},
  TipsType_20026_Desc = {
    Text = "チャージしますか？"
  },
  TipsType_20026_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20026_RightBtnDesc = {Text = "確認"},
  TipsType_20027_Desc = {
    Text = "ライフを回復しますか？"
  },
  TipsType_20027_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20027_RightBtnDesc = {Text = "確認"},
  TipsType_20028_Desc = {
    Text = "この画面を閉じると報酬の【{s1}】を諦めます。諦めますか？"
  },
  TipsType_20028_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20028_RightBtnDesc = {Text = "確認"},
  TipsType_20029_Desc = {
    Text = "この画面を閉じると今回の事件をスキップします（遺物は削除されません）。確定しますか？"
  },
  TipsType_20029_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20029_RightBtnDesc = {Text = "確認"},
  TipsType_20030_Desc = {
    Text = "選択した遺物は持ち込まれません。放棄しますか？"
  },
  TipsType_20030_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20030_RightBtnDesc = {Text = "確認"},
  TipsType_20031_Desc = {
    Text = "戦闘を終了しますか？"
  },
  TipsType_20031_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20031_RightBtnDesc = {Text = "確認"},
  TipsType_20032_Desc = {
    Text = "このステージはまだ解放されていません。調査ステージをクリアして解放しますか？"
  },
  TipsType_20032_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20032_RightBtnDesc = {Text = "確認"},
  TipsType_20032_Title = {Text = "未解放"},
  TipsType_20033_Desc = {
    Text = "挑戦回数が不足しています。500シルバーコアを消費してリセットしますか？"
  },
  TipsType_20033_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20033_RightBtnDesc = {Text = "確認"},
  TipsType_20034_Desc = {
    Text = "クールダウン中です。50シルバーコアを消費してリセットしますか？"
  },
  TipsType_20034_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20034_RightBtnDesc = {Text = "確認"},
  TipsType_20035_Desc = {
    Text = "推奨レベルは{s1}、現在のチーム平均レベルは{s2}、調査は難航しますが続行しますか？"
  },
  TipsType_20035_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20035_RightBtnDesc = {Text = "確認"},
  TipsType_20035_Title = {
    Text = "戦力不足"
  },
  TipsType_20036_Desc = {
    Text = "現在の掃討回数は{s1}に設定されています。ただし、挑戦するステージでは{s2}スタミナを消費し、報酬は1回のみ獲得。挑戦を確定しますか？"
  },
  TipsType_20036_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20036_RightBtnDesc = {Text = "確認"},
  TipsType_20036_Title = {
    Text = "挑戦確認"
  },
  TipsType_20037_Desc = {
    Text = "強化素材に高級素材が含まれています。強化を確定しますか？"
  },
  TipsType_20037_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20037_RightBtnDesc = {Text = "確認"},
  TipsType_20037_Title = {
    Text = "強化確認"
  },
  TipsType_20038_Desc = {
    Text = "この装備はロックされています。ロックを解放しますか？"
  },
  TipsType_20038_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20038_RightBtnDesc = {Text = "確認"},
  TipsType_20039_Desc = {
    Text = "確認すると今回の調査は失敗し、報酬を得られません。\n調査を終了しますか？"
  },
  TipsType_20039_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20039_RightBtnDesc = {Text = "確認"},
  TipsType_20039_Title = {
    Text = "調査を終了"
  },
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:調査を中断すると{s1}個のエンフェリンを消費します。>確認すると今回の調査は失敗し、後続の調査報酬を得られません。調査を終了しますか？"
  },
  TipsType_20040_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20040_RightBtnDesc = {Text = "確認"},
  TipsType_20040_Title = {
    Text = "調査を終了"
  },
  TipsType_20041_BottomDesc = {
    Text = "現在の時間圧縮許可：{s1}"
  },
  TipsType_20041_Desc = {
    Text = "{s1}個の時間圧縮許可を消費して加速しますか？"
  },
  TipsType_20041_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20041_RightBtnDesc = {Text = "確認"},
  TipsType_20041_Title = {
    Text = "加速確認"
  },
  TipsType_20042_Desc = {
    Text = "RPG戦闘調整中、現在は直接勝利を決定"
  },
  TipsType_20042_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20042_RightBtnDesc = {Text = "確認"},
  TipsType_20043_Desc = {
    Text = "{s1} シルバーコアを使って、現在の任務を更新しますか？"
  },
  TipsType_20043_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20043_RightBtnDesc = {Text = "確認"},
  TipsType_20043_Title = {
    Text = "任務更新"
  },
  TipsType_20044_BottomDesc = {
    Text = "消費：{s1}研究許可"
  },
  TipsType_20044_Desc = {
    Text = "{s1}の研究を行いますか？\n研究効果: {s2}"
  },
  TipsType_20044_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20044_RightBtnDesc = {Text = "確認"},
  TipsType_20044_Title = {
    Text = "研究確認"
  },
  TipsType_20045_BottomDesc = {
    Text = "研究をキャンセルし、既に研究した進行を保持しません"
  },
  TipsType_20045_Desc = {
    Text = "{s1}の研究を中止しますか？(全額研究許可を返還します)"
  },
  TipsType_20045_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20045_RightBtnDesc = {Text = "確認"},
  TipsType_20045_Title = {
    Text = "研究中止"
  },
  TipsType_20046_Desc = {
    Text = "{s1} シルバーコアを消費して加速しますか？"
  },
  TipsType_20046_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20046_RightBtnDesc = {Text = "確認"},
  TipsType_20046_Title = {
    Text = "加速確認"
  },
  TipsType_20047_Desc = {
    Text = "{s1} 個の<Blue:「{s2}」>が不足しています。<Blue:シルバーコア×{s3}>を消費して購入しますか？"
  },
  TipsType_20047_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20047_RightBtnDesc = {Text = "確認"},
  TipsType_20047_Title = {
    Text = "購入確認"
  },
  TipsType_20048_Desc = {
    Text = "{s1} 個の<Blue:「{s2}」>が不足しています。<Blue:シルバーコア×{s3}>を消費して購入しますか？"
  },
  TipsType_20048_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20048_RightBtnDesc = {Text = "確認"},
  TipsType_20048_Title = {
    Text = "購入確認"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:「{s1}」> は <Blue:「{s2}」> が装備中ですが、変更しますか？"
  },
  TipsType_20049_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20049_RightBtnDesc = {Text = "確認"},
  TipsType_20049_Title = {
    Text = "交換のヒント"
  },
  TipsType_20050_Desc = {
    Text = "運命の札を消費して強化済みです。確定しますか？"
  },
  TipsType_20050_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20050_RightBtnDesc = {Text = "確認"},
  TipsType_20050_Title = {
    Text = "強化のヒント"
  },
  TipsType_20051_Desc = {
    Text = "運命の札の強化レベル上限を超えます。強化後、超過レベルに応じて運命の札が返還されます。確定しますか？"
  },
  TipsType_20051_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20051_RightBtnDesc = {Text = "確認"},
  TipsType_20051_Title = {
    Text = "強化のヒント"
  },
  TipsType_20052_Desc = {
    Text = "推奨レベルは{s1}、現在のチーム平均レベルは{s2}です。調査は難航しますが、続行しますか？"
  },
  TipsType_20052_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20052_RightBtnDesc = {Text = "確認"},
  TipsType_20052_Title = {
    Text = "戦力不足"
  },
  TipsType_20053_Desc = {
    Text = "推奨レベルは{s1}、現在のチーム平均レベルは{s2}です。調査は難航しますが、続行しますか？"
  },
  TipsType_20053_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20053_RightBtnDesc = {Text = "確認"},
  TipsType_20053_Title = {
    Text = "戦力不足"
  },
  TipsType_20054_Desc = {
    Text = "現在の挑戦報酬はすべて受け取り済みです。続行しても報酬は得られませんが、よろしいですか？"
  },
  TipsType_20054_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20054_RightBtnDesc = {Text = "確認"},
  TipsType_20054_Title = {
    Text = "挑戦確認"
  },
  TipsType_20055_Desc = {
    Text = "リセット後、現在のステージ進行は0星にリセットされ、覚醒体の出撃記録も削除されます。リセットを確認しますか？"
  },
  TipsType_20055_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20055_RightBtnDesc = {Text = "確認"},
  TipsType_20055_Title = {
    Text = "リセット確認"
  },
  TipsType_20056_Desc = {
    Text = "挑戦成功後、現在のチームメンバーの覚醒体4名は{s1}の他のステージに出撃できません。チャレンジしますか？"
  },
  TipsType_20056_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20056_RightBtnDesc = {Text = "確認"},
  TipsType_20056_Title = {
    Text = "挑戦確認"
  },
  TipsType_20057_Desc = {
    Text = "チーム編成が学院任務手帳の推奨指示に反していますが、それでもチャレンジを続けますか？"
  },
  TipsType_20057_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20057_RightBtnDesc = {Text = "確認"},
  TipsType_20057_Title = {
    Text = "チーム確認"
  },
  TipsType_20058_Desc = {
    Text = "現在のステージはクリア済みです。再挑戦するには、ステージ進行を0星にリセットし、覚醒体の出撃記録をすべて消去する必要があります。リセットしますか？"
  },
  TipsType_20058_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20058_RightBtnDesc = {Text = "確認"},
  TipsType_20058_Title = {
    Text = "リセット確認"
  },
  TipsType_20059_Desc = {
    Text = "現在のチームは覚醒体が4体未満のため、戦闘に入れません"
  },
  TipsType_20059_Title = {
    Text = "編成を保存"
  },
  TipsType_20060_BottomDesc = {
    Text = "確認後は再び覚醒することができません"
  },
  TipsType_20060_Desc = {
    Text = "今回の召喚結果を選択しますか？\n（今回の召喚で得たすべての覚醒体と運命の札を獲得します）"
  },
  TipsType_20060_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20060_RightBtnDesc = {Text = "確認"},
  TipsType_20060_Title = {
    Text = "選択を確認"
  },
  TipsType_20061_BottomDesc = {
    Text = "現在のシルバーコア：{s1}"
  },
  TipsType_20061_Desc = {
    Text = "{s1} シルバーコアを消費して再召喚しますか？\n再召喚すると今回のガチャ結果は保持されません"
  },
  TipsType_20061_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20061_RightBtnDesc = {Text = "確認"},
  TipsType_20061_Title = {Text = "再召喚"},
  TipsType_20062_Desc = {
    Text = "すべての既読メールを削除しますか？\n添付ファイルが未受領のメールは削除されません"
  },
  TipsType_20062_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20062_RightBtnDesc = {Text = "確認"},
  TipsType_20062_Title = {
    Text = "既読を削除"
  },
  TipsType_20063_Desc = {
    Text = "削除しますか？"
  },
  TipsType_20063_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20063_RightBtnDesc = {Text = "確認"},
  TipsType_20063_Title = {
    Text = "現在のメールを削除"
  },
  TipsType_20064_Desc = {
    Text = "お気に入りボックスのメールを削除すると、復元できません。\nこのメールを削除しますか？"
  },
  TipsType_20064_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20064_RightBtnDesc = {Text = "確認"},
  TipsType_20064_Title = {
    Text = "お気に入りメールを削除"
  },
  TipsType_20065_Desc = {
    Text = "<Blue:{s1}> を消費して <Blue:{s2}> を合成しますか？"
  },
  TipsType_20065_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20065_RightBtnDesc = {Text = "確認"},
  TipsType_20065_Title = {
    Text = "合成確認"
  },
  TipsType_20066_Desc = {
    Text = "<Blue:{s1}>を分解して、<Blue:{s2}>を獲得しますか？"
  },
  TipsType_20066_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20066_RightBtnDesc = {Text = "確認"},
  TipsType_20066_Title = {
    Text = "分解確認"
  },
  TipsType_20067_Desc = {
    Text = "<Blue:{s1}>個の<Blue:SSR密約>を消費し、<Blue:{s2}>個の<Blue:{s3}>を再印しますか？"
  },
  TipsType_20067_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20067_RightBtnDesc = {Text = "確認"},
  TipsType_20067_Title = {
    Text = "再印確認"
  },
  TipsType_20068_Desc = {
    Text = "すべての覚醒体が戦闘不能\n\n守秘者よ、どちらを選ぶ？"
  },
  TipsType_20068_LeftBtnDesc = {Text = "再戦"},
  TipsType_20068_RightBtnDesc = {
    Text = "一時撤退"
  },
  TipsType_20068_Title = {
    Text = "調査失敗"
  },
  TipsType_20069_Desc = {
    Text = "選択中の覚醒体は狂気が満タンです。選択しますか？"
  },
  TipsType_20069_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20069_RightBtnDesc = {Text = "確認"},
  TipsType_20069_Title = {
    Text = "選択を確定"
  },
  TipsType_20070_Desc = {
    Text = "{s1}を使用しますか？\nレベルとスキルが上がった覚醒体はアップグレード物資が返却されません"
  },
  TipsType_20070_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20070_RightBtnDesc = {Text = "確認"},
  TipsType_20070_Title = {
    Text = "増幅確認"
  },
  TipsType_20071_Desc = {
    Text = "調査レベル制限により、覚醒体のレベルが{s1}に増加。足りない物資は返却されません。レベルアップしますか？"
  },
  TipsType_20071_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20071_RightBtnDesc = {Text = "確認"},
  TipsType_20071_Title = {
    Text = "増幅確認"
  },
  TipsType_20072_Desc = {
    Text = "このセクションの全ストーリーをスキップしますか？\n※後でこのステージに再度入り、ストーリーを観ることができます。"
  },
  TipsType_20072_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20072_RightBtnDesc = {Text = "確認"},
  TipsType_20072_Title = {
    Text = "スキップ"
  },
  TipsType_20073_Desc = {
    Text = "{s1}を分解し、{s2}を獲得しますか？\n（現在の密約は強化されています。分解しても強化物資は返却されません）"
  },
  TipsType_20073_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20073_RightBtnDesc = {Text = "確認"},
  TipsType_20073_Title = {
    Text = "分解確認"
  },
  TipsType_20074_Desc = {
    Text = "{s1}を分解して、{s2}を獲得しますか？\n（現在の運命の札はレア度が高いです）"
  },
  TipsType_20074_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20074_RightBtnDesc = {Text = "確認"},
  TipsType_20074_Title = {
    Text = "分解確認"
  },
  TipsType_20075_BottomDesc = {
    Text = "消費：{s1}研究許可"
  },
  TipsType_20075_Desc = {
    Text = "{s1}の研究を開始しますか？\n生産効率: {s2}薔薇金券/6時間ごと\n      ——>{s3}薔薇金券/6時間ごと"
  },
  TipsType_20075_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20075_RightBtnDesc = {Text = "確認"},
  TipsType_20075_Title = {
    Text = "研究確認"
  },
  TipsType_20076_BottomDesc = {
    Text = "消費：{s1}研究許可"
  },
  TipsType_20076_Desc = {
    Text = "{s1}の研究を開始しますか？\n生産効率: {s2}霊知の薬剤/6時間毎\n      ——>{s3}霊知の薬剤/6時間毎"
  },
  TipsType_20076_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20076_RightBtnDesc = {Text = "確認"},
  TipsType_20076_Title = {
    Text = "研究確認"
  },
  TipsType_20077_BottomDesc = {
    Text = "消費：{s1}研究許可"
  },
  TipsType_20077_Desc = {
    Text = "{s1}の研究を開始しますか？\n生産効率: {s2}密契の痕跡/6時間\n      ——>{s3}密契の痕跡/6時間"
  },
  TipsType_20077_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20077_RightBtnDesc = {Text = "確認"},
  TipsType_20077_Title = {
    Text = "研究確認"
  },
  TipsType_20078_Desc = {
    Text = "ストーリーをスキップしますか？\n※再調査の際にも読むことができます"
  },
  TipsType_20078_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20078_RightBtnDesc = {Text = "確認"},
  TipsType_20078_Title = {
    Text = "スキップ"
  },
  TipsType_20079_Desc = {
    Text = "シルバーキーが致命的な危機を感知しました。応急霊知体を起動しますか？\n（復活には応急霊知体を1回分消費します。応急霊知体は毎日9:00に自動で1回分補充されます。現在の残り回数：{s1}/{s2}）"
  },
  TipsType_20079_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20079_RightBtnDesc = {Text = "確認"},
  TipsType_20079_Title = {
    Text = "致命的な危機を感知"
  },
  TipsType_20080_Desc = {
    Text = "シルバーキーが致命的な危機を感知しました。応急霊知体を起動しますか？\n（復活には応急霊知体を1回分消費します。応急霊知体は毎日9:00に自動で1回分補充されます。現在の残り回数：{s1}/{s2}）"
  },
  TipsType_20080_RightBtnDesc = {Text = "確認"},
  TipsType_20080_Title = {
    Text = "致命的な危機を感知"
  },
  TipsType_20081_Desc = {
    Text = "ゲーム初期化失敗。{s1}"
  },
  TipsType_20081_RightBtnDesc = {Text = "確認"},
  TipsType_20081_Title = {
    Text = "ログインエラー"
  },
  TipsType_20082_Desc = {
    Text = "<Blue:「シルバーコア」× {s1} >を消費して<Blue: {s2} >レベルを購入しますか？"
  },
  TipsType_20082_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20082_RightBtnDesc = {Text = "確認"},
  TipsType_20082_Title = {
    Text = "レベルアップ"
  },
  TipsType_20083_Desc = {
    Text = "運命の札{s1}を消費して強化しますか？"
  },
  TipsType_20083_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20083_RightBtnDesc = {Text = "確認"},
  TipsType_20083_Title = {
    Text = "消費確認"
  },
  TipsType_20084_Desc = {
    Text = "チームの平均レベルがステージの推奨レベルより低いため、出場する覚醒体の能力が弱まります。それでも調査を続けますか？"
  },
  TipsType_20084_LeftBtnDesc = {
    Text = "レベルアップへ"
  },
  TipsType_20084_RightBtnDesc = {Text = "確定"},
  TipsType_20084_Title = {
    Text = "調査確認"
  },
  TipsType_20085_Desc = {
    Text = "ゲーム終了の確認"
  },
  TipsType_20085_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20085_RightBtnDesc = {Text = "確認"},
  TipsType_20085_Title = {
    Text = "ゲーム終了"
  },
  TipsType_20086_Desc = {
    Text = "サーバーメンテナンス中"
  },
  TipsType_20086_RightBtnDesc = {Text = "確認"},
  TipsType_20086_Title = {
    Text = "通信エラー"
  },
  TipsType_20087_Desc = {
    Text = "<TipsHighlightText:{s1} × {s2}>を消費して<TipsHighlightText:{s3}>を解放しますか？"
  },
  TipsType_20087_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20087_RightBtnDesc = {Text = "確認"},
  TipsType_20087_Title = {
    Text = "開放確認"
  },
  TipsType_20088_Desc = {
    Text = "受け取るとエンフェリンが超過し、{s1}を超える部分は取得できません。\n続けて受け取りますか？"
  },
  TipsType_20088_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20088_RightBtnDesc = {Text = "確認"},
  TipsType_20088_Title = {
    Text = "エンフェリンの所持上限が超過"
  },
  TipsType_20089_Desc = {
    Text = "「薔薇金券」×<Blue: {s1} >を消費して在庫を更新 \n 残り更新回数：<Blue:{s2}> \n 更新回数が増えるほど、必要な「薔薇金券」の数が増加します"
  },
  TipsType_20089_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20089_RightBtnDesc = {Text = "確認"},
  TipsType_20089_Title = {
    Text = "在庫を更新"
  },
  TipsType_20090_Desc = {
    Text = "運命の札の所持数が上限に達しているため、整理してからでないと召喚できません。移動しますか？\n\n<color=#ADC0CB>※「設定」でSR/R級運命の札の自動分解を設定可能</color>"
  },
  TipsType_20090_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20090_RightBtnDesc = {Text = "整理へ"},
  TipsType_20090_Title = {
    Text = "整理のヒント"
  },
  TipsType_20091_Desc = {
    Text = "密約の所持数が上限に達しているため、調査を行う前に密約の整理が必要です。移動しますか？"
  },
  TipsType_20091_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20091_RightBtnDesc = {Text = "整理へ"},
  TipsType_20091_Title = {
    Text = "整理のヒント"
  },
  TipsType_20092_Desc = {
    Text = "覚醒体が装備しているすべての運命の札を解放しますか？"
  },
  TipsType_20092_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20092_RightBtnDesc = {Text = "確認"},
  TipsType_20092_Title = {
    Text = "解放確認"
  },
  TipsType_20093_Desc = {
    Text = "密約を消費してアップグレードを行います。確定しますか？"
  },
  TipsType_20093_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20093_RightBtnDesc = {Text = "確認"},
  TipsType_20093_Title = {
    Text = "アップグレード確認"
  },
  TipsType_20094_Desc = {
    Text = "元のサブ能力に良い能力があります。変換後は保存されませんが、変換しますか？"
  },
  TipsType_20094_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20094_RightBtnDesc = {Text = "確認"},
  TipsType_20094_Title = {
    Text = "変換確認"
  },
  TipsType_20095_Desc = {
    Text = "現在の転写されたサブ能力には良い能力があります。続けると保存されませんが、続行しますか？"
  },
  TipsType_20095_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20095_RightBtnDesc = {Text = "確認"},
  TipsType_20095_Title = {
    Text = "転写確認"
  },
  TipsType_20096_Desc = {
    Text = "密契強化をするとレベル上限を超過します。超過後は素材が返還されます。強化しますか？"
  },
  TipsType_20096_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20096_RightBtnDesc = {Text = "確認"},
  TipsType_20096_Title = {
    Text = "アップグレード確認"
  },
  TipsType_20097_Desc = {
    Text = "覚醒体の霊知啓発は完了済です。\n選択後、「魂の回溯欠片」×1のみを獲得します。"
  },
  TipsType_20097_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20097_RightBtnDesc = {Text = "続行"},
  TipsType_20097_Title = {
    Text = "選択確認"
  },
  TipsType_20098_Desc = {
    Text = "この商品は<Blue:{s1}>白銀の交換証で購入可能"
  },
  TipsType_20098_LeftBtnDesc = {
    Text = "現金払い"
  },
  TipsType_20098_RightBtnDesc = {
    Text = "証明書支払い"
  },
  TipsType_20098_Title = {
    Text = "決済方法選択"
  },
  TipsType_20099_Desc = {
    Text = "ゲームを終了しますか？"
  },
  TipsType_20099_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20099_RightBtnDesc = {Text = "確認"},
  TipsType_20099_Title = {Text = "ヒント"},
  TipsType_20100_Desc = {
    Text = "更新データを検出しました。ダウンロードします"
  },
  TipsType_20100_RightBtnDesc = {Text = "確認"},
  TipsType_20100_Title = {
    Text = "更新のヒント"
  },
  TipsType_20101_Desc = {
    Text = "この調査は完了済みです。ストーリーをスキップしますか？"
  },
  TipsType_20101_LeftBtnDesc = {Text = "はい"},
  TipsType_20101_RightBtnDesc = {Text = "いいえ"},
  TipsType_20101_Title = {
    Text = "ストーリー確認"
  },
  TipsType_20102_Desc = {
    Text = "{s1}のフォローを解放しますか？"
  },
  TipsType_20102_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20102_RightBtnDesc = {Text = "確認"},
  TipsType_20102_Title = {
    Text = "フォロー解除"
  },
  TipsType_20103_Desc = {
    Text = "イベント期間中<WeaponEffect_Num:期間限定無料>解放、解放しますか？"
  },
  TipsType_20103_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20103_RightBtnDesc = {Text = "確認"},
  TipsType_20103_Title = {
    Text = "イベント特典"
  },
  TipsType_20105_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20105_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20105_Title = {
    Text = "調査確認"
  },
  TipsType_20106_Desc = {
    Text = "<Blue:「プラチナジェル」×  {s1} >を消費して購入しますか？"
  },
  TipsType_20106_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20106_RightBtnDesc = {Text = "購入"},
  TipsType_20106_Title = {
    Text = "購入確認"
  },
  TipsType_20107_Desc = {
    Text = "<Blue:{s1}> を選択しますか？"
  },
  TipsType_20107_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20107_RightBtnDesc = {Text = "確認"},
  TipsType_20107_Title = {
    Text = "選択確認"
  },
  TipsType_20108_Desc = {
    Text = "今回の強化で希少アイテム「循環基盤」を消費します\n続行しますか？"
  },
  TipsType_20108_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20108_RightBtnDesc = {Text = "確認"},
  TipsType_20108_Title = {
    Text = "消耗確認"
  },
  TipsType_20109_Desc = {
    Text = "本当に今回の戦闘をやり直しますか？"
  },
  TipsType_20109_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20109_RightBtnDesc = {Text = "確認"},
  TipsType_20109_Title = {Text = "再戦"},
  TipsType_20110_Desc = {
    Text = "{s1}月{s2}日を誕生日に設定しますか？\n設定後は変更できません。"
  },
  TipsType_20110_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20110_RightBtnDesc = {Text = "確認"},
  TipsType_20110_Title = {
    Text = "誕生日確認"
  },
  TipsType_20111_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20111_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20111_Title = {
    Text = "調査確認"
  },
  TipsType_20112_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20112_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20112_Title = {
    Text = "調査確認"
  },
  TipsType_20113_Desc = {
    Text = "すべての取得済みヘルプを既読にし、報酬を受け取りますか？"
  },
  TipsType_20113_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20113_RightBtnDesc = {Text = "確認"},
  TipsType_20113_Title = {
    Text = "一括確認"
  },
  TipsType_20114_Desc = {
    Text = "<WeaponEffect_Num:{s1}>を選んでリセットしますか？\nこの操作は元に戻せませんのでご注意ください"
  },
  TipsType_20114_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20114_RightBtnDesc = {Text = "確認"},
  TipsType_20114_Title = {
    Text = "リセット選択"
  },
  TipsType_201151_Desc = {
    Text = "この覚醒体は霊知啓発をしていないため、霊知啓発リセットはできません。"
  },
  TipsType_20115_Desc = {
    Text = "現在の覚醒体は育成されていないため、育成リセットは不要です。"
  },
  TipsType_20116_Desc = {
    Text = "<WeaponEffect_Num:{s1}>のリセットが開始されました。\n今すぐリセットに進みますか？"
  },
  TipsType_20116_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20116_RightBtnDesc = {Text = "進む"},
  TipsType_20116_Title = {
    Text = "開始成功"
  },
  TipsType_20117_Desc = {
    Text = "覚醒体のレベルアップ、昇格、スキル、才能、霊知深化の状態をリセットし、消費した素材を返還します。\n<WeaponEffect_Num:{s1}>に対してリセットを実行しますか？"
  },
  TipsType_20117_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20117_RightBtnDesc = {Text = "確認"},
  TipsType_20117_Title = {
    Text = "育成リセット"
  },
  TipsType_20118_Desc = {
    Text = "覚醒体の霊知啓発レベルをリセットし、消費を返還します。\n<WeaponEffect_Num:{s1}>の霊知啓発リセットを確認しますか？"
  },
  TipsType_20118_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20118_RightBtnDesc = {Text = "確認"},
  TipsType_20118_Title = {
    Text = "霊知啓発リセット"
  },
  TipsType_20119_Desc = {
    Text = "覚醒体のレベルアップ、昇格、スキル、霊知啓発、才能、霊知深化状態をリセットし、\n消費を返還し、覚醒体を昏き海に返還します。\n<WeaponEffect_Num:{s1}>の昏き海への返還を確認しますか？"
  },
  TipsType_20119_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20119_RightBtnDesc = {Text = "確認"},
  TipsType_20119_Title = {
    Text = "昏き海への返還"
  },
  TipsType_20120_Desc = {
    Text = "特殊な覚醒体は返還不可"
  },
  TipsType_20121_Desc = {
    Text = "運命の札の強化をリセットし、すべての強化素材を返還します。\n<WeaponEffect_Num:{s1}>の強化をリセットしますか？"
  },
  TipsType_20121_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20121_RightBtnDesc = {Text = "確認"},
  TipsType_20121_Title = {
    Text = "強化リセット"
  },
  TipsType_20122_Desc = {
    Text = "運命の札の強化をリセットし、すべての強化消費を返還し、運命の札を昏き海へ返還します。\n<WeaponEffect_Num:{s1}>を昏き海へ返還しますか？"
  },
  TipsType_20122_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20122_RightBtnDesc = {Text = "確認"},
  TipsType_20122_Title = {
    Text = "昏き海へ返還"
  },
  TipsType_20123_Desc = {
    Text = "挑戦を完了すると、チーム内の覚醒体、運命の札、キーオーダーは他の融災禁区で使用できなくなります。確定しますか？"
  },
  TipsType_20123_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20123_RightBtnDesc = {Text = "確認"},
  TipsType_20123_Title = {
    Text = "挑戦確認"
  },
  TipsType_20124_Desc = {
    Text = "リセット後、現在の調査チームの覚醒体、運命の札、キーオーダーは再度使用可能ですが、そのステージで得た特訓値も差し引かれます（報酬状態には影響しません）。リセットを確認しますか？"
  },
  TipsType_20124_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20124_RightBtnDesc = {Text = "確認"},
  TipsType_20124_Title = {
    Text = "リセット確認"
  },
  TipsType_20125_Desc = {
    Text = "現在の運命の札の強化レベルは0です。強化リセットは不要です。"
  },
  TipsType_20126_Desc = {
    Text = "現在、覚醒体は派遣中です。リセットまたは帰還する前に召喚してください。"
  },
  TipsType_20127_Desc = {
    Text = "現在の運命の札はロックされています。帰還前にロックを解放してください。"
  },
  TipsType_20128_Desc = {
    Text = "{s1}はクリア済みです。挑戦するにはリセットが必要です。リセットしますか？\n（リセット後、調査チームの覚醒体、運命の札、キーオーダーは再度使用可能ですが、そのステージで得た特訓値も差し引かれます）"
  },
  TipsType_20128_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20128_RightBtnDesc = {Text = "確認"},
  TipsType_20128_Title = {
    Text = "リセット確認"
  },
  TipsType_20129_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20129_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20129_Title = {
    Text = "調査確認"
  },
  TipsType_20130_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20130_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20130_Title = {
    Text = "調査確認"
  },
  TipsType_20131_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20131_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20131_Title = {
    Text = "調査確認"
  },
  TipsType_20132_Desc = {
    Text = "チェックすると、<TipsHighlightText:密約の断片>が十分であれば優先的に消費します。\n不足の場合は<TipsHighlightText:「{s1}」>を自動消費して補足します。"
  },
  TipsType_20132_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20132_RightBtnDesc = {
    Text = "チェックを続ける"
  },
  TipsType_20132_Title = {
    Text = "自動補充"
  },
  TipsType_20133_Desc = {
    Text = "<TipsHighlightText:「{s1}」>に霊知深化を行いますか？"
  },
  TipsType_20133_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20133_RightBtnDesc = {Text = "確認"},
  TipsType_20133_Title = {
    Text = "霊知深化"
  },
  TipsType_20134_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20134_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20134_Title = {
    Text = "調査確認"
  },
  TipsType_20137_Desc = {
    Text = "<Blue:{s1}×{s2}>を消費してこの曲を解放しますか？"
  },
  TipsType_20137_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20137_RightBtnDesc = {Text = "確認"},
  TipsType_20137_Title = {
    Text = "解放確認"
  },
  TipsType_20138_Desc = {
    Text = "イベント期間中 <Blue:期間限定無料> 解放。解放しますか？"
  },
  TipsType_20138_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20138_RightBtnDesc = {Text = "確認"},
  TipsType_20138_Title = {
    Text = "解放確認"
  },
  TipsType_20139_Desc = {
    Text = "<Blue:{s1}×{s3}>を消費して<Blue:{s2}>を開放しますか？"
  },
  TipsType_20139_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20139_RightBtnDesc = {Text = "確認"},
  TipsType_20139_Title = {
    Text = "解放確認"
  },
  TipsType_20140_Desc = {
    Text = "<Blue:{s1}> は所持上限のため、獲得できません。\nこれ以外の物資を獲得しますか？"
  },
  TipsType_20140_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20140_RightBtnDesc = {Text = "確認"},
  TipsType_20140_Title = {
    Text = "受取確認"
  },
  TipsType_20141_Desc = {
    Text = "最大ライフの30%({s1})を代償に\n戦闘をスキップし、敵を即座に倒しますか？\n\n現在のライフ:{s2}"
  },
  TipsType_20141_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20141_RightBtnDesc = {Text = "確認"},
  TipsType_20141_Title = {
    Text = "肉体の記憶"
  },
  TipsType_20142_Desc = {
    Text = "<color=#BB646D> {s1} </color> 点のライフを失うことを選択し、{s2} 枚の黒章を獲得しますか？"
  },
  TipsType_20142_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20142_RightBtnDesc = {Text = "確認"},
  TipsType_20142_Title = {
    Text = "調査確認"
  },
  TipsType_20145_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20145_Title = {
    Text = "ログインボーナス"
  },
  TipsType_20151_Desc = {
    Text = "リセット後、「特別アイテム」の残り数量が上限にリセットされますが、よろしいですか？"
  },
  TipsType_20151_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20151_RightBtnDesc = {Text = "確認"},
  TipsType_20151_Title = {
    Text = "リセット確認"
  },
  TipsType_20152_Desc = {
    Text = "{s1}不足、薔薇金券×{s2}を使用して補いますか？"
  },
  TipsType_20152_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20152_RightBtnDesc = {Text = "確認"},
  TipsType_20152_Title = {
    Text = "起動確認"
  },
  TipsType_20153_Desc = {
    Text = "リセット後、「特別アイテム」と「通常アイテム」の残量が上限にリセットされます。\n第{s1}回目以降、「特別アイテム」はリセットされません。\n確定しますか？"
  },
  TipsType_20153_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20153_RightBtnDesc = {Text = "確認"},
  TipsType_20153_Title = {
    Text = "リセット確認"
  },
  TipsType_20154_Desc = {
    Text = "リセット後、「特別アイテム」と「通常アイテム」の残量が上限にリセットされます。\n第3回目以降、「特別アイテム」はリセットされません。\n <Blue:現在「通常アイテム」が残っています>、確定しますか？"
  },
  TipsType_20154_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20154_RightBtnDesc = {Text = "確認"},
  TipsType_20154_Title = {
    Text = "リセット確認"
  },
  TipsType_20155_Desc = {
    Text = "強化素材にロックされた運命の札が含まれています。消費して強化しますか？"
  },
  TipsType_20155_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20155_RightBtnDesc = {Text = "確認"},
  TipsType_20155_Title = {
    Text = "強化の確認"
  },
  TipsType_20156_Desc = {
    Text = "<TipsHighlightText:起点装置×1>を消費して解放しますか？\n（欲望の波イベント期間中、解放に必要な起点装置が{s1}個から{s2}個に減少します）"
  },
  TipsType_20156_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20156_RightBtnDesc = {Text = "確認"},
  TipsType_20156_Title = {
    Text = "解放確認"
  },
  TipsType_20157_Desc = {
    Text = "<TipsHighlightText:起点装置×{s1}>を消費して解放しますか？"
  },
  TipsType_20157_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20157_RightBtnDesc = {Text = "確認"},
  TipsType_20157_Title = {
    Text = "解放確認"
  },
  TipsType_20158_Desc = {
    Text = "現在のステージは期限切れです。挑戦を完了しても報酬は得られません。退出しますか？"
  },
  TipsType_20158_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20158_RightBtnDesc = {Text = "確認"},
  TipsType_20158_Title = {
    Text = "退出確認"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:「{s1}」>上限超過<TipsHighlightText: {s2}>個、各々が<Blue:「無形者の招待状」× 1>に変換済み"
  },
  TipsType_20159_Title = {
    Text = "変換ヒント"
  },
  TipsType_20160_Desc = {
    Text = "あなたは<TipsHighlightText:「{s1}」>を解放しました。\n今回のイベントの無料解放特典として以下を贈呈します。"
  },
  TipsType_20160_RightBtnDesc = {Text = "確認"},
  TipsType_20160_Title = {
    Text = "補償案内"
  },
  TipsType_20161_Desc = {
    Text = "<TipsHighlightText:「{s1}」>上限超過<TipsHighlightText: {s2}>個、各々が<Blue:「薔薇金券」× 5000>に変換済み"
  },
  TipsType_20161_Title = {
    Text = "変換ヒント"
  },
  TipsType_20162_Desc = {
    Text = "覚醒体のレベルアップ、昇格、スキル、才能、霊知深化の状態をリセットし、消費した素材を返還します。\n<WeaponEffect_Num:{s1}>に対してリセットを実行しますか？"
  },
  TipsType_20162_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20162_RightBtnDesc = {Text = "確認"},
  TipsType_20162_Title = {
    Text = "育成リセット"
  },
  TipsType_20163_Desc = {
    Text = "覚醒体の霊知啓発の状態をリセットし、消費した素材を返還します。\n<WeaponEffect_Num:{s1}>に対してリセットを実行しますか？"
  },
  TipsType_20163_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20163_RightBtnDesc = {Text = "確認"},
  TipsType_20163_Title = {
    Text = "霊知啓発リセット"
  },
  TipsType_20164_Desc = {
    Text = "覚醒体のレベルアップ、昇格、スキル、才能、霊知啓発および霊知深化の状態をリセットし、消費した素材を返還し、\n覚醒体を昏き海に返還します。\n<WeaponEffect_Num:{s1}>の昏き海への返還を確認しますか？"
  },
  TipsType_20164_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20164_RightBtnDesc = {Text = "確認"},
  TipsType_20164_Title = {
    Text = "昏き海への帰還"
  },
  TipsType_20165_Desc = {
    Text = "<WeaponEffect_Num:{s1}>は特殊な覚醒体に分類され、レベルアップ、昇格、スキル、才能、霊知深化の育成のみリセット可能であり、<Red:霊知啓発育成はリセット不可です>。\n<WeaponEffect_Num:{s1}>のリセットを開始してもよろしいですか？\nこの操作は取り消せません。慎重にご確認ください。"
  },
  TipsType_20165_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20165_RightBtnDesc = {Text = "確認"},
  TipsType_20165_Title = {
    Text = "リセット選択"
  },
  TipsType_20166_Desc = {
    Text = "特殊覚醒体は「霊知啓発リセット」できません"
  },
  TipsType_20167_Desc = {
    Text = "今回のリセットでは「育成リセット」は使用済みです。次回リセットの際に「育成リセット」を行ってください。"
  },
  TipsType_20168_Desc = {
    Text = "今回のリセットでは「霊知啓発リセット」は使用済みです。次回リセットの際に「霊知啓発リセット」を行ってください。"
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue:注意：一度選択すると、今回の開催期間中は変更できません！>"
  },
  TipsType_20169_Desc = {
    Text = "覚醒体<OrangeQuality:「{s1}」>および推奨の運命の札<OrangeQuality:「{s2}」>を今回のピックアップとして選択しますか。"
  },
  TipsType_20169_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20169_RightBtnDesc = {Text = "確認"},
  TipsType_20169_Title = {
    Text = "選択を確認"
  },
  TipsType_20170_Desc = {
    Text = "日々の挑戦の上限に達しましたので、明日再度挑戦してください！"
  },
  TipsType_20171_Desc = {
    Text = "今すぐ「幻夢の深奥」にアクセスできます！"
  },
  TipsType_20173_Desc = {
    Text = "今すぐ「対人戦」にアクセスできます！"
  },
  TipsType_20174_Desc = {
    Text = "今すぐ「調査行動・高難度」にアクセスできます！"
  },
  TipsType_20175_Desc = {
    Text = "今すぐ「超越存在」にアクセスできます！"
  },
  TipsType_20176_Desc = {
    Text = "今すぐ「融災禁区」にアクセスできます！"
  },
  TipsType_20177_Desc = {
    Text = "今すぐ「繁栄狂宴」にアクセスできます！"
  },
  TipsType_20178_Desc = {
    Text = "今すぐ「第二運命の札装備」にアクセスできます！"
  },
  TipsType_20179_Desc = {
    Text = "今すぐ「混沌地帯」にアクセスできます！"
  },
  TipsType_20180_Desc = {
    Text = "今すぐ「禁忌編纂」にアクセスできます！"
  },
  TipsType_20181_Desc = {
    Text = "今すぐ「密約強化」にアクセスできます！"
  },
  TipsType_20182_Desc = {
    Text = "今すぐ「密約転写」にアクセスできます！"
  },
  TipsType_20183_Desc = {
    Text = "現在のイベントは終了しました"
  },
  TipsType_20184_Desc = {
    Text = "今すぐ「学籍档案」にアクセスできます！"
  },
  TipsType_20185_Desc = {
    Text = "ストーリーをスキップしますか？"
  },
  TipsType_20185_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20185_RightBtnDesc = {Text = "確認"},
  TipsType_20185_Title = {
    Text = "スキップ"
  },
  TipsType_20186_Desc = {
    Text = "ゲームの実行に必要なデータをダウンロードします。\n続行しますか？\n\n*Wi-Fi環境でのダウンロードを推奨します。"
  },
  TipsType_20186_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20186_RightBtnDesc = {Text = "確認"},
  TipsType_20187_Desc = {
    Text = "リソースのダウンロードが完了しました"
  },
  TipsType_20187_LeftBtnDesc = {Text = "確認"},
  TipsType_20188_Desc = {
    Text = "ストレージの空き容量が不足しています。実行中にリソースが失われる可能性があるため、少なくとも{s1}のストレージ容量を確保する必要があります。新しいリソースのダウンロードを続行しますか？"
  },
  TipsType_20188_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20188_RightBtnDesc = {Text = "確認"},
  TipsType_20189_Desc = {
    Text = "リソースのダウンロードに失敗しました。再試行しますか？"
  },
  TipsType_20189_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20189_RightBtnDesc = {Text = "確認"},
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}>が上限を<TipsHighlightText: {s2} >個超過しました。\n超過分は<Blue:{s3}>に変換されました。"
  },
  TipsType_20190_Title = {
    Text = "変換ヒント"
  },
  TipsType_20191_Desc = {
    Text = "今すぐ「イベント」にアクセスできます！"
  },
  TipsType_20192_Desc = {
    Text = "序章の後続コンテンツの必要データをダウンロードします。\nリソースサイズ：{s1}\n続行しますか？\n\n※WiFi環境でのダウンロードを推奨します。"
  },
  TipsType_20192_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20192_RightBtnDesc = {
    Text = "ダウンロード"
  },
  TipsType_20193_Desc = {
    Text = "今すぐ「派遣」にアクセスできます！"
  },
  TipsType_20194_Desc = {
    Text = "今すぐ「シルバーコア通信」にアクセスできます！"
  },
  TipsType_20195_Desc = {
    Text = "今すぐ「学期課題」にアクセスできます！"
  },
  TipsType_20196_Desc = {
    Text = "今すぐ「闇の境界」にアクセスできます！"
  },
  TipsType_20197_Desc = {
    Text = "最大の覚醒回数に達しました。タスク報酬を受け取るために向かってください！"
  },
  TipsType_20198_Desc = {
    Text = "まだ任務が完了していません。任務を完了した後に再度受け取りに来てください！"
  },
  TipsType_20199_Desc = {
    Text = "受け取ると代理証明が上限を超え、\n超過分は受け取れません。\n続けますか？"
  },
  TipsType_20199_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20199_RightBtnDesc = {Text = "確認"},
  TipsType_20199_Title = {
    Text = "受取確認"
  },
  TipsType_20200_Desc = {
    Text = "外勤代理を実行すると<Blue:代理証明×1>を消費します。\n実行後、即座に「日々の訓練」が完了します。よろしいですか？"
  },
  TipsType_20200_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20200_RightBtnDesc = {Text = "確認"},
  TipsType_20200_Title = {
    Text = "代理確認"
  },
  TipsType_20201_Desc = {
    Text = "以下の密約を装備中です。入れ替えますか？"
  },
  TipsType_20201_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20201_RightBtnDesc = {Text = "確認"},
  TipsType_20201_Title = {
    Text = "換装確認"
  },
  TipsType_20202_Desc = {
    Text = "現在のセットは{s1}に適用されています。セット【{s2}】を削除しますか？"
  },
  TipsType_20202_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20202_RightBtnDesc = {Text = "確認"},
  TipsType_20202_Title = {
    Text = "削除確認"
  },
  TipsType_20203_Desc = {
    Text = "チーム内で同じ運命の札の効果は重複しません。{s1}は現在のチームに装備されています。装備を確認しますか？"
  },
  TipsType_20203_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20203_RightBtnDesc = {Text = "確認"},
  TipsType_20203_Title = {
    Text = "装備確認"
  },
  TipsType_20204_Desc = {
    Text = "現在の密約は{s1}で使用中です。分解するとこのセットから削除されますが、よろしいですか？"
  },
  TipsType_20204_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20204_RightBtnDesc = {Text = "確認"},
  TipsType_20204_Title = {
    Text = "削除確認"
  },
  TipsType_20205_Desc = {
    Text = "現在の密約はチーム{s1}で使用中です。分解するとこの密約が解放されますが、よろしいですか？"
  },
  TipsType_20205_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20205_RightBtnDesc = {Text = "確認"},
  TipsType_20205_Title = {
    Text = "削除確認"
  },
  TipsType_20206_Desc = {
    Text = "現在の運命の札はチーム{s1}で使用中です。分解すると編成から解放されますが、よろしいですか？"
  },
  TipsType_20206_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20206_RightBtnDesc = {Text = "確認"},
  TipsType_20206_Title = {
    Text = "削除確認"
  },
  TipsType_20207_Desc = {
    Text = "現在のセットは保存されていません。退出すると保存されませんが、よろしいですか？"
  },
  TipsType_20207_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20207_RightBtnDesc = {Text = "確認"},
  TipsType_20207_Title = {
    Text = "保存確認"
  },
  TipsType_20208_Desc = {
    Text = "任務報酬は受け取られました。他の任務を見に行きましょう！"
  },
  TipsType_20209_Desc = {
    Text = "任務は期限切れです"
  },
  TipsType_20210_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20210_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20210_Title = {
    Text = "調査確認"
  },
  TipsType_20211_Desc = {
    Text = "{s1}日{s2}時間後に開始"
  },
  TipsType_20212_Desc = {
    Text = "{s1}時間{s2}分後に開封可能"
  },
  TipsType_20213_Desc = {
    Text = "<WeaponEffect_Num:{s1}>は編成で「因果の超越」を発動しています。\nリセットした場合、「因果の超越」は無効となり、編成から自動的に外されます。\n本当に<WeaponEffect_Num:{s1}> をリセットしますか？\nこの操作は取り消せませんので、慎重にご確認ください。"
  },
  TipsType_20213_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20213_RightBtnDesc = {Text = "確認"},
  TipsType_20213_Title = {
    Text = "リセット選択"
  },
  TipsType_20214_Desc = {
    Text = "運命の札の強化をリセットし、すべての強化素材を返還します。\n<WeaponEffect_Num:{s1}>は編成で「因果の超越」を発動していますが、リセット後は編成から自動的に外されます。\n本当に<WeaponEffect_Num:{s1}> の強化をリセットしますか？"
  },
  TipsType_20214_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20214_RightBtnDesc = {Text = "確認"},
  TipsType_20214_Title = {
    Text = "強化リセット"
  },
  TipsType_20215_Desc = {
    Text = "運命の札の強化をリセットし、すべての強化素材を返還し、運命の札を昏き海へ返還します\n<WeaponEffect_Num:{s1}> は編成で「因果の超越」を発動していますが、リセット後は編成から自動的に外されます。\n本当に <WeaponEffect_Num:{s1}>を昏き海へ返還しますか？"
  },
  TipsType_20215_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20215_RightBtnDesc = {Text = "確認"},
  TipsType_20215_Title = {
    Text = "昏き海への帰還"
  },
  TipsType_20216_Desc = {
    Text = "<Blue:「{s1}」× {s2} >を消費して購入しますか？"
  },
  TipsType_20216_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20216_RightBtnDesc = {Text = "購入"},
  TipsType_20216_Title = {
    Text = "購入確認"
  },
  TipsType_20217_Desc = {
    Text = "{s1}は{s2}後に開放されます。"
  },
  TipsType_20218_Desc = {
    Text = "今回の調査において予選された覚醒体は出場を取りやめることはできず、対応する覚醒体と置き換えることが可能です"
  },
  TipsType_20219_Desc = {
    Text = "同じ覚醒体が既に配置されています。重複して選択することはできません。"
  },
  TipsType_20220_Desc = {
    Text = "現在WIFIを使用していないことが検出されました。ダウンロードには多くのデータ通信が必要です。ダウンロードを確認しますか？\nリソースサイズ：{s1}\n続行しますか？"
  },
  TipsType_20220_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20220_RightBtnDesc = {
    Text = "ダウンロード"
  },
  TipsType_20221_Desc = {
    Text = "リソースのダウンロードが完了しました"
  },
  TipsType_20221_LeftBtnDesc = {Text = "確認"},
  TipsType_20222_Desc = {
    Text = "ストレージの空き容量が不足しています。実行中にリソースが失われる可能性があるため、少なくとも{s1}のストレージ容量を確保する必要があります。新しいリソースのダウンロードを続行しますか？"
  },
  TipsType_20222_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20222_RightBtnDesc = {Text = "確認"},
  TipsType_20223_Desc = {
    Text = "リソースのダウンロードに失敗しました。再試行しますか？"
  },
  TipsType_20223_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20223_RightBtnDesc = {Text = "確認"},
  TipsType_20224_Desc = {
    Text = "序章の後続コンテンツの必要データをダウンロードします。\nリソースサイズ：{s1}\n続行しますか？\n\n※WiFi環境でのダウンロードを推奨します。"
  },
  TipsType_20224_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20224_RightBtnDesc = {
    Text = "ダウンロード"
  },
  TipsType_20225_Desc = {
    Text = "{s1}はクリア済みです。追加チャレンジを行いますか？\n追加チャレンジで {s2} 特訓値を獲得できます"
  },
  TipsType_20225_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20225_RightBtnDesc = {Text = "確認"},
  TipsType_20225_Title = {
    Text = "追加の挑戦"
  },
  TipsType_20226_Desc = {
    Text = "リセット後、追加の挑戦隊の覚醒体、キー令、命輪は全て再出場できますが、そのステージで得た特訓値も減少します（報酬状態には影響しません）。リセットしてもよろしいですか？"
  },
  TipsType_20226_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20226_RightBtnDesc = {Text = "確認"},
  TipsType_20226_Title = {
    Text = "リセット確認"
  },
  TipsType_20227_Desc = {
    Text = "リセット後、現在の調査隊の覚醒体、キーおよび命輪は再出場可能で、追加の挑戦隊が現在の調査隊に置き換わりますが、そのステージでの追加クリアによって得た特訓値も減算されます(報酬ステータスには影響しません)。リセットを確認しますか？"
  },
  TipsType_20227_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20227_RightBtnDesc = {Text = "確認"},
  TipsType_20227_Title = {
    Text = "リセット確認"
  },
  TipsType_20228_Desc = {
    Text = "下にスワイプしてさらに読み込む"
  },
  TipsType_20229_Desc = {
    Text = "「<Blue:{s1}>」は強化レベルの上限に達しました。\n購入を続けますか？（残り数量：{s2}）"
  },
  TipsType_20229_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20229_RightBtnDesc = {Text = "確認"},
  TipsType_20229_Title = {
    Text = "購入確認"
  },
  TipsType_20230_Desc = {
    Text = "最高のストーリー体験を確保するため、以下の調査ステージを完了することをお勧めします。"
  },
  TipsType_20230_LeftBtnDesc = {Text = "終了"},
  TipsType_20230_RightBtnDesc = {
    Text = "まだ調査が必要"
  },
  TipsType_20230_Title = {
    Text = "調査確認"
  },
  TipsType_20231_Desc = {
    Text = "最高のストーリー体験を確保するため、以下の調査ステージを完了することをお勧めします。"
  },
  TipsType_20231_LeftBtnDesc = {Text = "終了"},
  TipsType_20231_RightBtnDesc = {
    Text = "まだ調査が必要"
  },
  TipsType_20231_Title = {
    Text = "調査確認"
  },
  TipsType_20232_Desc = {
    Text = "最高のストーリー体験を確保するため、以下の調査ステージを完了することをお勧めします。"
  },
  TipsType_20232_LeftBtnDesc = {Text = "終了"},
  TipsType_20232_RightBtnDesc = {
    Text = "まだ調査が必要"
  },
  TipsType_20232_Title = {
    Text = "調査確認"
  },
  TipsType_20233_Desc = {
    Text = "必要な素材が不足しています。\n以下の素材を消費して補充しますか？"
  },
  TipsType_20233_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20233_RightBtnDesc = {Text = "確認"},
  TipsType_20233_Title = {
    Text = "補充の確認"
  },
  TipsType_20234_Desc = {
    Text = "このステージでは指定されたキーのみ装備可能であり、入れ替えはできません。"
  },
  TipsType_20235_Desc = {
    Text = "最高のストーリー体験を確保するため、以下の調査ステージを完了することをお勧めします。"
  },
  TipsType_20235_LeftBtnDesc = {Text = "終了"},
  TipsType_20235_RightBtnDesc = {
    Text = "まだ調査が必要"
  },
  TipsType_20235_Title = {
    Text = "調査確認"
  },
  TipsType_20236_Desc = {
    Text = "最高のストーリー体験を確保するため、以下の調査ステージを完了することをお勧めします。"
  },
  TipsType_20236_LeftBtnDesc = {Text = "終了"},
  TipsType_20236_RightBtnDesc = {
    Text = "まだ調査が必要"
  },
  TipsType_20236_Title = {
    Text = "調査確認"
  },
  TipsType_20237_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20237_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20237_Title = {
    Text = "調査確認"
  },
  TipsType_20238_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20238_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20238_Title = {
    Text = "調査確認"
  },
  TipsType_20239_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20239_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20239_Title = {
    Text = "調査確認"
  },
  TipsType_20240_Desc = {
    Text = "修復完了。ゲームを再起動してください。"
  },
  TipsType_20240_RightBtnDesc = {Text = "確認"},
  TipsType_20240_Title = {
    Text = "お知らせ"
  },
  TipsType_20241_Desc = {
    Text = "強化レベルの上限に達するには、あと{s1}個の「<Blue:{s2}>」が必要です\n購入を続けますか？"
  },
  TipsType_20241_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20241_RightBtnDesc = {Text = "確認"},
  TipsType_20241_Title = {
    Text = "購入確認"
  },
  TipsType_20250_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20250_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20250_Title = {
    Text = "調査確認"
  },
  TipsType_20251_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_20251_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_20251_Title = {
    Text = "調査確認"
  },
  TipsType_20252_Desc = {
    Text = "最高のストーリー体験を確保するため、以下の調査ステージを完了することをお勧めします。"
  },
  TipsType_20252_LeftBtnDesc = {Text = "終了"},
  TipsType_20252_RightBtnDesc = {
    Text = "まだ調査が必要"
  },
  TipsType_20252_Title = {
    Text = "調査確認"
  },
  TipsType_20259_Desc = {
    Text = "「千面印章」不足時の自動変換設定を保存"
  },
  TipsType_20300_Desc = {
    Text = "既に {s1} の役割の覚醒体がいます。同じ役割の覚醒体は同じチームで使用できません。"
  },
  TipsType_20301_Desc = {
    Text = "今すぐ「通常任務」にアクセスできます！"
  },
  TipsType_20351_Desc = {
    Text = "{s1}が不足しています。{s2}{s3}を使用して{s4}{s5}に交換しますか？"
  },
  TipsType_20351_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20351_RightBtnDesc = {Text = "確認"},
  TipsType_20352_Desc = {
    Text = "相手と連携を行います。\n連携後は解除できません。よろしいですか？"
  },
  TipsType_20352_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20352_RightBtnDesc = {Text = "確認"},
  TipsType_20352_Title = {
    Text = "招待確認"
  },
  TipsType_20353_Desc = {
    Text = "招待コードがクリップボードにコピーされました。"
  },
  TipsType_20354_Desc = {
    Text = "あなたはすでに相手の招待者です。"
  },
  TipsType_20355_Desc = {
    Text = "自分の招待コードは入力できません。他の守秘者の招待コードを取得してみてください。"
  },
  TipsType_20356_Desc = {
    Text = "再プレイで序章のストーリーとチュートリアルをもう一度体験できます！\nただし、再プレイ時のステージ内容と報酬はすべてデモ表示となり、報酬を実際に獲得することはできません。\n実行しますか？"
  },
  TipsType_20356_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20356_RightBtnDesc = {Text = "確認"},
  TipsType_20356_Title = {
    Text = "調査確認"
  },
  TipsType_20357_Desc = {
    Text = "この{s1}人の守秘者のフォローを解除しますか？"
  },
  TipsType_20357_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20357_RightBtnDesc = {Text = "確認"},
  TipsType_20357_Title = {
    Text = "フォロー解除"
  },
  TipsType_20358_Desc = {
    Text = "未確認のフォロー解除があります。\n離れると操作は保存されませんが、離れますか？"
  },
  TipsType_20358_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20358_RightBtnDesc = {Text = "確認"},
  TipsType_20358_Title = {
    Text = "退出確認"
  },
  TipsType_20400_Desc = {
    Text = "<WeaponEffect_Num:「{s1}」>が不足しています。\n獲得しに行きますか？"
  },
  TipsType_20400_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_20400_RightBtnDesc = {Text = "確認"},
  TipsType_20400_Title = {
    Text = "抽選アイテムが不足しています"
  },
  TipsType_300001_Desc = {
    Text = "【初回限定無料召喚】を実行しますか？"
  },
  TipsType_300001_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_300001_RightBtnDesc = {Text = "確認"},
  TipsType_300001_Title = {
    Text = "召喚確認"
  },
  TipsType_300002_Desc = {
    Text = "この召喚結果で決定しますか？\n決定した場合、【初回限定無料召喚】を終了します。"
  },
  TipsType_300002_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_300002_RightBtnDesc = {Text = "決定"},
  TipsType_300002_Title = {
    Text = "召喚確認"
  },
  TipsType_30001_Desc = {
    Text = "サイドヒントにアイコンなし"
  },
  TipsType_30003_Desc = {Text = "{s1}解放"},
  TipsType_30004_Desc = {
    Text = "{s1}上級モード解放"
  },
  TipsType_30005_Desc = {
    Text = "{s1}（高難度）解放"
  },
  TipsType_31000_Desc = {
    Text = "この生年月日で認証しますか？\n一度確定すると変更できません！"
  },
  TipsType_31000_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_31000_RightBtnDesc = {Text = "確認"},
  TipsType_31000_Title = {
    Text = "年齢認証"
  },
  TipsType_31001_Desc = {
    Text = "今月は<Blue:{s1}>円をチャージ済みです。\n上限は<Blue:{s2}>円ですので、来月まで待つか、低額のプランで試してください。"
  },
  TipsType_31002_Desc = {
    Text = "まずは年齢認証を完了してください"
  },
  TipsType_31003_Desc = {
    Text = "シルバーキーが致命的な危機を感知しました。復活の魂魄を使用しますか？\n（復活には復活の魂魄を1つ消費します。復活の魂魄は毎日9:00に1回自動で取得されます。現在の残り回数：{s1}）\n<Blue:（初回復活は復活の魂魄を消費しません）>"
  },
  TipsType_31003_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_31003_RightBtnDesc = {Text = "確認"},
  TipsType_31003_Title = {
    Text = "致命的な危機を感知"
  },
  TipsType_31004_Desc = {
    Text = "シルバーキーが致命的な危機を感知しました。復活の魂魄を使用しますか？\n（復活には復活の魂魄を1つ消費します。復活の魂魄は毎日9:00に1回自動で取得されます。現在の残り回数：{s1}）\n<Blue:（初回復活は復活の魂魄を消費しません）>"
  },
  TipsType_31004_RightBtnDesc = {Text = "確認"},
  TipsType_31004_Title = {
    Text = "致命的な危機を感知"
  },
  TipsType_40001_Desc = {
    Text = "ライフ0になると、調査は強制終了。"
  },
  TipsType_40001_Title = {Text = "ライフ"},
  TipsType_40002_Desc = {
    Text = "マップ移動や事件調査で精神的ストレスが増加し、心労値が溜まると守秘者に症状が現れる。\n1マス移動ごとに心労値が10点増加し、心労値100点ごとに1つの症状を獲得。\n心労値が500点に達すると、1マス移動ごとにライフが10%減少。"
  },
  TipsType_40002_Title = {Text = "心労値"},
  TipsType_40003_Desc = {
    Text = "派遣レベルが高いほど、任務の難易度が高くなり、獲得する報酬も増加。"
  },
  TipsType_40003_Title = {
    Text = "派遣レベル"
  },
  TipsType_40004_Desc = {
    Text = "各ターン初めて出した指令カードの一時的なコピーが超次元空間に入ります。\n超次元空間が上限に達すると、1つの追加超次元ターンを獲得し、シールドを保持します。\n界域知識効果：ターン開始時に「啓示」を1枚手札に追加する確率があります。"
  },
  TipsType_40004_Title = {
    Text = "超次元空間"
  },
  TipsType_40005_Desc = {
    Text = "守秘者は調査や強化演習などの挑戦でレベルを上げることができます。守秘者調査レベルが上がると、新たな機能などが順次解放されます。"
  },
  TipsType_40005_Title = {Text = "レベル"},
  TipsType_40006_Desc = {
    Text = "指令カードの使用には行動力が必要です。ターン終了時、残りの行動力は保持されません。ターン開始時に行動力は上限まで回復します。"
  },
  TipsType_40006_Title = {Text = "行動力"},
  TipsType_40007_Desc = {
    Text = "シルバーキーが特別なエネルギーを感知しました。マップには貴重な物資が隠されているかもしれません……"
  },
  TipsType_40007_Title = {
    Text = "隠し物資"
  },
  TipsType_40008_Desc = {
    Text = "戦闘中に致命的な危機に遭遇した際に発動可能で、発動ごとに1つ消費します。守秘者のライフと覚醒体の狂気を上限まで回復し、毎日15:00に1つ自動で獲得されます。"
  },
  TipsType_40008_Title = {
    Text = "復活の魂魄"
  },
  TipsType_40009_Desc = {
    Text = "指令カードを出すには行動力を消費します。ターン終了時に残った行動力は持ち越されず、ターン開始時に行動力の上限が+1され、上限まで回復します。現在は {s1} ターンです。"
  },
  TipsType_40009_Title = {Text = "行動力"},
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "融災禁区がリセットされました。進行中の挑戦は即座に終了します。"
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {Text = "確認"},
  TipsType_AbyssChallengeResetTips_Title = {Text = "ヒント"},
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = "銀の鍵が致命的な危機を感知しました。緊急れいち体を使用しますか？\n（復活には {s1} 個の緊急れいち体を消費します。緊急れいち体は毎日9時に自動で1個獲得できます）"
  },
  TipsType_AbyssChallengeRevivalTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {Text = "確認"},
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "致命的な危機を感知"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "<Blue:{s1}>の<Blue:{s2}>の招待を受け入れますか？"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {Text = "拒否"},
  TipsType_AcceptConfirm_RightBtnDesc = {
    Text = "受け入れる"
  },
  TipsType_AcceptConfirm_Title = {
    Text = "パスワード対戦"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "対応する任務を完了すると召喚可能"
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "すでに現在のBGMです"
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "「薔薇金券」が不足しているため、現在所持している「霊知製剤」を完全に使用できません。「薔薇金券」を補充してから再度お試しください。"
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "覚醒体はまだ開放されていません。今しばらくお待ちください"
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "<Blue:{s1}> を消費して、1個の<Blue:ランダム>覚醒体を獲得しますか？"
  },
  TipsType_AwakerRandomChestConfirm_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "使用確認"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "バトルの作成に失敗しました"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "現在の守密の旅はすべて完了しました。"
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "調査確認"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "最高のストーリー体験を確保するため、以下の調査ステージを完了することをお勧めします。"
  },
  TipsType_BestExperienceTips_Chapter7_LeftBtnDesc = {Text = "終了"},
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {
    Text = "まだ調査が必要"
  },
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "調査確認"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "最高のストーリー体験を確保するため、以下の調査ステージを完了することをお勧めします。"
  },
  TipsType_BestExperienceTips_Chapter8_LeftBtnDesc = {Text = "終了"},
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {
    Text = "まだ調査が必要"
  },
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "調査確認"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "最高のストーリー体験を確保するため、以下の調査ステージを完了することをお勧めします。"
  },
  TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "終了"},
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "まだ調査が必要"
  },
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "調査確認"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "最高のストーリー体験を確保するため、以下の調査ステージを完了することをお勧めします。"
  },
  TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc = {Text = "終了"},
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {
    Text = "まだ調査が必要"
  },
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "調査確認"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "調査確認"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "調査確認"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "調査確認"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "調査確認"
  },
  TipsType_CancelCollectAwakerTips_Desc = {
    Text = "お気に入りを解除しました"
  },
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "「薔薇金券」× {s1} を消費して購入しますか？"
  },
  TipsType_CoinBulkBuyConfirm_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "購入確認"
  },
  TipsType_CollectAwakerTips_Desc = {
    Text = "お気に入りに追加しました。"
  },
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "常用救援守秘者が上限に達しました。常用救援リストを調整してください"
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "ファイルの書き込みに失敗しました。デバイスの空きストレージ容量が十分かご確認ください"
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {Text = "確認"},
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "空き容量が不足しています。ダウンロードを続けますか？"
  },
  TipsType_DiskSpaceNotEnough_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {Text = "確認"},
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = "<Blue:「プラチナジェル」× {s1} >を消費して購入しますか？\n <color=#ACBFCA>今期は特別なテーマで、コアテーマの価格が下がっています</color>"
  },
  TipsType_DoubleExBPBuyConfirm_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "購入"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "購入確認"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "<color=#5EF2FF>パスワード</color>を入力してください"
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "最大{s1}名の覚醒体を選択してフィルタリング可能"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = "現在のページの<color=#5EF2FF>{s1}</color>名のフォロワーをフォローしますか？\n\n<color=#96947F>現在のフォロー </color>{s2}<color=#A0A0A0>/{s3}\n上限を超えるとフォローできなくなります</color>"
  },
  TipsType_FollowBackConfirm_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_FollowBackConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_FollowBackConfirm_Title = {
    Text = "フォロー確認"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = "この操作は大量のリソースを消費します。覚醒体の能力を限界まで育てたい場合に適しています。「狂気の予兆」を強化しますか？"
  },
  TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "強化確認"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = "この操作は大量のリソースを消費します。覚醒体の能力を限界まで育てたい場合に適しています。「内なるスピリチュア」を強化しますか？"
  },
  TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "強化確認"
  },
  TipsType_InCharging_Desc = {
    Text = "ご注文は処理中です。重複してお支払いしないでください。\nチャージが正常に完了している場合は、システムによる報酬の自動配布をしばらくお待ちください。\nチャージが完了していない場合は、ゲームを再起動してから再度お試しください。\nご不明な点がございましたら、カスタマーサポートにお問い合わせください。"
  },
  TipsType_InCharging_RightBtnDesc = {Text = "確認"},
  TipsType_InCharging_Title = {
    Text = "お知らせ"
  },
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "テキスト識別リソースをダウンロード中です。しばらくしてから再度ご確認ください"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "この覚醒体の霊知啓発は完了済です。\n選択後、「魂の回溯欠片」× 2のみを獲得します"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {Text = "続行"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "選択を確認"
  },
  TipsType_MainResetBG_Desc = {
    Text = "寮の背景<Blue:「画像」>と<Blue:「音楽」>をデフォルトに戻しますか？"
  },
  TipsType_MainResetBG_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_MainResetBG_RightBtnDesc = {Text = "確認"},
  TipsType_MainResetBG_Title = {
    Text = "デフォルトに戻す"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "固定で獲得できるアイテム。変更不可"
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "すべての選択アイテムを選んでから購入してください"
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "相手がマッチングをキャンセルしました"
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "相手が<Blue:{s1}>の招待を拒否しました。モードを再選択してください"
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = "戦闘ラウンド数が上限に達しました\n\n唯一のシークレットキーパーよ\nこれからどう選択しますか？"
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {Text = "再戦"},
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "一時撤退"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "調査失敗"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "戦闘再生の取得エラー\nしばらくしてから再試行してください"
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = "再生が25ターンの最大制限に達しました。\n再生を終了します。"
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {Text = "確認"},
  TipsType_PVEReplayMaxRounds_Title = {
    Text = "終了確認"
  },
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "調査記録なし"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "戦闘再生を読み込み中\n操作を繰り返さないでください"
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "特殊編成の戦闘再生は現在サポートされていません。\n今後をお楽しみに"
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "戦闘再生の取得がタイムアウトしました"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "戦闘再生中は操作できません"
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {
    Text = "クリップボードにコピーしました。"
  },
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "クリップボード内に<color=#5EF2FF>調査</color>編成が正しく認識されませんでした"
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = "この編成コードに対応するチーム配置を適用しますか？\n未所持の部分は空欄になります。"
  },
  TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {Text = "確認"},
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "適用確認"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "この編成にはプリセットの覚醒体が含まれているため、編成コードをコピーまたはインポートできません"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "対局がラウンド上限に達し、先手側が対局をエンディングできなかったため、敗北と判定されました。"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {Text = "確認"},
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {
    Text = "対戦終了"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "対局がラウンド上限に達し、後手側が終局まで守り切ったため、勝利と判定されました。"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {Text = "確認"},
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {
    Text = "対戦終了"
  },
  TipsType_PVPSurrenderConfirm_Desc = {
    Text = "降参しますか？"
  },
  TipsType_PVPSurrenderConfirm_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "降参確認"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "クリップボード内に<color=#5EF2FF>対人戦</color>の編成が正しく認識されませんでした"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "この守秘者をブロックリストに追加しますか？"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {Text = "拒否"},
  TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc = {
    Text = "受け入れる"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Title = {
    Text = "ブロックリストに追加しますか"
  },
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "パスワード対戦が始まりました"
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "新しい守秘者がこのパスワード対戦に参加しました"
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {
    Text = "待機中……"
  },
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "パスワード対戦を退出しますか？"
  },
  TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "退出確認"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "相手が対戦を拒否しました"
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "「基礎活性イオン」\n·解放後、今期課題の期間中「日常訓練」の「基礎活性イオン」累積報酬で獲得できる「起点装置」、「ヘブンズコア」、「経験」、「シルバーコア」が3倍になります。「核心課題」を購入すると、今期すでに受け取った「基礎活性イオン」累積報酬の追加倍率分が補填されます。"
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = "「時序逆行」\n・戦闘中に既に経過したターンまで遡ることができます。\n・過去25ターン以内の任意のターンに戻ることができます。\n・再戦後も逆行機能を使用して以前のターンに戻ることができます。"
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = "「対人戦」\n・解放後、今期課題の期間中「対人戦」の全てのカードを使用できます。"
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = "<color=#5EF2FF>パスワード</color>がクリップボードにコピーされました"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "<Blue:「プラチナジェル」× {s1} >を消費して購入しますか？\n\n<size=30><color=#ACBFCA>「プラチナジェル」消費時、贈られた「プラチナジェル」を優先的に差し引きます。\n（抽出：{s2}、贈与：{s3}）</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "購入"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "購入確認"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "コメント内容は空にできません"
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "このコメントを削除しますか？"
  },
  TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {Text = "確認"},
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "削除確認"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "すべてのコメントを非表示にしますか？"
  },
  TipsType_PvpHideCommentConfirm_LeftBtnDesc = {Text = "いいえ"},
  TipsType_PvpHideCommentConfirm_RightBtnDesc = {Text = "そう。"},
  TipsType_PvpHideCommentConfirm_Title = {Text = "秘密"},
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "ネットワーク異常を検出しました。マッチングが中断されました。"
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = "戦闘中です。以前の戦闘を続けますか？ \n「疾走する歓喜特急」シーズンが更新されました。挑戦を続けると最新シーズンのミッションを達成できますが、「VIPリスト」には入れません。"
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {Text = "確認"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Title = {Text = "ヒント"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "前回の挑戦進捗は {s1} - 第 {s2} ステージ - 第 {s3} 戦闘、「VIPポイント」× {s4} を獲得済みです。\nシーズンが更新されました。挑戦を続けると最新シーズンのミッションを達成できますが、「VIPリスト」には入れません。挑戦を続けますか？"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {Text = "確認"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {
    Text = "挑戦を続ける"
  },
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = "前回の挑戦進捗は {s1} - 第 {s2} 段階 - 第 {s3} 戦闘で、「VIPポイント」× {s4}を獲得しました。\n挑戦を続けますか？"
  },
  TipsType_RailWayContinueSaveStage_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {Text = "確認"},
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "挑戦を続ける"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "前回保存した挑戦を終了しないと、新しい挑戦はできません"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = "挑戦を終了してもよろしいですか？\n今回の挑戦の進行状況は保存され、次回の挑戦では現在の進行状況から続行され、この戦闘を再開します。"
  },
  TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {Text = "確認"},
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "保存して終了"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = "挑戦を終了してもよろしいですか？\n今回の挑戦の進行状況は保存され、次回の挑戦では現在の進行状況から続行されます。"
  },
  TipsType_RailWaySaveAndExitTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {Text = "確認"},
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "保存して終了"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "シーズンが更新されました。挑戦を続けると最新シーズンのミッションを達成できますが、「VIPリスト」には入れません。"
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "再生情報は空にできません"
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "チーム内に覚醒体の界域の衝突がありますので、調整してください。"
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "選択数を超えました"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "このランキングデータはまだ読み込みが完了していません。しばらくしてから画面を開き直してください。"
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {Text = "確認"},
  TipsType_ServerRankDataLoading_Title = {
    Text = "サーバーランキングデータ初期化中"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "<Blue:{s1}> 個の{s2}を使用して、<Blue:{s3}> 個の{s4}と交換します。交換を確認しますか？"
  },
  TipsType_ShopBulkBuyConfirm_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "交換確認"
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "戦闘記録は非公開です"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "Steam「設定-ゲーム中」および本ゲームの「プロパティ-一般」で「ゲーム中にSteamオーバーレイを有効にする」をオンにし、完了後にゲームを再起動して再試行してください。"
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {Text = "確認"},
  TipsType_SteamOverlayEnabledTips_Title = {
    Text = "お知らせ"
  },
  TipsType_SteamRestartTips_Desc = {
    Text = "Steam 認証に異常が発生しました。Steam クライアントを再起動してから再試行してください。"
  },
  TipsType_SteamRestartTips_RightBtnDesc = {Text = "確認"},
  TipsType_SteamRestartTips_Title = {
    Text = "ログイン異常"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "調査確認"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "調査確認"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "最適なストーリー体験のために、以下の調査を完了することをお勧めします。"
  },
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "調査を続ける"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "調査確認"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "覚醒消費素材の情報が変更されました。再度覚醒を行ってください"
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "{s1} 個の<Blue:「{s2}」>が不足しています。<Blue:「{s4}」×{s3} >で代替しますか？"
  },
  TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {Text = "確認"},
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "交換確認"
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue:注意：一度選択すると、今回の開催期間中は変更できません！>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "覚醒体<OrangeQuality:「{s1}」、「{s2}」、「{s3}」、「{s4}」>を今回のピックアップとして選択しますか？"
  },
  TipsType_SummonType_14SelectConfirm_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "選択確認"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue:注意：一度選択すると、今回の開催期間中は変更できません！>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "選択数が上限に達しました。"
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "すべてのタイプの選択を完了してからお試しください"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = "今期の指定覚醒体の選択を確定しますか？\n確定後、今期の選択は再度変更できません。"
  },
  TipsType_SummonType_17SelectConfirm_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "選択確認"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "最新ステータスです。もっと多くの校友をフォローして、より多くの救援の選択肢を手に入れましょう！"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "自動転写中のため、操作できません。"
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "（ロックオンされていない属性強度が1つ8になった時点で自動転写を停止します。）"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = "最大 {s1} 回転写\n最大消耗"
  },
  TipsType_TrinketAutoRefineTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "自動転写確認"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "密契バッグが満杯です"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "すべての密契を析離しますか？"
  },
  TipsType_TrinketBatchUnbindTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "析離確認"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "結合済みの密契が存在するため、方案として保存できません！"
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "以下の密契の結合を確認しますか？他の覚醒体が装備中、またはチーム編成/プリセット/サポートに存在する密契は自動的に取り外されます。"
  },
  TipsType_TrinketBindTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_TrinketBindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketBindTips_Title = {
    Text = "結合確認"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "結合を変更しますか？"
  },
  TipsType_TrinketChangeBindTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_TrinketChangeBindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketChangeBindTips_Title = {
    Text = "結合変更確認"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = "すべての密契を析離しますか？\n\n<color=#9BA3A2><size=30>選択した素材に +12 密契部品が含まれています。</size></color>"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "析離確認"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = "結合を変更しますか？\n\n<color=#9BA3A2><size=30>選択した素材に +12 密契部品が含まれています。</size></color>"
  },
  TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "結合変更確認"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = "この密契を析離しますか？\n\n<color=#9BA3A2><size=30>選択した素材に +12 密契部品が含まれています。</size></color>"
  },
  TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "析離確認"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "この密契を析離しますか？"
  },
  TipsType_TrinketUnbindTips_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_TrinketUnbindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketUnbindTips_Title = {
    Text = "析離確認"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "この<color=#5EF2FF>パスワード</color>は使用中です、しばらくしてから再試行してください"
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = "\n{s1}\nが<Blue:{s2}>の招待を受け入れるのを待っています"
  },
  TipsType_WaitOppositeSideAccept_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "パスワード対戦"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = "他の守秘者の入力を待っています\n <Blue:{s1}>\nパスワード対戦をマッチング中"
  },
  TipsType_WaitOthersEnter_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "<color=#5EF2FF>パスワード</color>をコピー"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "パスワード対戦"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "<Blue:{s1}> を消費して、1個の<Blue:ランダム>命輪を獲得しますか？"
  },
  TipsType_WeaponRandomChestConfirm_LeftBtnDesc = {
    Text = "キャンセル"
  },
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "使用確認"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "今週中の報酬受取回数が上限に達しているため、リプレイはできません。"
  }
})
return Text_TipsType
