-- chunkname: @modules/logic/fight/view/FightExPointSynchronizationView.lua

module("modules.logic.fight.view.FightExPointSynchronizationView", package.seeall)

local FightExPointSynchronizationView = class("FightExPointSynchronizationView", FightBaseView)

function FightExPointSynchronizationView:onConstructor(entityData)
	self.entityData = entityData
	self.entityId = entityData.id

	self:com_registMsg(FightMsgId.GetExPointView, self.onGetExPointView)
end

function FightExPointSynchronizationView:onInitView()
	recthelper.setAnchorX(self.viewGO.transform, 30)

	self.preImg = gohelper.findChildImage(self.viewGO, "root/go_pre")
	self.preImg.fillAmount = 0
	self.energyImg = gohelper.findChildImage(self.viewGO, "root/go_energy")
	self.animator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function FightExPointSynchronizationView:addEvents()
	self:com_registMsg(FightMsgId.ShowAiJiAoExpointEffectBeforeUniqueSkill, self.onShowAiJiAoExpointEffectBeforeUniqueSkill)
	self:com_registFightEvent(FightEvent.OnExpointMaxAdd, self.onExPointMaxAdd)
	self:com_registFightEvent(FightEvent.OnExPointChange, self.onExPointChange)
	self:com_registFightEvent(FightEvent.UpdateExPoint, self.onUpdateExPoint)
	self:com_registFightEvent(FightEvent.CoverPerformanceEntityData, self.onCoverPerformanceEntityData)

	self.tweenComp = self:addComponent(FightTweenComponent)
end

function FightExPointSynchronizationView:removeEvents()
	return
end

function FightExPointSynchronizationView:onCoverPerformanceEntityData(entityId)
	if entityId ~= self.entityId then
		return
	end

	self:refreshSlider()
end

function FightExPointSynchronizationView:onGetExPointView(entityId)
	if entityId == self.entityId then
		self.com_replyMsg(self, FightMsgId.GetExPointView, self)
	end
end

function FightExPointSynchronizationView:onOpen()
	self:refreshSlider()
end

function FightExPointSynchronizationView:onExPointChange(entityId, oldNum, newNum)
	if entityId ~= self.entityId then
		return
	end

	local cur, max = self:refreshSlider()

	if oldNum < newNum and cur < max then
		self:playAni("add")
		AudioMgr.instance:trigger(20305031)
	end
end

function FightExPointSynchronizationView:onUpdateExPoint(entityId, oldNum, newNum)
	if entityId ~= self.entityId then
		return
	end

	self:refreshSlider()
end

function FightExPointSynchronizationView:onExPointMaxAdd(entityId, offsetNum)
	if entityId ~= self.entityId then
		return
	end

	self:refreshSlider()
end

function FightExPointSynchronizationView:refreshSlider()
	local max = self.entityData:getMaxExPoint()
	local cur = self.entityData.exPoint
	local fillAmount = cur / max

	self.tweenComp:DOFillAmount(self.energyImg, fillAmount, 0.2)

	if max <= cur then
		if self.curAniName ~= "max" then
			self:playAni("max")
		end
	else
		self:playAni("idle")
	end

	return cur, max
end

function FightExPointSynchronizationView:onShowAiJiAoExpointEffectBeforeUniqueSkill(entityId)
	if entityId ~= self.entityId then
		return
	end

	self.curAniName = "dazhao"

	FightMsgMgr.replyMsg(FightMsgId.ShowAiJiAoExpointEffectBeforeUniqueSkill, self.viewGO)
end

function FightExPointSynchronizationView:playAni(name)
	self.curAniName = name

	self.animator:Play(name, 0, 0)
end

function FightExPointSynchronizationView:onClose()
	return
end

function FightExPointSynchronizationView:onDestroyView()
	return
end

return FightExPointSynchronizationView
