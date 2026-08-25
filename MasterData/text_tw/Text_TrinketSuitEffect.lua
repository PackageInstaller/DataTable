__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TrinketSuitEffect = readonly({
  TrinketSuitEffect_18335_Name = {
    Text = "四月禮讚"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_1 = {
    Text = "暴擊傷害 +7.2%"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 隊伍唯一>：回合開始時，若敵人總生命大於 75%，裝備者臨時暴擊率和暴擊傷害+35%。"
  },
  TrinketSuitEffect_18336_Name = {
    Text = "環形詩篇（未完成）"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_2 = {
    Text = "偶數回合開始後，使一張隨機手牌算力消耗降低 1。"
  },
  TrinketSuitEffect_18337_Name = {Text = "海歸線"},
  TrinketSuitEffect_18337_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 隊伍唯一>：戰鬥開始時，獲得等同於裝備者攻擊力 12% 的力量。若當前界域為深海，效果改為“每回合開始時，有 (50+0.25*隊伍界域精通)%的機會獲得 1 層觸腕集結，超過 100% 時可獲得多層，機率在首領戰中翻倍。"
  },
  TrinketSuitEffect_18338_Name = {Text = "詛咒兔"},
  TrinketSuitEffect_18338_SuitEffectDesc_2 = {
    Text = "裝備者造成的護盾與生命回復提高 12%。"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_1 = {
    Text = "銀鑰充能等級 +7.2"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 隊伍唯一>：裝備者的基礎狂氣提升 20 點、裝備者指令卡的暴擊率、暴擊傷害、護盾、回復生命提升 20%。"
  },
  TrinketSuitEffect_18340_Name = {
    Text = "有機形態"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 隊伍唯一>。探索開始時扣除至多 100% 死亡抵抗。每扣除 1% 死亡抵抗，就使裝備者造成的狂氣提高 0.15%。"
  },
  TrinketSuitEffect_18341_Name = {
    Text = "猩紅之悸"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_1 = {
    Text = "暴擊傷害 +7.2%"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_2 = {
    Text = "釋放鑰令後，裝備者獲得 30% 臨時暴擊率。"
  },
  TrinketSuitEffect_18342_Name = {
    Text = "標準密契SSR"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_2 = {
    Text = "裝備者造成的傷害、治療、護盾提高 15%。"
  },
  TrinketSuitEffect_18343_Name = {
    Text = "標準密契R"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_2 = {
    Text = "裝備者造成的傷害、治療、護盾提高 15%。"
  },
  TrinketSuitEffect_18344_Name = {
    Text = "機械降神"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_2 = {
    Text = "每場戰鬥的首個回合獲得 1 點算力，首領戰中，每4回合額外獲得1點算力"
  },
  TrinketSuitEffect_18345_Name = {
    Text = "光合祭禮"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_1 = {
    Text = "傷害強效 +7.2%"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 隊伍唯一>：裝備者的指令卡進入超維空間後，使胚胎融合+25~50，當前生命越低則獲得胚胎融合越高。"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_1 = {
    Text = "狂氣回充等級 +2.4"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 隊伍唯一>：探索開始時，裝備者獲得 35 點狂氣。裝備者使用狂氣爆發後，本場戰鬥中回合結束時獲得 2 點狂氣，該效果至多堆疊 3 次。"
  },
  TrinketSuitEffect_18347_Name = {
    Text = "生機榨取"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_1 = {
    Text = "銀鑰充能等級 +7.2"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 隊伍唯一>：回合結束時獲得等同於裝備者銀鑰充能 200％ 的銀鑰能量。若當前界域為「血肉」，效果變為每有 5 點銀鑰充能，就使胚胎融合 +1。"
  },
  TrinketSuitEffect_18348_Name = {
    Text = "入藥之夢"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_1 = {
    Text = "傷害強效 +4.8%"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 隊伍唯一>。戰鬥結束時獲得的黑印 -8，戰鬥開始時將裝備者非打擊防禦指令卡的原始複製洗入抽牌堆，每種至多 1 張。"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 隊伍唯一>：若在 1 回合內同時釋放了「湮滅」並切換過觸腕姿態，裝備者本回合造成的護盾、生命回復、最終傷害 +25%，3 回合冷卻。"
  },
  TrinketSuitEffect_18350_Name = {
    Text = "劇院貓（未完成）"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_2 = {
    Text = "裝備者對生命大於 75% 的敵人造成的傷害必定暴擊。"
  },
  TrinketSuitEffect_18351_Name = {
    Text = "36室之環"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_1 = {
    Text = "狂氣回充等級 +2.4"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 隊伍唯一>。銀鑰能量上限及鑰令消耗銀鑰能量 +200，裝備者狂氣爆發的暴擊率、暴擊傷害、護盾、回復生命提高 30%。"
  },
  TrinketSuitEffect_18352_Name = {
    Text = "扭曲雙子·白"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_2 = {
    Text = "偶數回合開始後，將一張附加<NothingnessIconKeywords:虛無>和<DepleteIconKeywords:消耗>的裝備者的「防禦」加入手牌。"
  },
  TrinketSuitEffect_18353_Name = {
    Text = "猩紅之擁"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_1 = {
    Text = "暴擊率 +4.8%"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_2 = {
    Text = "裝備者造成傷害時獲得 35 點銀鑰能量，若造成暴擊傷害，改為獲得 70 點銀鑰能量，每回合最多觸發 3 次。"
  },
  TrinketSuitEffect_18354_Name = {
    Text = "標準密契SR"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_2 = {
    Text = "裝備者造成的傷害、治療、護盾提高 15%。"
  },
  TrinketSuitEffect_18355_Name = {
    Text = "無垢啟示錄"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_1 = {
    Text = "銀鑰充能等級 +7.2"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 隊伍唯一>：釋放鑰令後，回復等同於裝備者體質 12% 的生命，效果隨損失生命比例提高，至多提高為裝備者體質 24% 的生命。"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_1 = {
    Text = "傷害強效 +4.8%"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_2 = {
    Text = "裝備者造成的基礎傷害提高 20％，造成的<IntoxicationIconKeywords:中毒>和<RetaliateIconKeywords:反擊>提高 10%。"
  },
  TrinketSuitEffect_18357_Name = {
    Text = "遠方的歡宴"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_2 = {
    Text = "探索開始時，獲得 10 黑印。裝備者「防禦」造成護盾提高 60%。"
  },
  TrinketSuitEffect_18358_Name = {
    Text = "扭曲雙子·黑"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_1 = {
    Text = "暴擊率 +4.8%"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_2 = {
    Text = "奇數回合開始後，將一張附加<NothingnessIconKeywords:虛無>和<DepleteIconKeywords:消耗>的裝備者的「打擊」加入手牌。"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_1 = {
    Text = "暴擊率 +7.2%"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 隊伍唯一>：裝備者每回合首次消耗胚胎後，每擁有 1 條觸腕獲得 8% 臨時暴擊傷害，最大 80%。"
  },
  TrinketSuitEffect_18360_Name = {
    Text = "埋骨地絮語"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_2 = {
    Text = "關卡開始時<DeathResistanceIconKeywords:死亡抵抗>提高 25%。觸發死亡抵抗後，裝備者獲得 50 點狂氣。"
  },
  TrinketSuitEffect_99234_Name = {Text = "腐殖質"},
  TrinketSuitEffect_99234_SuitEffectDesc_1 = {
    Text = "臨時文本"
  },
  TrinketSuitEffect_99234_SuitEffectDesc_2 = {
    Text = "臨時文本"
  },
  TrinketSuitEffect_99235_Name = {Text = "飛昇"},
  TrinketSuitEffect_99235_SuitEffectDesc_1 = {
    Text = "臨時文本"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_2 = {
    Text = "臨時文本"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_1 = {
    Text = "臨時文本"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_2 = {
    Text = "臨時文本"
  }
})
return Text_TrinketSuitEffect
