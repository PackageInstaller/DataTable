__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = "切換分辨率後需重啟用戶端才能生效，是否確認？"
  },
  TipsType_100001_RightBtnDesc = {Text = "確認"},
  TipsType_100001_Title = {
    Text = "切換分辨率確認"
  },
  TipsType_100002_Desc = {
    Text = "正在等待 {s1} 接受再來一局邀請"
  },
  TipsType_100002_Title = {
    Text = "再來一局"
  },
  TipsType_100003_Desc = {
    Text = "{s1} 邀請你再來一局"
  },
  TipsType_100003_LeftBtnDesc = {Text = "拒絕"},
  TipsType_100003_Title = {
    Text = "再來一局"
  },
  TipsType_100004_Desc = {
    Text = "已經是當前宿舍背景"
  },
  TipsType_100005_Desc = {
    Text = "相位對弈玩法未開啟"
  },
  TipsType_100006_Desc = {
    Text = "對方相位對弈玩法未開啟"
  },
  TipsType_100007_Desc = {
    Text = "互相關注才能發起友誼賽"
  },
  TipsType_100008_Desc = {
    Text = "對方已離線"
  },
  TipsType_100009_Desc = {
    Text = "對方正在探索中"
  },
  TipsType_100010_Desc = {
    Text = "友誼賽等待超時"
  },
  TipsType_100011_Desc = {
    Text = "你已取消友誼賽"
  },
  TipsType_100012_Desc = {
    Text = "友誼賽邀請被拒絕"
  },
  TipsType_100012_LeftBtnDesc = {Text = "確認"},
  TipsType_100013_Desc = {
    Text = "對方已離線"
  },
  TipsType_100014_Desc = {
    Text = "對方已進入其他玩法"
  },
  TipsType_100015_Desc = {
    Text = "邀請過於頻繁，{s1}秒後重試"
  },
  TipsType_100016_Desc = {
    Text = "對方已取消友誼賽"
  },
  TipsType_100016_LeftBtnDesc = {Text = "確認"},
  TipsType_100017_Desc = {
    Text = "該玩家正在進行友誼賽"
  },
  TipsType_100017_LeftBtnDesc = {Text = "確認"},
  TipsType_100018_Desc = {
    Text = "此編隊包含限時使用的卡牌，需要解鎖本期核心課題才可繼續使用，期待與你再次並肩作戰！\n是否前往解鎖核心課題？"
  },
  TipsType_100018_RightBtnDesc = {Text = "確認"},
  TipsType_100018_Title = {
    Text = "核心課題已過期"
  },
  TipsType_100020_Desc = {
    Text = "尚在戰鬥中，是否繼續之前的戰鬥？"
  },
  TipsType_100020_RightBtnDesc = {Text = "確認"},
  TipsType_10002_Desc = {
    Text = "配置表錯誤"
  },
  TipsType_10003_Desc = {
    Text = "用戶端傳入資料錯誤"
  },
  TipsType_10004_Desc = {
    Text = "伺服器未啟動"
  },
  TipsType_10005_Desc = {
    Text = "角色資料錯誤"
  },
  TipsType_10006_Desc = {
    Text = "沒有找到喚醒體資料"
  },
  TipsType_10007_Desc = {
    Text = "喚醒體已達最高等級"
  },
  TipsType_10008_Desc = {
    Text = "沒有足夠的課題分"
  },
  TipsType_10009_Desc = {
    Text = "喚醒體未達最高等級，無法啟靈"
  },
  TipsType_100100_Desc = {
    Text = "遊戲當前有版本更新，若未自動更新，請嘗試重啟 Steam 後檢查更新。"
  },
  TipsType_100100_RightBtnDesc = {Text = "確認"},
  TipsType_10010_Desc = {
    Text = "已完成啟靈"
  },
  TipsType_10011_Desc = {
    Text = "當前未創建角色"
  },
  TipsType_10012_Desc = {
    Text = "當前已有角色"
  },
  TipsType_10013_Desc = {
    Text = "角色名重複"
  },
  TipsType_10014_Desc = {
    Text = "密境區域錯誤"
  },
  TipsType_10015_Desc = {
    Text = "無法定位密境區域"
  },
  TipsType_10016_Desc = {
    Text = "當前體力過低"
  },
  TipsType_10017_Desc = {
    Text = "{s1}到{s2}可解鎖"
  },
  TipsType_10018_Desc = {
    Text = "抵達此密境第二層1次後，可進行快速調查"
  },
  TipsType_10020_Desc = {
    Text = "事件配置表中類型填寫錯誤"
  },
  TipsType_10022_Desc = {
    Text = "黑印不足無法購買"
  },
  TipsType_10023_Desc = {
    Text = "此卡無法強化"
  },
  TipsType_10024_Desc = {
    Text = "此卡已達強化上限"
  },
  TipsType_10025_Desc = {
    Text = "行商不售賣此商品"
  },
  TipsType_10026_Desc = {
    Text = "無此獎勵"
  },
  TipsType_10027_Desc = {
    Text = "獎勵已領取"
  },
  TipsType_10028_Desc = {
    Text = "事件資料錯誤"
  },
  TipsType_10029_Desc = {
    Text = "商品已購買"
  },
  TipsType_10030_Desc = {
    Text = "當前能量不足以啟動傳送門，啟動傳送門需要{s1}點能量。"
  },
  TipsType_10031_Desc = {
    Text = "未找到劇情對話事件"
  },
  TipsType_10032_Desc = {
    Text = "事件選擇指令卡數量不足"
  },
  TipsType_10033_Desc = {
    Text = "事件選擇指令卡數量過多"
  },
  TipsType_10034_Desc = {
    Text = "事件選擇指令卡不存在"
  },
  TipsType_10035_Desc = {
    Text = "隨機事件池中無資料"
  },
  TipsType_10036_Desc = {
    Text = "行商不售賣此商品"
  },
  TipsType_10037_Desc = {
    Text = "事件選擇造物數量不足"
  },
  TipsType_10038_Desc = {
    Text = "事件選擇造物數量過多"
  },
  TipsType_10039_Desc = {
    Text = "事件選擇造物不存在"
  },
  TipsType_10040_Desc = {
    Text = "未找到此事件節點"
  },
  TipsType_10041_Desc = {
    Text = "行商刷新次數已用盡"
  },
  TipsType_10042_Desc = {
    Text = "戰鬥掉落指令卡刷新次數已用盡"
  },
  TipsType_10043_Desc = {
    Text = "戰鬥掉落造物刷新次數已用盡"
  },
  TipsType_10044_Desc = {
    Text = "聯絡點功能被鎖"
  },
  TipsType_10045_Desc = {
    Text = "事件區域不匹配！當前區域：{s1}，事件配置區域：{s2}"
  },
  TipsType_10046_Desc = {
    Text = "事件商店刪除卡牌次數已用完"
  },
  TipsType_10047_Desc = {
    Text = "未找到課題單元資料"
  },
  TipsType_10048_Desc = {
    Text = "單元已提交，無需再次提交"
  },
  TipsType_10049_Desc = {
    Text = "單元下的課題尚未全部完成，無法提交"
  },
  TipsType_10050_Desc = {
    Text = "未找到課題模組"
  },
  TipsType_10051_Desc = {
    Text = "關卡沒有課題資料"
  },
  TipsType_10052_Desc = {
    Text = "沒有此密境對應的課題"
  },
  TipsType_10053_Desc = {
    Text = "學分不足，無法領取獎勵"
  },
  TipsType_10054_Desc = {
    Text = "學分獎勵尚未達到領取條件"
  },
  TipsType_10055_Desc = {
    Text = "課題分尚未找到任務"
  },
  TipsType_10056_Desc = {
    Text = "課題分任務已完成"
  },
  TipsType_10057_Desc = {
    Text = "課題分任務中的子任務未完成"
  },
  TipsType_10058_Desc = {
    Text = "NPC已被觸發"
  },
  TipsType_10059_Desc = {
    Text = "NPC資料錯誤"
  },
  TipsType_10061_Desc = {
    Text = "密境中未發現"
  },
  TipsType_10062_Desc = {
    Text = "未發現共鳴資料"
  },
  TipsType_10063_Desc = {
    Text = "共鳴已達最大等級"
  },
  TipsType_10064_Desc = {
    Text = "未發現共鳴等級相關資料"
  },
  TipsType_10065_Desc = {
    Text = "無重置次數"
  },
  TipsType_10066_Desc = {
    Text = "未達到啟動共鳴條件"
  },
  TipsType_10067_Desc = {
    Text = "共鳴粒子不足"
  },
  TipsType_10068_Desc = {
    Text = "啟靈已完成，無法再次啟靈"
  },
  TipsType_10069_Desc = {
    Text = "啟靈所需素材不足"
  },
  TipsType_10070_Desc = {
    Text = "喚醒體升級所需素材不足"
  },
  TipsType_10071_Desc = {
    Text = "喚醒體升級所需金券不足"
  },
  TipsType_10072_Desc = {
    Text = "喚醒體升級所需金券不足"
  },
  TipsType_10073_Desc = {
    Text = "無喚醒體技能"
  },
  TipsType_10074_Desc = {
    Text = "尚未解鎖喚醒體技能"
  },
  TipsType_10075_Desc = {
    Text = "喚醒所需的「銀芯」不足"
  },
  TipsType_10077_Desc = {
    Text = "今日購買次數已達上限"
  },
  TipsType_10079_Desc = {
    Text = "物品使用數量錯誤"
  },
  TipsType_10080_Desc = {
    Text = "技能已達到最大等級"
  },
  TipsType_10081_Desc = {
    Text = "素材不足，無法升級。"
  },
  TipsType_10082_Desc = {
    Text = "貨幣不足，無法升級。"
  },
  TipsType_10083_Desc = {
    Text = "喚醒體連接率已到達最高等級"
  },
  TipsType_10084_Desc = {
    Text = "該喚醒體同源精神不足"
  },
  TipsType_10085_Desc = {
    Text = "升級路線沒有配置角色id"
  },
  TipsType_10086_Desc = {
    Text = "找不到指定專屬卡資訊"
  },
  TipsType_10087_Desc = {
    Text = "指定專屬卡未解鎖"
  },
  TipsType_10088_Desc = {
    Text = "找不到該專屬卡uuid"
  },
  TipsType_10089_Desc = {
    Text = "章節獎勵未達到積分"
  },
  TipsType_10090_Desc = {
    Text = "章節獎勵已領取"
  },
  TipsType_10091_Desc = {
    Text = "選擇的劇情線尚未解鎖"
  },
  TipsType_10092_Desc = {
    Text = "選擇的副本尚未解鎖"
  },
  TipsType_10093_Desc = {
    Text = "副本區域尚未解鎖"
  },
  TipsType_10094_Desc = {
    Text = "劇情線掃蕩尚未解鎖"
  },
  TipsType_10095_Desc = {
    Text = "未找到副本挑戰的劇情線"
  },
  TipsType_10096_Desc = {
    Text = "未找到副本挑戰的劇情線任務"
  },
  TipsType_10097_Desc = {
    Text = "挑戰任務已完成,無法再次領取獎勵"
  },
  TipsType_10098_Desc = {
    Text = "挑戰任務尚未完成,無法領取獎勵"
  },
  TipsType_10099_Desc = {
    Text = "建築不存在"
  },
  TipsType_10100_Desc = {
    Text = "建築已到達最大等級"
  },
  TipsType_10101_Desc = {
    Text = "升級/建設建築條件不足"
  },
  TipsType_10102_Desc = {
    Text = "建築已存在不能再次建設"
  },
  TipsType_10103_Desc = {
    Text = "升級/建設所需要的的道具不足"
  },
  TipsType_10104_Desc = {
    Text = "位置已存在喚醒體,無法入駐"
  },
  TipsType_10106_Desc = {
    Text = "合成道具需要的貨幣不足"
  },
  TipsType_10107_Desc = {
    Text = "合成道具未解鎖"
  },
  TipsType_10108_Desc = {
    Text = "連接伺服器失敗，請檢查網路後重試"
  },
  TipsType_10109_Desc = {
    Text = "營地已選擇了功能無法再次選擇"
  },
  TipsType_10110_Desc = {
    Text = "營地功能已沒有使用次數"
  },
  TipsType_10111_Desc = {
    Text = "專屬卡沒有升級無法切換"
  },
  TipsType_10112_Desc = {
    Text = "專屬卡沒有變化無法切換"
  },
  TipsType_10113_Desc = {
    Text = "專屬卡切換失敗"
  },
  TipsType_10114_Desc = {
    Text = "獲得喚醒體{s1}"
  },
  TipsType_10115_Desc = {
    Text = "重複獲得{s1}，已轉為了{s2}{s3}"
  },
  TipsType_10116_Desc = {
    Text = "{s1}信物超過上限，已轉為了{s2}{s3}"
  },
  TipsType_10117_Desc = {
    Text = "Log上傳成功"
  },
  TipsType_10118_Desc = {
    Text = "指令不匹配，當前在等待指令 {s1}，輸入了 {s2}"
  },
  TipsType_10119_Desc = {
    Text = "失去卡牌：{s1}; uid：{s2}"
  },
  TipsType_10120_Desc = {
    Text = "不可釋放"
  },
  TipsType_10121_Desc = {
    Text = "無此技能"
  },
  TipsType_10122_Desc = {
    Text = "技能尚在緩衝"
  },
  TipsType_10123_Desc = {
    Text = "技能次數耗盡"
  },
  TipsType_10124_Desc = {
    Text = "檢查建築Tid {s1} 相關建築升級次序是否循環"
  },
  TipsType_10125_Desc = {
    Text = "檢查建築Tid {s1} 是否沒有相關配置"
  },
  TipsType_10126_Desc = {
    Text = "建築Tid {s1} 實際等級應該是 {s2},配置的為 {s3}"
  },
  TipsType_10127_Desc = {
    Text = "找不到建築類型配置"
  },
  TipsType_10128_Desc = {
    Text = "找不到建築配置，或者沒有建築類型"
  },
  TipsType_10129_Desc = {
    Text = "此劇情線課題分任務暫未開放"
  },
  TipsType_10131_Desc = {
    Text = "成功增加「靈啡肽」× {s1}"
  },
  TipsType_10132_Desc = {
    Text = "修復完成"
  },
  TipsType_10133_Desc = {
    Text = "GM 添加道具根據道具名【\"..arg1..\"】沒有找到對應的道具"
  },
  TipsType_10135_Desc = {
    Text = "當前：按{s1}"
  },
  TipsType_10136_Desc = {
    Text = "技能升級成功"
  },
  TipsType_10138_Desc = {
    Text = "修改伺服器時間成功"
  },
  TipsType_10139_Desc = {
    Text = "修改伺服器時間失敗"
  },
  TipsType_10140_Desc = {
    Text = "建築總數：17\n此臨時版本僅開放部分建築"
  },
  TipsType_10141_Desc = {
    Text = "未達到建築解鎖條件"
  },
  TipsType_10142_Desc = {
    Text = "建築：{s1}配置的介面不存在 {s2}"
  },
  TipsType_10143_Desc = {
    Text = "該合成公式暫未解鎖"
  },
  TipsType_10146_Desc = {
    Text = "升級成功"
  },
  TipsType_10147_Desc = {
    Text = "怪物欄為空，不能進入戰鬥"
  },
  TipsType_10148_Desc = {
    Text = "「靈啡肽」回覆"
  },
  TipsType_10149_Desc = {
    Text = "填寫的角色ID重複，不能進入戰鬥"
  },
  TipsType_10150_Desc = {
    Text = "填寫的ID{s1}不存在，不能進入戰鬥"
  },
  TipsType_10151_Desc = {
    Text = "怪物沒有對應的動作"
  },
  TipsType_10152_Desc = {
    Text = "暫未開放"
  },
  TipsType_10153_Desc = {
    Text = "當前卡堆中無卡牌"
  },
  TipsType_10155_Desc = {
    Text = "不在手卡中，無法打出"
  },
  TipsType_10160_Desc = {
    Text = "場上沒有對應喚醒體"
  },
  TipsType_10161_Desc = {
    Text = "剩餘次數不足"
  },
  TipsType_10163_Desc = {
    Text = "已選擇%d張指令卡"
  },
  TipsType_10164_Desc = {
    Text = "已達數量上限"
  },
  TipsType_10165_Desc = {
    Text = "尚未選中"
  },
  TipsType_10167_Desc = {
    Text = "消耗總和超過"
  },
  TipsType_10168_Desc = {
    Text = "已選擇{s1}張卡牌"
  },
  TipsType_10169_Desc = {
    Text = "觸腕數量已達上限"
  },
  TipsType_10171_Desc = {
    Text = "強化成功"
  },
  TipsType_10172_Desc = {
    Text = "變化成功"
  },
  TipsType_10173_Desc = {
    Text = "已複製到剪切板"
  },
  TipsType_10174_Desc = {
    Text = "已成功獲得指令卡"
  },
  TipsType_10175_Desc = {
    Text = "移除次數已用盡"
  },
  TipsType_10176_Desc = {
    Text = "強化次數已用盡"
  },
  TipsType_10177_Desc = {
    Text = "變化次數已用盡"
  },
  TipsType_10178_Desc = {
    Text = "複製次數已用盡"
  },
  TipsType_10179_Desc = {
    Text = "選擇指令卡張數到達上限"
  },
  TipsType_10180_Desc = {
    Text = "尚未選擇指令卡"
  },
  TipsType_10181_Desc = {
    Text = "商城暫未開啟，敬請期待。"
  },
  TipsType_10182_Desc = {
    Text = "敬請期待"
  },
  TipsType_10183_Desc = {
    Text = "課題目標所在區域過遠，無法定位"
  },
  TipsType_10184_Desc = {
    Text = "錯過目標所在區域，無法完成"
  },
  TipsType_10185_Desc = {
    Text = "暫未解鎖此課題"
  },
  TipsType_10186_Desc = {
    Text = "探索密境解鎖更多調查"
  },
  TipsType_10187_Desc = {
    Text = "完成前置任務解鎖更多調查"
  },
  TipsType_10188_Desc = {
    Text = "提交成功，課題分+{s1}"
  },
  TipsType_10189_Desc = {
    Text = "沒有可以提交的課題"
  },
  TipsType_10190_Desc = {
    Text = "暫未開啟，請留意副本開啟時間。"
  },
  TipsType_10191_Desc = {
    Text = "暫未達到關卡解鎖條件"
  },
  TipsType_10192_Desc = {
    Text = "{s1}不能為空"
  },
  TipsType_10193_Desc = {
    Text = "{s1}和{s2}不能為空"
  },
  TipsType_10194_Desc = {
    Text = "刷新次數已用盡，無法刷新。"
  },
  TipsType_10195_Desc = {
    Text = "獲取途徑尚未解鎖"
  },
  TipsType_10196_Desc = {
    Text = "獲取途徑不在開放時間內"
  },
  TipsType_10197_Desc = {
    Text = "請選擇需變化的造物"
  },
  TipsType_10199_Desc = {
    Text = "移除次數已用盡"
  },
  TipsType_10200_Desc = {
    Text = "變化次數已用盡"
  },
  TipsType_10201_Desc = {
    Text = "請選擇需移除的造物"
  },
  TipsType_10202_Desc = {
    Text = "數量已達上限"
  },
  TipsType_10203_Desc = {
    Text = "請至少選擇{s1}個造物"
  },
  TipsType_10204_Desc = {
    Text = "當前剩餘切換次數為0，無法進行切換"
  },
  TipsType_10205_Desc = {
    Text = "所有專屬卡均已升至等級上限"
  },
  TipsType_10206_Desc = {
    Text = "當前排斥度為0，無法繼續降低"
  },
  TipsType_10207_Desc = {
    Text = "暫未開放"
  },
  TipsType_10208_Desc = {
    Text = "錮靈之錨不足，無法進行強化"
  },
  TipsType_10209_Desc = {
    Text = "需{s1}達到{s2}級方可施行啟靈"
  },
  TipsType_10211_Desc = {
    Text = "暫未擁有「{s1}」"
  },
  TipsType_10212_Desc = {
    Text = "已達等級上限"
  },
  TipsType_10213_Desc = {
    Text = "請先選擇素材"
  },
  TipsType_10215_Desc = {
    Text = "升級成功"
  },
  TipsType_10216_Desc = {
    Text = "靈知製劑已增加"
  },
  TipsType_10217_Desc = {
    Text = "已達啟靈上限"
  },
  TipsType_10218_Desc = {
    Text = "升級失敗"
  },
  TipsType_10219_Desc = {
    Text = "道具不足，無法升級"
  },
  TipsType_10221_Desc = {
    Text = "技能升級成功"
  },
  TipsType_10222_Desc = {
    Text = "黑印不足，無法購買"
  },
  TipsType_10224_Desc = {
    Text = "黑印不足，無法移除指令卡"
  },
  TipsType_10225_Desc = {
    Text = "移除{s1}張指令卡"
  },
  TipsType_10226_Desc = {
    Text = "此方向暫未開放，無法進行強化"
  },
  TipsType_10227_Desc = {
    Text = "此方向已強化至上限等級"
  },
  TipsType_10228_Desc = {
    Text = "請先選擇專屬卡希望強化的方向"
  },
  TipsType_10229_Desc = {
    Text = "錮靈之錨不足，無法進行強化"
  },
  TipsType_10230_Desc = {
    Text = "暫未擁有該界域喚醒體，無法選擇。"
  },
  TipsType_10231_Desc = {
    Text = "創建一個隊伍"
  },
  TipsType_10232_Desc = {
    Text = "隊伍名稱不能超過{s1}漢字"
  },
  TipsType_10233_Desc = {
    Text = "隊伍名稱不能為空"
  },
  TipsType_10234_Desc = {
    Text = "兌換成功。"
  },
  TipsType_10235_Desc = {
    Text = "沒有更多「銀芯」了。"
  },
  TipsType_10236_Desc = {
    Text = "不能再減少了。"
  },
  TipsType_10237_Desc = {
    Text = "{s1}暫未開啟，敬請期待。"
  },
  TipsType_10238_Desc = {
    Text = "召喚暫未開啟，敬請期待。"
  },
  TipsType_10239_Desc = {
    Text = "校園小地圖功能暫未開啟"
  },
  TipsType_10240_Desc = {
    Text = "課題等級{s1}時解鎖"
  },
  TipsType_10241_Desc = {
    Text = "沒有符合條件的卡牌"
  },
  TipsType_10242_Desc = {
    Text = "所有界域卡已升級"
  },
  TipsType_10243_Desc = {
    Text = "沒有可升級的指令卡"
  },
  TipsType_10244_Desc = {
    Text = "發現新的傳送點！可前往{s1}。"
  },
  TipsType_10245_Desc = {
    Text = "已經獲得過此造物，無法重複獲得"
  },
  TipsType_10246_Desc = {
    Text = "恢復成功"
  },
  TipsType_10248_Desc = {
    Text = "打開背包界面"
  },
  TipsType_10249_Desc = {
    Text = "檢測到您上次異常下線、現已將「靈啡肽」及應得物資返還、可打開背包查看"
  },
  TipsType_10250_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10251_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10252_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10253_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10254_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10255_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10256_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10257_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10258_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10259_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10260_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10261_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10262_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10263_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10264_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10265_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10266_Desc = {
    Text = "AVG版僅提供個別建築，此處表示建築總數為17"
  },
  TipsType_10267_Desc = {
    Text = "不滿足使用條件"
  },
  TipsType_10268_Desc = {
    Text = "調查等級2級解鎖快速調查"
  },
  TipsType_10269_Desc = {
    Text = "連接中斷"
  },
  TipsType_10270_Desc = {
    Text = "伺服器連接中斷，稍後將返回登錄頁面。"
  },
  TipsType_10271_Desc = {Text = "確認"},
  TipsType_10272_Desc = {
    Text = "伺服器尚未開放，請稍後再試。"
  },
  TipsType_10274_Desc = {
    Text = "未找到對應密境"
  },
  TipsType_10276_Desc = {
    Text = "密境事件配置類型填寫錯誤"
  },
  TipsType_10278_Desc = {
    Text = "黑印不足，無法購買"
  },
  TipsType_10279_Desc = {
    Text = "此卡無法強化"
  },
  TipsType_10280_Desc = {
    Text = "此卡已達強化上限"
  },
  TipsType_10282_Desc = {
    Text = "無此獎勵"
  },
  TipsType_10283_Desc = {
    Text = "獎勵已領取"
  },
  TipsType_10284_Desc = {
    Text = "配置表錯誤"
  },
  TipsType_10285_Desc = {
    Text = "事件資料錯誤"
  },
  TipsType_10286_Desc = {
    Text = "商品已購買"
  },
  TipsType_10287_Desc = {
    Text = "未找到課題單元資料"
  },
  TipsType_10288_Desc = {
    Text = "單元已提交，無需再次提交"
  },
  TipsType_10289_Desc = {
    Text = "單元下的課題尚未全部完成，無法提交"
  },
  TipsType_10290_Desc = {
    Text = "課題無模組"
  },
  TipsType_10291_Desc = {
    Text = "關卡無課題資料"
  },
  TipsType_10292_Desc = {
    Text = "用戶端傳入資料錯誤"
  },
  TipsType_10293_Desc = {
    Text = "服務未啟動"
  },
  TipsType_10294_Desc = {
    Text = "角色資料錯誤"
  },
  TipsType_10295_Desc = {
    Text = "沒有角色，需創建"
  },
  TipsType_10296_Desc = {
    Text = "已有角色，不需要再次創建"
  },
  TipsType_10297_Desc = {
    Text = "角色名重複"
  },
  TipsType_10298_Desc = {
    Text = "密境錯誤"
  },
  TipsType_10299_Desc = {
    Text = "該劇情線尚未解鎖，無法進入。"
  },
  TipsType_10300_Desc = {
    Text = "在此處可以查看地形效果以及怪物資訊"
  },
  TipsType_10301_Desc = {
    Text = "{s1}達到{s2}解鎖{s3}"
  },
  TipsType_10302_Desc = {
    Text = "{s1}達到{s2}解鎖{s3}"
  },
  TipsType_10303_Desc = {
    Text = "未達到建築解鎖條件"
  },
  TipsType_10304_Desc = {
    Text = "未達到建築升級條件"
  },
  TipsType_10305_Desc = {
    Text = "建築升級素材不足"
  },
  TipsType_10306_Desc = {
    Text = "有可領取的任務獎勵"
  },
  TipsType_10307_Desc = {
    Text = "（生命將降低<Negative:10%%>）"
  },
  TipsType_10308_Desc = {
    Text = "每回合結束時，獲得等同於當前加護層數的<BuffTipBlock:護盾>值。每次受到傷害，加護減少<BuffTip:1>層"
  },
  TipsType_10309_Desc = {
    Text = "多重加護"
  },
  TipsType_10310_Desc = {
    Text = "體力低於警戒值，調查風險提高"
  },
  TipsType_10311_Desc = {
    Text = "體力低於警戒值，調查風險極高，是否選擇強行進入？"
  },
  TipsType_10312_Desc = {
    Text = "當前體力過低，無法進入密境。"
  },
  TipsType_10313_Desc = {
    Text = "請選擇同等級專屬卡進行切換"
  },
  TipsType_10314_Desc = {
    Text = "喚醒體啟靈2級後解鎖該方向"
  },
  TipsType_10315_Desc = {
    Text = "喚醒體啟靈3級後解鎖該方向"
  },
  TipsType_10316_Desc = {Text = "當前"},
  TipsType_10317_Desc = {
    Text = "所有喚醒體均未解鎖技能，無法充能"
  },
  TipsType_10318_Desc = {
    Text = "所有喚醒體技能的能量已滿"
  },
  TipsType_10323_Desc = {
    Text = "無法重複獲得已有造物"
  },
  TipsType_10324_Desc = {
    Text = "刷新次數不足"
  },
  TipsType_10325_Desc = {
    Text = "將對我方造成{s1}點傷害。"
  },
  TipsType_10326_Desc = {Text = "攻擊"},
  TipsType_10327_Desc = {
    Text = "在這裡會顯示關卡的小地圖預覽，玩家可以提前進行策略部署"
  },
  TipsType_10328_Desc = {
    Text = "你花了10分鐘完成日常副本中的一個關卡，在這裡得到了獨特的玩法體驗並且通過關卡設計強化了流派認知"
  },
  TipsType_10329_Desc = {
    Text = "當前生命上限已低於最大生命上限的50%，請注意安全"
  },
  TipsType_10330_Desc = {
    Text = "維繫喚醒體存在的能量。受到傷害會減少生命，生命歸零即代表調查失敗。"
  },
  TipsType_10331_Desc = {
    Text = "喚醒體攻擊強度的體現。力量越強，使用指令卡時對敵方造成的傷害越高。"
  },
  TipsType_10332_Desc = {
    Text = "喚醒體防禦能力的體現。戒備越高，使用指令卡時獲得的護盾越多。"
  },
  TipsType_10333_Desc = {
    Text = "點擊任意處繼續"
  },
  TipsType_10334_Desc = {
    Text = "尚未完成任務調查項目"
  },
  TipsType_10335_Desc = {
    Text = "調查評價"
  },
  TipsType_10336_Desc = {
    Text = "賦予1張專屬卡以啟示之靈"
  },
  TipsType_10337_Desc = {
    Text = "選擇專屬卡的強化方向"
  },
  TipsType_10338_Desc = {
    Text = "主城小地圖暫未開啟，敬請期待。"
  },
  TipsType_10340_Desc = {
    Text = "{s1}基礎卡組等級提升"
  },
  TipsType_10342_Desc = {
    Text = "與喚醒體之間的情感聯結的體現。好感度加深，可更加深入了解喚醒體。"
  },
  TipsType_10343_Desc = {
    Text = "<Positive:當前等級：>{s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:基礎卡組：>"
  },
  TipsType_10345_Desc = {
    Text = "該界域進入副本時擁有的初始卡組。"
  },
  TipsType_10346_Desc = {
    Text = "<Positive:卡組最高等級：>{s1}級"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:卡組等級：>"
  },
  TipsType_10348_Desc = {
    Text = "該界域指定數量喚醒體達到指定好感度等級時，可升級基礎卡組。"
  },
  TipsType_10349_Desc = {
    Text = "<Positive:升級內容：>"
  },
  TipsType_10350_Desc = {
    Text = "每次升級將提升一種指令卡的基礎值。"
  },
  TipsType_10355_Desc = {
    Text = "排斥度達到{s1}，密境正在注視你"
  },
  TipsType_10356_Desc = {Text = "啟靈1"},
  TipsType_10357_Desc = {
    Text = "領會該技能"
  },
  TipsType_10358_Desc = {
    Text = "能夠同時存在的觸腕數量最大值。"
  },
  TipsType_10359_Desc = {
    Text = "觸腕攻擊強度的體現。觸腕力量越強，激發觸腕時對敵方造成的傷害越高。"
  },
  TipsType_10360_Desc = {
    Text = "尚未選擇指令卡"
  },
  TipsType_10361_Desc = {
    Text = "變化成功"
  },
  TipsType_10362_Desc = {
    Text = "尚未選擇指令卡"
  },
  TipsType_10363_Desc = {
    Text = "複製成功"
  },
  TipsType_10364_Desc = {
    Text = "已選擇{s1}張指令卡"
  },
  TipsType_10365_Desc = {
    Text = "尚未選擇指令卡"
  },
  TipsType_10366_Desc = {
    Text = "尚未選擇指令卡"
  },
  TipsType_10367_Desc = {
    Text = "升級成功"
  },
  TipsType_10368_Desc = {
    Text = "造物背包界面開發中，敬請期待"
  },
  TipsType_10369_Desc = {
    Text = "請選擇需變化的造物"
  },
  TipsType_10370_Desc = {
    Text = "版本更新，請重新下載安裝包"
  },
  TipsType_10371_Desc = {
    Text = "進階效應"
  },
  TipsType_10372_Desc = {
    Text = "密境資訊"
  },
  TipsType_10373_Desc = {
    Text = "每使用1張傷害卡，觸腕會對隨機敵人造成{s1}點傷害。"
  },
  TipsType_10374_Desc = {
    Text = "當前無待完成課題"
  },
  TipsType_10375_Desc = {
    Text = "當前無已歸檔課題"
  },
  TipsType_10376_Desc = {
    Text = "本次調查未完成課題"
  },
  TipsType_10377_Desc = {
    Text = "無法回退"
  },
  TipsType_10378_Desc = {
    Text = "(以下課題已自動歸檔)"
  },
  TipsType_10379_Desc = {
    Text = "目標課題已完成"
  },
  TipsType_10380_Desc = {
    Text = "您沒有此道具"
  },
  TipsType_10381_Desc = {
    Text = "錯誤的索引值"
  },
  TipsType_10382_Desc = {Text = "未解鎖"},
  TipsType_10383_Desc = {
    Text = "專屬卡升級，沒有次數"
  },
  TipsType_10384_Desc = {
    Text = "已解鎖1個造物保留格！"
  },
  TipsType_10385_Desc = {
    Text = "連接率提升"
  },
  TipsType_10386_Desc = {
    Text = "沒有槽位資訊"
  },
  TipsType_10387_Desc = {
    Text = "貨幣不足"
  },
  TipsType_10388_Desc = {
    Text = "已到達最大等級"
  },
  TipsType_10389_Desc = {
    Text = "開發中敬請期待"
  },
  TipsType_10390_Desc = {
    Text = "已沒有手動升級槽位次數"
  },
  TipsType_10391_Desc = {
    Text = "在商店或營地解除封印後可使用"
  },
  TipsType_10392_Desc = {
    Text = "本場戰鬥扣除{s1}體力"
  },
  TipsType_10393_Desc = {
    Text = "喚醒體能量已滿，無法繼續提升"
  },
  TipsType_10394_Desc = {
    Text = "已將所有喚醒體的能量提升完畢"
  },
  TipsType_10395_Desc = {
    Text = "需要使用「眼」解鎖"
  },
  TipsType_10397_Desc = {
    Text = "已上陣{s1}喚醒體，隊伍將攜帶{s2}界域特性。"
  },
  TipsType_10398_Desc = {
    Text = "隊伍將變為中立，不攜帶任何界域特性。"
  },
  TipsType_10399_Desc = {
    Text = "小循環系統驗證在第四章關卡開啟"
  },
  TipsType_10400_Desc = {
    Text = "最多繼承{s1}個造物，請先減少選中造物數量。"
  },
  TipsType_10401_Desc = {
    Text = "未勾選造物無法繼承"
  },
  TipsType_10405_Desc = {Text = "獲得{s1}"},
  TipsType_10406_Desc = {
    Text = "上陣喚醒體已達到上限"
  },
  TipsType_10407_Desc = {
    Text = "該黃金塔無法挑戰-"
  },
  TipsType_10408_Desc = {
    Text = "該黃金塔未解鎖-請完成指定的調查副本"
  },
  TipsType_10409_Desc = {
    Text = "請選擇上場的喚醒體"
  },
  TipsType_10410_Desc = {
    Text = "喚醒體正在努力完成派遣任務，晚點再來領取吧"
  },
  TipsType_10411_Desc = {
    Text = "已領取{s1}薔薇金券"
  },
  TipsType_10412_Desc = {
    Text = "時間報酬需要隨時間累積"
  },
  TipsType_10413_Desc = {
    Text = "「銀芯」不足"
  },
  TipsType_10414_Desc = {
    Text = "沒有挑戰次數"
  },
  TipsType_10415_Desc = {
    Text = "挑戰冷卻中"
  },
  TipsType_10416_Desc = {
    Text = "沒有挑戰對手"
  },
  TipsType_10417_Desc = {
    Text = "請選擇上陣的喚醒體"
  },
  TipsType_10418_Desc = {
    Text = "靈知製劑不足，無法繼續提升等級"
  },
  TipsType_10419_Desc = {
    Text = "當前等級已達上限"
  },
  TipsType_10420_Desc = {
    Text = "喚醒體暫未解鎖"
  },
  TipsType_10422_Desc = {
    Text = "劇情線挑戰購買次數不足"
  },
  TipsType_10423_Desc = {
    Text = "劇情線星級不足，無法掃蕩"
  },
  TipsType_10424_Desc = {
    Text = "調查副本隊伍界域搭配錯誤"
  },
  TipsType_10425_Desc = {
    Text = "「銀芯」不足"
  },
  TipsType_10426_Desc = {
    Text = "今日憑證購買次數已達上限"
  },
  TipsType_10427_Desc = {
    Text = "三星通關秘境後解鎖"
  },
  TipsType_10428_Desc = {
    Text = "成功獲取{s1}張憑證"
  },
  TipsType_10429_Desc = {
    Text = "成功獲得{s1}次挑戰次數"
  },
  TipsType_10430_Desc = {
    Text = "通關 調查4-6 解鎖"
  },
  TipsType_10431_Desc = {
    Text = "憑證不足"
  },
  TipsType_10432_Desc = {
    Text = "憑證購買次數不足"
  },
  TipsType_10433_Desc = {
    Text = "啟靈等級已達上限"
  },
  TipsType_10435_Desc = {
    Text = "沒有此商品出售"
  },
  TipsType_10436_Desc = {
    Text = "沒有此類型商店"
  },
  TipsType_10437_Desc = {
    Text = "出售的商品已沒有庫存"
  },
  TipsType_10438_Desc = {
    Text = "沒有商店資料"
  },
  TipsType_10439_Desc = {
    Text = "沒有刷新次數"
  },
  TipsType_10440_Desc = {
    Text = "今日「靈啡肽」購買次數已達上限"
  },
  TipsType_10441_Desc = {
    Text = "喚醒體殘片不足"
  },
  TipsType_10442_Desc = {
    Text = "啟靈點已啟動"
  },
  TipsType_10443_Desc = {
    Text = "前置啟靈點未啟動"
  },
  TipsType_10444_Desc = {
    Text = "成功購買「靈啡肽」× {s1}"
  },
  TipsType_10445_Desc = {
    Text = "「靈啡肽」已達上限"
  },
  TipsType_10446_Desc = {
    Text = "完成 調查1-12 解鎖"
  },
  TipsType_10447_Desc = {
    Text = "完成 序章 解鎖"
  },
  TipsType_10448_Desc = {
    Text = "完成 序章 解鎖"
  },
  TipsType_10449_Desc = {
    Text = "完成 調查2-4 解鎖"
  },
  TipsType_10450_Desc = {
    Text = "該技能等級已達到上限"
  },
  TipsType_10451_Desc = {
    Text = "喚醒體升格等階不足"
  },
  TipsType_10452_Desc = {
    Text = "技能升級素材不足"
  },
  TipsType_10453_Desc = {
    Text = "完成 調查3-15 解鎖"
  },
  TipsType_10454_Desc = {
    Text = "完成 調查3-7 解鎖"
  },
  TipsType_10455_Desc = {
    Text = "技能升級未到達設置的條件"
  },
  TipsType_10456_Desc = {
    Text = "測試版本每個儲值項僅允許進行1次儲值操作"
  },
  TipsType_10457_Desc = {
    Text = "此喚醒體本源降臨冷卻中，下回合再釋放吧"
  },
  TipsType_10458_Desc = {
    Text = "儲值配置表中沒有此配置"
  },
  TipsType_10459_Desc = {
    Text = "已免費儲值過無法再次儲值"
  },
  TipsType_10460_Desc = {
    Text = "共鳴已啟動無需再次啟動"
  },
  TipsType_10461_Desc = {
    Text = "道具{s1}的價格已發生變更，請注意確認"
  },
  TipsType_10462_Desc = {
    Text = "「薔薇金券」不足"
  },
  TipsType_10463_Desc = {
    Text = "「演習徽章」不足"
  },
  TipsType_10464_Desc = {
    Text = "通關 調查3-4 解鎖"
  },
  TipsType_10465_Desc = {
    Text = "通關 調查2-16 解鎖"
  },
  TipsType_10466_Desc = {
    Text = "通關 調查3-16 解鎖"
  },
  TipsType_10467_Desc = {
    Text = "通關 調查4-12 解鎖"
  },
  TipsType_10468_Desc = {
    Text = "通關 調查5-12 解鎖"
  },
  TipsType_10469_Desc = {
    Text = "通關 調查6-12 解鎖"
  },
  TipsType_10470_Desc = {
    Text = "通關 調查1-7 解鎖"
  },
  TipsType_10471_Desc = {
    Text = "裝備成功"
  },
  TipsType_10473_Desc = {
    Text = "已達到最大等級"
  },
  TipsType_10474_Desc = {
    Text = "「薔薇金券」不足"
  },
  TipsType_10475_Desc = {
    Text = "請選擇材料"
  },
  TipsType_10476_Desc = {
    Text = "正被上鎖保護中，請先解除鎖定狀態"
  },
  TipsType_10477_Desc = {
    Text = "關卡未開放"
  },
  TipsType_10478_Desc = {
    Text = "戰鬥外未開放"
  },
  TipsType_10479_Desc = {
    Text = "棄牌堆為空"
  },
  TipsType_10480_Desc = {
    Text = "RPG戰鬥調整中，當前直接結算勝利"
  },
  TipsType_10482_Desc = {
    Text = "命輪已鎖定"
  },
  TipsType_10483_Desc = {
    Text = "命輪未找到"
  },
  TipsType_10484_Desc = {
    Text = "命輪已達最大等階"
  },
  TipsType_10485_Desc = {
    Text = "命輪已被裝備"
  },
  TipsType_10486_Desc = {
    Text = "命輪不匹配"
  },
  TipsType_10487_Desc = {
    Text = "命輪未鎖定"
  },
  TipsType_10488_Desc = {
    Text = "正處於「編隊」「助戰」「密契方案」中的密契，不可分解。"
  },
  TipsType_10489_Desc = {
    Text = "正處於「編隊」「助戰」中的命輪，不可分解。"
  },
  TipsType_10490_Desc = {
    Text = "狂氣值不足，無法釋放狂氣爆發"
  },
  TipsType_10491_Desc = {
    Text = "請先領取前一個禮包。"
  },
  TipsType_10492_Desc = {
    Text = "當前密契已鎖定，解鎖以作為物資消耗"
  },
  TipsType_10493_Desc = {
    Text = "當前命輪已鎖定，解鎖以作為物資消耗"
  },
  TipsType_10494_Desc = {
    Text = "通關 調查1-7 解鎖"
  },
  TipsType_10495_Desc = {
    Text = "通關 調查1-13 解鎖"
  },
  TipsType_10496_Desc = {
    Text = "當前密契等級已達上限"
  },
  TipsType_10498_Desc = {
    Text = "更換成功"
  },
  TipsType_10500_Desc = {
    Text = "疊位成功"
  },
  TipsType_10501_Desc = {
    Text = "當前挑戰尚未解鎖"
  },
  TipsType_10502_Desc = {
    Text = "當前喚醒體已在{s1}的其他關卡中進行了挑戰，無法再次出戰"
  },
  TipsType_10503_Desc = {
    Text = "上陣喚醒體不足4個，無法挑戰"
  },
  TipsType_10504_Desc = {
    Text = "通關 調查3-7 解鎖"
  },
  TipsType_10505_Desc = {
    Text = "第1層達到三星解鎖"
  },
  TipsType_10506_Desc = {
    Text = "第2層達到三星解鎖"
  },
  TipsType_10507_Desc = {
    Text = "第3層達到三星解鎖"
  },
  TipsType_10508_Desc = {
    Text = "第4層達到三星解鎖"
  },
  TipsType_10509_Desc = {
    Text = "第5層達到三星解鎖"
  },
  TipsType_10510_Desc = {
    Text = "第6層達到三星解鎖"
  },
  TipsType_10511_Desc = {
    Text = "第7層達到三星解鎖"
  },
  TipsType_10512_Desc = {
    Text = "第8層達到三星解鎖"
  },
  TipsType_10513_Desc = {
    Text = "請選擇希望強化的密契"
  },
  TipsType_10514_Desc = {Text = "已領取"},
  TipsType_10515_Desc = {
    Text = "通關 調查2-14 解鎖"
  },
  TipsType_10516_Desc = {
    Text = "通關 調查4-7 解鎖"
  },
  TipsType_10517_Desc = {
    Text = "通關 調查4-7 解鎖"
  },
  TipsType_10518_Desc = {
    Text = "編隊已保存"
  },
  TipsType_10519_Desc = {
    Text = "請觸摸發光區域進行移動"
  },
  TipsType_10520_Desc = {
    Text = "隊伍名中不可包含中文、英文、數字以外的字元"
  },
  TipsType_10521_Desc = {
    Text = "隊伍名長度不可大於8個字元"
  },
  TipsType_10522_Desc = {
    Text = "隊伍中喚醒體數量不足{s1}個，無法進行調查"
  },
  TipsType_10523_Desc = {
    Text = "喚醒體已參與過該層無光之境其它密境的戰鬥"
  },
  TipsType_10524_Desc = {
    Text = "隊伍中已有兩個界域的喚醒體，無法再選中其他界域喚醒體"
  },
  TipsType_10525_Desc = {
    Text = "請選中一個喚醒體"
  },
  TipsType_10526_Desc = {
    Text = "無法再選中更多的喚醒體"
  },
  TipsType_10527_Desc = {
    Text = "養成注意：幻夢深潛中，喚醒體等級和技能等級都被調為1級"
  },
  TipsType_10528_Desc = {
    Text = "隊伍名不可為空"
  },
  TipsType_10529_Desc = {
    Text = "隊伍中有喚醒體已筋疲力盡，無法再戰鬥"
  },
  TipsType_10530_Desc = {
    Text = "郵箱內的附件已全部領取完成"
  },
  TipsType_10531_Desc = {
    Text = "通關序章後解鎖"
  },
  TipsType_10532_Desc = {
    Text = "背包已滿，未領取完成，需清理背包後繼續領取"
  },
  TipsType_10533_Desc = {
    Text = "背包已滿，獎勵將發送至郵箱"
  },
  TipsType_10534_Desc = {
    Text = "背包已滿，物資未全部領取完成，需清理背包後繼續領取"
  },
  TipsType_10535_Desc = {
    Text = "沒有信函附件可領取"
  },
  TipsType_10536_Desc = {
    Text = "請先兌換造物"
  },
  TipsType_10537_Desc = {
    Text = "完成 調查2-4 解鎖"
  },
  TipsType_10538_Desc = {
    Text = "完成 調查1-12 解鎖"
  },
  TipsType_10539_Desc = {
    Text = "完成 調查1-12 解鎖"
  },
  TipsType_10540_Desc = {
    Text = "完成 調查1-12 解鎖"
  },
  TipsType_10541_Desc = {
    Text = "第9層達到三星解鎖"
  },
  TipsType_10542_Desc = {
    Text = "第10層達到三星解鎖"
  },
  TipsType_10543_Desc = {
    Text = "第11層達到三星解鎖"
  },
  TipsType_10544_Desc = {
    Text = "第12層達到三星解鎖"
  },
  TipsType_10545_Desc = {
    Text = "第13層達到三星解鎖"
  },
  TipsType_10546_Desc = {
    Text = "第14層達到三星解鎖"
  },
  TipsType_10547_Desc = {
    Text = "此功能即將移除"
  },
  TipsType_10548_Desc = {
    Text = "完成 調查1-7 解鎖"
  },
  TipsType_10549_Desc = {
    Text = "造物獲取已達上限，無法繼續獲取"
  },
  TipsType_10550_Desc = {
    Text = "{s1}完成連結，現在可以指揮她作戰了！"
  },
  TipsType_10551_Desc = {
    Text = "{s1}的等級和技能等級已超出靈知增幅器提供的等級，無法使用"
  },
  TipsType_10552_Desc = {
    Text = "喚醒體等級和技能等級已超出靈知增幅器提供的等級，無法使用"
  },
  TipsType_10553_Desc = {
    Text = "敬請期待"
  },
  TipsType_10554_Desc = {
    Text = "通過上一關卡後解鎖"
  },
  TipsType_10555_Desc = {
    Text = "脆弱通路上不可回頭"
  },
  TipsType_10556_Desc = {
    Text = "暫未開放，敬請期待"
  },
  TipsType_10557_Desc = {
    Text = "當前已擁有該造物，無法重複獲取"
  },
  TipsType_10558_Desc = {
    Text = "即將獲得系統剪切板中的內容並進行<Positive:【粘貼】>，\n是否確認？"
  },
  TipsType_10558_RightBtnDesc = {Text = "確認"},
  TipsType_10558_Title = {
    Text = "啟用粘貼功能"
  },
  TipsType_10560_Desc = {
    Text = "當前已是初始狀態"
  },
  TipsType_10561_Desc = {
    Text = "「薔薇金券」不足"
  },
  TipsType_10563_Desc = {
    Text = "共鳴重置成功"
  },
  TipsType_10564_Desc = {
    Text = "調查等級達到 {s1}級 解鎖"
  },
  TipsType_10565_Desc = {
    Text = "被封印的狂氣無法釋放"
  },
  TipsType_1056601_Desc = {
    Text = "銀芯通訊異常，請檢查網路並重試({s1})"
  },
  TipsType_10566_Desc = {
    Text = "銀芯通訊異常，請稍後重試({s1})"
  },
  TipsType_10567_Desc = {
    Text = "獲取伺服器信息失敗！{s1}"
  },
  TipsType_10568_Desc = {
    Text = "請先選擇伺服器"
  },
  TipsType_10569_Desc = {
    Text = "尚未解鎖"
  },
  TipsType_10570_Desc = {
    Text = "請輸入賬號"
  },
  TipsType_10571_Desc = {
    Text = "共鳴啟動材料不足"
  },
  TipsType_10572_Desc = {
    Text = "前置共鳴點未升級"
  },
  TipsType_10573_Desc = {Text = "已滿級"},
  TipsType_10574_Desc = {
    Text = "升級成功"
  },
  TipsType_10575_Desc = {
    Text = "該喚醒體不可更換"
  },
  TipsType_10576_Desc = {
    Text = "該位置不可上陣"
  },
  TipsType_10577_Desc = {
    Text = "喚醒體數量不足，不可挑戰"
  },
  TipsType_10578_Desc = {
    Text = "暫未解鎖下一關卡"
  },
  TipsType_10579_Desc = {
    Text = "已經是最後一個關卡了"
  },
  TipsType_10580_Desc = {
    Text = "已達當前經驗上限，無法添加"
  },
  TipsType_10581_Desc = {
    Text = "命輪槽已滿，無法添加"
  },
  TipsType_10582_Desc = {
    Text = "當前無可以快捷置入的素材"
  },
  TipsType_10583_Desc = {
    Text = "請放置素材到命輪槽"
  },
  TipsType_10584_Desc = {
    Text = "沒有可裝備的命輪"
  },
  TipsType_10585_Desc = {
    Text = "完成 調查2-8 解鎖"
  },
  TipsType_10586_Desc = {
    Text = "完成 調查2-14 解鎖"
  },
  TipsType_10587_Desc = {
    Text = "完成 調查3-16 解鎖"
  },
  TipsType_10588_Desc = {
    Text = "完成 調查4-12 解鎖"
  },
  TipsType_10589_Desc = {
    Text = "完成 調查5-12 解鎖"
  },
  TipsType_10590_Desc = {
    Text = "完成 調查6-12 解鎖"
  },
  TipsType_10591_Desc = {
    Text = "完成 調查2-12 解鎖"
  },
  TipsType_10592_Desc = {
    Text = "該用戶已被禁止登錄，如有疑問請聯繫客服。"
  },
  TipsType_10593_Desc = {
    Text = "登錄會話已過期，請重新登錄。"
  },
  TipsType_10594_Desc = {
    Text = "目前「靈啡肽」不足"
  },
  TipsType_10595_Desc = {
    Text = "是否啟動“{s1}”？"
  },
  TipsType_10595_Title = {
    Text = "啟動天賦"
  },
  TipsType_10596_Desc = {
    Text = "還未獲得該喚醒體"
  },
  TipsType_10597_Desc = {
    Text = "沒有可強化的命輪"
  },
  TipsType_10598_Desc = {
    Text = "該賬號由於違反相關條例已被禁止登錄直至{s1}，如有疑問請聯繫客服。"
  },
  TipsType_10599_Desc = {
    Text = "通關 調查2-15 解鎖"
  },
  TipsType_10600_Desc = {
    Text = "已達等級上限，無法繼續添加"
  },
  TipsType_10601_Desc = {
    Text = "完成調查1-7後開啟守密人成長記錄"
  },
  TipsType_10602_Desc = {
    Text = "完成調查1-7後開啟界域精通任務"
  },
  TipsType_10603_Desc = {
    Text = "尚未選擇素材"
  },
  TipsType_10604_Desc = {
    Text = "長時間未操作，自動退出副本"
  },
  TipsType_10605_Desc = {
    Text = "問卷填寫完畢，感謝您的支持！"
  },
  TipsType_10606_Desc = {
    Text = "啟動所需素材不足"
  },
  TipsType_10607_Desc = {
    Text = "本週內獲取獎勵次數已耗盡，挑戰後無法再獲得獎勵。是否仍要挑戰？"
  },
  TipsType_10607_RightBtnDesc = {Text = "確認"},
  TipsType_10607_Title = {
    Text = "挑戰提示"
  },
  TipsType_10608_Desc = {
    Text = "校園維護中，請靜候修整完成"
  },
  TipsType_10609_Desc = {
    Text = "成功邀請{s1}進入你的宿舍"
  },
  TipsType_10610_Desc = {
    Text = "{s1}已經在你的宿舍中了"
  },
  TipsType_10611_Desc = {
    Text = "當前為非wifi網路，是否使用流量繼續下載？"
  },
  TipsType_10611_RightBtnDesc = {Text = "確認"},
  TipsType_10611_Title = {
    Text = "下載確認"
  },
  TipsType_10613_Desc = {
    Text = "網路異常，請等待"
  },
  TipsType_10614_Desc = {
    Text = "當前挑戰未解鎖"
  },
  TipsType_10615_Desc = {
    Text = "冷卻中，下回合才能釋放。"
  },
  TipsType_10616_Desc = {
    Text = "處於選擇中，選擇完才能釋放。"
  },
  TipsType_10617_Desc = {
    Text = "當前狂氣爆發不滿足釋放條件，無法釋放。"
  },
  TipsType_10618_Desc = {
    Text = "當前隊伍平均等級{s1}低於推薦等級{s2}，調查可能會遇到較大的挑戰，是否確認？"
  },
  TipsType_10618_RightBtnDesc = {Text = "確認"},
  TipsType_10618_Title = {
    Text = "調查確認"
  },
  TipsType_10619_Desc = {
    Text = "調查等級 {s1}級 後方可使用"
  },
  TipsType_10620_Desc = {
    Text = "網路狀況不佳，請檢查Steam連接或重啟Steam後重試"
  },
  TipsType_10621_Desc = {
    Text = "是否確認使用<WeaponEffect_Num:{s1}>作為你的名字？"
  },
  TipsType_10621_RightBtnDesc = {Text = "確認"},
  TipsType_10621_Title = {
    Text = "鐫刻確認"
  },
  TipsType_10622_Desc = {
    Text = "鐫刻冷卻中，{s1}時{s2}分後可再次鐫刻"
  },
  TipsType_10623_Desc = {
    Text = "鐫刻成功"
  },
  TipsType_10624_Desc = {
    Text = "名字中只能包含中文、英文和數字"
  },
  TipsType_10625_Desc = {
    Text = "此卡即將丟棄"
  },
  TipsType_10626_Desc = {
    Text = "請在Steam中開啟以下選項：\n【Steam設置-遊戲中-在遊戲中啟用Steam介面】\n並重啟遊戲生效。"
  },
  TipsType_10626_RightBtnDesc = {Text = "確認"},
  TipsType_10628_Desc = {
    Text = "新的名字不可與當前重複"
  },
  TipsType_10629_Desc = {
    Text = "請輸入{s1}~{s2}個字元"
  },
  TipsType_10630_Desc = {
    Text = "{s1}達成三星後可進行重現"
  },
  TipsType_10631_Desc = {
    Text = "由於您的帳戶違反相關條例已被強制下線。"
  },
  TipsType_10631_RightBtnDesc = {Text = "確認"},
  TipsType_10631_Title = {
    Text = "溫馨提示"
  },
  TipsType_10632_Desc = {
    Text = "完成挑戰後，今日可進行重現"
  },
  TipsType_10633_Desc = {
    Text = "本次分解將消耗以下物資，<Blue:分解後將無法恢復>，是否確認分解？"
  },
  TipsType_10633_RightBtnDesc = {Text = "確認"},
  TipsType_10633_Title = {
    Text = "分解確認"
  },
  TipsType_10634_Desc = {
    Text = "當前月卡剩餘天數已超過{s1}天，無法累計。"
  },
  TipsType_10635_Desc = {
    Text = "所需「源液」不足、是否前往源液提煉？"
  },
  TipsType_10635_RightBtnDesc = {Text = "確認"},
  TipsType_10636_Desc = {
    Text = "當前無閒置命輪"
  },
  TipsType_10637_Desc = {
    Text = "當前無閒置密契"
  },
  TipsType_10638_Desc = {
    Text = "當前無可裝備密契位置，請卸下密契後嘗試"
  },
  TipsType_10640_Desc = {
    Text = "確認卸下該喚醒體的所有密契嗎？"
  },
  TipsType_10640_RightBtnDesc = {Text = "確認"},
  TipsType_10641_Desc = {
    Text = "切換語言後需重啟用戶端才能生效，是否確認？"
  },
  TipsType_10641_RightBtnDesc = {Text = "確認"},
  TipsType_10641_Title = {
    Text = "切換語言確認"
  },
  TipsType_10642_Desc = {
    Text = "玩家等級不足"
  },
  TipsType_10643_Desc = {
    Text = "步入遍佈融蝕的區域，生命值減少{s1}點"
  },
  TipsType_10644_Desc = {
    Text = "已選擇該鑰令"
  },
  TipsType_10645_Desc = {
    Text = "未獲得該鑰令"
  },
  TipsType_10647_Desc = {
    Text = "調查事件尚未開啟，{s1}"
  },
  TipsType_10648_Desc = {
    Text = "輪轉間隙已更新"
  },
  TipsType_10649_Desc = {
    Text = "當前可派遣數量已達上限"
  },
  TipsType_10650_Desc = {
    Text = "當前沒有已解鎖SSR角色"
  },
  TipsType_10651_Desc = {
    Text = "收集數量達到一定數量才可使用"
  },
  TipsType_10652_Desc = {
    Text = "當前沒有未獲得的頭像和對戰表情"
  },
  TipsType_10701_Desc = {
    Text = "當前已裝備命輪，請卸下後重試。"
  },
  TipsType_10702_Desc = {
    Text = "裝備的SSR命輪額外疊位達到 12 時，方可同時裝備兩個SSR命輪"
  },
  TipsType_10703_Desc = {
    Text = "喚醒體已裝備相同命輪，無法重複裝備。"
  },
  TipsType_10704_Desc = {
    Text = "密契等級已達上限"
  },
  TipsType_10705_Desc = {
    Text = "消耗材料數量已達上限"
  },
  TipsType_10706_Desc = {
    Text = "最多鎖定兩個副屬性"
  },
  TipsType_10707_Desc = {
    Text = "轉錄材料不足"
  },
  TipsType_10708_Desc = {
    Text = "喚醒體升格{s1}階後開啟"
  },
  TipsType_10711_Desc = {
    Text = "此商品未解鎖"
  },
  TipsType_10712_Desc = {
    Text = "消耗材料已滿"
  },
  TipsType_10713_Desc = {
    Text = "命輪疊位已達上限"
  },
  TipsType_10714_Desc = {
    Text = "不滿足事件條件，無法選擇"
  },
  TipsType_10715_Desc = {
    Text = "請安裝對應app後再進行分享"
  },
  TipsType_10716_Desc = {
    Text = "無法再選中更多的命輪"
  },
  TipsType_10717_Desc = {
    Text = "無法再選中更多的鑰令"
  },
  TipsType_10718_Desc = {
    Text = "啟動成功"
  },
  TipsType_10719_Desc = {
    Text = "「千面印章」不足、可在「置換設定」中選擇材料置換"
  },
  TipsType_10720_Desc = {
    Text = "已切換為1倍速"
  },
  TipsType_10721_Desc = {
    Text = "已切換為2倍速"
  },
  TipsType_10722_Desc = {
    Text = "校園入口擁堵中，請稍後重試"
  },
  TipsType_10724_Desc = {
    Text = "保存失敗，相冊權限未開啟或內存不足"
  },
  TipsType_10726_Desc = {
    Text = "請選擇卡牌"
  },
  TipsType_10727_Desc = {
    Text = "該喚醒體已被禁用"
  },
  TipsType_10728_Desc = {
    Text = "本源形態不可派遣，請重新選擇"
  },
  TipsType_10736_Desc = {
    Text = "「靈啡肽」已充足、無需補充"
  },
  TipsType_10737_Desc = {
    Text = "檢測到新的遊戲版本，請重新啟動遊戲更新以保證正常體驗。"
  },
  TipsType_10738_Desc = {
    Text = "當前沒有待閱讀的教學"
  },
  TipsType_10739_Desc = {
    Text = "{s1}已在{s2}中進行過挑戰，無法重複上場"
  },
  TipsType_10740_Desc = {
    Text = "當前調查等級{s1}低於推薦等級{s2}，調查可能會遇到較大的挑戰，是否確認？"
  },
  TipsType_10740_RightBtnDesc = {Text = "確認"},
  TipsType_10740_Title = {
    Text = "調查確認"
  },
  TipsType_10741_Desc = {
    Text = "當前隊伍平均等級{s1}和守密人調查等級{s2}均低於推薦等級，調查會遇到非常大的挑戰，是否確認？"
  },
  TipsType_10741_RightBtnDesc = {Text = "確認"},
  TipsType_10741_Title = {
    Text = "調查確認"
  },
  TipsType_10742_Desc = {
    Text = "隊伍中相同的命輪效果無法重複生效，當前<Blue:{s1}>存在命輪未生效的情況，建議守密人重新調整命輪裝備後再進行調查。\n是否仍要進行調查？"
  },
  TipsType_10742_RightBtnDesc = {Text = "確認"},
  TipsType_10742_Title = {
    Text = "調查確認"
  },
  TipsType_10743_Desc = {
    Text = "融災禁區無剩餘助戰次數"
  },
  TipsType_10744_Desc = {
    Text = "關注人數已達上限"
  },
  TipsType_10745_Desc = {
    Text = "生日日期有誤，無法設置"
  },
  TipsType_10746_Desc = {
    Text = "已複製到剪切板"
  },
  TipsType_10747_Desc = {
    Text = "點贊成功"
  },
  TipsType_10748_Desc = {
    Text = "{s1}已是助戰喚醒體"
  },
  TipsType_10749_Desc = {
    Text = "助戰喚醒體不可為空"
  },
  TipsType_10750_Desc = {
    Text = "今日已點贊過該守密人了"
  },
  TipsType_10751_Desc = {
    Text = "最多可以展示4名喚醒體"
  },
  TipsType_10752_Desc = {
    Text = "界域不符合要求，無法上場"
  },
  TipsType_10753_Desc = {
    Text = "{s1}已經上陣，不可重複選擇"
  },
  TipsType_10755_Desc = {
    Text = "解鎖成功"
  },
  TipsType_10756_Desc = {
    Text = "當前無疊位材料可放入"
  },
  TipsType_10757_Desc = {
    Text = "{s1}已經在今日本次活動中進行過挑戰，無法再次上場"
  },
  TipsType_10758_Desc = {
    Text = "隊伍界域不滿足要求"
  },
  TipsType_10761_Desc = {
    Text = "本源形態喚醒體無法與其普通形態同時出戰"
  },
  TipsType_10762_Desc = {
    Text = "本源形態喚醒體無法與其普通形態同時展示"
  },
  TipsType_10799_Desc = {
    Text = "當前<Blue:{s1}>的密契6件套效果由於<Blue:隊伍唯一>的限制未生效，建議守密人重新調整密契後再進行調查。\n是否仍要進行調查？"
  },
  TipsType_10799_RightBtnDesc = {Text = "確認"},
  TipsType_10799_Title = {
    Text = "調查確認"
  },
  TipsType_10801_Desc = {
    Text = "密契方案數量已達上限"
  },
  TipsType_10802_Desc = {
    Text = "{s1}已在其他密契方案中使用，無法保存方案"
  },
  TipsType_10803_Desc = {
    Text = "密契方案名不允許為空"
  },
  TipsType_10804_Desc = {
    Text = "包含非法字元，請重新輸入"
  },
  TipsType_10806_Desc = {
    Text = "當前密契已在{s1}中應用"
  },
  TipsType_10807_Desc = {Text = "已裝備"},
  TipsType_10809_Desc = {
    Text = "當前隊伍已出戰"
  },
  TipsType_10810_Desc = {
    Text = "密契方案不可為空"
  },
  TipsType_10811_Desc = {
    Text = "當前已裝備該方案"
  },
  TipsType_10812_Desc = {Text = "已裝備"},
  TipsType_10813_Desc = {
    Text = "是否確認刪除方案【{s1}】？"
  },
  TipsType_10813_RightBtnDesc = {Text = "確認"},
  TipsType_10814_Desc = {
    Text = "本次調查上陣喚醒體不符合隊伍要求"
  },
  TipsType_10815_Desc = {
    Text = "當前喚醒體為劇情特殊設計，無法查看詳情"
  },
  TipsType_10816_Desc = {
    Text = "「代理憑證」不足"
  },
  TipsType_10817_Desc = {
    Text = "當前沒有您的結算記錄，請先「挑戰」並在次日9：00 結算後再執行。"
  },
  TipsType_10818_Desc = {
    Text = "今日代理已完成，不可重複代理"
  },
  TipsType_10821_Desc = {
    Text = "當前暫無物資，請稍後再來"
  },
  TipsType_10822_Desc = {
    Text = "活動已結束"
  },
  TipsType_10823_Desc = {
    Text = "特殊種子售罄後才可要求商鋪進行補貨"
  },
  TipsType_10824_Desc = {
    Text = "補貨次數已用完，沒有更多的貨物儲備了"
  },
  TipsType_10826_Desc = {
    Text = "特殊種子已售罄，可選擇播種進行重置"
  },
  TipsType_10827_Desc = {
    Text = "特殊種子已重置"
  },
  TipsType_10828_Desc = {
    Text = "物品已全部交換完，請選擇重置"
  },
  TipsType_10830_Desc = {
    Text = "隊伍中存在無法上場的喚醒體，無法進入調查"
  },
  TipsType_10831_Desc = {
    Text = "隊伍中存在相同命輪，無法進入融災禁區"
  },
  TipsType_10832_Desc = {
    Text = "隊伍未裝備鑰令，無法進入調查"
  },
  TipsType_10833_Desc = {
    Text = "隊伍中存在無法裝備的命輪，無法進入調查"
  },
  TipsType_10834_Desc = {
    Text = "不可為助戰喚醒體裝備命輪"
  },
  TipsType_10835_Desc = {
    Text = "不可為助戰喚醒體裝備密契"
  },
  TipsType_10836_Desc = {
    Text = "不可為劇情預設喚醒體裝備命輪"
  },
  TipsType_10837_Desc = {
    Text = "不可為劇情預設喚醒體裝備密契"
  },
  TipsType_10838_Desc = {
    Text = "表情方案中的表情數量已達上限"
  },
  TipsType_10839_Desc = {
    Text = "表情已使用，點擊表情方案中的表情可卸下"
  },
  TipsType_10840_Desc = {
    Text = "表情發送太快啦"
  },
  TipsType_10841_Desc = {
    Text = "表情方案不可為空"
  },
  TipsType_10843_Desc = {
    Text = "此條目尚未解鎖"
  },
  TipsType_10844_Desc = {
    Text = "尚未解鎖"
  },
  TipsType_10850_Desc = {
    Text = "隊伍中存在無法裝備的鑰令，無法進入調查"
  },
  TipsType_10901_Desc = {Text = "麻痺"},
  TipsType_10903_Desc = {
    Text = "暫未擁有：{s1}"
  },
  TipsType_10904_Desc = {
    Text = "通關本章「普通」模式後，解鎖「溯夢」模式觀賞劇情"
  },
  TipsType_10905_Desc = {
    Text = "完成「調查行動」1-15·普通 後解鎖 「溯夢」觀賞劇情"
  },
  TipsType_10906_Desc = {
    Text = "「現實起點」不足"
  },
  TipsType_10907_Desc = {Text = "已解鎖"},
  TipsType_10908_Desc = {
    Text = "{s1}啟靈等級已滿、繼續領取將轉為<TipsHighlightText:「靈魂回溯碎片」× 2>、<TipsHighlightText:「根源沉澱」× 250>、是否確認喚醒？"
  },
  TipsType_10908_RightBtnDesc = {Text = "確認"},
  TipsType_10908_Title = {
    Text = "喚醒確認"
  },
  TipsType_10909_Desc = {
    Text = "{s1}已喚醒、繼續領取將轉為<TipsHighlightText:「殘片·{s2}」× 1>和<TipsHighlightText:「根源沉澱」× 50>、是否確認喚醒？"
  },
  TipsType_10909_RightBtnDesc = {Text = "確認"},
  TipsType_10909_Title = {
    Text = "喚醒確認"
  },
  TipsType_10910_Desc = {
    Text = "是否確認喚醒<TipsHighlightText:{s1}>？"
  },
  TipsType_10910_RightBtnDesc = {Text = "確認"},
  TipsType_10910_Title = {
    Text = "喚醒確認"
  },
  TipsType_10911_Desc = {
    Text = "空間不足"
  },
  TipsType_10912_Desc = {
    Text = "超維空間尚無指令卡，不可使用"
  },
  TipsType_10913_Desc = {
    Text = "本回合無法再次使用"
  },
  TipsType_10914_Desc = {
    Text = "是否確認選擇<TipsHighlightText:{s1}>？"
  },
  TipsType_10914_RightBtnDesc = {Text = "確認"},
  TipsType_10914_Title = {
    Text = "任選確認"
  },
  TipsType_10915_Desc = {
    Text = "解鎖編隊需按順序進行，不可跳過未解鎖的編隊"
  },
  TipsType_10916_Desc = {
    Text = "是否消耗<Blue: {s1} × {s2}> 解鎖？"
  },
  TipsType_10916_RightBtnDesc = {Text = "確認"},
  TipsType_10916_Title = {
    Text = "解鎖確認"
  },
  TipsType_10917_Desc = {
    Text = "成功解鎖 {s1}"
  },
  TipsType_10918_Desc = {
    Text = "成功解鎖{s1}，隊伍已全部解鎖完畢"
  },
  TipsType_10919_Desc = {
    Text = "完成[{s1}：{s2}]後解鎖，是否前往[{s1}]?"
  },
  TipsType_10919_RightBtnDesc = {Text = "確認"},
  TipsType_10919_Title = {
    Text = "暫未解鎖"
  },
  TipsType_10920_Desc = {
    Text = "在限時活動「相位逆轉」中累積「魔法橡果」× {s1} 即可解鎖、是否前往「相位逆轉」？"
  },
  TipsType_10920_RightBtnDesc = {Text = "確認"},
  TipsType_10920_Title = {
    Text = "暫未解鎖"
  },
  TipsType_10921_Desc = {
    Text = "無法同時裝備兩個主屬性相同的命輪"
  },
  TipsType_20001_Desc = {
    Text = "帶勾選二次確認"
  },
  TipsType_20001_LeftBtnDesc = {Text = "確定"},
  TipsType_20001_Title = {Text = "標題"},
  TipsType_20002_Desc = {
    Text = "不帶勾選二次確認"
  },
  TipsType_20002_RightBtnDesc = {Text = "確定"},
  TipsType_20002_Title = {Text = "標題"},
  TipsType_20003_Desc = {
    Text = "您的賬號已在其他設備登錄。"
  },
  TipsType_20003_RightBtnDesc = {Text = "確認"},
  TipsType_20003_Title = {
    Text = "斷線提示"
  },
  TipsType_20004_Desc = {
    Text = "與伺服器連接斷開，請重新登錄。"
  },
  TipsType_20004_RightBtnDesc = {Text = "確認"},
  TipsType_20004_Title = {
    Text = "斷線提示"
  },
  TipsType_20005_Desc = {
    Text = "同步失敗，是否再次嘗試？"
  },
  TipsType_20005_RightBtnDesc = {Text = "確認"},
  TipsType_20005_Title = {
    Text = "同步失敗"
  },
  TipsType_20006_Desc = {
    Text = "失去同步，稍後將返回登錄介面。"
  },
  TipsType_20006_RightBtnDesc = {Text = "確認"},
  TipsType_20006_Title = {
    Text = "同步失敗"
  },
  TipsType_20007_Desc = {
    Text = "失去同步，稍後將返回登錄介面。"
  },
  TipsType_20007_RightBtnDesc = {Text = "確認"},
  TipsType_20007_Title = {
    Text = "同步失敗"
  },
  TipsType_20008_Desc = {
    Text = "本次調查消耗體力 <Positive:{s1}>，是否確認結束？"
  },
  TipsType_20008_RightBtnDesc = {Text = "確認"},
  TipsType_20008_Title = {
    Text = "結束勘探"
  },
  TipsType_20009_Desc = {
    Text = "刷新將會更新刻印和造物，喚醒體覺醒和出售指令卡的次數不會重置，是否確認？"
  },
  TipsType_20009_RightBtnDesc = {Text = "確認"},
  TipsType_20009_Title = {
    Text = "確認刷新"
  },
  TipsType_20010_Desc = {
    Text = "此界域喚醒體數量不足，是否繼續創建隊伍？"
  },
  TipsType_20010_RightBtnDesc = {Text = "確認"},
  TipsType_20011_Desc = {
    Text = "未選擇任何喚醒體，編隊不予保留。"
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "確認離開"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "繼續編隊"
  },
  TipsType_20012_Desc = {
    Text = "未選擇喚醒體"
  },
  TipsType_20012_RightBtnDesc = {Text = "確認"},
  TipsType_20013_Desc = {
    Text = "隊伍尚有空缺，是否確認啟程？"
  },
  TipsType_20013_RightBtnDesc = {Text = "啟程"},
  TipsType_20014_Desc = {
    Text = "隊伍數量已達上限。"
  },
  TipsType_20014_RightBtnDesc = {Text = "確認"},
  TipsType_20015_Desc = {
    Text = "是否刪除此隊伍？"
  },
  TipsType_20015_RightBtnDesc = {Text = "確認"},
  TipsType_20016_Desc = {
    Text = "{s1}通關後解鎖"
  },
  TipsType_20016_RightBtnDesc = {Text = "確認"},
  TipsType_20017_Desc = {
    Text = "此處可查看地圖資訊和已經打過的怪物資訊，當前版本暫未開發"
  },
  TipsType_20017_RightBtnDesc = {Text = "確認"},
  TipsType_20018_Desc = {
    Text = "暫未達到關卡解鎖條件"
  },
  TipsType_20018_RightBtnDesc = {Text = "確認"},
  TipsType_20019_Desc = {
    Text = "「銀芯」不足、是否前往商城購買？"
  },
  TipsType_20020_Desc = {
    Text = "進階{s1}通關後解鎖此進階難度"
  },
  TipsType_20020_RightBtnDesc = {Text = "確認"},
  TipsType_20021_Desc = {
    Text = "{s1}普通模式通關後解鎖進階訓練"
  },
  TipsType_20021_RightBtnDesc = {Text = "確認"},
  TipsType_20022_Desc = {
    Text = "「銀芯」不足、是否前往購買"
  },
  TipsType_20022_RightBtnDesc = {Text = "確認"},
  TipsType_20022_Title = {
    Text = "銀芯不足"
  },
  TipsType_20023_Desc = {
    Text = "本次升級溢出{s1}點經驗（不返還），且角色達到等級上限後無法繼續獲得經驗，是否繼續？"
  },
  TipsType_20023_RightBtnDesc = {Text = "確認"},
  TipsType_20024_Desc = {
    Text = "隊伍未滿編，無法進入副本。"
  },
  TipsType_20024_RightBtnDesc = {Text = "確認"},
  TipsType_20026_Desc = {
    Text = "是否確認充能？"
  },
  TipsType_20026_RightBtnDesc = {Text = "確認"},
  TipsType_20027_Desc = {
    Text = "是否確認恢復生命？"
  },
  TipsType_20027_RightBtnDesc = {Text = "確認"},
  TipsType_20028_Desc = {
    Text = "關閉此介面將放棄拾取【{s1}】，是否放棄？"
  },
  TipsType_20028_RightBtnDesc = {Text = "確認"},
  TipsType_20029_Desc = {
    Text = "關閉此介面將跳過本次事件（造物不會被移除），是否確認？"
  },
  TipsType_20029_RightBtnDesc = {Text = "確認"},
  TipsType_20030_Desc = {
    Text = "已勾選造物將不會攜帶，是否放棄繼承？"
  },
  TipsType_20030_RightBtnDesc = {Text = "確認"},
  TipsType_20031_Desc = {
    Text = "是否確認退出戰鬥？"
  },
  TipsType_20031_RightBtnDesc = {Text = "確認"},
  TipsType_20032_Desc = {
    Text = "當前關卡暫未解鎖，是否前往通關調查關卡解鎖？"
  },
  TipsType_20032_RightBtnDesc = {Text = "確認"},
  TipsType_20032_Title = {
    Text = "暫未解鎖"
  },
  TipsType_20033_Desc = {
    Text = "當前挑戰次數不足、是否消耗「銀芯」× 500 重置？"
  },
  TipsType_20033_RightBtnDesc = {Text = "確認"},
  TipsType_20034_Desc = {
    Text = "當前挑戰冷卻中、是否消耗「銀芯」× 50 重置？"
  },
  TipsType_20034_RightBtnDesc = {Text = "確認"},
  TipsType_20035_Desc = {
    Text = "推薦等級為{s1}，當前隊伍平均等級為{s2}，調查將遇到阻礙，是否繼續進行？"
  },
  TipsType_20035_RightBtnDesc = {Text = "確認"},
  TipsType_20035_Title = {
    Text = "戰力不足"
  },
  TipsType_20036_Desc = {
    Text = "當前掃蕩次數設定為{s1}，但挑戰副本僅會消耗{s2}體力獲得1次獎勵，是否確認挑戰？"
  },
  TipsType_20036_RightBtnDesc = {Text = "確認"},
  TipsType_20036_Title = {
    Text = "挑戰確認"
  },
  TipsType_20037_Desc = {
    Text = "強化素材中包含高級素材，是否確定強化？"
  },
  TipsType_20037_RightBtnDesc = {Text = "確認"},
  TipsType_20037_Title = {
    Text = "強化確認"
  },
  TipsType_20038_Desc = {
    Text = "這件裝備正處於鎖定狀態，是否解除鎖定？"
  },
  TipsType_20038_RightBtnDesc = {Text = "確認"},
  TipsType_20039_Desc = {
    Text = "確認後本次調查將會失敗，無法獲得後續調查獎勵，是否確認結束調查？"
  },
  TipsType_20039_RightBtnDesc = {Text = "確認"},
  TipsType_20039_Title = {
    Text = "退出調查"
  },
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:主動退出調查將消耗「靈啡肽」× {s1}。>確認後本次調查將會失敗、無法獲得後續調查獎勵、是否確認結束調查？"
  },
  TipsType_20040_RightBtnDesc = {Text = "確認"},
  TipsType_20040_Title = {
    Text = "退出調查"
  },
  TipsType_20041_BottomDesc = {
    Text = "當前擁有時間壓縮許可：{s1}"
  },
  TipsType_20041_Desc = {
    Text = "是否消耗{s1}個時間壓縮許可加速？"
  },
  TipsType_20041_RightBtnDesc = {Text = "確認"},
  TipsType_20041_Title = {
    Text = "加速確認"
  },
  TipsType_20042_Desc = {
    Text = "RPG戰鬥調整中，當前直接結算勝利"
  },
  TipsType_20042_RightBtnDesc = {Text = "確認"},
  TipsType_20043_Desc = {
    Text = "是否花費 {s1} 銀芯，刷新當前任務？"
  },
  TipsType_20043_RightBtnDesc = {Text = "確認"},
  TipsType_20043_Title = {
    Text = "任務刷新"
  },
  TipsType_20044_BottomDesc = {
    Text = "消耗：{s1}研究許可"
  },
  TipsType_20044_Desc = {
    Text = "是否進行{s1}的研究？\n研究效果： {s2}"
  },
  TipsType_20044_RightBtnDesc = {Text = "確認"},
  TipsType_20044_Title = {
    Text = "研究確認"
  },
  TipsType_20045_BottomDesc = {
    Text = "取消研究不保留已研究進度"
  },
  TipsType_20045_Desc = {
    Text = "是否取消{s1}的研究？(將返還全額研究許可)"
  },
  TipsType_20045_RightBtnDesc = {Text = "確認"},
  TipsType_20046_Desc = {
    Text = "是否消耗 {s1} 「銀芯」加速？"
  },
  TipsType_20046_RightBtnDesc = {Text = "確認"},
  TipsType_20046_Title = {
    Text = "加速確認"
  },
  TipsType_20047_Desc = {
    Text = "缺少 {s1} 個<Blue:「{s2}」>、是否消耗<Blue:「銀芯」×{s3}>購買？"
  },
  TipsType_20047_RightBtnDesc = {Text = "確認"},
  TipsType_20047_Title = {
    Text = "購買確認"
  },
  TipsType_20048_Desc = {
    Text = "缺少 {s1} 個<Blue:「{s2}」>、是否消耗<Blue:「銀芯」×{s3}>購買？"
  },
  TipsType_20048_RightBtnDesc = {Text = "確認"},
  TipsType_20048_Title = {
    Text = "購買確認"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:「{s1}」> 已被 <Blue:「{s2}」> 所裝備、是否確認更換？"
  },
  TipsType_20049_RightBtnDesc = {Text = "確認"},
  TipsType_20049_Title = {
    Text = "更換提示"
  },
  TipsType_20050_Desc = {
    Text = "消耗命輪已經過疊位，是否確認？"
  },
  TipsType_20050_RightBtnDesc = {Text = "確認"},
  TipsType_20050_Title = {
    Text = "疊位提示"
  },
  TipsType_20051_Desc = {
    Text = "當前疊位將超過命輪的疊位等級上限，疊位後將根據溢出等級返還相應數量的命輪，是否確認？"
  },
  TipsType_20051_RightBtnDesc = {Text = "確認"},
  TipsType_20051_Title = {
    Text = "疊位提示"
  },
  TipsType_20052_Desc = {
    Text = "推薦等級為{s1}，當前隊伍平均等級為{s2}，調查將遇到較大阻礙，是否繼續進行？"
  },
  TipsType_20052_RightBtnDesc = {Text = "確認"},
  TipsType_20052_Title = {
    Text = "戰力不足"
  },
  TipsType_20053_Desc = {
    Text = "推薦等級為{s1}，當前隊伍平均等級為{s2}，調查將遇到極大阻礙，是否繼續進行？"
  },
  TipsType_20053_RightBtnDesc = {Text = "確認"},
  TipsType_20053_Title = {
    Text = "戰力不足"
  },
  TipsType_20054_Desc = {
    Text = "當前挑戰獎勵已全部領取，繼續挑戰將不會獲得獎勵，是否確認？"
  },
  TipsType_20054_RightBtnDesc = {Text = "確認"},
  TipsType_20054_Title = {
    Text = "挑戰確認"
  },
  TipsType_20055_Desc = {
    Text = "重置後，當前關卡進度將會重置為0顆星，喚醒體出戰記錄同步清除，是否確認重置？"
  },
  TipsType_20055_RightBtnDesc = {Text = "確認"},
  TipsType_20055_Title = {
    Text = "重置確認"
  },
  TipsType_20056_Desc = {
    Text = "挑戰成功後，當前編隊的四名喚醒體將無法出戰{s1}的其他關卡，是否確認挑戰？"
  },
  TipsType_20056_RightBtnDesc = {Text = "確認"},
  TipsType_20056_Title = {
    Text = "挑戰確認"
  },
  TipsType_20057_Desc = {
    Text = "隊伍構成違背學院手冊的推薦指示，是否仍要繼續挑戰？"
  },
  TipsType_20057_RightBtnDesc = {Text = "確認"},
  TipsType_20057_Title = {
    Text = "編隊確認"
  },
  TipsType_20058_Desc = {
    Text = "當前關卡已挑戰成功，若希望重新挑戰需先重置當前關卡進度為0顆星，喚醒體出戰記錄同步清除，是否確認重置？"
  },
  TipsType_20058_RightBtnDesc = {Text = "確認"},
  TipsType_20058_Title = {
    Text = "重置確認"
  },
  TipsType_20059_Desc = {
    Text = "當前隊伍喚醒體數量未滿四個，無法進入戰鬥"
  },
  TipsType_20059_Title = {
    Text = "編隊保存"
  },
  TipsType_20060_BottomDesc = {
    Text = "確認後將無法重新喚醒"
  },
  TipsType_20060_Desc = {
    Text = "是否選擇本次喚醒結果（將獲得本次喚醒的所有喚醒體和命輪）？"
  },
  TipsType_20060_RightBtnDesc = {Text = "確認"},
  TipsType_20060_Title = {
    Text = "確認選擇"
  },
  TipsType_20061_BottomDesc = {
    Text = "當前銀芯：{s1}"
  },
  TipsType_20061_Desc = {
    Text = "是否消耗  {s1} 「銀芯」重新喚醒？\n重新喚醒將不保留本次抽卡結果"
  },
  TipsType_20061_RightBtnDesc = {Text = "確認"},
  TipsType_20061_Title = {
    Text = "重新喚醒"
  },
  TipsType_20062_Desc = {
    Text = "確定要刪除所有的已讀信函嗎？\n附件未領取的信函並不會刪除"
  },
  TipsType_20062_RightBtnDesc = {Text = "確認"},
  TipsType_20062_Title = {
    Text = "刪除已讀"
  },
  TipsType_20063_Desc = {
    Text = "確認刪除？"
  },
  TipsType_20063_RightBtnDesc = {Text = "確認"},
  TipsType_20063_Title = {
    Text = "刪除當前信件"
  },
  TipsType_20064_Desc = {
    Text = "珍藏箱中的信函被刪除後，將無法恢復，\n是否刪除此信函？"
  },
  TipsType_20064_RightBtnDesc = {Text = "確認"},
  TipsType_20064_Title = {
    Text = "刪除珍藏信件"
  },
  TipsType_20065_Desc = {
    Text = "確認消耗 <Blue:{s1}> ，合成 <Blue:{s2}> 嗎？"
  },
  TipsType_20065_RightBtnDesc = {Text = "確認"},
  TipsType_20065_Title = {
    Text = "合成確認"
  },
  TipsType_20066_Desc = {
    Text = "確認分解<Blue:{s1}，獲得{s2}>嗎？"
  },
  TipsType_20066_RightBtnDesc = {Text = "確認"},
  TipsType_20066_Title = {
    Text = "分解確認"
  },
  TipsType_20067_Desc = {
    Text = "確認消耗 <Blue:{s1}> 個SSR品階密契，重印 <Blue:{s2}> 個 <Blue:{s3}> ？"
  },
  TipsType_20067_RightBtnDesc = {Text = "確認"},
  TipsType_20067_Title = {
    Text = "重印確認"
  },
  TipsType_20068_Desc = {
    Text = "所有喚醒體徹底失去戰鬥能力\n\n唯一的守密人啊\n接下來你該如何選擇？"
  },
  TipsType_20068_LeftBtnDesc = {
    Text = "重新戰鬥"
  },
  TipsType_20068_RightBtnDesc = {
    Text = "暫時撤退"
  },
  TipsType_20068_Title = {
    Text = "調查失敗"
  },
  TipsType_20069_Desc = {
    Text = "當前選中喚醒體狂氣已滿，是否確定仍然選擇該喚醒體"
  },
  TipsType_20069_RightBtnDesc = {Text = "確認"},
  TipsType_20069_Title = {
    Text = "確定選擇"
  },
  TipsType_20070_Desc = {
    Text = "是否確認使用{s1}？\n等級與技能已提升的喚醒體將不會返還升級物資"
  },
  TipsType_20070_RightBtnDesc = {Text = "確認"},
  TipsType_20070_Title = {
    Text = "增幅確認"
  },
  TipsType_20071_Desc = {
    Text = "受守密人調查等級限制，喚醒體等級將提升至{s1}級，缺少的升級物資不會返還，是否確認提升？"
  },
  TipsType_20071_RightBtnDesc = {Text = "確認"},
  TipsType_20071_Title = {
    Text = "增幅確認"
  },
  TipsType_20072_Desc = {
    Text = "確認跳過本小節全部劇情嗎？\n注：之後您可重新進入本關卡觀看劇情。"
  },
  TipsType_20072_RightBtnDesc = {Text = "確認"},
  TipsType_20072_Title = {
    Text = "跳過劇情"
  },
  TipsType_20073_Desc = {
    Text = "確認分解{s1}，獲得{s2}嗎？\n（當前密契已強化，分解不返還強化物資）"
  },
  TipsType_20073_RightBtnDesc = {Text = "確認"},
  TipsType_20073_Title = {
    Text = "分解確認"
  },
  TipsType_20074_Desc = {
    Text = "確認分解{s1}，獲得{s2}嗎？\n（當前命輪稀有度較高）"
  },
  TipsType_20074_RightBtnDesc = {Text = "確認"},
  TipsType_20074_Title = {
    Text = "分解確認"
  },
  TipsType_20075_BottomDesc = {
    Text = "消耗：{s1}研究許可"
  },
  TipsType_20075_Desc = {
    Text = "是否啟動{s1}研究？\n生產效率： {s2}薔薇金券/每6小時\n      ——>{s3}薔薇金券/每6小時"
  },
  TipsType_20075_RightBtnDesc = {Text = "確認"},
  TipsType_20075_Title = {
    Text = "研究確認"
  },
  TipsType_20076_BottomDesc = {
    Text = "消耗：{s1}研究許可"
  },
  TipsType_20076_Desc = {
    Text = "是否啟動{s1}的研究？\n生產效率： {s2}靈知製劑/每6小時\n      ——>{s3}靈知製劑/每6小時"
  },
  TipsType_20076_RightBtnDesc = {Text = "確認"},
  TipsType_20076_Title = {
    Text = "研究確認"
  },
  TipsType_20077_BottomDesc = {
    Text = "消耗：{s1}研究許可"
  },
  TipsType_20077_Desc = {
    Text = "是否啟動{s1}的研究？\n生產效率： {s2}密契回痕/每6小時\n      ——>{s3}密契回痕/每6小時"
  },
  TipsType_20077_RightBtnDesc = {Text = "確認"},
  TipsType_20077_Title = {
    Text = "研究確認"
  },
  TipsType_20078_Desc = {
    Text = "確認跳過本段全部劇情？\n注：之後您可重新進入本關卡觀看劇情。"
  },
  TipsType_20078_RightBtnDesc = {Text = "確認"},
  TipsType_20078_Title = {
    Text = "跳過劇情"
  },
  TipsType_20079_Desc = {
    Text = "銀鑰感知到致命危機，是否啟用應急靈知體？\n（復活將消耗1次應急靈知體，應急靈知體每日9點自動獲得1次，當前剩餘次數：{s1}/{s2}）"
  },
  TipsType_20079_RightBtnDesc = {Text = "確認"},
  TipsType_20079_Title = {
    Text = "復活確認"
  },
  TipsType_20080_Desc = {
    Text = "銀鑰感知到致命危機，是否啟用應急靈知體？\n（復活將消耗1次應急靈知體，應急靈知體每日9點自動獲得1次，當前剩餘次數：{s1}/{s2}）"
  },
  TipsType_20080_RightBtnDesc = {Text = "確認"},
  TipsType_20080_Title = {
    Text = "復活確認"
  },
  TipsType_20081_Desc = {
    Text = "遊戲初始化失敗。{s1}"
  },
  TipsType_20081_RightBtnDesc = {Text = "確認"},
  TipsType_20081_Title = {
    Text = "登錄錯誤提示"
  },
  TipsType_20082_Desc = {
    Text = "是否消耗<Blue:「銀芯」× {s1} >購買<Blue: {s2} >級"
  },
  TipsType_20082_RightBtnDesc = {Text = "確認"},
  TipsType_20082_Title = {
    Text = "提升等級"
  },
  TipsType_20083_Desc = {
    Text = "消耗的命輪{s1}，是否確認強化？"
  },
  TipsType_20083_RightBtnDesc = {Text = "確認"},
  TipsType_20083_Title = {
    Text = "消耗確認"
  },
  TipsType_20084_Desc = {
    Text = "隊伍平均等級低於關卡推薦等級，出場喚醒體的屬性將受到削弱，是否依然選擇調查？"
  },
  TipsType_20084_RightBtnDesc = {Text = "確認"},
  TipsType_20084_Title = {
    Text = "調查確認"
  },
  TipsType_20085_Desc = {
    Text = "確認退出遊戲"
  },
  TipsType_20085_RightBtnDesc = {Text = "確認"},
  TipsType_20085_Title = {
    Text = "退出遊戲"
  },
  TipsType_20086_Desc = {
    Text = "伺服器維護中"
  },
  TipsType_20086_RightBtnDesc = {Text = "確認"},
  TipsType_20086_Title = {
    Text = "斷線提示"
  },
  TipsType_20087_Desc = {
    Text = "是否確認消耗<TipsHighlightText:{s1} × {s2}>、開啟<TipsHighlightText:{s3}>？"
  },
  TipsType_20087_RightBtnDesc = {Text = "確認"},
  TipsType_20087_Title = {
    Text = "開啟確認"
  },
  TipsType_20088_Desc = {
    Text = "領取後「靈啡肽」將溢出、超出{s1}的部分無法獲得。\n是否繼續領取？"
  },
  TipsType_20088_RightBtnDesc = {Text = "確認"},
  TipsType_20088_Title = {
    Text = "靈啡肽溢出"
  },
  TipsType_20089_Desc = {
    Text = "消耗「薔薇金券」×<Blue: {s1} >刷新庫存 \n 剩餘刷新次數：<Blue:{s2}> \n 刷新次數越多、所需「薔薇金券」數量越多"
  },
  TipsType_20089_RightBtnDesc = {Text = "確認"},
  TipsType_20089_Title = {
    Text = "刷新庫存"
  },
  TipsType_20090_Desc = {
    Text = "命輪數量已達上限，需要清理命輪後才能進行喚醒，是否前往？\n\n<color=#ADC0CB>*可在「設置」中設定SR/R級命輪自動分解</color>"
  },
  TipsType_20091_Desc = {
    Text = "密契數量已達上限，需要清理密契後才能進行調查，是否前往？"
  },
  TipsType_20092_Desc = {
    Text = "是否確認卸下當前喚醒體裝備的所有命輪？"
  },
  TipsType_20092_RightBtnDesc = {Text = "確認"},
  TipsType_20092_Title = {
    Text = "卸下確認"
  },
  TipsType_20093_Desc = {
    Text = "消耗密契已進行升級，是否確認？"
  },
  TipsType_20093_RightBtnDesc = {Text = "確認"},
  TipsType_20093_Title = {
    Text = "升級確認"
  },
  TipsType_20094_Desc = {
    Text = "原副屬性中存在較好的屬性，替換後將不會保存，是否確認替換？"
  },
  TipsType_20094_RightBtnDesc = {Text = "確認"},
  TipsType_20094_Title = {
    Text = "替換確認"
  },
  TipsType_20095_Desc = {
    Text = "當前轉錄出的副屬性中存在較好的屬性，繼續轉錄將不會保存，是否確認？"
  },
  TipsType_20095_RightBtnDesc = {Text = "確認"},
  TipsType_20095_Title = {
    Text = "轉錄確認"
  },
  TipsType_20096_Desc = {
    Text = "密契升級後將會溢出等級上限，溢出後將返還轉錄材料，是否確認？"
  },
  TipsType_20096_RightBtnDesc = {Text = "確認"},
  TipsType_20096_Title = {
    Text = "升級確認"
  },
  TipsType_20097_Desc = {
    Text = "該喚醒體啟靈已滿\n選擇後將僅獲得「靈魂回溯碎片」×1"
  },
  TipsType_20097_RightBtnDesc = {Text = "繼續"},
  TipsType_20097_Title = {
    Text = "確認選擇"
  },
  TipsType_20098_Desc = {
    Text = "該商品可使用<Blue:{s1}>張密銀交易憑證購買"
  },
  TipsType_20098_LeftBtnDesc = {
    Text = "現金支付"
  },
  TipsType_20098_RightBtnDesc = {
    Text = "憑證支付"
  },
  TipsType_20098_Title = {
    Text = "結算方式選擇"
  },
  TipsType_20099_Desc = {
    Text = "是否退出遊戲？"
  },
  TipsType_20099_RightBtnDesc = {Text = "確認"},
  TipsType_20100_Desc = {
    Text = "檢測到新的遊戲版本，請重新啟動遊戲進行資源更新"
  },
  TipsType_20100_RightBtnDesc = {Text = "確認"},
  TipsType_20101_Desc = {
    Text = "該調查已完成，重新調查是否選擇跳過劇情？"
  },
  TipsType_20101_LeftBtnDesc = {
    Text = "跳過劇情"
  },
  TipsType_20101_RightBtnDesc = {
    Text = "保留劇情"
  },
  TipsType_20101_Title = {
    Text = "劇情確認"
  },
  TipsType_20102_Desc = {
    Text = "確定不再關注{s1}？"
  },
  TipsType_20102_RightBtnDesc = {Text = "確認"},
  TipsType_20102_Title = {
    Text = "取消關注"
  },
  TipsType_20103_Desc = {
    Text = "活動期間<WeaponEffect_Num:限時免費>解鎖，是否解鎖？"
  },
  TipsType_20103_RightBtnDesc = {Text = "確認"},
  TipsType_20103_Title = {
    Text = "活動福利"
  },
  TipsType_20105_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20105_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20105_Title = {
    Text = "調查確認"
  },
  TipsType_20106_Desc = {
    Text = "是否消耗<Blue:「源液」×  {s1} >購買？"
  },
  TipsType_20106_RightBtnDesc = {Text = "購買"},
  TipsType_20106_Title = {
    Text = "購買確認"
  },
  TipsType_20107_Desc = {
    Text = "確定要選擇 <Blue:{s1}> 嗎？"
  },
  TipsType_20107_RightBtnDesc = {Text = "確認"},
  TipsType_20107_Title = {
    Text = "選擇確認"
  },
  TipsType_20108_Desc = {
    Text = "本次疊位將消耗稀有物品「循環母版」\n是否繼續？"
  },
  TipsType_20108_RightBtnDesc = {Text = "確認"},
  TipsType_20108_Title = {
    Text = "消耗確認"
  },
  TipsType_20109_Desc = {
    Text = "確定要重新開始本次戰鬥嗎？"
  },
  TipsType_20109_RightBtnDesc = {Text = "確認"},
  TipsType_20109_Title = {
    Text = "重新戰鬥"
  },
  TipsType_20110_Desc = {
    Text = "確認選擇{s1}月{s2}日作為你的生日嗎?\n確認後將無法修改。"
  },
  TipsType_20110_RightBtnDesc = {Text = "確認"},
  TipsType_20110_Title = {
    Text = "生日確認"
  },
  TipsType_20111_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20111_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20111_Title = {
    Text = "調查確認"
  },
  TipsType_20112_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20112_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20112_Title = {
    Text = "調查確認"
  },
  TipsType_20113_Desc = {
    Text = "是否將所有已獲得的教學內容標記為已閱讀，並領取教學獎勵？（建議新入學的守密人仔細閱讀教學內容~）"
  },
  TipsType_20113_RightBtnDesc = {Text = "確認"},
  TipsType_20113_Title = {
    Text = "一鍵閱讀確認"
  },
  TipsType_20114_Desc = {
    Text = "確認選擇<WeaponEffect_Num:{s1}>開啟回溯嗎？\n此操作不可回退，請謹慎確認"
  },
  TipsType_20114_RightBtnDesc = {Text = "確認"},
  TipsType_20114_Title = {
    Text = "回溯選擇"
  },
  TipsType_201151_Desc = {
    Text = "當前喚醒體沒有啟靈，無需進行啟靈回溯"
  },
  TipsType_20115_Desc = {
    Text = "當前喚醒體未經過任何養成，無需進行養成回溯"
  },
  TipsType_20116_Desc = {
    Text = "<WeaponEffect_Num:{s1}>已開啟回溯。\n是否立即前往進行回溯？"
  },
  TipsType_20116_Title = {
    Text = "開啟成功"
  },
  TipsType_20117_Desc = {
    Text = "即將重置喚醒體的升級、升格、技能、天賦和靈知深化狀態，並返還相應消耗。\n確認對<WeaponEffect_Num:{s1}>進行養成回溯嗎？"
  },
  TipsType_20117_RightBtnDesc = {Text = "確認"},
  TipsType_20117_Title = {
    Text = "養成回溯"
  },
  TipsType_20118_Desc = {
    Text = "即將重置喚醒體的啟靈等級，並返還啟靈消耗。\n確認對<WeaponEffect_Num:{s1}>進行啟靈回溯嗎？"
  },
  TipsType_20118_RightBtnDesc = {Text = "確認"},
  TipsType_20118_Title = {
    Text = "啟靈回溯"
  },
  TipsType_20119_Desc = {
    Text = "即將重置喚醒體的升級、升格、技能、啟靈、天賦和靈知深化狀態，返還相應消耗，\n並將喚醒體歸還至黑池。\n確認對<WeaponEffect_Num:{s1}>進行黑池歸還嗎？"
  },
  TipsType_20119_RightBtnDesc = {Text = "確認"},
  TipsType_20119_Title = {
    Text = "黑池歸還"
  },
  TipsType_20120_Desc = {
    Text = "特殊喚醒體不可進行歸還"
  },
  TipsType_20121_Desc = {
    Text = "即將重置命輪的疊位狀態，並返還所有疊位消耗。\n確認對<WeaponEffect_Num:{s1}>進行疊位回溯嗎？"
  },
  TipsType_20121_RightBtnDesc = {Text = "確認"},
  TipsType_20121_Title = {
    Text = "疊位回溯"
  },
  TipsType_20122_Desc = {
    Text = "即將重置命輪的疊位狀態，返還所有疊位消耗，並將命輪歸還至黑池。\n確認對<WeaponEffect_Num:{s1}>進行黑池歸還嗎？"
  },
  TipsType_20122_RightBtnDesc = {Text = "確認"},
  TipsType_20122_Title = {
    Text = "黑池歸還"
  },
  TipsType_20123_Desc = {
    Text = "完成挑戰後，隊伍中的喚醒體、命輪和鑰令將無法在其他融災禁區中上場，是否確認？"
  },
  TipsType_20123_RightBtnDesc = {Text = "確認"},
  TipsType_20123_Title = {
    Text = "挑戰確認"
  },
  TipsType_20124_Desc = {
    Text = "重置後，當前調查隊伍的喚醒體、命輪和鑰令都可以重新上場，但通過該關卡獲得的特訓值也會扣除（不影響獎勵狀態），是否確認重置？"
  },
  TipsType_20124_RightBtnDesc = {Text = "確認"},
  TipsType_20124_Title = {
    Text = "重置確認"
  },
  TipsType_20125_Desc = {
    Text = "當前命輪疊位等級為0，不需要疊位回溯"
  },
  TipsType_20126_Desc = {
    Text = "當前喚醒體正在派遣中，請召回後再進行回溯或歸還"
  },
  TipsType_20127_Desc = {
    Text = "當前命輪已鎖定，歸還前請先解除鎖定"
  },
  TipsType_20128_Desc = {
    Text = "{s1}已通關，需要進行重置才可以進行挑戰，是否確認重置？\n（重置後，調查隊伍中的喚醒體、命輪和鑰令可重新上場，但通過該關卡獲得的特訓值也會扣除。）"
  },
  TipsType_20128_RightBtnDesc = {Text = "確認"},
  TipsType_20128_Title = {
    Text = "重置確認"
  },
  TipsType_20129_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20129_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20129_Title = {
    Text = "調查確認"
  },
  TipsType_20130_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20130_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20130_Title = {
    Text = "調查確認"
  },
  TipsType_20131_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20131_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20131_Title = {
    Text = "調查確認"
  },
  TipsType_20132_Desc = {
    Text = "勾選後，若<TipsHighlightText:密契殘本>充足，則優先消耗殘本。\n若殘本不足，則自動消耗 <TipsHighlightText:「{s1}」> 補足殘本。"
  },
  TipsType_20132_RightBtnDesc = {
    Text = "仍要勾選"
  },
  TipsType_20132_Title = {
    Text = "自動補足"
  },
  TipsType_20133_Desc = {
    Text = "是否對 <TipsHighlightText:「{s1}」> 進行靈知深化？"
  },
  TipsType_20133_RightBtnDesc = {Text = "確認"},
  TipsType_20133_Title = {
    Text = "靈知深化"
  },
  TipsType_20134_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20134_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20134_Title = {
    Text = "調查確認"
  },
  TipsType_20137_Desc = {
    Text = "確認消耗<Blue:「{s1}」×{s2}>解鎖該曲目嗎？"
  },
  TipsType_20137_RightBtnDesc = {Text = "確認"},
  TipsType_20137_Title = {
    Text = "解鎖確認"
  },
  TipsType_20138_Desc = {
    Text = "活動期間內 <Blue:限時免費>解鎖，是否解鎖？"
  },
  TipsType_20138_RightBtnDesc = {Text = "確認"},
  TipsType_20138_Title = {
    Text = "解鎖確認"
  },
  TipsType_20139_Desc = {
    Text = "確認消耗<Blue:「{s1}」×{s3}>、開啟<Blue:「{s2}」>嗎？"
  },
  TipsType_20139_RightBtnDesc = {Text = "確認"},
  TipsType_20139_Title = {
    Text = "解鎖確認"
  },
  TipsType_20140_Desc = {
    Text = "<Blue:「{s1}」>當前已達持有上限，繼續領取將無法獲得該道具。是否領取？"
  },
  TipsType_20140_RightBtnDesc = {Text = "確認"},
  TipsType_20140_Title = {
    Text = "領取確認"
  },
  TipsType_20141_Desc = {
    Text = "是否以 30%的最大生命({s1})為代價\n跳過戰鬥，立即消滅敵人？\n\n當前生命：{s2}"
  },
  TipsType_20141_RightBtnDesc = {Text = "確認"},
  TipsType_20141_Title = {
    Text = "肌肉記憶"
  },
  TipsType_20142_Desc = {
    Text = "是否選擇失去 <color=#BB646D> {s1} </color> 點生命，獲得 {s2} 枚黑印？"
  },
  TipsType_20142_RightBtnDesc = {Text = "確認"},
  TipsType_20142_Title = {
    Text = "調查確認"
  },
  TipsType_20145_Title = {
    Text = "登入獎勵"
  },
  TipsType_20151_Desc = {
    Text = "重置後，「特殊物品」的剩餘數量將重置至上限，是否確認？"
  },
  TipsType_20151_RightBtnDesc = {Text = "確認"},
  TipsType_20151_Title = {
    Text = "重置確認"
  },
  TipsType_20152_Desc = {
    Text = "「{s1}」不足、是否使用「薔薇金券」× {s2}補齊？"
  },
  TipsType_20152_RightBtnDesc = {Text = "確認"},
  TipsType_20152_Title = {
    Text = "啟動確認"
  },
  TipsType_20153_Desc = {
    Text = "重置後，「特殊物品」和「普通物品」的剩餘數量會重置至上限。\n第{s1}次及之後，「特殊物品」將不會再重置。\n是否確認？"
  },
  TipsType_20153_RightBtnDesc = {Text = "確認"},
  TipsType_20153_Title = {
    Text = "重置確認"
  },
  TipsType_20154_Desc = {
    Text = "重置後，「特殊物品」和「普通物品」的剩餘數量會重置至上限。\n第3次及之後，「特殊物品」將不會再重置。\n <Blue:當前仍有「普通物品」>，是否確認？"
  },
  TipsType_20154_RightBtnDesc = {Text = "確認"},
  TipsType_20154_Title = {
    Text = "重置確認"
  },
  TipsType_20155_Desc = {
    Text = "疊位材料中包含已上鎖的命輪，是否確認消耗用於疊位？"
  },
  TipsType_20155_RightBtnDesc = {Text = "確認"},
  TipsType_20155_Title = {
    Text = "疊位確認"
  },
  TipsType_20156_Desc = {
    Text = "是否確認消耗<TipsHighlightText:「現實起點」× 1>解鎖？\n（慾海翻波活動期間、解鎖所需的「現實起點」從{s1}個降低為{s2}個。）"
  },
  TipsType_20156_RightBtnDesc = {Text = "確認"},
  TipsType_20156_Title = {
    Text = "解鎖確認"
  },
  TipsType_20157_Desc = {
    Text = "是否確認消耗<TipsHighlightText:「現實起點」× {s1}>解鎖？"
  },
  TipsType_20157_RightBtnDesc = {Text = "確認"},
  TipsType_20157_Title = {
    Text = "解鎖確認"
  },
  TipsType_20158_Desc = {
    Text = "當前關卡已過期，完成挑戰後將不會獲得獎勵，是否確認退出？"
  },
  TipsType_20158_RightBtnDesc = {Text = "確認"},
  TipsType_20158_Title = {
    Text = "退出確認"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:「{s1}」>超出上限<TipsHighlightText: {s2}>個、每個已轉換為<Blue:「無形者的請柬」× 1>"
  },
  TipsType_20159_Title = {
    Text = "轉換提示"
  },
  TipsType_20160_Desc = {
    Text = "你已解鎖<TipsHighlightText:「{s1}」>\n本次活動的免費解鎖福利將為你提供以下補償。"
  },
  TipsType_20160_RightBtnDesc = {Text = "確認"},
  TipsType_20160_Title = {
    Text = "補償提示"
  },
  TipsType_20161_Desc = {
    Text = "<TipsHighlightText:「{s1}」>超出上限<TipsHighlightText: {s2}>個、每個已轉換為<Blue:「薔薇金券」× 5000>"
  },
  TipsType_20161_Title = {
    Text = "轉換提示"
  },
  TipsType_20162_Desc = {
    Text = "即將重置喚醒體的升級、升格、技能、天賦和靈知深化狀態，並返還相應消耗。\n確認對<WeaponEffect_Num:{s1}>進行養成回溯嗎？"
  },
  TipsType_20162_RightBtnDesc = {Text = "確認"},
  TipsType_20162_Title = {
    Text = "養成回溯"
  },
  TipsType_20163_Desc = {
    Text = "即將重置喚醒體的啟靈狀態，並返還相應消耗。\n確認對<WeaponEffect_Num:{s1}>進行養成回溯嗎？"
  },
  TipsType_20163_RightBtnDesc = {Text = "確認"},
  TipsType_20163_Title = {
    Text = "啟靈回溯"
  },
  TipsType_20164_Desc = {
    Text = "即將重置喚醒體的升級、升格、技能、天賦、啟靈和靈知深化狀態，返還相應消耗，\n並將喚醒體歸還至黑池。\n確認對<WeaponEffect_Num:{s1}>進行黑池歸還嗎？"
  },
  TipsType_20164_RightBtnDesc = {Text = "確認"},
  TipsType_20164_Title = {
    Text = "黑池歸還"
  },
  TipsType_20165_Desc = {
    Text = "<WeaponEffect_Num:{s1}>屬於特殊喚醒體，僅能回溯升級、升格、技能、天賦和靈知深化養成，<Red:無法回溯啟靈養成>，確認選擇<WeaponEffect_Num:{s1}>開啟回溯嗎？\n此操作不可回退，請謹慎確認"
  },
  TipsType_20165_RightBtnDesc = {Text = "確認"},
  TipsType_20165_Title = {
    Text = "回溯選擇"
  },
  TipsType_20166_Desc = {
    Text = "特殊喚醒體不可進行啟靈回溯"
  },
  TipsType_20167_Desc = {
    Text = "本次回溯已使用過「養成回溯」，請下次回溯開啟時進行「養成回溯」。"
  },
  TipsType_20168_Desc = {
    Text = "本次回溯已使用過「啟靈回溯」，請下次回溯開啟時進行「啟靈回溯」。"
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue:注意：一旦選定，本次活動無法再更改！>"
  },
  TipsType_20169_Desc = {
    Text = "是否確認選擇喚醒體<OrangeQuality:「{s1}」>以及推薦命輪<OrangeQuality:「{s2}」>，作為本期活動的定向UP。"
  },
  TipsType_20169_RightBtnDesc = {Text = "確認"},
  TipsType_20169_Title = {
    Text = "確認選擇"
  },
  TipsType_20170_Desc = {
    Text = "已達到每日挑戰上限，請明天再來挑戰吧！"
  },
  TipsType_20171_Desc = {
    Text = "現在可以前往「幻夢深潛」了！"
  },
  TipsType_20173_Desc = {
    Text = "現在可以前往「相位對弈」了！"
  },
  TipsType_20174_Desc = {
    Text = "現在可以前往「調查行動·困難」了！"
  },
  TipsType_20175_Desc = {
    Text = "現在可以前往「超驗存在」了！"
  },
  TipsType_20176_Desc = {
    Text = "現在可以前往「融災禁區」了！"
  },
  TipsType_20177_Desc = {
    Text = "現在可以前往「繁衍狂歡」了！"
  },
  TipsType_20178_Desc = {
    Text = "現在可以前往裝備「第二命輪」了！"
  },
  TipsType_20179_Desc = {
    Text = "現在可以前往「混沌集群」了！"
  },
  TipsType_20180_Desc = {
    Text = "現在可以前往「禁忌纂錄」了！"
  },
  TipsType_20181_Desc = {
    Text = "現在可以前往「密契升級」了！"
  },
  TipsType_20182_Desc = {
    Text = "現在可以前往「密契轉錄」了！"
  },
  TipsType_20183_Desc = {
    Text = "當前活動已結束"
  },
  TipsType_20184_Desc = {
    Text = "現在可以前往「學籍檔案」了！"
  },
  TipsType_20185_Desc = {
    Text = "確認跳過本段全部劇情？"
  },
  TipsType_20185_RightBtnDesc = {Text = "確認"},
  TipsType_20185_Title = {
    Text = "跳過劇情"
  },
  TipsType_20186_Desc = {
    Text = "將下載運行遊戲的必要資料。\n是否繼續？\n\n*建議在WiFi環境下進行下載。"
  },
  TipsType_20186_RightBtnDesc = {Text = "確認"},
  TipsType_20187_Desc = {
    Text = "資源下載完成"
  },
  TipsType_20187_LeftBtnDesc = {Text = "確認"},
  TipsType_20188_Desc = {
    Text = "存儲空間不足，需要預留至少{s1}存儲空間，否則運行時可能導致資源丟失，是否繼續下載新？"
  },
  TipsType_20188_RightBtnDesc = {Text = "確認"},
  TipsType_20189_Desc = {
    Text = "資源下載失敗，是否重試？"
  },
  TipsType_20189_RightBtnDesc = {Text = "確認"},
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}>超出上限<TipsHighlightText: {s2}>個，每個已轉換為<Blue:{s3}>"
  },
  TipsType_20190_Title = {
    Text = "轉換提示"
  },
  TipsType_20191_Desc = {
    Text = "現在可以前往「活動」了！"
  },
  TipsType_20192_Desc = {
    Text = "將下載遊玩序章後續內容的必要資料。\n資源大小：{s1}\n是否繼續？\n\n*建議在WiFi環境下進行下載。"
  },
  TipsType_20192_RightBtnDesc = {Text = "下載"},
  TipsType_20193_Desc = {
    Text = "現在可以前往「派遣」了！"
  },
  TipsType_20194_Desc = {
    Text = "現在可以前往「銀芯通信」了！"
  },
  TipsType_20195_Desc = {
    Text = "現在可以前往「學期課題」了！"
  },
  TipsType_20196_Desc = {
    Text = "現在可以前往「無光之境」了！"
  },
  TipsType_20197_Desc = {
    Text = "已達最大可喚醒次數，請前往領取任務獎勵！"
  },
  TipsType_20198_Desc = {
    Text = "還未完成任務，請完成任務後再來領取！"
  },
  TipsType_20199_Desc = {
    Text = "領取後「代理憑證」將超出擁有上限、\n超出部分將不會獲得。\n是否繼續領取？"
  },
  TipsType_20199_RightBtnDesc = {Text = "確認"},
  TipsType_20199_Title = {
    Text = "領取確認"
  },
  TipsType_20200_Desc = {
    Text = "申請試訓代理將消耗 <Blue:「代理憑證」× 1>\n申請後將直接完成每日試訓、是否確認？"
  },
  TipsType_20200_RightBtnDesc = {Text = "確認"},
  TipsType_20200_Title = {
    Text = "代理確認"
  },
  TipsType_20201_Desc = {
    Text = "以下密契正在裝備中，是否進行替換？"
  },
  TipsType_20201_RightBtnDesc = {Text = "確認"},
  TipsType_20201_Title = {
    Text = "替換確認"
  },
  TipsType_20202_Desc = {
    Text = "當前方案應用於{s1}，是否確認刪除方案【{s2}】？"
  },
  TipsType_20202_RightBtnDesc = {Text = "確認"},
  TipsType_20202_Title = {
    Text = "刪除確認"
  },
  TipsType_20203_Desc = {
    Text = "隊伍中相同的命輪效果無法重複生效，{s1}已在當前隊伍裝備，是否確認裝備？"
  },
  TipsType_20203_RightBtnDesc = {Text = "確認"},
  TipsType_20203_Title = {
    Text = "裝備確認"
  },
  TipsType_20204_Desc = {
    Text = "當前密契已在{s1}中使用，分解後將會從該方案中移除，是否確認？"
  },
  TipsType_20204_RightBtnDesc = {Text = "確認"},
  TipsType_20204_Title = {
    Text = "刪除確認"
  },
  TipsType_20205_Desc = {
    Text = "當前密契已在編隊{s1}中使用，分解後將會卸下該密契，是否確認？"
  },
  TipsType_20205_RightBtnDesc = {Text = "確認"},
  TipsType_20205_Title = {
    Text = "刪除確認"
  },
  TipsType_20206_Desc = {
    Text = "當前命輪已在編隊{s1}中使用，分解後將會在編隊中卸下該命輪，是否確認？"
  },
  TipsType_20206_RightBtnDesc = {Text = "確認"},
  TipsType_20206_Title = {
    Text = "刪除確認"
  },
  TipsType_20207_Desc = {
    Text = "當前方案尚未保存，退出後將清空本次編輯，是否確認退出？"
  },
  TipsType_20207_RightBtnDesc = {Text = "確認"},
  TipsType_20207_Title = {
    Text = "保存確認"
  },
  TipsType_20208_Desc = {
    Text = "任務獎勵已領取，去看看其它任務吧！"
  },
  TipsType_20209_Desc = {
    Text = "任務已過期"
  },
  TipsType_20210_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20210_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20210_Title = {
    Text = "調查確認"
  },
  TipsType_20211_Desc = {
    Text = "{s1}天{s2}小時後開啟"
  },
  TipsType_20212_Desc = {
    Text = "{s1}小時{s2}分後開啟"
  },
  TipsType_20213_Desc = {
    Text = "<WeaponEffect_Num:{s1}>已在編隊中觸發超限因果，任意回溯將會導致超限因果失效，並且將會從編隊中自動卸下，確認選擇<WeaponEffect_Num:{s1}>開啟回溯嗎？\n此操作不可回退，請謹慎確認"
  },
  TipsType_20213_RightBtnDesc = {Text = "確認"},
  TipsType_20213_Title = {
    Text = "回溯選擇"
  },
  TipsType_20214_Desc = {
    Text = "即將重置命輪的疊位狀態，並返還所有疊位消耗。\n<WeaponEffect_Num:{s1}>已在編隊中觸發超限因果，回溯後將會從編隊中自動卸下。\n確認對<WeaponEffect_Num:{s1}>進行疊位回溯嗎？"
  },
  TipsType_20214_RightBtnDesc = {Text = "確認"},
  TipsType_20214_Title = {
    Text = "疊位回溯"
  },
  TipsType_20215_Desc = {
    Text = "即將重置命輪的疊位狀態，返還所有疊位消耗，並將命輪歸還至黑池。\n<WeaponEffect_Num:{s1}>已在編隊中觸發超限因果，歸還後將會從編隊中自動卸下。\n確認對<WeaponEffect_Num:{s1}>進行黑池歸還嗎？"
  },
  TipsType_20215_RightBtnDesc = {Text = "確認"},
  TipsType_20215_Title = {
    Text = "黑池歸還"
  },
  TipsType_20216_Desc = {
    Text = "是否消耗 <Blue:「{s1}」× {s2} >購買？"
  },
  TipsType_20216_RightBtnDesc = {Text = "購買"},
  TipsType_20216_Title = {
    Text = "購買確認"
  },
  TipsType_20217_Desc = {
    Text = "{s1}將在{s2}後開啟。"
  },
  TipsType_20218_Desc = {
    Text = "本次調查的預選喚醒體不可下場，只可替換為對應喚醒體"
  },
  TipsType_20219_Desc = {
    Text = "已上陣相同喚醒體，不可重複選擇。"
  },
  TipsType_20220_Desc = {
    Text = "檢測到當前沒有使用WIFI，下載會消耗較多流量，是否確認下載？\n資源大小：{s1}\n是否繼續？"
  },
  TipsType_20220_RightBtnDesc = {Text = "下載"},
  TipsType_20221_Desc = {
    Text = "資源下載完成"
  },
  TipsType_20221_LeftBtnDesc = {Text = "確認"},
  TipsType_20222_Desc = {
    Text = "存儲空間不足，需要預留至少{s1}存儲空間，否則運行時可能導致資源丟失，是否繼續下載新？"
  },
  TipsType_20222_RightBtnDesc = {Text = "確認"},
  TipsType_20223_Desc = {
    Text = "資源下載失敗，是否重試？"
  },
  TipsType_20223_RightBtnDesc = {Text = "確認"},
  TipsType_20224_Desc = {
    Text = "將下載遊玩序章後續內容的必要資料。\n資源大小：{s1}\n是否繼續？\n\n*建議在WiFi環境下進行下載。"
  },
  TipsType_20224_RightBtnDesc = {Text = "下載"},
  TipsType_20225_Desc = {
    Text = "{s1}已通關，是否進行額外挑戰？\n額外挑戰可以獲得 {s2} 特訓值"
  },
  TipsType_20225_RightBtnDesc = {Text = "確認"},
  TipsType_20225_Title = {
    Text = "額外挑戰"
  },
  TipsType_20226_Desc = {
    Text = "重置後，額外挑戰隊伍的喚醒體、鑰令和命輪都可以重新上場，但該關卡額外通關獲得的特訓值也會扣除（不影響獎勵狀態），是否確認重置？"
  },
  TipsType_20226_RightBtnDesc = {Text = "確認"},
  TipsType_20226_Title = {
    Text = "重置確認"
  },
  TipsType_20227_Desc = {
    Text = "重置後，當前調查隊伍的喚醒體、鑰令和命輪都可以重新上場，並且額外挑戰隊伍將替代當前調查隊伍，但該關卡額外通關獲得的特訓值也會扣除（不影響獎勵狀態），是否確認重置？"
  },
  TipsType_20227_RightBtnDesc = {Text = "確認"},
  TipsType_20227_Title = {
    Text = "重置確認"
  },
  TipsType_20228_Desc = {
    Text = "向下滑動清單查看更多公告"
  },
  TipsType_20229_Desc = {
    Text = "「<Blue:{s1}>」已達到疊位等級上限\n是否繼續購買？\n剩餘數量：{s2}"
  },
  TipsType_20229_RightBtnDesc = {Text = "確認"},
  TipsType_20229_Title = {
    Text = "購買確認"
  },
  TipsType_20230_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20230_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20230_Title = {
    Text = "調查確認"
  },
  TipsType_20231_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20231_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20231_Title = {
    Text = "調查確認"
  },
  TipsType_20232_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20232_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20232_Title = {
    Text = "調查確認"
  },
  TipsType_20233_Desc = {
    Text = "當前所需材料不足，是否消耗以下材料進行補全？"
  },
  TipsType_20233_RightBtnDesc = {Text = "確認"},
  TipsType_20233_Title = {
    Text = "補全確認"
  },
  TipsType_20234_Desc = {
    Text = "該關卡只能裝備指定鑰令，無法進行替換。"
  },
  TipsType_20235_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20235_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20235_Title = {
    Text = "調查確認"
  },
  TipsType_20236_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20236_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20236_Title = {
    Text = "調查確認"
  },
  TipsType_20237_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20237_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20237_Title = {
    Text = "調查確認"
  },
  TipsType_20238_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20238_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20238_Title = {
    Text = "調查確認"
  },
  TipsType_20239_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20239_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20239_Title = {
    Text = "調查確認"
  },
  TipsType_20240_Desc = {
    Text = "修復完成，請重新啟動遊戲"
  },
  TipsType_20240_RightBtnDesc = {Text = "確認"},
  TipsType_20240_Title = {
    Text = "溫馨提示"
  },
  TipsType_20241_Desc = {
    Text = "還需{s1}個「<Blue:{s2}>」即可達到疊位等級上限\n是否繼續購買？"
  },
  TipsType_20241_RightBtnDesc = {Text = "確認"},
  TipsType_20241_Title = {
    Text = "購買確認"
  },
  TipsType_20250_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20250_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20250_Title = {
    Text = "調查確認"
  },
  TipsType_20251_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20251_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20251_Title = {
    Text = "調查確認"
  },
  TipsType_20252_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_20252_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_20252_Title = {
    Text = "調查確認"
  },
  TipsType_20259_Desc = {
    Text = "已保存「千面印章」不足時的置換設置"
  },
  TipsType_20300_Desc = {
    Text = "已有 {s1} 定位喚醒體，無法在同一個隊伍中使用同定位喚醒體。"
  },
  TipsType_20301_Desc = {
    Text = "現在可以前往「常訓任務」了！"
  },
  TipsType_20351_Desc = {
    Text = "{s1}不足，是否使用{s2}{s3}兌換{s4}{s5}"
  },
  TipsType_20351_RightBtnDesc = {Text = "確認"},
  TipsType_20352_Desc = {
    Text = "即將與對方綁定，綁定後無法解綁，確認要繼續綁定嗎？"
  },
  TipsType_20352_RightBtnDesc = {Text = "確認"},
  TipsType_20352_Title = {
    Text = "邀請確認"
  },
  TipsType_20353_Desc = {
    Text = "邀請碼已複製至剪切板。"
  },
  TipsType_20354_Desc = {
    Text = "您已是對方的邀請人。"
  },
  TipsType_20355_Desc = {
    Text = "不能輸入自己的邀請碼，嘗試去獲取其他守密人的邀請碼吧。"
  },
  TipsType_20356_Desc = {
    Text = "重新遊玩可再次體驗序章劇情與教學！\n但重新遊玩時關卡內容所有獎勵均為演示，無法真正獲取獎勵。\n是否確認？"
  },
  TipsType_20356_RightBtnDesc = {Text = "確認"},
  TipsType_20356_Title = {
    Text = "調查確認"
  },
  TipsType_20357_Desc = {
    Text = "確定不再關注這 {s1} 位守密人？"
  },
  TipsType_20357_RightBtnDesc = {Text = "確認"},
  TipsType_20357_Title = {
    Text = "取消關注"
  },
  TipsType_20358_Desc = {
    Text = "有未確認的取消關注，離開將不保存任何操作，是否離開？"
  },
  TipsType_20358_RightBtnDesc = {Text = "確認"},
  TipsType_20358_Title = {
    Text = "退出確認"
  },
  TipsType_20400_Desc = {
    Text = "<WeaponEffect_Num:「{s1}」>不足，是否前往兌換？"
  },
  TipsType_20400_RightBtnDesc = {Text = "確認"},
  TipsType_20400_Title = {
    Text = "抽獎道具不足"
  },
  TipsType_300001_Desc = {
    Text = "「銀輝初耀」只有一次免費喚醒的機會，確認要使用嗎？"
  },
  TipsType_300001_RightBtnDesc = {Text = "確認"},
  TipsType_300001_Title = {
    Text = "喚醒確認"
  },
  TipsType_300002_Desc = {
    Text = "確認選擇本次喚醒結果嗎？確認後本次喚醒將消耗免費5連抽次數"
  },
  TipsType_300002_RightBtnDesc = {Text = "確認"},
  TipsType_300002_Title = {
    Text = "喚醒確認"
  },
  TipsType_30001_Desc = {
    Text = "側邊提示無圖標"
  },
  TipsType_30003_Desc = {Text = "{s1}解鎖"},
  TipsType_30004_Desc = {
    Text = "{s1}進階模式解鎖"
  },
  TipsType_30005_Desc = {
    Text = "{s1}（困難）解鎖"
  },
  TipsType_31000_Desc = {
    Text = "確定要使用此出生年月認證嗎？出生年月一旦確定不可再更改！"
  },
  TipsType_31000_RightBtnDesc = {Text = "確認"},
  TipsType_31000_Title = {
    Text = "年齡認證"
  },
  TipsType_31001_Desc = {
    Text = "本月已儲值<Blue:{s1}>元，上限限制為<Blue:{s2}>元，請下個月再儲值或換更低金額的擋位儲值試試吧"
  },
  TipsType_31002_Desc = {
    Text = "請先完成年齡認證"
  },
  TipsType_31003_Desc = {
    Text = "銀鑰感知到致命危機，是否啟用應急靈知體？\n（復活將消耗1次應急靈知體，應急靈知體每日9點自動獲得1次，當前剩餘次數：{s1}）\n<Blue:（首次復活不消耗應急靈知體）>"
  },
  TipsType_31003_RightBtnDesc = {Text = "確認"},
  TipsType_31003_Title = {
    Text = "復活確認"
  },
  TipsType_31004_Desc = {
    Text = "銀鑰感知到致命危機，是否啟用應急靈知體？\n（復活將消耗1次應急靈知體，應急靈知體每日9點自動獲得1次，當前剩餘次數：{s1}）\n<Blue:（首次復活不消耗應急靈知體）>"
  },
  TipsType_31004_RightBtnDesc = {Text = "確認"},
  TipsType_31004_Title = {
    Text = "復活確認"
  },
  TipsType_40001_Desc = {
    Text = "當生命降至0時，調查會強制結束。"
  },
  TipsType_40002_Desc = {
    Text = "地圖移動、調查事件將會產生精神壓力，壓力累積會使守密人受到症狀。\n每移動一格，壓力提升10點。壓力每滿100點獲得1個症狀。\n當壓力達到500後，每移動一格，扣除10%生命。"
  },
  TipsType_40002_Title = {Text = "壓力"},
  TipsType_40003_Desc = {
    Text = "派遣等級越高，任務難度越高，派遣獲得的獎勵也相應提升。"
  },
  TipsType_40003_Title = {
    Text = "派遣等級"
  },
  TipsType_40004_Desc = {
    Text = "每回合打出的第 1 張指令卡的臨時複製會進入超維空間。\n當超維空間達到上限時，獲得 1 個額外的超維回合並保留護盾。\n界域精通效果：回合開始時有機率將 1 張「靈感」加入手中。"
  },
  TipsType_40004_Title = {
    Text = "超維空間"
  },
  TipsType_40005_Desc = {
    Text = "守密人可以通過調查、幕間演習等挑戰提升自身等級。更多的玩法會隨著守密人的等級提升而逐步解鎖。"
  },
  TipsType_40005_Title = {Text = "等級"},
  TipsType_40006_Desc = {
    Text = "打出指令卡需要消耗算力。回合結束時不會保留剩餘算力，回合開始時使算力恢復至上限。"
  },
  TipsType_40007_Desc = {
    Text = "銀鑰匙感知到一縷特殊能量，地圖中或許隱藏著珍貴的物資……"
  },
  TipsType_40007_Title = {
    Text = "隱藏物資"
  },
  TipsType_40008_Desc = {
    Text = "戰鬥中遇到致命危機時可以發動，每次發動消耗1枚，使守密人生命和喚醒體狂氣回復至上限，每天9點自動獲得1枚。"
  },
  TipsType_40008_Title = {
    Text = "應急靈知體"
  },
  TipsType_40009_Desc = {
    Text = "打出指令卡需要消耗算力。回合結束時不會保留剩餘算力，回合開始時算力上限 +1 並使算力恢復至上限。當前是第 {s1} 回合。"
  },
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "融災禁區已重置，正在進行中的挑戰將立即結束。"
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {Text = "確認"},
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = "銀鑰感知到致命危機，是否啟用應急靈知體？\n（復活將消耗 {s1} 個應急靈知體，應急靈知體每日 9 點自動獲得 1 個）"
  },
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {Text = "確認"},
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "復活確認"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "是否接受 <Blue:{s1}>的 <Blue:{s2}>邀請？"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {Text = "拒絕"},
  TipsType_AcceptConfirm_Title = {
    Text = "密碼對戰"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "完成對應任務即可進行喚醒"
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "已經是當前背景音樂"
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "「薔薇金券」不足以完整使用當前擁有的「靈知製劑」，可補充「薔薇金券」後再嘗試。"
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "喚醒體暫未到開放時間，敬請期待"
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "確認消耗 <Blue:{s1}>，獲得1個<Blue:隨機>喚醒體嗎？"
  },
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "使用確認"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "戰鬥創建失敗"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "當前守密紀行已全部完成。"
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "調查確認"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "調查確認"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "調查確認"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "調查確認"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "調查確認"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "調查確認"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "調查確認"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "調查確認"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "調查確認"
  },
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "是否消耗「薔薇金券」× {s1} 進行購買？"
  },
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "購買確認"
  },
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "常用助戰守密人已達上限，請調整常用助戰清單"
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "檔案寫入失敗，請檢查裝置剩餘儲存空間是否充足"
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {Text = "確認"},
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "存儲空間不足，是否繼續嘗試下載？"
  },
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {Text = "確認"},
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = "是否消耗<Blue:「源液」× {s1} >購買？\n <color=#ACBFCA>本期為特殊課題、核心課題的價格降低</color>"
  },
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "購買"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "購買確認"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "請輸入 <color=#5EF2FF>相位值</color>"
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "最多選擇 {s1} 名喚醒體進行篩選"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = "確定對當前頁的 <color=#5EF2FF>{s1}</color> 名追隨者進行關注？\n\n<color=#96947F>當前關注 </color>{s2}<color=#A0A0A0>/{s3}\n超出上限之後將無法關注</color>"
  },
  TipsType_FollowBackConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_FollowBackConfirm_Title = {
    Text = "回關確認"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = "此操作將消耗大量資源，適合想將喚醒體的能力培養到極限的情況，確認強化「瘋狂預兆」嗎？"
  },
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "強化確認"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = "此操作將消耗大量資源，適合想將喚醒體的能力培養到極限的情況，確認強化「內在靈格」嗎？"
  },
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "強化確認"
  },
  TipsType_InCharging_Desc = {
    Text = "訂單處理中、請勿重複支付。\n若支付已完成、請耐心等待系統發放獎勵。\n若支付未完成、請嘗試重啟遊戲後重試。\n如有疑問、請聯繫客服。"
  },
  TipsType_InCharging_RightBtnDesc = {Text = "確認"},
  TipsType_InCharging_Title = {
    Text = "溫馨提示"
  },
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "正在下載文本標識資源，請過一會再嘗試查看"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "該喚醒體啟靈已滿\n選擇後將僅獲得「靈魂回溯碎片」× 2"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {Text = "繼續"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "確認選擇"
  },
  TipsType_MainResetBG_Desc = {
    Text = "是否需要將宿舍的背景<Blue:「畫面」>與<Blue:「音樂」>恢復到默認？"
  },
  TipsType_MainResetBG_RightBtnDesc = {Text = "確認"},
  TipsType_MainResetBG_Title = {
    Text = "恢復默認"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "固定獲得物品，不可更改"
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "請完成所有自選物品選擇後，才可進行購買"
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "對方取消了匹配"
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "對方拒絕了<Blue:{s1}>的邀請，請重新選擇模式"
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = "戰鬥回合數已達上限\n\n唯一的守密人啊\n接下來你該如何選擇？"
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {
    Text = "重新戰鬥"
  },
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "暫時撤退"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "調查失敗"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "獲取戰鬥回放錯誤，請稍後重試"
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = "回放已達到25回合的最大限制，\n回放結束。"
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {Text = "確認"},
  TipsType_PVEReplayMaxRounds_Title = {
    Text = "結束確認"
  },
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "暫無調查行動記錄"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "正在加載戰鬥回放，請勿重複操作"
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "暫不支持特殊編隊的戰鬥回放，敬請期待"
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "獲取戰鬥回放超時"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "戰鬥回放中不可進行操作"
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {
    Text = "已複製到剪切板"
  },
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "未能正確識別到剪切板內有 <color=#5EF2FF>調查行動</color> 編隊"
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = "是否確認保存該編隊碼對應的隊伍配置？\n未持有該配置的部分將會被空置。"
  },
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {Text = "確認"},
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "保存確認"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "該隊伍包含預設喚醒體，無法複製或導入編隊碼"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "對局已達回合上限，先手方未能終結對局，判為失敗。"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {Text = "確認"},
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {
    Text = "對戰結束"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "對局已達回合上限，後手方成功堅守至終局，判為勝利。"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {Text = "確認"},
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {
    Text = "對戰結束"
  },
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "投降確認"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "未能正確識別到剪切板內有 <color=#5EF2FF>相位對弈</color> 編隊"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "是否需要拉黑這位守密人？"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {Text = "拒絕"},
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "本場密碼對戰已開始"
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "有新的守密人進入了本場密碼對戰"
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {
    Text = "正在排隊中……"
  },
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "是否退出密碼對戰？"
  },
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "退出確認"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "對方拒絕了與你對戰"
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "「基礎活性離子」\n·解鎖後，本期課題持續期間在「日常試訓」的「基礎活性離子」累積獎勵中獲得的「現實起點」、「無垢之芯」、「經驗」、「銀芯」提升至 3 倍。購買「核心課題」後會補發本期已領取的「基礎活性離子」累積獎勵的額外倍率部分。"
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = "「時序逆行」\n·可在戰鬥中返回經歷過的回合。\n·可返回至戰鬥的前 25 回合中的任意一個回合。\n·重新挑戰後依然可以使用逆行功能回到之前的回合。"
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = "「相位對弈」\n·解鎖後，本期課題持續期間可使用「相位對弈」全部卡牌。"
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = "<color=#5EF2FF>相位值</color> 已複製到剪貼簿"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "是否消耗<Blue:「源液」× {s1} >購買？\n\n<size=30><color=#ACBFCA>消耗「源液」時，優先扣除贈送的「源液」。\n（提取：{s2}，贈送：{s3}）</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "購買"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "購買確認"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "評論內容不可為空"
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "是否刪除該評論？"
  },
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {Text = "確認"},
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "刪除確認"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "是否隱藏其所有評論？"
  },
  TipsType_PvpHideCommentConfirm_Title = {Text = "隱藏"},
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "檢測到網路異常，配對中斷。"
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = "尚在戰鬥中，是否繼續之前的戰鬥？ \n「疾馳的歡愉專列」賽季已更新。繼續挑戰可完成最新賽季任務，但無法進入「貴賓名錄」。"
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {Text = "確認"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "上次挑戰進度為 {s1} - 第 {s2} 階段 - 第 {s3} 場戰鬥，已獲得「貴賓積分」× {s4}\n賽季已更新。繼續挑戰可完成最新賽季任務，但無法進入「貴賓名錄」。是否要繼續挑戰？"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {Text = "確認"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {
    Text = "繼續挑戰"
  },
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = "上次挑戰進度為 {s1} - 第 {s2} 階段 - 第 {s3} 場戰鬥、已獲得「貴賓積分」× {s4}\n是否要繼續挑戰？"
  },
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {Text = "確認"},
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "繼續挑戰"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "需要結束上次保存的挑戰後才可進行新的挑戰"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = "是否確認退出挑戰？\n本次挑戰進度將會被保存、下次挑戰時會以當前進度繼續進行、並重開本場戰鬥。"
  },
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {Text = "確認"},
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "保存並退出"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = "是否確認退出挑戰？\n本次挑戰進度將會被保存、下次挑戰時會以當前進度繼續進行。"
  },
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {Text = "確認"},
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "保存並退出"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "賽季已更新。繼續挑戰可完成最新賽季任務，但無法進入「貴賓名錄」。"
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "回放資訊不可為空"
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "隊伍中喚醒體存在界域衝突，請進行調整。"
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "超過了選定數量"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "該榜單資料尚未載入完成，請稍後重新開啟介面。"
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {Text = "確認"},
  TipsType_ServerRankDataLoading_Title = {
    Text = "伺服器排行榜資料初始化中"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "將使用 <Blue:{s1}> 個{s2}，兌換 <Blue:{s3}> 個{s4}，確認進行兌換嗎？"
  },
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "兌換確認"
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "戰鬥記錄被隱藏"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "請在Steam「設置-遊戲中」及本遊戲「屬性-通用」中開啟「在遊戲中啟用Steam疊加界面」，完成後重新啟動遊戲再次嘗試。"
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {Text = "確認"},
  TipsType_SteamOverlayEnabledTips_Title = {
    Text = "溫馨提示"
  },
  TipsType_SteamRestartTips_Desc = {
    Text = "Steam 授權異常，請重啟 Steam 客戶端後重試"
  },
  TipsType_SteamRestartTips_RightBtnDesc = {Text = "確認"},
  TipsType_SteamRestartTips_Title = {
    Text = "登入異常"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "調查確認"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "調查確認"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "為確保最佳劇情體驗，建議完成以下調查關卡。"
  },
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "仍要調查"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "調查確認"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "喚醒消耗材料資訊變化，請重新喚醒"
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "缺少 {s1} 個<Blue:「{s2}」>，是否消耗<Blue:「{s4}」×{s3} >代替？"
  },
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {Text = "確認"},
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "兌換確認"
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue:注意：一旦選定，本次活動無法再更改！>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "是否確認選擇喚醒體<OrangeQuality:「{s1}」、「{s2}」、「{s3}」、「{s4}」>作為本期活動的定向UP？"
  },
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "確認選擇"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue:注意：一旦選定，本次活動無法再更改！>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "已達到選擇數量上限"
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "請先完成所有類型的選擇後再嘗試吧"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = "確認完成本期指定喚醒體選擇？\n確認後，本期選擇將無法再次更改。"
  },
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "確認選擇"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "已是最新狀態，快去關注更多校友獲得更多助戰選擇吧！"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "正在進行自動轉錄，無法進行操作。"
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "（自動轉錄至一條未鎖定屬性強度為8時停止。）"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = "至多轉錄 {s1} 次\n至多消耗"
  },
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "自動轉錄確認"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "密契背包已滿"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "是否析離所有密契？"
  },
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "析離確認"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "存在被結合的密契，無法儲存為方案！"
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "確認結合以下密契？已被其他喚醒體裝備或在編隊/方案/助戰中存在的密契將被自動卸下。"
  },
  TipsType_TrinketBindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketBindTips_Title = {
    Text = "結合確認"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "確認修改結合？"
  },
  TipsType_TrinketChangeBindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketChangeBindTips_Title = {
    Text = "修改結合確認"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = "是否析離所有密契？\n\n<color=#9BA3A2><size=30>所選素材中含有 +12 密契部件。</size></color>"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "析離確認"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = "確認修改結合？\n\n<color=#9BA3A2><size=30>所選素材中含有 +12 密契部件。</size></color>"
  },
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "修改結合確認"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = "確認析離該密契？\n\n<color=#9BA3A2><size=30>所選素材中含有 +12 密契部件。</size></color>"
  },
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "析離確認"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "確認析離該密契？"
  },
  TipsType_TrinketUnbindTips_RightBtnDesc = {Text = "確認"},
  TipsType_TrinketUnbindTips_Title = {
    Text = "析離確認"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "該 <color=#5EF2FF>相位值</color> 正在被使用，請稍後再試"
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = "正在等待\n{s1}\n接受 <Blue:{s2}>的邀請"
  },
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "密碼對戰"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = "正在等待其他守密人輸入\n <Blue:{s1}>\n匹配密碼對戰"
  },
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "複製 <color=#5EF2FF>相位值</color>"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "密碼對戰"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "確認消耗 <Blue:{s1}>，獲得1個<Blue:隨機>命輪嗎？"
  },
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {Text = "確認"},
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "使用確認"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "本週內獲取獎勵次數已耗盡，無法進行重現。"
  }
})
return Text_TipsType
