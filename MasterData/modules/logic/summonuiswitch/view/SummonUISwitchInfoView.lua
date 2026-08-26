-- chunkname: @modules/logic/summonuiswitch/view/SummonUISwitchInfoView.lua

module("modules.logic.summonuiswitch.view.SummonUISwitchInfoView", package.seeall)

local SummonUISwitchInfoView = class("SummonUISwitchInfoView", BaseView)

function SummonUISwitchInfoView:onInitView()
	self._btnchange = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_change")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_get")
	self._goshowing = gohelper.findChild(self.viewGO, "right/start/#go_showing")
	self._goLocked = gohelper.findChild(self.viewGO, "right/start/#go_Locked")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_card")
	self._btntimerank = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_timerank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_rarerank")
	self._goSceneLogo = gohelper.findChild(self.viewGO, "right/#go_SceneLogo")
	self._goUse = gohelper.findChild(self.viewGO, "right/#go_use")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_equip")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_close")
	self._goHideBtn = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_HideBtn")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "left/LayoutGroup/#go_HideBtn/#btn_Hide")
	self._goSceneName = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_SceneName")
	self._txtSceneName = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName")
	self._goTime = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_Time")
	self._txtTime = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_Time/#txt_Time")
	self._txtSceneDescr = gohelper.findChildText(self.viewGO, "left/#txt_SceneDescr")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonUISwitchInfoView:addEvents()
	self._btnHide:AddClickListener(self._btnHideOnClick, self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SummonUISwitchInfoView:removeEvents()
	self._btnHide:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

SummonUISwitchInfoView.UIBlockKey = "switchSummonUISwitchInfo"
SummonUISwitchInfoView.UIBlockTime = 5

function SummonUISwitchInfoView:_btncloseOnClick()
	self:closeThis()
end

function SummonUISwitchInfoView:_btnequipOnClick()
	TaskDispatcher.cancelTask(self.forceEndBlock, self)
	TaskDispatcher.runDelay(self.forceEndBlock, self, SummonUISwitchInfoView.UIBlockTime)
	UIBlockMgr.instance:startBlock(SummonUISwitchInfoView.UIBlockKey)
	SummonUISwitchController.instance:setCurSummonUIStyle(self._selectSceneSkinId)
end

function SummonUISwitchInfoView:_btnHideOnClick()
	if self._hideTime and Time.time - self._hideTime < 0.2 then
		return
	end

	self._hideTime = Time.time
	self._showUI = not self._showUI

	SummonUISwitchController.instance:dispatchEvent(SummonUISwitchEvent.PreviewSceneSwitchUIVisible, self._showUI)
end

function SummonUISwitchInfoView:_editableInitView()
	self._showUI = true
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._goLeft = gohelper.findChild(self.viewGO, "left")
	self._rootAnimator = self.viewGO:GetComponent("Animator")

	gohelper.setActive(self._btnchange, false)
	gohelper.setActive(self._btnget, false)
	gohelper.setActive(self._goshowing, false)
	gohelper.setActive(self._goLocked, false)
	gohelper.setActive(self._goSceneLogo, true)
	gohelper.setActive(self._goUse, false)
	gohelper.setActive(self._btnequip, false)
	self.addEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.PreviewSceneSwitchUIVisible, self._onSceneSwitchUIVisible, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
end

function SummonUISwitchInfoView:_onTouchScreen()
	if not self._showUI then
		self:_btnHideOnClick()
	end
end

function SummonUISwitchInfoView:onUseScene()
	TaskDispatcher.cancelTask(self.forceEndBlock, self)
	UIBlockMgr.instance:endBlock(SummonUISwitchInfoView.UIBlockKey)
	self:_updateBtnStatus()
	self:_showTip()
end

function SummonUISwitchInfoView:forceEndBlock()
	logError("抽卡场景页面锁屏超时")
	TaskDispatcher.cancelTask(self.forceEndBlock, self)
	UIBlockMgr.instance:endBlock(SummonUISwitchInfoView.UIBlockKey)
end

function SummonUISwitchInfoView:_showTip()
	GameFacade.showToast(ToastEnum.SceneSwitchSuccess)
	self._rootAnimator:Play("open", 0, 0)
end

function SummonUISwitchInfoView:_updateBtnStatus()
	local sceneStatus = SummonUISwitchModel.getUIStatus(self._selectSceneSkinId)

	if sceneStatus ~= MainSceneSwitchEnum.SceneStutas.Unlock then
		return
	end

	local useScene = self._selectSceneSkinId == SummonUISwitchModel.instance:getCurUseUI()

	gohelper.setActive(self._btnequip, not useScene)
	gohelper.setActive(self._goUse, useScene)
end

function SummonUISwitchInfoView:onUpdateParam()
	return
end

function SummonUISwitchInfoView:onOpen()
	self._selectSceneSkinId = self.viewParam.sceneSkinId
	self._materialDataMOList = self.viewParam.materialDataMOList

	self:_showSceneStatus()
	self:_updateBtnStatus()

	if not self.viewParam.noInfoEffect then
		self._rootAnimator:Play("info", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_get_scene)
	end

	self.addEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.UseSceneUI, self.onUseScene, self)
end

function SummonUISwitchInfoView:onClose()
	if self._materialDataMOList and #self._materialDataMOList == 1 then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, self._materialDataMOList)
	end

	self.removeEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.UseSceneUI, self.onUseScene, self)
end

function SummonUISwitchInfoView:_onSceneSwitchUIVisible(visible)
	self._rootAnimator:Play(visible and "open" or "close", 0, 0)
end

function SummonUISwitchInfoView:_showSceneStatus()
	self:_updateSceneInfo()
end

function SummonUISwitchInfoView:_updateSceneInfo()
	local selectedSceneConfig = SummonUISwitchConfig.instance:getSummonSwitchConfig(self._selectSceneSkinId)

	if not selectedSceneConfig then
		return
	end

	SummonUISwitchController.instance:dispatchEvent(SummonUISwitchEvent.SwitchPreviewSceneUI, self._selectSceneSkinId)

	local itemId = selectedSceneConfig.itemId
	local itemConfig = lua_item.configDict[itemId]

	if not itemConfig then
		return
	end

	self._txtSceneName.text = itemConfig.name
	self._txtSceneDescr.text = itemConfig.desc

	gohelper.setActive(self._goTime, true)

	if selectedSceneConfig.defaultUnlock == 1 then
		local info = PlayerModel.instance:getPlayinfo()
		local time = TimeUtil.timestampToString5(ServerTime.timeInLocal(info.registerTime / 1000))

		self._txtTime.text = string.format(luaLang("receive_time"), time)
	else
		local itemMo = ItemModel.instance:getById(itemId)

		if itemMo and itemMo.quantity > 0 and itemMo.lastUpdateTime then
			local time = TimeUtil.timestampToString5(ServerTime.timeInLocal(itemMo.lastUpdateTime / 1000))

			self._txtTime.text = string.format(luaLang("receive_time"), time)
		else
			self._txtTime.text = ""

			gohelper.setActive(self._goTime, false)
		end
	end
end

function SummonUISwitchInfoView:onDestroyView()
	TaskDispatcher.cancelTask(self.forceEndBlock, self)
	self.removeEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.PreviewSceneSwitchUIVisible, self._onSceneSwitchUIVisible, self)
	self.removeEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
end

return SummonUISwitchInfoView
