-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/constdef/ConstString.lua

module("logiccommon.common.constdef.ConstString", package.seeall)

local ConstString = {}

ConstString.NotRelease = lang("tips_not_release")
ConstString.JobStr = lang("job")
ConstString.AttrStr = lang("attr")
ConstString.TagStr = lang("tag")
ConstString.SortStr = lang("sort")
ConstString.Lv = {
	[1] = "Lv. %d",
	[2] = lang("lv_number")
}
ConstString.Attr = {
	[GameEnum.AttrType.AttackPhysical] = lang("attr_attack_physical"),
	[GameEnum.AttrType.DefensePhysical] = lang("attr_defense_physical"),
	[GameEnum.AttrType.AttackSuper] = lang("attr_attack_ult"),
	[GameEnum.AttrType.DefenseSuper] = lang("attr_defense_ult"),
	[GameEnum.AttrType.AttackMagic] = lang("attr_attack_magic"),
	[GameEnum.AttrType.DefenseMagic] = lang("attr_defense_magic"),
	[GameEnum.AttrType.Hp] = lang("attr_hp"),
	[GameEnum.AttrType.Speed] = lang("attr_speed"),
	[GameEnum.AttrType.HitRate] = lang("命中率"),
	[GameEnum.AttrType.DodgeRate] = lang("闪避率"),
	[GameEnum.AttrType.StrikeRate] = lang("破击率"),
	[GameEnum.AttrType.BlockRate] = lang("格挡率"),
	[GameEnum.AttrType.CriticalRate] = lang("暴击率"),
	[GameEnum.AttrType.AntiCriticalRate] = lang("防暴率"),
	[GameEnum.AttrType.Attack] = lang("攻击"),
	[GameEnum.AttrType.OriginalVigour] = lang("起始气势"),
	[GameEnum.AttrType.HpRate] = lang("生命率"),
	[GameEnum.AttrType.AttackPhysicalRate] = lang("物攻率"),
	[GameEnum.AttrType.DefensePhysicalRate] = lang("物防率"),
	[GameEnum.AttrType.AttackMagicRate] = lang("魔攻率"),
	[GameEnum.AttrType.DefenseMagicRate] = lang("魔防率"),
	[GameEnum.AttrType.AttackSuperRate] = lang("超攻率"),
	[GameEnum.AttrType.DefenseSuperRate] = lang("超防率"),
	[GameEnum.AttrType.SpeedRate] = lang("速度率"),
	[GameEnum.AttrType.AttackRate] = lang("攻击率")
}
ConstString.TaskColor = {
	[GameEnum.TaskType.Main] = "ed963a",
	[GameEnum.TaskType.Branch] = "f5d10b",
	[GameEnum.TaskType.Guide] = "b470fa",
	[GameEnum.TaskType.Daily] = "1cc2ff",
	[GameEnum.TaskType.Festival] = "ed963a",
	[GameEnum.TaskType.ColorfulEggs] = "b470fa"
}
ConstString.Task = {
	[GameEnum.TaskType.Main] = lang("task_main_shortcut"),
	[GameEnum.TaskType.Branch] = lang("task_branch_shortcut"),
	[GameEnum.TaskType.Guide] = lang("task_guide_shortcut"),
	[GameEnum.TaskType.Daily] = lang("task_daily_shortcut"),
	[GameEnum.TaskType.Festival] = lang("task_festival_shortcut"),
	[GameEnum.TaskType.ColorfulEggs] = "彩蛋"
}
ConstString.SkillType = {
	[GameEnum.SkillRaceType.Passive] = lang("skill_passive_shortcut"),
	[GameEnum.SkillRaceType.Normal] = lang("skill_normal_shortcut"),
	[GameEnum.SkillRaceType.Ult] = lang("skill_ult_shortcut"),
	[GameEnum.SkillRaceType.Hero] = lang("skill_hero_shortcut"),
	[GameEnum.SkillRaceType.Summon] = lang("skill_summon_shortcut"),
	[GameEnum.SkillRaceType.Combine] = lang("合体技"),
	[GameEnum.SkillRaceType.Contract] = lang("契约技"),
	[GameEnum.SkillRaceType.Domain] = lang("领域技"),
	[GameEnum.SkillRaceType.PsychicSkill] = lang("通灵技"),
	[GameEnum.SkillRaceType.PsychicSkillNormal] = lang("通灵-普攻"),
	[GameEnum.SkillRaceType.PsychicSkillUtl] = lang("通灵-超杀"),
	[GameEnum.SkillRaceType.Element] = lang("元素技"),
	[GameEnum.SkillRaceType.AwakenSkill] = lang("觉醒技"),
	[GameEnum.SkillRaceType.ShenYaoSkill] = lang("神曜技"),
	[GameEnum.SkillRaceType.JuanYouSkill] = lang("眷佑技"),
	[GameEnum.SkillRaceType.ShenShiSkill] = lang("神使技"),
	[GameEnum.SkillRaceType.BenyuanSkill] = lang("本源技"),
	[GameEnum.SkillRaceType.TianjueSkill] = lang("天觉技"),
	[GameEnum.SkillRaceType.SourceTraceSkill] = lang("源起技"),
	[GameEnum.SkillRaceType.GenesisSkill] = lang("创世技"),
	[GameEnum.SkillRaceType.BookSpiritSkill] = lang("吞噬技"),
	[GameEnum.SkillRaceType.SpiritInvocationSkill] = lang("唤灵技"),
	[GameEnum.SkillRaceTypeExt.Normal_Phy] = lang("attr_attack_physical"),
	[GameEnum.SkillRaceTypeExt.Normal_Mag] = lang("attr_attack_magic")
}
ConstString.BestPosition = lang("tips_best_position")
ConstString.Race = {
	[GameEnum.RaceType.Cao] = lang("race_cao"),
	[GameEnum.RaceType.Shui] = lang("race_shui"),
	[GameEnum.RaceType.Huo] = lang("race_huo"),
	[GameEnum.RaceType.Guang] = lang("race_guang"),
	[GameEnum.RaceType.An] = lang("race_an"),
	[GameEnum.RaceType.Kong] = lang("race_kong"),
	[GameEnum.RaceType.Chuang] = lang("race_chuang")
}
ConstString.Tag = {
	[GameEnum.Tag.Normal] = lang("tag_normal"),
	[GameEnum.Tag.Special] = lang("tag_special")
}
ConstString.HandbookPetEvolutionTag = {
	[EvolveEnum.EvolutionTier.Initial] = lang("初始"),
	[EvolveEnum.EvolutionTier.DivineEvolve] = lang("神启"),
	[EvolveEnum.EvolutionTier.Divine] = lang("神曜"),
	[EvolveEnum.EvolutionTier.SourceTrace] = lang("源起")
}
ConstString.Team = lang("tips_team")
ConstString.NumberCN = {
	lang("number_1"),
	lang("number_2"),
	lang("number_3"),
	lang("number_4"),
	(lang("number_5"))
}
ConstString.GeniusName = {
	[GameEnum.GeniusType.yiwushichu] = lang("genius_yiwushichu"),
	[GameEnum.GeniusType.shifenchangjian] = lang("genius_shifenchangjian"),
	[GameEnum.GeniusType.bailitiaoyi] = lang("genius_bailitiaoyi"),
	[GameEnum.GeniusType.qianzainanfeng] = lang("genius_qianzainanfeng"),
	[GameEnum.GeniusType.wanzhongzhumu] = lang("genius_wanzhongzhumu"),
	[GameEnum.GeniusType.wangzhewudi] = lang("genius_wangzhewudi")
}
ConstString.Channel = {
	[GameEnum.ChatChannel.Zone] = lang("channel_zone"),
	[GameEnum.ChatChannel.World] = lang("channel_world"),
	[GameEnum.ChatChannel.League] = lang("channel_league"),
	[GameEnum.ChatChannel.Nearby] = lang("channel_nearby"),
	[GameEnum.ChatChannel.System] = lang("channel_system"),
	[GameEnum.ChatChannel.All] = lang("全服频道"),
	[GameEnum.ChatChannel.LanternFestival] = lang("猜谜")
}
ConstString.ChannelShortcut = {
	[GameEnum.ChatChannel.Zone] = lang("channel_zone_shortcut"),
	[GameEnum.ChatChannel.World] = lang("channel_world_shortcut"),
	[GameEnum.ChatChannel.League] = lang("channel_league_shortcut"),
	[GameEnum.ChatChannel.Nearby] = lang("答题"),
	[GameEnum.ChatChannel.System] = lang("channel_system_shortcut"),
	[GameEnum.ChatChannel.Private] = lang("好友"),
	[GameEnum.ChatChannel.Share] = lang("分享"),
	[GameEnum.ChatChannel.All] = lang("全服"),
	[GameEnum.ChatChannel.GoddessContest] = lang("女神"),
	[GameEnum.ChatChannel.Team] = lang("队伍"),
	[GameEnum.ChatChannel.ElementSpark] = lang("势力"),
	[GameEnum.ChatChannel.Camp] = lang("阵营"),
	[GameEnum.ChatChannel.Help] = lang("求助"),
	[GameEnum.ChatChannel.LanternFestival] = lang("猜谜")
}
ConstString.Quality = {
	lang("白色"),
	lang("绿色"),
	lang("蓝色"),
	lang("紫色"),
	lang("橙色"),
	(lang("红色"))
}
ConstString.StarGodPlusQualityDesc = {
	lang("绿色"),
	lang("蓝色"),
	lang("紫色"),
	lang("金色"),
	lang("红色"),
	(lang("红色"))
}
ConstString.EquipmentQualityDesc = {
	lang("白色"),
	lang("绿色"),
	lang("蓝色"),
	lang("蓝色+1"),
	lang("紫色"),
	lang("紫色+1"),
	lang("紫色+2"),
	lang("橙色"),
	lang("橙色+1"),
	lang("橙色+2"),
	(lang("橙色+3"))
}
ConstString.AtkTypeByIdx = {
	[GameEnum.CareerType.JiSu] = lang("物"),
	[GameEnum.CareerType.Mofa] = lang("魔"),
	[GameEnum.CareerType.LiZhua] = lang("物"),
	[GameEnum.CareerType.Dun] = lang("物"),
	[GameEnum.CareerType.Pingheng] = lang("物"),
	[GameEnum.CareerType.ZhiLiao] = lang("魔")
}
ConstString.BestPosition = {
	[GameEnum.FRONT_PET] = lang("前排"),
	[GameEnum.BACK_PET] = lang("后排")
}
ConstString.BestPositionColor = {
	[GameEnum.FRONT_PET] = "#df4dff",
	[GameEnum.BACK_PET] = "#6666cc"
}
ConstString.AwakenCardTagTitle = {
	[GameEnum.AwakenCardTag.SameCao] = lang("草属性"),
	[GameEnum.AwakenCardTag.SameShui] = lang("水属性"),
	[GameEnum.AwakenCardTag.SameHuo] = lang("火属性"),
	[GameEnum.AwakenCardTag.SameGuang] = lang("光属性"),
	[GameEnum.AwakenCardTag.SameAn] = lang("暗属性"),
	[GameEnum.AwakenCardTag.SameRaceIdSSR] = lang("同名"),
	[GameEnum.AwakenCardTag.SameRaceIdUR] = lang("同名")
}
ConstString.PetAwakeUpTitle = {
	[GameEnum.PetAwakenType.UpStar] = lang("升星"),
	[GameEnum.PetAwakenType.UpSun] = lang("进阶"),
	[GameEnum.PetAwakenType.UpRare] = lang("品质突破"),
	[GameEnum.PetAwakenType.UpRareUtl] = lang("神启试炼"),
	[GameEnum.PetAwakenType.MaxLv] = lang("满觉醒")
}
ConstString.PetAwakenTypeText = {
	[GameEnum.PetAwakenType.UpStar] = lang("升星"),
	[GameEnum.PetAwakenType.UpRare] = lang("升星"),
	[GameEnum.PetAwakenType.UpRareUtl] = lang("升星"),
	[GameEnum.PetAwakenType.UpSun] = lang("升星"),
	[GameEnum.PetAwakenType.MaxLv] = lang("升星")
}
ConstString.PetRareLang = {
	[GameEnum.PetRare.N] = lang("初代"),
	[GameEnum.PetRare.R] = lang("幻兽"),
	[GameEnum.PetRare.SR] = lang("超能"),
	[GameEnum.PetRare.SSR] = lang("传说")
}
ConstString.QualityToName = {
	[0] = lang("普通"),
	lang("普通"),
	lang("经典"),
	lang("良品"),
	lang("史诗"),
	lang("精品"),
	lang("性转"),
	lang("臻品"),
	lang("圣品"),
	lang("绝品"),
	(lang("神话"))
}
ConstString.SkinGenderName = {
	[GameEnum.SkinGenderFemale] = lang("女"),
	[GameEnum.SkinGenderMale] = lang("男")
}
ConstString.JobIdxToStr = {
	[GameEnum.CareerType.JiSu] = lang("疾速"),
	[GameEnum.CareerType.Mofa] = lang("魔法"),
	[GameEnum.CareerType.LiZhua] = lang("利爪"),
	[GameEnum.CareerType.Dun] = lang("肉盾"),
	[GameEnum.CareerType.Pingheng] = lang("平衡"),
	[GameEnum.CareerType.ZhiLiao] = lang("治疗"),
	[GameEnum.CareerType.Yingxiong] = lang("英雄"),
	[GameEnum.CareerType.Zhaohuanshi] = lang("召唤师"),
	[GameEnum.CareerType.Mowangkexing] = lang("魔王克星"),
	[GameEnum.CareerType.Yuanguchong] = lang("远古宠"),
	[GameEnum.CareerType.Yuanshou] = lang("源兽"),
	[GameEnum.CareerType.Mowang] = lang("魔王"),
	[GameEnum.CareerType.Shenqi] = lang("神启"),
	[GameEnum.CareerType.Psychic] = lang("通灵师"),
	[GameEnum.CareerType.Element] = lang("元素师"),
	[GameEnum.CareerType.ShenYao] = lang("神曜"),
	[GameEnum.CareerType.Tianjue] = lang("天觉者"),
	[GameEnum.CareerType.SourceTrace] = lang("源起")
}
ConstString.RaceIdToTxt = {
	[GameEnum.RaceType.Cao] = lang("草"),
	[GameEnum.RaceType.Shui] = lang("水"),
	[GameEnum.RaceType.Huo] = lang("火"),
	[GameEnum.RaceType.Guang] = lang("光"),
	[GameEnum.RaceType.An] = lang("暗"),
	[GameEnum.RaceType.Kong] = lang("空"),
	[GameEnum.RaceType.Chuang] = lang("创"),
	[GameEnum.RaceType.Yuan] = lang("源"),
	[GameEnum.RaceType.ShenCao] = lang("神草"),
	[GameEnum.RaceType.ShenShui] = lang("神水"),
	[GameEnum.RaceType.ShenHuo] = lang("神火"),
	[GameEnum.RaceType.ShenGuang] = lang("神光"),
	[GameEnum.RaceType.ShenAn] = lang("神暗"),
	[GameEnum.RaceType.ShenKong] = lang("神空"),
	[GameEnum.RaceType.ShenChuang] = lang("神创"),
	[GameEnum.RaceType.ShenYuan] = lang("神源")
}
ConstString.RaceIdToTxt = {
	[GameEnum.RaceType.Cao] = lang("草"),
	[GameEnum.RaceType.Shui] = lang("水"),
	[GameEnum.RaceType.Huo] = lang("火"),
	[GameEnum.RaceType.Guang] = lang("光"),
	[GameEnum.RaceType.An] = lang("暗"),
	[GameEnum.RaceType.Kong] = lang("空"),
	[GameEnum.RaceType.Chuang] = lang("创"),
	[GameEnum.RaceType.Yuan] = lang("源"),
	[GameEnum.RaceType.ShenCao] = lang("神草"),
	[GameEnum.RaceType.ShenShui] = lang("神水"),
	[GameEnum.RaceType.ShenHuo] = lang("神火"),
	[GameEnum.RaceType.ShenGuang] = lang("神光"),
	[GameEnum.RaceType.ShenAn] = lang("神暗"),
	[GameEnum.RaceType.ShenKong] = lang("神空"),
	[GameEnum.RaceType.ShenChuang] = lang("神创"),
	[GameEnum.RaceType.ShenYuan] = lang("神源")
}
ConstString.ChineseNumber = {
	[0] = lang("零"),
	lang("一"),
	lang("二"),
	lang("三"),
	lang("四"),
	lang("五"),
	lang("六"),
	lang("七"),
	lang("八"),
	lang("九"),
	lang("十"),
	[100] = lang("百")
}
ConstString.ElementSparkTagTypeName = {
	[GameEnum.ElementSparkTagType.Attack] = lang("攻"),
	[GameEnum.ElementSparkTagType.Defend] = lang("防"),
	[GameEnum.ElementSparkTagType.Retreat] = lang("撤")
}
ConstString.TimeTxtFormat = {
	Y_M_D_H_M_1 = "%Y.%m.%d 5:00",
	Y_M_D_1 = "%Y-%m.%d",
	M_D_H_M_S = "%m.%d %H:%M:%S",
	Y_M = "%Y%m",
	Y_M_D_H_M_S = "%Y.%m.%d %H:%M:%S",
	CN_Y_M = "%Y年%m月",
	CN_H_M_S = "%H时%M分%S秒",
	CN_M_D = "%m月%d日",
	Y_M_D_H_M_S_1 = "%Y-%m-%d %H:%M:%S",
	M_D = "%m.%d",
	H = "%H",
	CN_M_D_H = "%m月%d日%H时",
	CN_Y_M_D_1 = "%y年%m月%d日",
	Y_M_D = "%Y.%m.%d",
	CN_M_D_H_M = "%m月%d日 %H:%M",
	t = "%m/%d %H:00",
	M_D_H_M = "%m.%d %H:%M",
	CN_M_D_1 = "%m月%d号",
	CN_M_D_H_M_S = "%m月%d日 %H:%M:%S",
	a = "%Y/%m/%d",
	Y_M_D_H_M = "%Y.%m.%d %H:%M",
	Y_M_D_3 = "%Y%m%d",
	H_M = "%H:%M",
	b = "%Y/%m/%d/%h/%m",
	u = "%m/%d 05:00",
	H_M_S = "%H:%M:%S",
	n = "%Y/%m/%d %H:%M:%S",
	Y_M_D_2 = "%Y-%m-%d",
	CN_Y_M_D_H = "%Y年%m月%d日%H点",
	CN_Y_M_D = "%Y年%m月%d日"
}

function ConstString.langAttr(key)
	if key == "物攻率" or key == "魔攻率" or key == "超攻率" or key == "物防率" or key == "魔防率" or key == "超防率" or key == "生命率" then
		return string.gsub(key, "率", "")
	end

	return key
end

ConstString.HolyStripeAttr = {
	[GameEnum.HolyStripeAttrType.AttackPhysical] = lang("attr_attack_physical"),
	[GameEnum.HolyStripeAttrType.DefensePhysical] = lang("attr_defense_physical"),
	[GameEnum.HolyStripeAttrType.AttackSuper] = lang("attr_attack_ult"),
	[GameEnum.HolyStripeAttrType.DefenseSuper] = lang("attr_defense_ult"),
	[GameEnum.HolyStripeAttrType.AttackMagic] = lang("attr_attack_magic"),
	[GameEnum.HolyStripeAttrType.DefenseMagic] = lang("attr_defense_magic"),
	[GameEnum.HolyStripeAttrType.Hp] = lang("attr_hp"),
	[GameEnum.HolyStripeAttrType.Speed] = lang("attr_speed"),
	[GameEnum.HolyStripeAttrType.HitRate] = lang("命中率"),
	[GameEnum.HolyStripeAttrType.DodgeRate] = lang("闪避率"),
	[GameEnum.HolyStripeAttrType.StrikeRate] = lang("破击率"),
	[GameEnum.HolyStripeAttrType.BlockRate] = lang("格挡率"),
	[GameEnum.HolyStripeAttrType.CriticalRate] = lang("暴击率"),
	[GameEnum.HolyStripeAttrType.AntiCriticalRate] = lang("防暴率"),
	[GameEnum.HolyStripeAttrType.Attack] = lang("攻击"),
	[GameEnum.HolyStripeAttrType.OriginalVigour] = lang("起始气势"),
	[GameEnum.HolyStripeAttrType.HpRate] = lang("生命率"),
	[GameEnum.HolyStripeAttrType.AttackPhysicalRate] = lang("物攻率"),
	[GameEnum.HolyStripeAttrType.DefensePhysicalRate] = lang("物防率"),
	[GameEnum.HolyStripeAttrType.AttackMagicRate] = lang("魔攻率"),
	[GameEnum.HolyStripeAttrType.DefenseMagicRate] = lang("魔防率"),
	[GameEnum.HolyStripeAttrType.AttackSuperRate] = lang("超攻率"),
	[GameEnum.HolyStripeAttrType.DefenseSuperRate] = lang("超防率"),
	[GameEnum.HolyStripeAttrType.SpeedRate] = lang("速度率"),
	[GameEnum.HolyStripeAttrType.AttackRate] = lang("攻击率"),
	[GameEnum.HolyStripeAttrType.CriticalDamage] = lang("暴击伤害"),
	[GameEnum.HolyStripeAttrType.AOEDamage] = lang("群攻伤害"),
	[GameEnum.HolyStripeAttrType.RestrainAddDamge] = lang("克制增伤"),
	[GameEnum.HolyStripeAttrType.IncidentalDamge] = lang("附带伤害"),
	[GameEnum.HolyStripeAttrType.PhysicalDamageDeduce] = lang("物伤减免"),
	[GameEnum.HolyStripeAttrType.MagicDamageDeduce] = lang("魔伤减免"),
	[GameEnum.HolyStripeAttrType.AOEDamageDeduce] = lang("群攻减伤"),
	[GameEnum.HolyStripeAttrType.ReboundDamage] = lang("反弹伤害"),
	[GameEnum.HolyStripeAttrType.NormalAttackDamge] = lang("普攻增伤"),
	[GameEnum.HolyStripeAttrType.SuperAttackDamge] = lang("超杀增伤"),
	[GameEnum.HolyStripeAttrType.NormalAttackReduce] = lang("普攻减伤"),
	[GameEnum.HolyStripeAttrType.SuperAttackReduce] = lang("超杀减伤")
}
ConstString.AssignmentConditionText = {
	[GameEnum.AssignmentConditionType.Num] = lang("数量"),
	[GameEnum.AssignmentConditionType.Rarity] = lang("稀有度"),
	[GameEnum.AssignmentConditionType.Awaken] = lang("tip_awake"),
	[GameEnum.AssignmentConditionType.Attr] = lang("attr"),
	[GameEnum.AssignmentConditionType.Career] = lang("job"),
	[GameEnum.AssignmentConditionType.TotalLevel] = "总等级",
	[GameEnum.AssignmentConditionType.TotalAwaken] = "总觉醒",
	[GameEnum.AssignmentConditionType.Level] = lang("tip_level")
}
ConstString.TaskPeriodRefreshText = {
	[GameEnum.PeriodRefreshType.None] = lang("无"),
	[GameEnum.PeriodRefreshType.Daily] = lang("每日任务"),
	[GameEnum.PeriodRefreshType.Weekly] = lang("每周任务"),
	[GameEnum.PeriodRefreshType.Monthly] = lang("每月任务"),
	[GameEnum.PeriodRefreshType.AllTime] = lang("活动任务")
}
ConstString.PeriodRefreshText = {
	[GameEnum.PeriodRefreshType.Daily] = lang("每日"),
	[GameEnum.PeriodRefreshType.Weekly] = lang("每周"),
	[GameEnum.PeriodRefreshType.Monthly] = lang("每月"),
	[GameEnum.PeriodRefreshType.AllTime] = lang("永久")
}

return ConstString
