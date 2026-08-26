-- chunkname: @modules/logic/fight/view/FightViewDeviceAreaCardItem.lua

module("modules.logic.fight.view.FightViewDeviceAreaCardItem", package.seeall)

local FightViewDeviceAreaCardItem = class("FightViewDeviceAreaCardItem", UserDataDispose)

FightViewDeviceAreaCardItem.DeviceOffsetY = -67

function FightViewDeviceAreaCardItem:isDeviceAreaCard()
	return true
end

function FightViewDeviceAreaCardItem:init(parentGo)
	self:__onInit()

	self.parentGo = parentGo
	self.parentTr = parentGo:GetComponent(gohelper.Type_RectTransform)
	self.go = gohelper.create2d(self.parentGo, "inner")
	self.tr = self.go.transform
	self.deviceArea = FightDeviceArea.Create(self.go, FightDeviceArea.ViewType.WaitArea)

	self.deviceArea:setLoadDoneCallback(self.onDeviceAreaLoadDone, self)
	self.deviceArea:setDeviceCardItemCls(FightDeviceWaitAreaCardItem)
	self.deviceArea:startLoad()
end

function FightViewDeviceAreaCardItem:onDeviceAreaLoadDone()
	self.deviceArea:setLineActive(false)
	self.deviceArea:setDeviceAreaAnchor(0, FightViewDeviceAreaCardItem.DeviceOffsetY)
	self:addEvents()
end

function FightViewDeviceAreaCardItem:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_ScanSkill, self.onDeviceScanSkill, self)
	self.addEventCb(self, FightController.instance, FightEvent.AfterSkillEffect, self.onAfterSkillEffect, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_SingleSkillDone, self.onSingleSkillDone, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_SkillStopStatusChange, self.onDeviceSkillStopStatusChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_RestartDeviceChange, self.onDeviceRestartDeviceChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChanged, self)
end

function FightViewDeviceAreaCardItem:onStageChanged(curStage)
	if not self.deviceArea then
		return
	end

	if curStage ~= FightStageMgr.StageType.Play then
		return
	end

	self.deviceArea:refreshStopEffect()
end

function FightViewDeviceAreaCardItem:onDeviceSkillStopStatusChange(targetId, skillId)
	if not self.deviceArea then
		return
	end

	self.deviceArea:playStopEffect(targetId, skillId)
end

function FightViewDeviceAreaCardItem:onDeviceRestartDeviceChange(targetUid)
	if not self.deviceArea then
		return
	end

	self.deviceArea:restartDevice(targetUid)
end

function FightViewDeviceAreaCardItem:onSingleSkillDone()
	if not self.deviceArea then
		return
	end

	self.deviceArea:refreshStopEffect()
	self.deviceArea:hideAllDeviceCardSelectFrame()
	self.deviceArea:hideAllInnerSelectFrame()
end

function FightViewDeviceAreaCardItem:onDeviceScanSkill(success, deviceIndex, innerIndex)
	if not self.deviceArea then
		return
	end

	self.deviceArea:playScanEffect(success, deviceIndex, innerIndex)
end

function FightViewDeviceAreaCardItem:onAfterSkillEffect(fightStepData)
	if not self.deviceArea then
		return
	end

	if fightStepData and fightStepData.custom_deviceDone then
		self.deviceArea:disappearTween()
	end
end

function FightViewDeviceAreaCardItem:refreshUI()
	if self.deviceArea then
		self.deviceArea:refreshUI()
	end
end

function FightViewDeviceAreaCardItem:setActive(active)
	if self.deviceArea then
		self.deviceArea:setActive(active)
	end
end

function FightViewDeviceAreaCardItem:setCanvasAlpha(alpha)
	if self.deviceArea then
		self.deviceArea:setCanvasAlpha(alpha)
	end
end

function FightViewDeviceAreaCardItem:setCardInfo(cardInfo)
	self._cardInfoMO = cardInfo
end

function FightViewDeviceAreaCardItem:resetWidth()
	local width = FightDeviceHelper.getDeviceAreaTotalWidth()

	recthelper.setWidth(self.parentTr, width)
end

function FightViewDeviceAreaCardItem:getPowerWorldPos(careerId)
	if self.deviceArea then
		return self.deviceArea:getPowerWorldPos(careerId)
	end
end

function FightViewDeviceAreaCardItem:releaseEffectFlow()
	if self._cardDisplayFlow then
		self._cardDisplayFlow:stop()

		self._cardDisplayFlow = nil
	end

	if self._cardDisplayEndFlow then
		self._cardDisplayEndFlow:stop()

		self._cardDisplayEndFlow = nil
	end
end

function FightViewDeviceAreaCardItem:playUsedCardDisplay(tipsGO)
	if not self.go.activeInHierarchy then
		return
	end

	if not self._cardDisplayFlow then
		self._cardDisplayFlow = FlowSequence.New()

		self._cardDisplayFlow:addWork(FightDeviceCardDisplayEffect.New())
	end

	local context = self:getUserDataTb_()

	context.skillTipsGO = tipsGO
	context.skillItemGO = self.go
	context.cardItem = self

	self._cardDisplayFlow:start(context)
end

function FightViewDeviceAreaCardItem:playUsedCardFinish(tipsGO, waitingAreaGO)
	if not self.go.activeInHierarchy then
		return
	end

	if not self._cardDisplayEndFlow then
		self._cardDisplayEndFlow = FlowSequence.New()

		self._cardDisplayEndFlow:addWork(FightDeviceCardDisplayEndEffect.New())
	end

	local context = self:getUserDataTb_()

	context.skillTipsGO = tipsGO
	context.waitingAreaGO = waitingAreaGO

	self._cardDisplayEndFlow:start(context)
end

function FightViewDeviceAreaCardItem:emptyFunc()
	return
end

function FightViewDeviceAreaCardItem:dispose()
	if self.deviceArea then
		self.deviceArea:dispose()

		self.deviceArea = nil
	end

	self:__onDispose()
end

local srcIndex = FightViewDeviceAreaCardItem.__index

function FightViewDeviceAreaCardItem.__index(t, key)
	local existAttr = srcIndex[key]

	if existAttr then
		return existAttr
	end

	local func = FightViewCardItem[key]

	if not func then
		return
	end

	if type(func) == "function" then
		logError(string.format("try call FightViewCardItem.%s func, but FightViewDeviceAreaCardItem not had", key))

		return FightViewDeviceAreaCardItem.emptyFunc
	end
end

return FightViewDeviceAreaCardItem
