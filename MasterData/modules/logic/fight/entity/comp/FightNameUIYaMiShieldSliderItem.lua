-- chunkname: @modules/logic/fight/entity/comp/FightNameUIYaMiShieldSliderItem.lua

module("modules.logic.fight.entity.comp.FightNameUIYaMiShieldSliderItem", package.seeall)

local FightNameUIYaMiShieldSliderItem = class("FightNameUIYaMiShieldSliderItem", FightBaseClass)

function FightNameUIYaMiShieldSliderItem:onConstructor(viewGO, entityData, buffData, actInfo)
	self.viewGO = viewGO
	self.entityData = entityData
	self.buffData = buffData
	self.actInfo = actInfo
	self.slider = gohelper.findChildImage(viewGO, "")
	self.animator = gohelper.onceAddComponent(viewGO, gohelper.Type_Animator)

	self:com_registFightEvent(FightEvent.OnHpChange, self.onHpChange)
	self:com_registMsg(FightMsgId.OnRemoveYaMiShield, self.onRemoveYaMiShield)
	self:com_registMsg(FightMsgId.UpdateYaMiSliderItem, self.onUpdateYaMiSliderItem)
	self:refreshUI()
end

function FightNameUIYaMiShieldSliderItem:onUpdateYaMiSliderItem(entityId)
	if self.entityData.id ~= entityId then
		return
	end

	self:refreshUI()
end

function FightNameUIYaMiShieldSliderItem:refreshUI()
	self.slider.fillAmount = FightMsgMgr.sendMsg(FightMsgId.GetHpFillAmount, self.entityData.id) or 0
end

function FightNameUIYaMiShieldSliderItem:onHpChange(entity)
	if entity.id ~= self.entityData.id then
		return
	end

	self:refreshUI()
end

function FightNameUIYaMiShieldSliderItem:onRemoveYaMiShield(buffData)
	if self.buffData.uid ~= buffData.uid then
		return
	end

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkPlayAnimator, self.animator.gameObject, "close")
	flow:registFinishCallback(self.onRemoveFinish, self)
	flow:start()
end

function FightNameUIYaMiShieldSliderItem:onRemoveFinish()
	self:disposeSelf()
end

function FightNameUIYaMiShieldSliderItem:onDestructor()
	gohelper.destroy(self.viewGO)
end

return FightNameUIYaMiShieldSliderItem
