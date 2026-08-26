-- chunkname: @modules/logic/fight/view/FightDeviceCardItem.lua

module("modules.logic.fight.view.FightDeviceCardItem", package.seeall)

local FightDeviceCardItem = class("FightDeviceCardItem", UserDataDispose)
local CardPath = "ui/viewres/fight/fight3_7devicecarditem.prefab"
local _initTypeId = 0

local function GetCardTypeId()
	_initTypeId = _initTypeId + 1

	return _initTypeId
end

FightDeviceCardItem.CardType = {
	PlayCard = GetCardTypeId(),
	WaitArea = GetCardTypeId(),
	SwitchCard = GetCardTypeId(),
	SwitchPlayCard = GetCardTypeId()
}

function FightDeviceCardItem.Create(goParent, cardType)
	local deviceItem = FightDeviceCardItem.New()

	deviceItem:init(goParent, cardType)

	return deviceItem
end

function FightDeviceCardItem:init(goParent, cardType)
	self:__onInit()

	self.goParent = goParent
	self.rectTrParent = goParent:GetComponent(gohelper.Type_RectTransform)
	self.cardType = cardType
	self.selectFrameActive = false
	self.scanLineActive = false
	self.scanSuccessActive = false
	self.scanFailActive = false
	self.loader = MultiAbLoader.New()

	self.loader:addPath(CardPath)
	self.loader:startLoad(self.onLoadedCallback, self)
end

function FightDeviceCardItem:onLoadedCallback()
	local assetItem = self.loader:getFirstAssetItem()

	self.go = gohelper.clone(assetItem:GetResource(), self.goParent)
	self.rectTr = self.go:GetComponent(gohelper.Type_RectTransform)
	self.height = recthelper.getHeight(self.rectTr)

	self:initViews()
	self:setName(self.name)
end

function FightDeviceCardItem:initViews()
	self.goNormal = gohelper.findChild(self.go, "normal")
	self.goNormal1 = gohelper.findChild(self.go, "normal_1")
	self.goUnique = gohelper.findChild(self.go, "unique")
	self.goSpecialBg = gohelper.findChild(self.go, "special_bg")
	self.goSelect = gohelper.findChild(self.go, "go_select")
	self.rectSelect = self.goSelect:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(self.goNormal, false)
	gohelper.setActive(self.goNormal1, false)
	gohelper.setActive(self.goUnique, false)
	gohelper.setActive(self.goSpecialBg, false)
	gohelper.setActive(self.goSelect, false)

	self.normalComp = FightDeviceCardItemNormal.Create(self.goNormal, self)

	self.normalComp:startLoad(self.onNormalLoadDone, self)

	self.normal1Comp = FightDeviceCardItemNormal.Create(self.goNormal1, self)

	self.normal1Comp:startLoad(self.onNormal1LoadDone, self)

	self.uniqueComp = FightDeviceCardItemUnique.Create(self.goUnique, self)

	self.uniqueComp:startLoad(self.onUniqueLoadDone, self)
end

function FightDeviceCardItem:onNormalLoadDone()
	self.normalLoadDone = true

	self:checkAllLoadDone()
end

function FightDeviceCardItem:onNormal1LoadDone()
	self.normal1LoadDone = true

	self:checkAllLoadDone()
end

function FightDeviceCardItem:onUniqueLoadDone()
	self.uniqueLoadDone = true

	self:checkAllLoadDone()
end

function FightDeviceCardItem:checkAllLoadDone()
	if not self.normalLoadDone then
		return
	end

	if not self.normal1LoadDone then
		return
	end

	if not self.uniqueLoadDone then
		return
	end

	self.loadedDone = true

	self:setSelectFrameActive(self.selectFrameActive)
	self:setGrayMaskActive(self.grayMaskActive)
	self:afterLoadDone()
end

function FightDeviceCardItem:afterLoadDone()
	return
end

function FightDeviceCardItem:setGrayMaskActive(active)
	self.grayMaskActive = active

	if not self.loadedDone then
		return
	end

	self.normalComp:setGrayMaskActive(active)
	self.normal1Comp:setGrayMaskActive(active)
	self.uniqueComp:setGrayMaskActive(active)
end

function FightDeviceCardItem:hide()
	if self.loadedDone then
		gohelper.setActive(self.go, false)
	end
end

function FightDeviceCardItem:show()
	if self.loadedDone then
		gohelper.setActive(self.go, true)
	end
end

function FightDeviceCardItem:refreshUI(deviceInfo)
	if not self.loadedDone then
		return
	end

	if not deviceInfo then
		return
	end

	self.deviceInfo = deviceInfo
	self.uid = self.deviceInfo.uid

	local index = self.deviceInfo.clientIndex
	local group = deviceInfo.skills[index]

	if not group then
		logError("group is nil, " .. tostring(index))

		return
	end

	if index == FightDeviceInfoData.Index.Unique then
		gohelper.setActive(self.goNormal, false)
		gohelper.setActive(self.goNormal1, false)
		gohelper.setActive(self.goSpecialBg, false)
		gohelper.setActive(self.goUnique, true)
		self.uniqueComp:setActive(true)
		self.normalComp:setActive(false)
		self.normal1Comp:setActive(false)
		self.uniqueComp:refreshUI(group.skills[1])
	else
		gohelper.setActive(self.goNormal, true)
		self.normalComp:setActive(true)
		self.normalComp:refreshUI(group.skills[1])

		local skillInfo = group.skills[2]

		if skillInfo then
			gohelper.setActive(self.goNormal1, true)
			self.normal1Comp:setActive(true)
			gohelper.setActive(self.goSpecialBg, true)
			self.normal1Comp:refreshUI(skillInfo)
		else
			self.normal1Comp:setActive(false)
			gohelper.setActive(self.goSpecialBg, false)
			gohelper.setActive(self.goNormal1, false)
		end

		self.uniqueComp:setActive(false)
		gohelper.setActive(self.goUnique, false)
	end

	recthelper.setWidth(self.rectTr, FightDeviceHelper.getDeviceInfoWidth(deviceInfo))
end

function FightDeviceCardItem:getUid()
	return self.uid
end

function FightDeviceCardItem:getDeviceInfo()
	return self.deviceInfo
end

function FightDeviceCardItem:setName(name)
	if string.nilorempty(name) then
		name = "device_card_item"
	end

	self.name = name

	if not self.loadedDone then
		return
	end

	self.go.name = name
end

function FightDeviceCardItem:setSelectFrameActive(active)
	self.selectFrameActive = active

	if not self.loadedDone then
		return
	end

	if not self.deviceInfo then
		gohelper.setActive(self.goSelect, false)
		self.uniqueComp:setSelectFrameActive(false)

		return
	end

	local index = self.deviceInfo.clientIndex

	if index == FightDeviceInfoData.Index.Unique then
		gohelper.setActive(self.goSelect, false)
		self.uniqueComp:setSelectFrameActive(active)
	else
		self.uniqueComp:setSelectFrameActive(false)
		gohelper.setActive(self.goSelect, active)
		recthelper.setWidth(self.rectSelect, FightDeviceHelper.getSelectFrameWidth(self.deviceInfo))
		recthelper.setAnchorX(self.rectSelect, FightDeviceHelper.getSelectFrameAnchorX(self.deviceInfo))
	end
end

function FightDeviceCardItem:showInnerSelectFrame(innerIndex)
	self.normalComp:setSelectFrameActive(innerIndex == 1)
	self.normal1Comp:setSelectFrameActive(innerIndex == 2)
	self.uniqueComp:setSelectFrameActive(true)
end

function FightDeviceCardItem:hideAllInnerSelectFrame()
	self.normalComp:setSelectFrameActive(false)
	self.normal1Comp:setSelectFrameActive(false)
	self.uniqueComp:setSelectFrameActive(false)
end

function FightDeviceCardItem:getRectTr()
	return self.rectTr
end

function FightDeviceCardItem:playAnim(animName, callback, callbackObj)
	if not self.deviceInfo then
		logError("device info is nil")

		return
	end

	logError("play device anim : " .. tostring(animName))

	local groupIndex = self.deviceInfo.clientIndex

	if groupIndex == FightDeviceInfoData.Index.Unique then
		self.uniqueComp:playAnim(animName, callback, callbackObj)
	else
		self.normalComp:playAnim(animName, callback, callbackObj)
	end
end

function FightDeviceCardItem:playGroupAnim(animName, callback, callbackObj)
	if not self.deviceInfo then
		logError("device info is nil")

		return
	end

	local groupIndex = self.deviceInfo.clientIndex

	if groupIndex == FightDeviceInfoData.Index.Unique then
		self.uniqueComp:playAnim(animName, callback, callbackObj)
	else
		self.normalComp:playAnim(animName, callback, callbackObj)
		self.normal1Comp:playAnim(animName)
	end
end

function FightDeviceCardItem:playOneItemAnim(animName, index, callback, callbackObj)
	if not self.deviceInfo then
		logError("device info is nil")

		return
	end

	local groupIndex = self.deviceInfo.clientIndex

	if groupIndex == FightDeviceInfoData.Index.Unique then
		self.uniqueComp:playAnim(animName, callback, callbackObj)
	elseif index == FightDeviceInfoData.Index.One then
		self.normalComp:playAnim(animName, callback, callbackObj)
	else
		self.normal1Comp:playAnim(animName, callback, callbackObj)
	end
end

function FightDeviceCardItem:playScanEffect(success, index)
	if not self.loadedDone then
		return
	end

	if not self.deviceInfo then
		logError("device info is nil")

		return
	end

	local groupIndex = self.deviceInfo.clientIndex
	local group = self.deviceInfo.skills[groupIndex]

	if not group then
		return
	end

	local skillInfo = group.skills[index]

	if not skillInfo then
		return
	end

	if skillInfo.isStop then
		return
	end

	if groupIndex == FightDeviceInfoData.Index.Unique then
		self:setAsLastGo(self.goUnique)
	elseif index == FightDeviceInfoData.Index.One then
		self:setAsLastGo(self.goNormal)
	else
		self:setAsLastGo(self.goNormal1)
	end

	local animName = success and "success" or "fail"

	self:playOneItemAnim(animName, index)

	local audioId = success and 370807 or 370808

	AudioMgr.instance:trigger(audioId)
end

function FightDeviceCardItem:setAsLastGo(go)
	gohelper.setAsLastSibling(go)
	gohelper.setAsLastSibling(self.goSelect)
end

function FightDeviceCardItem:playStopEffect(skillId)
	return
end

function FightDeviceCardItem:restartDevice()
	return
end

function FightDeviceCardItem:refreshStopEffect()
	return
end

function FightDeviceCardItem:dispose()
	self.animDoneCallback = nil
	self.animDoneCallbackObj = nil

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	if self.normalComp then
		self.normalComp:dispose()

		self.normalComp = nil
	end

	if self.normal1Comp then
		self.normal1Comp:dispose()

		self.normal1Comp = nil
	end

	if self.uniqueComp then
		self.uniqueComp:dispose()

		self.uniqueComp = nil
	end

	self:__onDispose()
end

return FightDeviceCardItem
