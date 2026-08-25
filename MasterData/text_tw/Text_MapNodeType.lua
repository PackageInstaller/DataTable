__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MapNodeType = readonly({
  MapNodeType_116420_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_116420_Name = {
    Text = "隨機節點"
  },
  MapNodeType_116421_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_116421_Name = {
    Text = "隨機戰鬥"
  },
  MapNodeType_116422_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_116422_Name = {
    Text = "隨機事件"
  },
  MapNodeType_121329_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_128222_Name = {
    Text = "指令節點"
  },
  MapNodeType_130326_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_130326_Name = {
    Text = "命運的劇場"
  },
  MapNodeType_149067_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_149067_Name = {
    Text = "上現蜃景"
  },
  MapNodeType_18391_Desc = {
    Text = "危險還是機遇，取決於你的抉擇。"
  },
  MapNodeType_18392_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_18392_Name = {
    Text = "古怪膿皰"
  },
  MapNodeType_18393_Desc = {
    Text = "精神的迷霧無形卻堅硬，不允許任何物體穿透。"
  },
  MapNodeType_18393_Name = {Text = "虛無"},
  MapNodeType_18394_Desc = {
    Text = "危險還是機遇，取決於你的抉擇。"
  },
  MapNodeType_18395_Desc = {
    Text = "一場相遇，一次危機，抑或一段回憶。"
  },
  MapNodeType_18395_Name = {Text = "劇情"},
  MapNodeType_18396_Desc = {
    Text = "最終，亦是最強的敵人，擊敗後將結束這場調查。"
  },
  MapNodeType_18396_Name = {Text = "最終戰"},
  MapNodeType_18397_Desc = {
    Text = "觸發後進入融痕，其後的存在渴求著用神秘力量交換你手中的黑印。"
  },
  MapNodeType_18397_Name = {
    Text = "訂製造物融痕"
  },
  MapNodeType_18398_Desc = {
    Text = "觸發以獲得彌薩格大學的幫助，可以恢復生命。"
  },
  MapNodeType_18398_Name = {Text = "聯絡點"},
  MapNodeType_18399_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_18400_Desc = {
    Text = "暗影的池水深不可測，充滿未知，觸發後可以獲得隨機獎勵。"
  },
  MapNodeType_18401_Desc = {
    Text = "危險還是機遇，取決於你的抉擇。"
  },
  MapNodeType_18402_Desc = {
    Text = "玩家開始位置，你不應當看到此節點，看到就是有BUG了！"
  },
  MapNodeType_18402_Name = {Text = "開始"},
  MapNodeType_18404_Desc = {
    Text = "獲得黑印——一種在幻夢空間中的通行貨幣。"
  },
  MapNodeType_18405_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_18406_Desc = {
    Text = "單行密道的出口，內部已經坍縮，無法從此處折返回密道入口。"
  },
  MapNodeType_18407_Desc = {
    Text = "獲得造物。"
  },
  MapNodeType_18408_Desc = {
    Text = "一條有去無回的不穩定通路，進入後將無法從出口折返。"
  },
  MapNodeType_18408_Name = {
    Text = "單行密道"
  },
  MapNodeType_18409_Desc = {
    Text = "測試水晶球"
  },
  MapNodeType_18409_Name = {
    Text = "測試水晶球"
  },
  MapNodeType_18410_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_18410_Name = {
    Text = "代行之儀"
  },
  MapNodeType_18411_Desc = {
    Text = "一些略有挑戰的敵人，會觸發一場稍難的戰鬥。"
  },
  MapNodeType_18412_Desc = {
    Text = "觸發後進入融痕，其後的存在渴求著用神秘力量交換你手中的黑印。"
  },
  MapNodeType_18412_Name = {
    Text = "訂製刻印融痕"
  },
  MapNodeType_18413_Desc = {
    Text = "觸發以獲得彌薩格大學的幫助，可以恢復生命，或選擇覺醒一名喚醒體。"
  },
  MapNodeType_18413_Name = {Text = "聯絡點"},
  MapNodeType_18414_Desc = {
    Text = "觸發後進入融痕，其後的存在渴求著用神秘力量交換你手中的黑印。"
  },
  MapNodeType_18415_Desc = {
    Text = "隱藏獎勵"
  },
  MapNodeType_18415_Name = {
    Text = "隱藏獎勵"
  },
  MapNodeType_18416_Desc = {
    Text = "觸發後進入融痕，其後的存在渴求著用神秘力量交換你手中的黑印。"
  },
  MapNodeType_18417_Desc = {
    Text = "漆黑的道路通向未知，進入後將傳送至通道的另一端。"
  },
  MapNodeType_18419_Desc = {
    Text = "測試定時塌陷地板"
  },
  MapNodeType_18419_Name = {
    Text = "定時塌陷地板"
  },
  MapNodeType_18420_Desc = {
    Text = "測試隱藏通道"
  },
  MapNodeType_18420_Name = {
    Text = "測試隱藏通道"
  },
  MapNodeType_18421_Desc = {
    Text = "前人遺留下來的照明裝置，可驅散四周的濃霧。"
  },
  MapNodeType_18421_Name = {Text = "探照燈"},
  MapNodeType_18422_Desc = {
    Text = "沉默矗立的堅固門扉。需要使用銹蝕鑰匙開啟。"
  },
  MapNodeType_18422_Name = {
    Text = "銹蝕門扉"
  },
  MapNodeType_18423_Desc = {
    Text = "觸發後進入融痕，其後的存在渴求著用神秘力量交換你手中的黑印。"
  },
  MapNodeType_18425_Desc = {
    Text = "它耐心地尋找著屬於它的那一扇門扉。"
  },
  MapNodeType_18425_Name = {
    Text = "銹蝕鑰匙"
  },
  MapNodeType_18426_Desc = {
    Text = "頭像替換"
  },
  MapNodeType_18426_Name = {
    Text = "頭像替換"
  },
  MapNodeType_18427_Desc = {
    Text = "扭曲的幻象阻擋了你的前進，若選擇破除，將會感染未知的症狀。"
  },
  MapNodeType_18428_Desc = {
    Text = "獲取遊離的銀芯。"
  },
  MapNodeType_18428_Name = {Text = "銀芯"},
  MapNodeType_18429_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_18429_Name = {
    Text = "善意的禮物"
  },
  MapNodeType_18430_Desc = {
    Text = "測試用特殊商店節點，能看到說明你不在正式關卡中"
  },
  MapNodeType_18431_Desc = {
    Text = "一些不期而遇的敵人，會觸發一場戰鬥。"
  },
  MapNodeType_18431_Name = {Text = "戰鬥"},
  MapNodeType_18432_Desc = {
    Text = "危險的融蝕地帶，不要輕易踏入"
  },
  MapNodeType_18432_Name = {Text = "惡沼"},
  MapNodeType_24876_Desc = {
    Text = "一些略有挑戰的敵人，會觸發一場稍難的戰鬥。"
  },
  MapNodeType_35056_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_35056_Name = {
    Text = "製片人的迷思"
  },
  MapNodeType_35889_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_35889_Name = {
    Text = "純白之帆"
  },
  MapNodeType_37987_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_38711_Desc = {
    Text = "觸發後進入融痕，其後的存在渴求著用神秘力量交換你手中的黑印。"
  },
  MapNodeType_38711_Name = {
    Text = "夏裡奇市集"
  },
  MapNodeType_44838_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_44839_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_44839_Name = {Text = "救贖"},
  MapNodeType_44840_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_44840_Name = {Text = "懺悔"},
  MapNodeType_46149_Desc = {
    Text = "觸發後進入融痕，其後的存在渴求著用神秘力量交換你手中的黑印。"
  },
  MapNodeType_47473_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_47473_Name = {Text = "清醒夢"},
  MapNodeType_47474_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_47474_Name = {
    Text = "主體融合"
  },
  MapNodeType_47475_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_48144_Desc = {
    Text = "危險還是機遇，取決於你的抉擇。"
  },
  MapNodeType_48144_Name = {
    Text = "自性覺知"
  },
  MapNodeType_49058_Desc = {
    Text = "紅的發黑的池水中似乎隱藏著什麼"
  },
  MapNodeType_49100_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_52484_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_52484_Name = {Text = "天災"},
  MapNodeType_52485_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_52485_Name = {Text = "天災"},
  MapNodeType_52486_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_52486_Name = {Text = "天災"},
  MapNodeType_52487_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_52487_Name = {
    Text = "終極獻祭"
  },
  MapNodeType_55797_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_55797_Name = {
    Text = "春天的贈禮"
  },
  MapNodeType_55798_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_55798_Name = {
    Text = "繆斯的眷顧"
  },
  MapNodeType_57740_Desc = {
    Text = "這塊沒有任何遮擋物的區域，完全暴露在審查會的監視之下。"
  },
  MapNodeType_57740_Name = {Text = "監察點"},
  MapNodeType_57741_Desc = {
    Text = "審查會的看守並不嚴密，或許，這反而會是一條可以利用的道路？"
  },
  MapNodeType_57741_Name = {Text = "羈押點"},
  MapNodeType_57742_Desc = {
    Text = "於麗埃特的鷹犬似乎無窮無盡。又一隊審查會探員攔在了你前進的路上。"
  },
  MapNodeType_57742_Name = {
    Text = "審查會探員"
  },
  MapNodeType_59662_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_59662_Name = {
    Text = "入學儀式"
  },
  MapNodeType_65469_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_65469_Name = {
    Text = "安全撤離點"
  },
  MapNodeType_74221_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_74221_Name = {
    Text = "尚未流失的意識"
  },
  MapNodeType_76256_Desc = {
    Text = "利莫利亞沉沒的遺跡，其後的存在渴求著用神秘力量交換你手中的黑印。"
  },
  MapNodeType_76256_Name = {
    Text = "灰燼遺跡"
  },
  MapNodeType_76417_Desc = {
    Text = "一截蒼白的骸骨，半數浸沒於漆黑的融蝕漿中"
  },
  MapNodeType_76417_Name = {
    Text = "褪色遺骨"
  },
  MapNodeType_80599_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  },
  MapNodeType_80599_Name = {
    Text = "生命的蛻變"
  },
  MapNodeType_90661_Desc = {
    Text = "銀鑰將你指引向此地，與存在於此之物共鳴吧。"
  }
})
return Text_MapNodeType
