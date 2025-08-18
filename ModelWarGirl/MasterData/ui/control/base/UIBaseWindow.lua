-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Base\\UIBaseWindow.lua

local IUIBase = require("UI/Control/Base/IUIBase")
local UIUtils = require("Framework.UI.UIUtils")
local ResWindowMoneyConfig = require("ClientData/ResWindowMoneyConfig")
local VersionUtils = require("System/VersionUtils")
local EventConst = require("EventConst")
local UIBaseWindow = Class("UIBaseWindow", IUIBase)

UIBaseWindow.DELAY_INIT_CD = 0.1

local GraphicType = typeof(UnityEngine.UI.GraphicRaycaster)

function UIBaseWindow:ctor(prefabPath, order, needShow)
	if order == nil then
		order = 50
	end

	if needShow == nil then
		needShow = false
	end

	self._order = order
	self._orderOrg = order
	self._visible = needShow
	self.mWindow = self
	self._hide = false

	UIUtils.CreateUIWindow(prefabPath, self, self._visible, order)

	self._hide2Destroy = nil
	self.mOpening = false
	self.visibleHadChange = false
end

function UIBaseWindow:destroy()
	if self._timerInit ~= nil then
		self._timerInit:Stop()
	end

	self:_bindRelease()
	UIBaseWindow.super.destroy(self)
end

function UIBaseWindow:postInit(uiName, uiData)
	self.mUIName = uiName
	self.mPrefabKey = uiData.prefabKey

	if uiData.prefabKey then
		UIManager.prefabKeyDict[uiData.prefabKey] = uiName
	end

	self.mUIData = uiData
	self.mUIGroup = uiData.ui_group

	if ResWindowMoneyConfig[self.mUIName] then
		local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")

		self.panelFund = CommonFuncEntryPanel(self, "CommonFuncEntryPanel", "System/MainMenu/CommonFuncEntryPanel", 0, 0, true)

		if ResWindowMoneyConfig[self.mUIName].moneys then
			self.panelFund:settingFund(ResWindowMoneyConfig[self.mUIName].moneys)
		end
	end
end

function UIBaseWindow:addStepChild(cls, url, prefabPath, x, y, defaultVisible, step)
	if self._initList == nil then
		self._initList = {}
	end

	if step and self._initList[step] then
		step = nil
	end

	if step == nil then
		step = #self._initList + 1
	end

	local child = cls(self, url, prefabPath, x, y, defaultVisible, true)

	self._initList[step] = child

	if self._timerInit == nil then
		self._timerInit = Timer.New(Slot(self.onChildDelayInit, self), UIBaseWindow.DELAY_INIT_CD, -1)
	end

	if not self._timerInit:IsRunning() then
		self._timerInit:Start()
	end

	return child
end

function UIBaseWindow:onChildDelayInit()
	for step, child in pairs(self._initList) do
		if not child:IsInit() then
			child:getController()

			return
		end
	end

	self._timerInit:Stop()
end

function UIBaseWindow:onOpen()
	self.mOpening = true

	if self.mUIData and self.mUIData.ui_block then
		UIManager.showBlock(self)
	end

	self:onVisibleChanged(true)
	self:bgmOn()
end

function UIBaseWindow:onWindowInit()
	return
end

function UIBaseWindow:windowBeginnerReady()
	return self:getVisible() and not self:getHide() and not self.mOpening
end

function UIBaseWindow:onOpenOver()
	self.mOpening = false

	self:onVisibleChanged(true)

	if not self.ignoreBeginnerOpen then
		BeginnerManager.onTriggerCanvasOpen(self.mPrefabKey)
	end
end

function UIBaseWindow:playAni(aniName, callback, immidiatly)
	UIBaseWindow.super.playAni(self, aniName, callback, immidiatly)

	if self.mOpening then
		self:OnOpenEnd()
	end
end

function UIBaseWindow:onClose()
	if self._hide2Destroy and not self._visible then
		if self.mUIName ~= nil then
			UIManager.delUI(self.mUIName)
		else
			self:destroy()
		end
	end

	self:onVisibleChanged(false)
	BeginnerManager.onTriggerCanvasClosed(self.mPrefabKey)
	EventCenter.sendEvent(EventConst.UI_CLOSE, self.mUIName)
	self:bgmOff()

	if self.mUIData.logic_flag == 1 then
		UIManager.checkBonusNotice()
	end
end

function UIBaseWindow:onVisibleChanged(isSee)
	return
end

function UIBaseWindow:setVisible(v, hideAndDestroy, noAni)
	if self.id == nil then
		local msg = string.format(Lang.get(30254), self.mUIName or "")

		ClientUtils.trySendException(msg, debug.traceback())
		UIManager.delUI(self.mUIName)

		return
	end

	if self.visibleHadChange and v and self._visible and not self._hide then
		return
	end

	if self.visibleHadChange and not v and self._hide and hideAndDestroy == false then
		if self._visible and (self.mUIGroup ~= nil or self.mUIData and (self.mUIData.shut_down_cam or self.mUIData.need_hdr)) then
			self._visible = false

			UIManager.visibleReject(self)
		end

		return
	end

	if self.visibleHadChange and not v and not self._visible and hideAndDestroy == false then
		if noAni then
			self:OnCloseEnd()
		end

		return
	end

	self._visible = v

	if not self._visible then
		if hideAndDestroy == nil then
			hideAndDestroy = true
		end

		self._hide2Destroy = hideAndDestroy

		if self._hide2Destroy then
			self:_bindRelease()
		end

		ModelStageManager.onUIClose(self.id)
	else
		self:setHide(false, nil, true)
	end

	if self._boundUIs then
		for i, ui in pairs(self._boundUIs) do
			ui:setVisible(self._visible)
		end
	end

	if self.mUIGroup ~= nil or self.mUIData and (self.mUIData.shut_down_cam or self.mUIData.need_hdr) then
		UIManager.visibleReject(self)
	end

	if self.id then
		UIUtils.SetUIVisible(self.id, self._visible, noAni or false)

		self.visibleHadChange = true
	end
end

function UIBaseWindow:uniteVisible(v, hideAndDestroy)
	return
end

function UIBaseWindow:setHide(v, showAni, notOnOpen)
	if self._hide == v then
		return
	end

	if showAni == nil then
		showAni = false
	end

	self._hide = v

	if self._boundUIs then
		for i, ui in pairs(self._boundUIs) do
			ui:setHide(v, showAni, notOnOpen)
		end
	end

	UIUtils.SetUIHide(self.id, v)

	if VersionUtils.getEngineVersion() < 85154 then
		if not self.casterInited then
			self.casterInited = true
			self.graphicCaster = self:getController().gameObject:GetComponent(GraphicType)

			if self.panelFund then
				self.fundGraphicCaster = self.panelFund:getController().gameObject:GetComponentInParent(GraphicType)
			end
		end

		if self.graphicCaster then
			self.graphicCaster.enabled = not v
		end

		if self.fundGraphicCaster then
			self.fundGraphicCaster.enabled = not v
		end
	end

	ModelStageManager.onUIHide(self.id, v)

	if v then
		self:setOrder()

		if showAni then
			self:getController():PlayCloseAni()
		else
			self:OnCloseEnd()
		end
	else
		self:resetOrder()

		if not notOnOpen then
			self:OnOpenStart()
		end

		if showAni then
			self:getController():PlayOpenAni()
		else
			self:OnOpenEnd()
		end
	end

	self:onVisibleChanged(not v)
end

function UIBaseWindow:isInShow()
	return self._visible and not self:getHide()
end

function UIBaseWindow:getHide()
	return self._hide
end

function UIBaseWindow:setOrder(v)
	v = v or 0

	if self._order == v then
		return
	end

	self._order = v

	UIUtils.SetUIOrder(self.id, v)
end

function UIBaseWindow:getOrder()
	return self._order
end

function UIBaseWindow:resetOrder()
	self:setOrder(self._orderOrg)
end

function UIBaseWindow:bindWindow(window)
	if self._boundWindow ~= nil then
		self:_bindRelease()
	end

	if window.isInShow and window:isInShow() then
		self._boundWindow = window

		if window then
			if window._boundUIs == nil then
				window._boundUIs = {}
			end

			window._boundUIs[self.id] = self
		end
	end
end

function UIBaseWindow:_bindRelease()
	if self._boundWindow and self._boundWindow._boundUIs then
		self._boundWindow._boundUIs[self.id] = nil
	end

	self._boundWindow = nil
end

function UIBaseWindow:isRejectShow()
	return not self._boundWindow or self._boundWindow and self._boundWindow:isInShow()
end

function UIBaseWindow:allBindedWindowRelease()
	if self._boundUIs then
		for _, window in pairs(self._boundUIs) do
			window:setVisible(false)
		end

		self._boundUIs = nil
	end
end

function UIBaseWindow:getMainCamVisible()
	if self.mUIData.shut_down_cam and self._visible and not self._hide then
		return false
	else
		return true
	end
end

function UIBaseWindow:need2DHDR()
	if self.mUIData.need_hdr and self._visible and not self._hide then
		return true
	else
		return false
	end
end

function UIBaseWindow:hasUIBGM(...)
	if (self.mUIData.bgm or self.logicBGM) and self._visible and not self._hide then
		return true
	else
		return false
	end
end

function UIBaseWindow:bgmOn()
	if self.logicBGM then
		CueManager.playUIBGM(self.logicBGM)
	elseif self.mUIData and self.mUIData.bgm then
		CueManager.playUIBGM(self.mUIData.bgm)
	end
end

function UIBaseWindow:bgmOff(...)
	if self.mUIData and self.mUIData.bgm or self.logicBGM then
		UIManager.checkUIBgm()
	end
end

function UIBaseWindow:playLogicBGM(bgmId)
	self.logicBGM = bgmId

	self:bgmOn()
end

function UIBaseWindow:stopLogicBGM()
	self.logicBGM = nil

	if self:hasUIBGM() then
		self:bgmOn()
	else
		UIManager.checkUIBgm()
	end
end

function UIBaseWindow:playCustomBgm(battleType, whereToUse)
	local relicHeroBgm = CueManager.getRelicBGM()

	if relicHeroBgm then
		self.logicBGM = relicHeroBgm
	elseif battleType and whereToUse then
		self.logicBGM = CueManager.getBattleBGMConfig(battleType, whereToUse)
	end

	self:bgmOn()
end

function UIBaseWindow:changeOutAnim(animName)
	self:getController():SetCloseAnimName(animName)
end

function UIBaseWindow:inCache(...)
	ModelStageManager.onUIHide(self.id, true)
end

function UIBaseWindow:reuseCache(...)
	ModelStageManager.onUIHide(self.id, false)
end

function UIBaseWindow:setManualReject(uiName, uiFuncName, uiFuncArgs)
	self.manualRejectUi = uiName
	self.manualRejectUiFunc = uiFuncName
	self.manualRejectUiFuncArgs = uiFuncArgs or {}
end

function UIBaseWindow:recoverManualReject()
	if self.manualRejectUi then
		local rejectUI = UIManager.createUI(self.manualRejectUi)

		if self.manualRejectUiFunc and rejectUI and rejectUI[self.manualRejectUiFunc] then
			rejectUI[self.manualRejectUiFunc](rejectUI, unpack(self.manualRejectUiFuncArgs))
		end
	end
end

return UIBaseWindow
