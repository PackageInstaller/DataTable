-- chunkname: @modules/logic/fight/view/FightDeviceArea.lua

module("modules.logic.fight.view.FightDeviceArea", package.seeall)

local FightDeviceArea = class("FightDeviceArea", BaseView)
local DT = 0.033
local frameCount = 5

FightDeviceArea.ViewType = {
	WaitArea = 3,
	FightView = 1,
	FightSwitchView = 2
}

function FightDeviceArea.Create(go, viewType)
	local deviceArea = FightDeviceArea.New()

	deviceArea:init(go, viewType)

	return deviceArea
end

function FightDeviceArea:init(go, viewType)
	self:__onInit()

	self.goParent = go
	self.viewType = viewType
	self._active = true
end

function FightDeviceArea:startLoad()
	if self.loader then
		return
	end

	self.loader = MultiAbLoader.New()

	self.loader:addPath("ui/viewres/fight/fight3_7deviceview.prefab")
	self.loader:startLoad(self.onLoadResDone, self)
end

function FightDeviceArea:setDeviceCardItemCls(deviceCardItemCls)
	self.deviceCardItemCls = deviceCardItemCls
end

function FightDeviceArea:getDeviceCardItemCls()
	return self.deviceCardItemCls or FightDevicePlayCardItem
end

function FightDeviceArea:setLoadDoneCallback(callback, callbackObj)
	self.loadDoneCallback = callback
	self.loadDoneCallbackObj = callbackObj
end

function FightDeviceArea:doLoadDoneCallback()
	local callback = self.loadDoneCallback
	local callbackObj = self.loadDoneCallbackObj

	self.loadDoneCallback = nil
	self.loadDoneCallbackObj = nil

	if callback then
		self.loadDoneCallback(callbackObj)
	end
end

function FightDeviceArea:getCardItem(uid)
	for _, cardItem in ipairs(self.deviceItemList) do
		if cardItem:getUid() == uid then
			return cardItem
		end
	end
end

function FightDeviceArea:getGoDeviceArea()
	return self.goDeviceArea
end

function FightDeviceArea:setActive(active)
	self._active = active

	if not self.goDeviceArea then
		return
	end

	gohelper.setActive(self.goDeviceArea, active)
end

function FightDeviceArea:setDeviceAreaAnchor(anchorX, anchorY)
	if not self.rectTrDeviceArea then
		return
	end

	recthelper.setAnchor(self.rectTrDeviceArea, anchorX, anchorY)
end

function FightDeviceArea:setDeviceAreaScale(scale, tween)
	if not self.rectTrDeviceArea then
		return
	end

	self:clearScaleTween()

	if tween then
		self.scaleTweenId = ZProj.TweenHelper.DOScale(self.rectTrDeviceArea, scale, scale, scale, 0.1)
	else
		transformhelper.setLocalScale(self.rectTrDeviceArea, scale, scale, scale)
	end
end

function FightDeviceArea:clearScaleTween()
	if self.scaleTweenId then
		ZProj.TweenHelper.KillById(self.scaleTweenId)

		self.scaleTweenId = nil
	end
end

function FightDeviceArea:onLoadResDone()
	local assetItem = self.loader:getFirstAssetItem()

	self.goDeviceArea = gohelper.clone(assetItem:GetResource(), self.goParent)
	self.canvasGroupDevice = gohelper.onceAddComponent(self.goDeviceArea, gohelper.Type_CanvasGroup)
	self.rectTrPlayCards = gohelper.findChildComponent(self.goDeviceArea, "playcards", gohelper.Type_RectTransform)
	self.goCardLayout = gohelper.findChild(self.goDeviceArea, "playcards/card_layout")
	self.rectPowerLayout = gohelper.findChildComponent(self.goDeviceArea, "energy", gohelper.Type_RectTransform)
	self.goPowerItem = gohelper.findChild(self.goDeviceArea, "energy/has/energyItem")

	gohelper.setActive(self.goPowerItem, false)

	self.rectTrDeviceArea = self.goDeviceArea:GetComponent(gohelper.Type_RectTransform)
	self.goLine = gohelper.findChild(self.goDeviceArea, "playcards/go_line")
	self.loaded = true
	self.deviceItemList = {}
	self.powerItemList = {}

	self:setActive(self._active)
	self:refreshUI()
	self:addEvents()
	self:doLoadDoneCallback()
end

function FightDeviceArea:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_SwitchGroup, self.onSwitchDeviceGroup, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_PowerChange, self.onDevicePowerChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_BeforeFly, self.onDeviceBeforeFly, self)
	self.addEventCb(self, FightController.instance, FightEvent.RefreshDeviceArea, self.onRefreshDeviceArea, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnCreateDeviceArea, self.onCreateDeviceArea, self)
end

function FightDeviceArea:onCreateDeviceArea()
	self:refreshUI()
end

function FightDeviceArea:onRefreshDeviceArea()
	self:refreshUI()
end

function FightDeviceArea:onDeviceBeforeFly()
	self:setLineActive(false)
end

function FightDeviceArea:refreshStopEffect()
	if not self.loaded then
		return
	end

	local count = FightDeviceHelper.getDeviceAreaCount()

	if count < 1 then
		return
	end

	for _, deviceItem in ipairs(self.deviceItemList) do
		deviceItem:refreshStopEffect()
	end
end

function FightDeviceArea:refreshUI()
	if not self.loaded then
		return
	end

	local count = FightDeviceHelper.getDeviceAreaCount()

	if count < 1 then
		self:setActive(false)

		return
	end

	self:refreshDeviceList()
	self:refreshPowerList()
end

function FightDeviceArea:refreshDeviceList()
	self:resetDeviceWidth()

	local deviceArea = FightDataHelper.getDeviceArea()
	local deviceList = deviceArea:getClientDeviceList()

	for index, deviceInfo in pairs(deviceList) do
		local item = self.deviceItemList[index]

		if not item then
			local cls = self:getDeviceCardItemCls()

			item = cls.Create(self.goCardLayout)

			table.insert(self.deviceItemList, item)
		end

		item:setName("deviceCardItem" .. index)
		item:setSelectFrameActive(false)
		item:show()
		item:refreshUI(index, deviceInfo)
	end

	for i = #deviceList + 1, #self.deviceItemList do
		self.deviceItemList[i]:hide()
	end
end

function FightDeviceArea:getChangeValue(powerId, changeArray)
	if not changeArray then
		return
	end

	for _, array in ipairs(changeArray) do
		if powerId == array[1] then
			return array[2]
		end
	end
end

function FightDeviceArea:refreshPowerList(changeStr, changeType)
	local deviceArea = FightDataHelper.getDeviceArea()
	local powerList = deviceArea:getShowPowerList()
	local changeArray = FightStrUtil.instance:getSplitString2Cache(changeStr, true)
	local count = 0

	for _, power in ipairs(powerList) do
		count = count + 1

		local item = self.powerItemList[count]

		item = item or self:createPowerItem()

		gohelper.setActive(item.go, true)

		local url = FightDeviceHelper.getCareerImage(power.id)

		UISpriteSetMgr.instance:setFightSprite(item.imageIcon, url)

		item.powerNum.text = power.power
		item.powerId = power.id

		local clientPower = deviceArea:getClientPowerValue(power.id)

		if clientPower > 0 and self.viewType == FightDeviceArea.ViewType.FightView then
			item.powerNumAnimator:Play("loop")
		else
			item.powerNumAnimator:Play("idle")
		end

		self:playPowerItemChangeAnim(item, changeArray, changeType)
	end

	for i = count + 1, #self.powerItemList do
		gohelper.setActive(self.powerItemList[i].go, false)
	end

	recthelper.setWidth(self.rectPowerLayout, FightDeviceHelper.getDeviceAreaPowerTotalWidth(count))
end

function FightDeviceArea:playPowerItemChangeAnim(powerItem, changeArray, changeType)
	local powerId = powerItem.powerId
	local changeValue = self:getChangeValue(powerId, changeArray)

	if not changeValue or changeValue == 0 then
		return
	end

	if changeType == FightEnum.DevicePowerChangeType.TriggerDeviceSkill then
		powerItem.animator:Play("expend", 0, 0)
		AudioMgr.instance:trigger(370806)
	elseif changeType == FightEnum.DevicePowerChangeType.DevicePowerCardAdd then
		if changeValue > 0 then
			powerItem.animator:Play("success", 0, 0)
			AudioMgr.instance:trigger(370804)
		end
	elseif changeType == FightEnum.DevicePowerChangeType.SpecialChange then
		local animName = changeValue > 0 and "success" or "fail"

		powerItem.animator:Play(animName, 0, 0)
		AudioMgr.instance:trigger(changeValue > 0 and 370804 or 370805)
	end
end

function FightDeviceArea:setDeviceCardItemActive(entityUid)
	for _, deviceItem in ipairs(self.deviceItemList) do
		deviceItem:setSelectFrameActive(deviceItem:getUid() == entityUid)
	end
end

function FightDeviceArea:hideAllDeviceCardSelectFrame()
	for _, deviceItem in ipairs(self.deviceItemList) do
		deviceItem:setSelectFrameActive(false)
	end
end

function FightDeviceArea:createPowerItem()
	local item = self:getUserDataTb_()

	item.go = gohelper.cloneInPlace(self.goPowerItem)
	item.imageIcon = gohelper.findChildImage(item.go, "#image_numCareer")
	item.imageTr = item.imageIcon.transform
	item.powerNum = gohelper.findChildText(item.go, "#txt_cost")
	item.powerNumAnimator = item.powerNum:GetComponent(gohelper.Type_Animator)
	item.animator = item.go:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(item.goAddEffect, false)
	gohelper.setActive(item.goReduceEffect, false)
	table.insert(self.powerItemList, item)

	return item
end

function FightDeviceArea:getPowerWorldPos(careerId)
	for _, powerItem in ipairs(self.powerItemList) do
		if powerItem.powerId == careerId then
			return powerItem.imageTr.position
		end
	end
end

function FightDeviceArea:onSwitchDeviceGroup(uid, index)
	for _, cardItem in ipairs(self.deviceItemList) do
		if cardItem:getUid() == uid then
			cardItem:updateData()
		end
	end

	self:resetDeviceWidth()
	self:updateItemPos()
end

function FightDeviceArea:updateItemPos()
	for _, cardItem in ipairs(self.deviceItemList) do
		cardItem:refreshAnchor()
	end
end

function FightDeviceArea:resetDeviceWidth()
	recthelper.setWidth(self.rectTrPlayCards, FightDeviceHelper.getDeviceAreaTotalWidth())
end

function FightDeviceArea:onDevicePowerChange(changeStr, changeType)
	self:refreshPowerList(changeStr, changeType)
end

function FightDeviceArea:clearActiveTween()
	if self.activeTweenId then
		ZProj.TweenHelper.KillById(self.activeTweenId)

		self.activeTweenId = nil
	end
end

function FightDeviceArea:disappearTween()
	self:clearActiveTween()

	local dt = DT / FightModel.instance:getUISpeed()

	self.activeTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(self.goDeviceArea, 1, 0, dt * frameCount)
end

function FightDeviceArea:appearTween()
	self:clearActiveTween()

	local dt = DT / FightModel.instance:getUISpeed()

	self.activeTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(self.goDeviceArea, 0, 1, dt * frameCount)
end

function FightDeviceArea:setCanvasAlpha(alpha)
	if not self.loaded then
		return
	end

	self:clearActiveTween()

	self.canvasGroupDevice.alpha = alpha
end

function FightDeviceArea:hideAllInnerSelectFrame()
	for _, cardItem in ipairs(self.deviceItemList) do
		cardItem:hideAllInnerSelectFrame()
	end
end

function FightDeviceArea:playScanEffect(success, deviceIndex, innerIndex)
	local cardItem = self.deviceItemList[deviceIndex]

	if not cardItem then
		return
	end

	if success then
		cardItem:showInnerSelectFrame(innerIndex)
	else
		cardItem:hideAllInnerSelectFrame(innerIndex)
	end

	cardItem:playScanEffect(success, innerIndex)
end

function FightDeviceArea:playStopEffect(targetId, skillId)
	for _, cardItem in ipairs(self.deviceItemList) do
		if cardItem:getUid() == targetId then
			cardItem:playStopEffect(skillId)

			return
		end
	end
end

function FightDeviceArea:restartDevice(targetId)
	for _, cardItem in ipairs(self.deviceItemList) do
		if cardItem:getUid() == targetId then
			cardItem:restartDevice()

			return
		end
	end
end

function FightDeviceArea:setLineActive(active)
	gohelper.setActive(self.goLine, active)
end

function FightDeviceArea:dispose()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	if self.deviceItemList then
		for _, deviceItem in ipairs(self.deviceItemList) do
			deviceItem:dispose()
		end

		tabletool.clear(self.deviceItemList)
	end

	self.loadDoneCallback = nil
	self.loadDoneCallbackObj = nil

	self:clearScaleTween()
	self:clearActiveTween()
	self:__onDispose()
end

return FightDeviceArea
