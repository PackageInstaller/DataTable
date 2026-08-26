-- chunkname: @modules/logic/fight/view/FightViewCardItemResistance.lua

module("modules.logic.fight.view.FightViewCardItemResistance", package.seeall)

local FightViewCardItemResistance = class("FightViewCardItemResistance", LuaCompBase)

function FightViewCardItemResistance:ctor()
	return
end

function FightViewCardItemResistance:init(go)
	self.resistanceGo = gohelper.findChild(go, "#go_resistance")
	self.resistanceGoPart = gohelper.findChild(go, "#go_resistancecrash")
	self.rectTr = self.resistanceGo:GetComponent(gohelper.Type_RectTransform)
	self.partRectTr = self.resistanceGoPart:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(self.resistanceGo, false)
	gohelper.setActive(self.resistanceGoPart, false)
end

function FightViewCardItemResistance:addEventListeners()
	self.addEventCb(self, FightController.instance, FightEvent.SelectSkillTarget, self.onSelectSkillTarget, self)
end

function FightViewCardItemResistance:removeEventListeners()
	self.removeEventCb(self, FightController.instance, FightEvent.SelectSkillTarget, self.onSelectSkillTarget, self)
end

function FightViewCardItemResistance:onSelectSkillTarget()
	if not self.cardInfoMO then
		return
	end

	self:updateByCardInfo(self.cardInfoMO)
end

function FightViewCardItemResistance:updateByBeginRoundOp(fightBeginRoundOp)
	if not fightBeginRoundOp then
		return self:hideResistanceGo()
	end

	if not fightBeginRoundOp:isPlayCard() then
		return self:hideResistanceGo()
	end

	local entityId = fightBeginRoundOp.toId

	if not entityId then
		return self:hideResistanceGo()
	end

	local entityMo = FightDataHelper.entityMgr:getById(entityId)

	if not entityMo then
		return self:hideResistanceGo()
	end

	if entityMo.side ~= FightEnum.EntitySide.EnemySide then
		return self:hideResistanceGo()
	end

	return self:refreshResistance(entityMo, fightBeginRoundOp.skillId)
end

function FightViewCardItemResistance:updateByCardInfo(cardInfoMO)
	self.cardInfoMO = cardInfoMO

	if not cardInfoMO then
		return self:hideResistanceGo()
	end

	local stage = FightDataHelper.stageMgr:getCurStage()

	if stage == FightStageMgr.StageType.Play then
		return self:hideResistanceGo()
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return self:hideResistanceGo()
	end

	local selectEntityId = FightDataHelper.operationDataMgr.curSelectEntityId

	if selectEntityId == 0 then
		return self:hideResistanceGo()
	end

	local entityMo = FightDataHelper.entityMgr:getById(selectEntityId)

	if not entityMo then
		return self:hideResistanceGo()
	end

	return self:refreshResistance(entityMo, cardInfoMO.skillId)
end

function FightViewCardItemResistance:updateBySkillDisplayMo(displayMo)
	if not displayMo then
		return self:hideResistanceGo()
	end

	local entityId = displayMo.targetId

	if entityId == 0 then
		return self:hideResistanceGo()
	end

	local entityMo = FightDataHelper.entityMgr:getById(entityId)

	if not entityMo then
		return self:hideResistanceGo()
	end

	return self:refreshResistance(entityMo, displayMo.skillId)
end

FightViewCardItemResistance.AnchorY = {
	BigSkill = -68,
	Normal = -54
}

function FightViewCardItemResistance:refreshResistance(entityMo, skillId)
	local skillCO = lua_skill.configDict[skillId]
	local resistanceTag = skillCO and skillCO.resistancesTag

	if not string.nilorempty(resistanceTag) then
		local resistanceList = FightStrUtil.instance:getSplitCache(resistanceTag, "#")

		if self:checkIsFullResistance(entityMo, resistanceList) then
			self:showFullResistanceTag(skillCO.isBigSkill == 1)
		elseif self:checkIsPartResistance(entityMo, resistanceList) then
			self:showPartResistanceTag(skillCO.isBigSkill == 1)
		else
			self:hideResistanceGo()
		end
	else
		self:hideResistanceGo()
	end
end

function FightViewCardItemResistance:showFullResistanceTag(isBigSkill)
	gohelper.setActive(self.resistanceGo, true)

	if isBigSkill then
		if not FightViewCardItemResistance.AnchorY.BigSkill then
			local anchorY = FightViewCardItemResistance.AnchorY.Normal

			recthelper.setAnchorY(self.rectTr, anchorY)
			FightController.instance:dispatchEvent(FightEvent.TriggerCardShowResistanceTag)
		end
	end
end

function FightViewCardItemResistance:showPartResistanceTag(isBigSkill)
	gohelper.setActive(self.resistanceGoPart, true)

	if isBigSkill then
		if not FightViewCardItemResistance.AnchorY.BigSkill then
			local anchorY = FightViewCardItemResistance.AnchorY.Normal

			recthelper.setAnchorY(self.partRectTr, anchorY)
			FightController.instance:dispatchEvent(FightEvent.TriggerCardShowResistanceTag)
		end
	end
end

function FightViewCardItemResistance:checkIsFullResistance(entityMo, resistanceList)
	for _, resistance in ipairs(resistanceList) do
		if entityMo:isFullResistance(resistance) then
			return true
		end
	end

	return false
end

function FightViewCardItemResistance:checkIsPartResistance(entityMo, resistanceList)
	for _, resistance in ipairs(resistanceList) do
		if entityMo:isPartResistance(resistance) then
			return true
		end
	end

	return false
end

function FightViewCardItemResistance:hideResistanceGo()
	gohelper.setActive(self.resistanceGo, false)
	gohelper.setActive(self.resistanceGoPart, false)
end

return FightViewCardItemResistance
