-- chunkname: @modules/logic/fight/model/data/FightUnnamedDataMgr.lua

module("modules.logic.fight.model.data.FightUnnamedDataMgr", package.seeall)

local FightUnnamedDataMgr = class("FightUnnamedDataMgr")

function FightUnnamedDataMgr:init()
	self.unnamedAddTypeDict = {}
	self.unnamedSpecialSkillPlayedData = {
		{},
		{},
		{},
		{}
	}
	self.unnamedSpecialSkillClientPlayedData = {
		{},
		{},
		{},
		{}
	}
	self.playedAnimDict = {}
end

function FightUnnamedDataMgr:clearUnnamedSpecialSkillPlayedData()
	for _, list in ipairs(self.unnamedSpecialSkillPlayedData) do
		tabletool.clear(list)
	end

	for _, list in ipairs(self.unnamedSpecialSkillClientPlayedData) do
		tabletool.clear(list)
	end

	tabletool.clear(self.playedAnimDict)
end

function FightUnnamedDataMgr:onCancelOperation()
	tabletool.clear(self.unnamedAddTypeDict)
end

function FightUnnamedDataMgr:onStageChanged()
	tabletool.clear(self.unnamedAddTypeDict)
end

function FightUnnamedDataMgr:setPlayedData(type, index)
	local typeList = self.unnamedSpecialSkillPlayedData[type]

	if not typeList then
		typeList = {}
		self.unnamedSpecialSkillPlayedData[type] = typeList
	end

	typeList[index] = true
end

function FightUnnamedDataMgr:setClientPlayedData(type, index)
	local typeList = self.unnamedSpecialSkillClientPlayedData[type]

	if not typeList then
		typeList = {}
		self.unnamedSpecialSkillClientPlayedData[type] = typeList
	end

	typeList[index] = true
end

function FightUnnamedDataMgr:checkPlayedData(type, index)
	if not self.unnamedSpecialSkillPlayedData then
		return false
	end

	local typeList = self.unnamedSpecialSkillPlayedData[type]

	if not typeList then
		return false
	end

	return typeList[index]
end

function FightUnnamedDataMgr:checkClientPlayedData(type, index)
	if not self.unnamedSpecialSkillClientPlayedData then
		return false
	end

	local typeList = self.unnamedSpecialSkillClientPlayedData[type]

	if not typeList then
		return false
	end

	return typeList[index]
end

function FightUnnamedDataMgr:onPlayHandCard(fightBeginRoundOp)
	if not fightBeginRoundOp then
		return
	end

	local opList = FightDataHelper.operationDataMgr:getOpList()

	for _, op in ipairs(opList) do
		local op1 = op

		if op1:isPlayCard() and op1.cardData:checkIsUnnamedCard() then
			return
		end
	end

	local skillId = fightBeginRoundOp.skillId
	local skillCo = lua_skill.configDict[skillId]

	if not skillCo then
		return
	end

	local addType = self:getUnnamedAddType(skillCo)

	if addType ~= 0 then
		self:addUnnamedOneType(addType)
	end
end

function FightUnnamedDataMgr:addUnnamedOneType(addType)
	self.unnamedAddTypeDict = self.unnamedAddTypeDict or {}
	self.unnamedAddTypeDict[addType] = self.unnamedAddTypeDict[addType] or 0
	self.unnamedAddTypeDict[addType] = self.unnamedAddTypeDict[addType] + 1

	FightController.instance:dispatchEvent(FightEvent.OnClientUnnamedTypeChange)
end

function FightUnnamedDataMgr:getUnnamedTypeValue(addType)
	return (self.unnamedAddTypeDict or nil) and (self.unnamedAddTypeDict[addType] or 0)
end

local UnnamedAddTypeDict = {
	[FightEnum.EffectTag.RealAttack] = {
		[FightEnum.LogicTargetType.Single] = 1,
		[FightEnum.LogicTargetType.Multiple] = 2
	},
	[FightEnum.EffectTag.SpiritAttack] = {
		[FightEnum.LogicTargetType.Single] = 1,
		[FightEnum.LogicTargetType.Multiple] = 2
	},
	[FightEnum.EffectTag.Debuff] = {
		[FightEnum.LogicTargetType.Single] = 1,
		[FightEnum.LogicTargetType.Multiple] = 2
	},
	[FightEnum.EffectTag.Buff] = {
		[FightEnum.LogicTargetType.None] = 3,
		[FightEnum.LogicTargetType.Single] = 3,
		[FightEnum.LogicTargetType.Multiple] = 3
	},
	[FightEnum.EffectTag.CounterSpell] = {
		[FightEnum.LogicTargetType.None] = 3,
		[FightEnum.LogicTargetType.Single] = 3,
		[FightEnum.LogicTargetType.Multiple] = 3
	},
	[FightEnum.EffectTag.Heal] = {
		[FightEnum.LogicTargetType.None] = 4,
		[FightEnum.LogicTargetType.Single] = 4,
		[FightEnum.LogicTargetType.Multiple] = 4
	},
	[FightEnum.EffectTag.Channel] = {
		[FightEnum.LogicTargetType.None] = 4,
		[FightEnum.LogicTargetType.Single] = 4,
		[FightEnum.LogicTargetType.Multiple] = 4
	}
}

function FightUnnamedDataMgr:getUnnamedAddType(skillCo)
	if not skillCo then
		return 0
	end

	local effectTag = skillCo.effectTag
	local logicTargetDict = UnnamedAddTypeDict[effectTag]

	if not logicTargetDict then
		return 0
	end

	local logicTargetType = FightHelper.getLogicTargetType(skillCo)
	local addType = logicTargetDict[logicTargetType]

	return addType or 0
end

function FightUnnamedDataMgr:setPlayedAnim(animName)
	self.playedAnimDict[animName] = true
end

function FightUnnamedDataMgr:checkPlayedAnim(animName)
	return self.playedAnimDict[animName]
end

return FightUnnamedDataMgr
