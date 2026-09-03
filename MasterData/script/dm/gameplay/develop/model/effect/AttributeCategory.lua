-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/AttributeCategory.lua

AttributeCategory = AttributeCategory or {}
GameEnvType = {
	kElite = "ELITE",
	kStagePractice = "STAGEPRACTICE",
	KSceneAll = "SCENE_ALL",
	kKof = "KOF",
	kTower = "TOWER",
	kCrystalStage = "CRYSTALSTAGE",
	kArena = "ARENA",
	kGoldStage = "GOLDSTAGE",
	kMap = "MAP",
	kAll = "ALL",
	kExpStage = "EXPSTAGE"
}
DevelopRoleType = {
	kHero = "hero",
	kPlayer = "player",
	kMaster = "master"
}
RangeTargetType = {
	kAll = "ALL",
	kMASTER = "MASTER",
	kHERO = "HERO"
}
AttrSystemName = {
	kMasterGeneral = "主角__光环",
	kMasterTime = "主角__计时BUFF",
	kHeroSoul = "英雄__战魂",
	kMasterReforge = "主角__重铸",
	kMasterGallay = "主角__好感度",
	kHeroBLegend = "英雄__相册-传说",
	kMasterBuilding = "主角__城建",
	kMasterGallayALL = "主角__好感度通用",
	kMasterEmblem = "主角__徽章",
	kHeroEquip = "英雄__装备",
	kMasterSkill = "主角__技能",
	kHeroSkill = "英雄__技能",
	kHeroEquipSkill = "英雄__装备技能",
	kHeroRelation = "英雄__羁绊",
	kHeroBase = "英雄__基础",
	kHeroAdvance = "英雄__里属性",
	kMasterStarPoint = "主角__小星级",
	kHeroStar = "英雄__星级",
	kMasterLeadStage = "主角__源阶",
	kHeroLove = "英雄__好感度",
	kMasterBase = "主角__基础",
	kHeroBuilding = "英雄__城建"
}
AttrBaseType = {
	DEF = 3,
	HP = 2,
	ATK = 1
}
AttrPercentageType = {
	DEF_RATE = "DEF",
	ATK_RATE = "ATK",
	HP_RATE = "HP"
}
AttrRateFactors = {
	EFFECTRATE = 29,
	ABSORPTION = 18,
	UNHURTRATE = 17,
	DEFRATE = 9,
	UNDEADRATE = 26,
	REFLECTION = 19,
	DMGRATE = 38,
	COST = 4,
	DMGRATEDEF = 39,
	HURTRATE = 16,
	BLOCKRATE = 13,
	UNCRITRATE = 11,
	EFFECTSTRG = 27,
	SKILLRATE = 40,
	ATK_RATE = 188,
	UNBLOCKRATE = 14,
	HP_RATE = 189,
	DEF_RATE = 190,
	UNEFFECTRATE = 28,
	BECUREDRATE = 25,
	BLOCKSTRG = 15,
	CRITSTRG = 12,
	ATKWEAKEN = 24,
	ATKRATE = 8,
	DEFWEAKEN = 23,
	CRITRATE = 10
}
AttOrder = {
	EFFECTRATE = 31,
	HP = 3,
	UNHURTRATE = 17,
	CRITRATE = 10,
	ABSORPTION = 18,
	ATKWEAKEN = 24,
	BECUREDRATE = 25,
	HP_RATE = 6,
	CTRLRATE = 21,
	DEF = 2,
	BLOCKRATE = 13,
	UNCRITRATE = 11,
	EFFECTSTRG = 29,
	CURERATE = 20,
	ATK_RATE = 5,
	UNBLOCKRATE = 14,
	COUNTERRATE = 28,
	SKILLRATE = 32,
	UNDEADRATE = 26,
	ATK = 1,
	UNEFFECTRATE = 30,
	REFLECTION = 19,
	BLOCKSTRG = 15,
	CRITSTRG = 12,
	DEF_RATE = 7,
	HURTRATE = 16,
	UNCTRLRATE = 22,
	ATKRATE = 8,
	DEFWEAKEN = 23,
	DEFRATE = 9
}
AttrName = {
	EFFECTRATE = "EffectRate",
	DEFRATE = "DefRate",
	UNHURTRATE = "UnhurtRate",
	BECUREDRATE = "BecuredRate",
	UNDEADRATE = "UndeadRate",
	ABSORPTION = "Absorption",
	SKILLRATE = "SkillRate",
	COST = "Cost",
	CTRLRATE = "CtrlRate",
	HURTRATE = "HurtRate",
	BLOCKRATE = "BlockRate",
	UNCRITRATE = "UncritRate",
	EFFECTSTRG = "EffectStrg",
	CURERATE = "CureRate",
	UNBLOCKRATE = "UnblockRate",
	UNEFFECTRATE = "UneffectRate",
	REFLECTION = "Reflection",
	BLOCKSTRG = "BlockStrg",
	CRITSTRG = "CritStrg",
	ATKWEAKEN = "AtkWeaken",
	UNCTRLRATE = "UnctrlRate",
	ATKRATE = "AtkRate",
	DEFWEAKEN = "DefWeaken",
	CRITRATE = "CritRate"
}
AttrElementType = {
	c = 3,
	a = 1,
	d = 4,
	f = 5,
	b = 2
}

function AttributeCategory:isAttrBaseType(attrType)
	return AttrBaseType[attrType] or AttrPercentageType[attrType]
end

function AttributeCategory:isAttRateType(attrType)
	return AttrRateFactors[attrType]
end

function AttributeCategory:isAttrPercentageType(attrType)
	return AttrPercentageType[attrType]
end

function AttributeCategory:changeBaseAttrType(attrType)
	return (AttrPercentageType[attrType] or nil) and (AttrPercentageType[attrType] or attrType)
end

function AttributeCategory:getBaseAttrElement()
	return {
		e = 0,
		a = 0,
		c = 0,
		d = 0,
		f = 0,
		b = 0
	}
end

function AttributeCategory:getRateAttrElement()
	return {
		b = 0,
		a = 0
	}
end

function AttributeCategory:isAttPercentType(attrType)
	return AttrRateFactors[attrType] or AttrPercentageType[attrType]
end

function AttributeCategory:getAttName(attrType)
	local attrArr = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_SkillAttrName", "content")

	return Strings:get(attrArr[attrType])
end

function AttributeCategory:getAttNameAttend(attrType)
	local attrTypeDesc = {
		EFFECTRATE = "%",
		UNEFFECTRATE = "%",
		SPEED = "",
		DEF = "",
		ATKWEAKEN = "%",
		HP = "",
		["TODPS@HURT"] = "%",
		HP_RATE = "%",
		REFLECTION = "%",
		HURTRATE = "%",
		BLOCKRATE = "%",
		["TOTANK@HURT"] = "%",
		ATK = "",
		["TODPS@UNHURT"] = "%",
		ABSORPTION = "%",
		CRITSTRG = "%",
		UNDEADRATE = "%",
		ATKRATE = "%",
		DEFWEAKEN = "%",
		CRITRATE = "%",
		UNHURTRATE = "%",
		["TOGANK@HURT"] = "%",
		["TOGANK@UNHURT"] = "%",
		UNCRITRATE = "%",
		EFFECTSTRG = "%",
		ATK_RATE = "%",
		UNBLOCKRATE = "%",
		BECUREDRATE = "%",
		BLOCKSTRG = "%",
		DEF_RATE = "%",
		["TOTANK@UNHURT"] = "%",
		SKILLRATE = "%",
		DEFRATE = "%"
	}

	return attrTypeDesc[attrType]
end

AttName = {
	ATK = Strings:get("HERO_ATTACK"),
	DEF = Strings:get("HERO_DEFENCE"),
	HP = Strings:get("HERO_HP"),
	ATK_RATE = Strings:get("HERO_ATTACK"),
	HP_RATE = Strings:get("HERO_DEFENCE"),
	DEF_RATE = Strings:get("HERO_HP"),
	ATKRATE = Strings:get("HERO_ATTACK"),
	DEFRATE = Strings:get("HERO_DEFENCE"),
	CRITRATE = Strings:get("HERO_HP")
}

function AttributeCategory:getAttName1(attrType)
	return AttName[attrType]
end
