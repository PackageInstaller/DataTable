__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TrinketSuitEffect = readonly({
  TrinketSuitEffect_18335_Name = {
    Text = "四月礼赞"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_1 = {
    Text = "暴击伤害 +7.2%"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 队伍唯一>：回合开始时，若敌人总生命大于 75%，装备者临时暴击率和暴击伤害+35%。"
  },
  TrinketSuitEffect_18336_Name = {
    Text = "环形诗篇（未完成）"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_1 = {
    Text = "死亡抵抗 +16.8%"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_2 = {
    Text = "偶数回合开始后，使一张随机手牌算力消耗降低 1。"
  },
  TrinketSuitEffect_18337_Name = {Text = "海归线"},
  TrinketSuitEffect_18337_SuitEffectDesc_1 = {
    Text = "界域精通 +12"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 队伍唯一>：战斗开始时，获得等同于装备者攻击力 12% 的力量。若当前界域为深海，效果改为“每回合开始时，有 (50+0.25*队伍界域精通)%的机会获得 1 层触腕集结，超过 100% 时可获得多层，概率在首领战中翻倍。"
  },
  TrinketSuitEffect_18338_Name = {Text = "诅咒兔"},
  TrinketSuitEffect_18338_SuitEffectDesc_1 = {
    Text = "界域精通 +12"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_2 = {
    Text = "装备者造成的护盾与生命回复提高 12%。"
  },
  TrinketSuitEffect_18339_Name = {
    Text = "二律背反"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_1 = {
    Text = "银钥充能等级 +7.2"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 队伍唯一>：装备者的基础狂气提高 20 点，装备者指令卡的暴击率、暴击伤害、护盾、回复生命提高 20%。"
  },
  TrinketSuitEffect_18340_Name = {
    Text = "有机形态"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_1 = {
    Text = "黑印掉落 +3.6%"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 队伍唯一>。探索开始时扣除至多 100% 死亡抵抗。每扣除 1% 死亡抵抗，就使装备者造成的狂气提高 0.15%。"
  },
  TrinketSuitEffect_18341_Name = {
    Text = "猩红之悸"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_1 = {
    Text = "暴击伤害 +7.2%"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_2 = {
    Text = "释放钥令后，装备者获得 30% 临时暴击率。"
  },
  TrinketSuitEffect_18342_Name = {
    Text = "标准密契SSR"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_1 = {
    Text = "死亡抵抗 +16.8%"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_2 = {
    Text = "装备者造成的伤害、治疗、护盾提高 15%。"
  },
  TrinketSuitEffect_18343_Name = {
    Text = "标准密契R"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_1 = {
    Text = "死亡抵抗 +16.8%"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_2 = {
    Text = "装备者造成的伤害、治疗、护盾提高 15%。"
  },
  TrinketSuitEffect_18344_Name = {
    Text = "机械降神"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_1 = {
    Text = "界域精通 +12"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_2 = {
    Text = "每场战斗的首个回合获得 1 点算力，首领战中，每4回合额外获得1点算力"
  },
  TrinketSuitEffect_18345_Name = {
    Text = "光合祭礼"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_1 = {
    Text = "伤害强效 +7.2%"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 队伍唯一>：装备者的指令卡进入超维空间后，使胚胎融合+25~50，当前生命越低则获得胚胎融合越高。"
  },
  TrinketSuitEffect_18346_Name = {Text = "再衍化"},
  TrinketSuitEffect_18346_SuitEffectDesc_1 = {
    Text = "狂气回充等级 +2.4"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 队伍唯一>：探索开始时，装备者获得 35 点狂气。装备者使用狂气爆发后，本场战斗中回合结束时获得 2 点狂气，该效果至多堆叠 3 次。"
  },
  TrinketSuitEffect_18347_Name = {
    Text = "生机榨取"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_1 = {
    Text = "银钥充能等级 +7.2"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 队伍唯一>：回合结束时获得等同于装备者银钥充能 200% 的银钥能量。若当前界域为「血肉」，效果变为每有 5 点银钥充能，就使胚胎融合 +1。"
  },
  TrinketSuitEffect_18348_Name = {
    Text = "入药之梦"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_1 = {
    Text = "伤害强效 +4.8%"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 队伍唯一>。战斗结束时获得的黑印 -8，战斗开始时将装备者非打击防御指令卡的原始复制洗入抽牌堆，每种至多 1 张。"
  },
  TrinketSuitEffect_18349_Name = {
    Text = "甜蜜蛞蝓"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_1 = {
    Text = "死亡抵抗 +25.2%"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 队伍唯一>：若在 1 回合内同时释放了「湮灭」并切换过触腕姿态，装备者本回合造成的护盾、生命回复、最终伤害 +25%，3 回合冷却。"
  },
  TrinketSuitEffect_18350_Name = {
    Text = "剧院猫（未完成）"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_1 = {
    Text = "死亡抵抗 +16.8%"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_2 = {
    Text = "装备者对生命大于 75% 的敌人造成的伤害必定暴击。"
  },
  TrinketSuitEffect_18351_Name = {
    Text = "36室之环"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_1 = {
    Text = "狂气回充等级 +2.4"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 队伍唯一>。银钥能量上限及钥令消耗银钥能量 +200，装备者狂气爆发的暴击率、暴击伤害、护盾、回复生命提高 30%。"
  },
  TrinketSuitEffect_18352_Name = {
    Text = "扭曲双子·白"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_1 = {
    Text = "死亡抵抗 +16.8%"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_2 = {
    Text = "偶数回合开始后，将一张附加<NothingnessIconKeywords:虚无>和<DepleteIconKeywords:消耗>的装备者的「防御」加入手牌。"
  },
  TrinketSuitEffect_18353_Name = {
    Text = "猩红之拥"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_1 = {
    Text = "暴击率 +4.8%"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_2 = {
    Text = "装备者造成伤害时获得 35 点银钥能量，若造成暴击伤害，改为获得 70 点银钥能量，每回合最多触发 3 次。"
  },
  TrinketSuitEffect_18354_Name = {
    Text = "标准密契SR"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_1 = {
    Text = "死亡抵抗 +16.8%"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_2 = {
    Text = "装备者造成的伤害、治疗、护盾提高 15%。"
  },
  TrinketSuitEffect_18355_Name = {
    Text = "无垢启示录"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_1 = {
    Text = "银钥充能等级 +7.2"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 队伍唯一>：释放钥令后，回复等同于装备者体质 12% 的生命，效果随损失生命比例提高，至多提高为装备者体质 24% 的生命。"
  },
  TrinketSuitEffect_18356_Name = {Text = "荒原狼"},
  TrinketSuitEffect_18356_SuitEffectDesc_1 = {
    Text = "伤害强效 +4.8%"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_2 = {
    Text = "装备者造成的基础伤害提高 20％，造成的<IntoxicationIconKeywords:中毒>和<RetaliateIconKeywords:反击>提高 10%。"
  },
  TrinketSuitEffect_18357_Name = {
    Text = "远方的欢宴"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_1 = {
    Text = "黑印掉落 +3.6%"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_2 = {
    Text = "探索开始时，获得 10 黑印。装备者「防御」造成护盾提高 60%。"
  },
  TrinketSuitEffect_18358_Name = {
    Text = "扭曲双子·黑"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_1 = {
    Text = "暴击率 +4.8%"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_2 = {
    Text = "奇数回合开始后，将一张附加<NothingnessIconKeywords:虚无>和<DepleteIconKeywords:消耗>的装备者的「打击」加入手牌。"
  },
  TrinketSuitEffect_18359_Name = {
    Text = "少女之蛹"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_1 = {
    Text = "暴击率 +7.2%"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 队伍唯一>：装备者每回合首次消耗胚胎后，每拥有 1 条触腕获得 8% 临时暴击伤害，最大 80%。"
  },
  TrinketSuitEffect_18360_Name = {
    Text = "埋骨地絮语"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_1 = {
    Text = "死亡抵抗 +16.8%"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_2 = {
    Text = "关卡开始时<DeathResistanceIconKeywords:死亡抵抗>提高 25%。触发死亡抵抗后，装备者获得 50 点狂气。"
  },
  TrinketSuitEffect_99234_Name = {Text = "腐殖质"},
  TrinketSuitEffect_99234_SuitEffectDesc_1 = {
    Text = "临时文本"
  },
  TrinketSuitEffect_99234_SuitEffectDesc_2 = {
    Text = "临时文本"
  },
  TrinketSuitEffect_99235_Name = {Text = "飞升"},
  TrinketSuitEffect_99235_SuitEffectDesc_1 = {
    Text = "临时文本"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_2 = {
    Text = "临时文本"
  },
  TrinketSuitEffect_99236_Name = {
    Text = "斯提克斯"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_1 = {
    Text = "临时文本"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_2 = {
    Text = "临时文本"
  }
})
return Text_TrinketSuitEffect
