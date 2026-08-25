__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MapNodeType = readonly({
  MapNodeType_116420_Desc = {
    Text = "シルバーキーがここへとあなたを導いた。ここにあるものと共鳴しなさい。"
  },
  MapNodeType_116420_Name = {
    Text = "ランダムノード"
  },
  MapNodeType_116421_Desc = {
    Text = "シルバーキーがここへとあなたを導いた。ここにあるものと共鳴しなさい。"
  },
  MapNodeType_116421_Name = {
    Text = "ランダムバトル"
  },
  MapNodeType_116422_Desc = {
    Text = "シルバーキーがここへとあなたを導いた。ここにあるものと共鳴しなさい。"
  },
  MapNodeType_116422_Name = {
    Text = "ランダムイベント"
  },
  MapNodeType_121329_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_121329_Name = {
    Text = "マーフィーの幻影"
  },
  MapNodeType_128222_Name = {
    Text = "コマンドノード"
  },
  MapNodeType_130326_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_130326_Name = {
    Text = "運命の劇場"
  },
  MapNodeType_149067_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_149067_Name = {
    Text = "上空蜃気楼"
  },
  MapNodeType_18391_Desc = {
    Text = "危険か好機かは、あなたの選択次第。"
  },
  MapNodeType_18392_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_18392_Name = {
    Text = "奇妙な膿"
  },
  MapNodeType_18393_Desc = {
    Text = "精神の霧は無形だが硬く、何物も通さない。"
  },
  MapNodeType_18393_Name = {Text = "虚無"},
  MapNodeType_18394_Desc = {
    Text = "危険か好機かは、あなたの選択次第。"
  },
  MapNodeType_18395_Desc = {
    Text = "出会い、危機、または記憶。"
  },
  MapNodeType_18395_Name = {
    Text = "ストーリー"
  },
  MapNodeType_18396_Desc = {
    Text = "最終、そして最強の敵。倒すとこの調査が終わる。"
  },
  MapNodeType_18396_Name = {Text = "最終戦"},
  MapNodeType_18397_Desc = {
    Text = "融痕の中の存在があなたの黒章と、神秘的な力を交換しようとする。"
  },
  MapNodeType_18397_Name = {
    Text = "遺物変質の交換所"
  },
  MapNodeType_18398_Desc = {
    Text = "ミサゴ大学の支援を獲得し、ライフを回復。"
  },
  MapNodeType_18398_Name = {Text = "休憩所"},
  MapNodeType_18399_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_18399_Name = {Text = "蜂蜜酒"},
  MapNodeType_18400_Desc = {
    Text = "暗影の池は深く未知に満ち、触発するとランダムな報酬を獲得する。"
  },
  MapNodeType_18400_Name = {Text = "影の池"},
  MapNodeType_18401_Desc = {
    Text = "危険か好機かは、あなたの選択次第。"
  },
  MapNodeType_18402_Desc = {
    Text = "プレイヤー開始位置、このノードを見てはいけません、見たらバグです！"
  },
  MapNodeType_18402_Name = {Text = "開始"},
  MapNodeType_18403_Desc = {
    Text = "光影ショー"
  },
  MapNodeType_18403_Name = {
    Text = "光影ショー"
  },
  MapNodeType_18404_Desc = {
    Text = "黒章を獲得する。密境での通貨。"
  },
  MapNodeType_18404_Name = {Text = "黒章"},
  MapNodeType_18405_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_18405_Name = {
    Text = "未完成の蝋人形"
  },
  MapNodeType_18406_Desc = {
    Text = "一方通行の隠し通路の出口は内部が崩壊しており、ここから戻って入口に辿り着くことはできない。"
  },
  MapNodeType_18406_Name = {
    Text = "隠し通路の出口"
  },
  MapNodeType_18407_Desc = {
    Text = "遺物を獲得。"
  },
  MapNodeType_18407_Name = {Text = "遺物"},
  MapNodeType_18408_Desc = {
    Text = "一方通行の不安定な通路、入ると出口から戻れない。"
  },
  MapNodeType_18408_Name = {
    Text = "一方通行の隠し通路"
  },
  MapNodeType_18409_Desc = {
    Text = "テスト水晶玉"
  },
  MapNodeType_18409_Name = {
    Text = "テスト水晶玉"
  },
  MapNodeType_18410_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_18410_Name = {
    Text = "代行の儀"
  },
  MapNodeType_18411_Desc = {
    Text = "やや挑戦的な敵が少し難しい戦闘を引き起こす。"
  },
  MapNodeType_18411_Name = {Text = "精鋭"},
  MapNodeType_18412_Desc = {
    Text = "融痕の中の存在があなたの黒章と、神秘的な力を交換しようとする。"
  },
  MapNodeType_18412_Name = {
    Text = "刻印変質の交換所"
  },
  MapNodeType_18413_Desc = {
    Text = "ミサゴ大学の支援を獲得し、ライフを回復するか、覚醒体を1体選んで覚醒する。"
  },
  MapNodeType_18413_Name = {Text = "休憩所"},
  MapNodeType_18414_Desc = {
    Text = "融痕の中の存在があなたの黒章と、神秘的な力を交換しようとする。"
  },
  MapNodeType_18414_Name = {
    Text = "刻印の交換所"
  },
  MapNodeType_18415_Desc = {
    Text = "隠し報酬"
  },
  MapNodeType_18415_Name = {
    Text = "隠し報酬"
  },
  MapNodeType_18416_Desc = {
    Text = "融痕の中の存在があなたの黒章と、神秘的な力を交換しようとする。"
  },
  MapNodeType_18416_Name = {
    Text = "遺物の交換所"
  },
  MapNodeType_18417_Desc = {
    Text = "漆黒の道が未知へと続き、入ると通路の反対側に転送される。"
  },
  MapNodeType_18417_Name = {
    Text = "トンネル"
  },
  MapNodeType_18419_Desc = {
    Text = "テストタイマー崩壊床"
  },
  MapNodeType_18419_Name = {
    Text = "タイマー付き崩壊床"
  },
  MapNodeType_18420_Desc = {
    Text = "テスト隠し通路"
  },
  MapNodeType_18420_Name = {
    Text = "テスト隠し通路"
  },
  MapNodeType_18421_Desc = {
    Text = "前人の残した照明装置。周囲の濃霧を払う。"
  },
  MapNodeType_18421_Name = {
    Text = "サーチライト"
  },
  MapNodeType_18422_Desc = {
    Text = "静かに立つ頑丈な扉。扉の鍵が必要だ。"
  },
  MapNodeType_18422_Name = {Text = "扉"},
  MapNodeType_18423_Desc = {
    Text = "融痕の中の存在があなたの黒章と、神秘的な力を交換しようとする。"
  },
  MapNodeType_18423_Name = {Text = "交換所"},
  MapNodeType_18424_Desc = {
    Text = "不安定な床"
  },
  MapNodeType_18424_Name = {
    Text = "不安定な床"
  },
  MapNodeType_18425_Desc = {
    Text = "それは忍耐強く自分の扉を探している。"
  },
  MapNodeType_18425_Name = {Text = "扉の鍵"},
  MapNodeType_18426_Desc = {
    Text = "アイコン変更"
  },
  MapNodeType_18426_Name = {
    Text = "アイコン変更"
  },
  MapNodeType_18427_Desc = {
    Text = "歪んだ幻影が前進を妨げる。破壊すると未知の症状に感染する。"
  },
  MapNodeType_18427_Name = {Text = "幻影"},
  MapNodeType_18428_Desc = {
    Text = "遊離したシルバーコアを取得。"
  },
  MapNodeType_18428_Name = {
    Text = "シルバーコア"
  },
  MapNodeType_18429_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_18429_Name = {
    Text = "善意の贈り物"
  },
  MapNodeType_18430_Desc = {
    Text = "テスト用特殊ショップノード、説明が見えるなら正式ステージではない。"
  },
  MapNodeType_18431_Desc = {
    Text = "不意に出会う敵が戦闘を引き起こす。"
  },
  MapNodeType_18431_Name = {Text = "戦闘"},
  MapNodeType_18432_Desc = {
    Text = "危険な融蝕地帯、軽々しく踏み入れるな。"
  },
  MapNodeType_18432_Name = {Text = "悪沼"},
  MapNodeType_24876_Desc = {
    Text = "やや挑戦的な敵が少し難しい戦闘を引き起こす。"
  },
  MapNodeType_24876_Name = {Text = "精鋭"},
  MapNodeType_35056_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_35056_Name = {
    Text = "製作者の迷宮"
  },
  MapNodeType_35889_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_35889_Name = {
    Text = "純白の帆"
  },
  MapNodeType_37987_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_37987_Name = {
    Text = "代行の密令"
  },
  MapNodeType_38711_Desc = {
    Text = "融痕の中の存在があなたの黒章と、神秘的な力を交換しようとする。"
  },
  MapNodeType_38711_Name = {
    Text = "シャリッシュ市場"
  },
  MapNodeType_44838_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_44839_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_44839_Name = {Text = "救済"},
  MapNodeType_44840_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_44840_Name = {Text = "懺悔"},
  MapNodeType_46149_Desc = {
    Text = "融痕の中の存在があなたの黒章と、神秘的な力を交換しようとする。"
  },
  MapNodeType_46149_Name = {Text = "交換所"},
  MapNodeType_47473_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_47473_Name = {Text = "明晰夢"},
  MapNodeType_47474_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_47475_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_47475_Name = {
    Text = "催眠の蛇"
  },
  MapNodeType_48144_Desc = {
    Text = "危険か好機かは、あなたの選択次第。"
  },
  MapNodeType_48144_Name = {
    Text = "自己覚知"
  },
  MapNodeType_49058_Desc = {
    Text = "血の海の水に何かが隠れているようだ。"
  },
  MapNodeType_49058_Name = {Text = "血の池"},
  MapNodeType_49100_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_49100_Name = {
    Text = "母なる存在"
  },
  MapNodeType_52484_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_52484_Name = {Text = "天災"},
  MapNodeType_52485_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_52485_Name = {Text = "天災"},
  MapNodeType_52486_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_52486_Name = {Text = "天災"},
  MapNodeType_52487_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_52487_Name = {
    Text = "究極の犠牲"
  },
  MapNodeType_55797_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_55797_Name = {
    Text = "春の贈り物"
  },
  MapNodeType_55798_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_55798_Name = {
    Text = "ミューズの加護"
  },
  MapNodeType_57740_Desc = {
    Text = "ここは遮るものがなく、審査会の監視を完全に受けている。"
  },
  MapNodeType_57740_Name = {Text = "検査所"},
  MapNodeType_57741_Desc = {
    Text = "審査会の監視は厳しくない、もしかしたら、これが利用できる道かもしれない？"
  },
  MapNodeType_57741_Name = {Text = "拘留所"},
  MapNodeType_57742_Desc = {
    Text = "ジュリエットの手下は無限にいるようだ。さらに監視員があなたの前進を阻む。"
  },
  MapNodeType_57742_Name = {Text = "監視員"},
  MapNodeType_59662_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_59662_Name = {Text = "入学式"},
  MapNodeType_65469_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_65469_Name = {
    Text = "安全な退避所"
  },
  MapNodeType_74221_Desc = {
    Text = "シルバーキーがあなたをここに導き、ここにあるものと共鳴する。"
  },
  MapNodeType_74221_Name = {
    Text = "消えいる意識の残響"
  },
  MapNodeType_76256_Desc = {
    Text = "リモリア沈没の遺跡、その中の存在があなたの黒章と、神秘的な力を交換しようとする。"
  },
  MapNodeType_76256_Name = {
    Text = "灰燼遺跡"
  },
  MapNodeType_76417_Desc = {
    Text = "蒼白い骸骨の一部が、黒い融蝕液に半分沈んでいる。"
  },
  MapNodeType_76417_Name = {
    Text = "色褪せた遺骨"
  },
  MapNodeType_80599_Desc = {
    Text = "シルバーキーがここへとあなたを導いた。ここにあるものと共鳴しなさい。"
  },
  MapNodeType_80599_Name = {
    Text = "ライフの変身"
  },
  MapNodeType_90661_Desc = {
    Text = "シルバーキーがここへとあなたを導いた。ここにあるものと共鳴しなさい。"
  },
  MapNodeType_90661_Name = {
    Text = "完璧な味わい"
  }
})
return Text_MapNodeType
