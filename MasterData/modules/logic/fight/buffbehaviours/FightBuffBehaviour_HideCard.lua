-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviour_HideCard.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_HideCard", package.seeall)

local FightBuffBehaviour_HideCard = class("FightBuffBehaviour_HideCard", FightBuffBehaviourBase)

function FightBuffBehaviour_HideCard:init(viewGo, viewContainer, co)
	FightBuffBehaviour_HideCard.super.init(self, viewGo, viewContainer, co)

	local paramList = FightStrUtil.instance:getSplitCache(self.co.param, "#")

	self.smallSkillIcon = paramList[1]
	self.bigSkillIcon = paramList[2]
end

function FightBuffBehaviour_HideCard:onAddBuff(entityId, buffId, buffMo)
	FightModel.instance:setSkillIcon(self.smallSkillIcon, self.bigSkillIcon)
	FightModel.instance:setIsHideCard(true)
	FightController.instance:dispatchEvent(FightEvent.OnAddHideCardBuff)
	AudioMgr.instance:trigger(310005)
end

function FightBuffBehaviour_HideCard:onRemoveBuff(entityId, buffId, buffMo)
	FightModel.instance:setSkillIcon(nil, nil)
	FightModel.instance:setIsHideCard(false)
	FightController.instance:dispatchEvent(FightEvent.OnRemoveHideCardBuff)
end

return FightBuffBehaviour_HideCard
