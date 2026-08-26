-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/skill/MaLiAnNaActiveSkill.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaActiveSkill", package.seeall)

local MaLiAnNaActiveSkill = class("MaLiAnNaActiveSkill", MaLiAnNaSkillBase)

function MaLiAnNaActiveSkill:init(id, configId)
	self._config = Activity201MaLiAnNaConfig.instance:getActiveSkillConfig(configId)

	MaLiAnNaActiveSkill.super.init(self, id, configId)

	self._cdTime = 0
	self._skillParams = {}
	self._skillParamCount = 0

	local skillActionType = self:getSkillActionType()

	if skillActionType == Activity201MaLiAnNaEnum.SkillAction.addSlotSolider or skillActionType == Activity201MaLiAnNaEnum.SkillAction.pauseSlotGenerateSolider or skillActionType == Activity201MaLiAnNaEnum.SkillAction.removeSlotSolider then
		self._skillParamCount = 1
	end

	if skillActionType == Activity201MaLiAnNaEnum.SkillAction.moveSlotSolider then
		self._skillParamCount = 2
	end

	self._skillType = Activity201MaLiAnNaEnum.SkillType.active
end

function MaLiAnNaActiveSkill:addParams(slotId)
	if self:paramIsFull() then
		return true
	end

	if slotId == nil then
		return false
	end

	local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId)

	if slot == nil then
		return false
	end

	if self:getSkillNeedSlotCamp() == slot:getSlotCamp() then
		self._skillParams[#self._skillParams + 1] = slotId

		return true
	end

	return false
end

function MaLiAnNaActiveSkill:getSkillNeedSlotCamp()
	local skillActionType = self:getSkillActionType()

	if skillActionType == Activity201MaLiAnNaEnum.SkillAction.addSlotSolider then
		return Activity201MaLiAnNaEnum.CampType.Player
	end

	if skillActionType == Activity201MaLiAnNaEnum.SkillAction.pauseSlotGenerateSolider then
		return Activity201MaLiAnNaEnum.CampType.Enemy
	end

	if skillActionType == Activity201MaLiAnNaEnum.SkillAction.removeSlotSolider then
		return Activity201MaLiAnNaEnum.CampType.Enemy
	end

	if skillActionType == Activity201MaLiAnNaEnum.SkillAction.moveSlotSolider then
		return Activity201MaLiAnNaEnum.CampType.Player
	end

	return Activity201MaLiAnNaEnum.CampType.Player
end

function MaLiAnNaActiveSkill:clearParams()
	tabletool.clear(self._skillParams)
end

function MaLiAnNaActiveSkill:paramIsFull()
	return #self._skillParams == self._skillParamCount
end

function MaLiAnNaActiveSkill:execute()
	if self:isInCD() then
		return
	end

	Activity201MaLiAnNaGameController.instance:addAction(self:getEffect(), self._skillParams)

	self._cdTime = self._config.coolDown

	local slot1 = self._skillParams[1]
	local slot2 = self._skillParams[2]

	if slot1 then
		Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.ShowShowVX, slot1, self:getSkillActionType())
	end

	if slot2 then
		Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.ShowShowVX, slot2, self:getSkillActionType(), 1)
	end

	self:clearParams()
end

function MaLiAnNaActiveSkill:isInCD()
	return self._cdTime > 0
end

function MaLiAnNaActiveSkill:getCDPercent()
	return self._cdTime / self._config.coolDown
end

function MaLiAnNaActiveSkill:destroy()
	self._config = nil
end

return MaLiAnNaActiveSkill
