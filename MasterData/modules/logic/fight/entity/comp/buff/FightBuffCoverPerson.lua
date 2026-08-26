-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffCoverPerson.lua

module("modules.logic.fight.entity.comp.buff.FightBuffCoverPerson", package.seeall)

local FightBuffCoverPerson = class("FightBuffCoverPerson")
local CardLvCostCelebrityCharm = {
	2,
	3,
	5,
	10
}

function FightBuffCoverPerson:onBuffStart(entity, buffMO)
	self.entity = entity
	self.buffMO = buffMO
	self._celebrityCharm = self:_calcCelebrityCharm()
	self._useCelebrityCharm = 0

	FightController.instance:registerCallback(FightEvent.AddPlayOperationData, self._onAddPlayOperationData, self)
	FightController.instance:registerCallback(FightEvent.OnResetCard, self._onResetCard, self)
	FightController.instance:registerCallback(FightEvent.RespBeginRound, self._respBeginRound, self)
	FightController.instance:registerCallback(FightEvent.StageChanged, self.onStageChange, self)
end

function FightBuffCoverPerson:_removeEvents()
	FightController.instance:unregisterCallback(FightEvent.AddPlayOperationData, self._onAddPlayOperationData, self)
	FightController.instance:unregisterCallback(FightEvent.OnResetCard, self._onResetCard, self)
	FightController.instance:unregisterCallback(FightEvent.RespBeginRound, self._respBeginRound, self)
	FightController.instance:unregisterCallback(FightEvent.StageChanged, self.onStageChange, self)
end

function FightBuffCoverPerson:_onAddPlayOperationData(fightBeginRoundOp)
	if fightBeginRoundOp.operType ~= FightEnum.CardOpType.PlayCard then
		return
	end

	if fightBeginRoundOp.belongToEntityId ~= self.entity.id then
		return
	end

	local skillId = fightBeginRoundOp.skillId

	if not self.entity:getMO():getSkillLv(skillId) then
		local skillLv = 1
		local needCelebrityCharm = CardLvCostCelebrityCharm[skillLv]

		if needCelebrityCharm + self._useCelebrityCharm <= self._celebrityCharm then
			self._useCelebrityCharm = self._useCelebrityCharm + needCelebrityCharm

			fightBeginRoundOp:copyCard()
		end
	end
end

function FightBuffCoverPerson:_onResetCard()
	self._useCelebrityCharm = 0
end

function FightBuffCoverPerson:_respBeginRound()
	self._useCelebrityCharm = 0
end

function FightBuffCoverPerson:onStageChange(stage)
	if stage == FightStageMgr.StageType.Operate then
		self._useCelebrityCharm = 0
		self._celebrityCharm = self:_calcCelebrityCharm()
	end
end

function FightBuffCoverPerson:onBuffEnd()
	self:_removeEvents()
end

function FightBuffCoverPerson:reset()
	self:_removeEvents()
end

function FightBuffCoverPerson:dispose()
	self:_removeEvents()
end

function FightBuffCoverPerson:_calcCelebrityCharm()
	local count = 0

	for _, buffMO in pairs(self.entity:getMO():getBuffDic()) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]
		local buffTypeCO = buffCO and lua_skill_bufftype.configDict[buffCO.typeId]

		if buffTypeCO.id == FightEnum.BuffTypeId_CelebrityCharm then
			count = count + 1
		end
	end

	return count
end

return FightBuffCoverPerson
