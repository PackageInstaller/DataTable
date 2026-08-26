-- chunkname: @modules/logic/fight/view/expoint/FightExPointDevicePowerView.lua

module("modules.logic.fight.view.expoint.FightExPointDevicePowerView", package.seeall)

local FightExPointDevicePowerView = class("FightExPointDevicePowerView", FightBaseView)

function FightExPointDevicePowerView:onConstructor(entityMo)
	self.entityMo = entityMo
	self.entityId = entityMo.id
	self.clientAddDevicePower = 0

	self:com_registMsg(FightMsgId.GetExPointView, self.onGetExPointView)
end

function FightExPointDevicePowerView:onInitView()
	recthelper.setAnchorX(self.viewGO.transform, 30)

	local rootTr = gohelper.findChildComponent(self.viewGO, "root", gohelper.Type_RectTransform)

	recthelper.setAnchorY(rootTr, 0)

	self.imageEnergy = gohelper.findChildImage(self.viewGO, "root/go_energy")
	self.imageStoreEnergy = gohelper.findChildImage(self.viewGO, "root/go_store_energy")

	gohelper.setActive(self.imageStoreEnergy.gameObject, false)
end

function FightExPointDevicePowerView:addEvents()
	return
end

function FightExPointDevicePowerView:removeEvents()
	return
end

function FightExPointDevicePowerView:onGetExPointView(entityId)
	if entityId == self.entityId then
		self.com_replyMsg(self, FightMsgId.GetExPointView, self)
	end
end

function FightExPointDevicePowerView:onOpen()
	self.addEventCb(self, FightController.instance, FightEvent.OnExpointMaxAdd, self.refreshDevicePower, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnExPointChange, self.refreshDevicePower, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayHandCard, self.onPlayHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnResetCard, self.onResetCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_StoreExPointChange, self.onDeviceStoreExPointChange, self)
	self:refreshDevicePower()
end

function FightExPointDevicePowerView:onDeviceStoreExPointChange(entityId)
	if entityId ~= self.entityId then
		return
	end

	self:refreshStoreExPoint()
end

function FightExPointDevicePowerView:onExPointMaxAdd(entityId)
	if entityId ~= self.entityId then
		return
	end

	self:refreshDevicePower()
	self:refreshStoreExPoint()
end

function FightExPointDevicePowerView:onStageChange()
	self.clientAddDevicePower = 0

	self:refreshDevicePower()
	self:refreshStoreExPoint()
end

function FightExPointDevicePowerView:onResetCard()
	self.clientAddDevicePower = 0

	self:refreshDevicePower()
	self:refreshStoreExPoint()
end

function FightExPointDevicePowerView:onPlayHandCard(cardMo)
	local curStage = FightDataHelper.stageMgr:getCurStage()

	if curStage ~= FightStageMgr.StageType.Operate then
		return
	end

	if cardMo.uid ~= self.entityId then
		return
	end

	self.clientAddDevicePower = FightDeviceHelper.getSkillIdAddDeviceExPoint(cardMo.skillId)

	self:refreshDevicePower()
end

function FightExPointDevicePowerView:getCurDevicePower()
	return self.entityMo:getExPoint()
end

function FightExPointDevicePowerView:refreshDevicePower()
	local max = self.entityMo:getMaxExPoint()
	local curPower = self:getCurDevicePower()

	curPower = curPower + self.clientAddDevicePower

	local rate = curPower / max

	rate = Mathf.Clamp01(rate)

	self:clearTween()

	self.tweenId = ZProj.TweenHelper.DOFillAmount(self.imageEnergy, rate, 0.3)
end

function FightExPointDevicePowerView:refreshStoreExPoint()
	gohelper.setActive(self.imageStoreEnergy.gameObject, true)

	local max = self.entityMo:getMaxExPoint()
	local storePower = self.entityMo:getStoredDeviceExPoint()
	local rate = storePower / max

	rate = Mathf.Clamp01(rate)

	self:clearStoreTween()

	self.storeTweenId = ZProj.TweenHelper.DOFillAmount(self.imageStoreEnergy, rate, 0.3)
end

function FightExPointDevicePowerView:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function FightExPointDevicePowerView:clearStoreTween()
	if self.storeTweenId then
		ZProj.TweenHelper.KillById(self.storeTweenId)

		self.storeTweenId = nil
	end
end

function FightExPointDevicePowerView:onClose()
	self:clearTween()
	self:clearStoreTween()
end

function FightExPointDevicePowerView:onDestroyView()
	return
end

return FightExPointDevicePowerView
