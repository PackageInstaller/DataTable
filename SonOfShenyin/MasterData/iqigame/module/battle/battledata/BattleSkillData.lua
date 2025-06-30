-- chunkname: @IQIGame\\Module\\Battle\\BattleData\\BattleSkillData.lua

local BattleSkillData = {
	disPlace = 0,
	elementType = 0,
	level = 0,
	isSeal = false,
	isPassive = false,
	apCost = 0,
	valid = true,
	disableManual = false,
	selectCamp = 0,
	skillCid = 0,
	coolDown = 0,
	usedLimit = 0,
	manualSkill = false,
	isUltimate = false,
	configID = 0,
	isNeedSelectTarget = false,
	usedCount = 0,
	skillType = 0,
	canSelectGrid = false,
	energyCost = 0,
	strengthLv = 1,
	purifyLv = 1
}

function BattleSkillData.New(skillCid)
	local obj = Clone(BattleSkillData)

	obj:__Init(skillCid)

	return obj
end

function BattleSkillData:__Init(skillCid)
	self.valid = true
	self.skillCid = skillCid
	self.configID = skillCid

	local skillConfig = CfgSkillTable[skillCid]

	self.skillType = skillConfig.SkillType
	self.isUltimate = skillConfig.SkillType == Constant.SkillType.TYPE_ULTIMATE
	self.isPassive = skillConfig.ReleaseType == 2
	self.manualSkill = skillConfig.ManualSkill

	local skillDetailConfig = CfgSkillDetailTable[skillConfig.SkillDetail]

	self.isNeedSelectTarget = not skillDetailConfig.NotSelectTarget
	self.elementType = skillDetailConfig.Element
	self.sustainCD = skillDetailConfig.CoolDown
	self.targetTypeID = 0
	self.selectCamp = 1
	self.canSelectGrid = false
	self.coolDown = 0
	self.energyCost = 0
	self.apCost = 0
	self.level = 1
	self.purifyLv = 1
	self.strengthLv = 1
	self.isSeal = false
	self.usedCount = 0
	self.disableManual = skillConfig.IsNotShow == 1

	if skillDetailConfig.DisPlace ~= nil then
		self.disPlace = skillDetailConfig.DisPlace
	end
end

function BattleSkillData:GetCfgSkillDetailData()
	local skillConfig = CfgSkillTable[self.configID]

	return CfgSkillDetailTable[skillConfig.SkillDetail]
end

function BattleSkillData:UpdateCoolDown(coolDown)
	self.coolDown = coolDown == nil and 0 or coolDown
end

function BattleSkillData:UpdateEnergyCost(cost)
	self.energyCost = cost == nil and 0 or cost
end

function BattleSkillData:UpdateAPCost(cost)
	self.apCost = cost == nil and 0 or cost
end

function BattleSkillData:UpdateLevel(level)
	self.level = level
end

function BattleSkillData:UpdatePurifyLv(level)
	self.purifyLv = level
end

function BattleSkillData:UpdateStrengthLv(level)
	self.strengthLv = level
end

function BattleSkillData:UpdateUserLimit(limit)
	self.usedLimit = limit
end

function BattleSkillData:UpdateSKillUsedCount(cnt)
	self.usedCount = cnt
end

function BattleSkillData:UpdateSkillSealState(isSeal)
	self.isSeal = isSeal
end

function BattleSkillData:UpdateSkillTargetTypeID(targetTypeID)
	self.targetTypeID = targetTypeID
	self.searchTargetData = CfgSearchTargetTable[self.targetTypeID]
	self.selectCamp = self.searchTargetData.SelectCamp
	self.canSelectGrid = self.searchTargetData.SearchScope ~= 0
end

function BattleSkillData:TargetIsSelf()
	return self.selectCamp == 3
end

function BattleSkillData:TargetIsFriendly()
	if self:TargetIsSelf() then
		return true
	end

	return self.selectCamp == 2
end

return BattleSkillData
