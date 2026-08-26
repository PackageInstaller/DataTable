-- chunkname: @modules/logic/summonuiswitch/view/SummonUISwitchView.lua

module("modules.logic.summonuiswitch.view.SummonUISwitchView", package.seeall)

local SummonUISwitchView = class("SummonUISwitchView", BaseView)

function SummonUISwitchView:onInitView()
	self._gomainUI = gohelper.findChild(self.viewGO, "middle/#go_mainUI")
	self._btnchange = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_change")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_get")
	self._goshowing = gohelper.findChild(self.viewGO, "right/start/#go_showing")
	self._goLocked = gohelper.findChild(self.viewGO, "right/start/#go_Locked")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_card")
	self._goSceneName = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_SceneName")
	self._txtSceneName = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName")
	self._txtTime = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName/#txt_Time")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "left/LayoutGroup/#go_HideBtn/#btn_Hide")
	self._txtSceneDescr = gohelper.findChildText(self.viewGO, "left/#txt_SceneDescr")
	self._btnshow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_show")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonUISwitchView:addEvents()
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
	self._btnHide:AddClickListener(self._btnHideOnClick, self)
	self._btnshow:AddClickListener(self._btnshowOnClick, self)
end

function SummonUISwitchView:removeEvents()
	self._btnchange:RemoveClickListener()
	self._btnget:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnshow:RemoveClickListener()
end

SummonUISwitchView.UIBlockKey = "switchSummonSceneSkin"
SummonUISwitchView.UIBlockTime = 5

function SummonUISwitchView:_btnchangeOnClick()
	TaskDispatcher.cancelTask(self.forceEndBlock, self)
	TaskDispatcher.runDelay(self.forceEndBlock, self, SummonUISwitchView.UIBlockTime)
	UIBlockMgr.instance:startBlock(SummonUISwitchView.UIBlockKey)
	SummonUISwitchController.instance:setCurSummonUIStyle(self.selectId)
end

function SummonUISwitchView:_btngetOnClick()
	local config = SummonUISwitchConfig.instance:getSummonSwitchConfig(self.selectId)

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, config.itemId)
end

function SummonUISwitchView:_btnHideOnClick()
	if self._hideTime and Time.time - self._hideTime < 0.2 then
		return
	end

	self._hideTime = Time.time
	self._showUI = not self._showUI

	gohelper.setActive(self._btnshow, not self._showUI)
	SummonUISwitchController.instance:dispatchEvent(SummonUISwitchEvent.SwitchVisible, self._showUI)
end

function SummonUISwitchView:_btnshowOnClick()
	self:_btnHideOnClick()
end

function SummonUISwitchView:_onSwitchUIVisible(showUi)
	self._rootAnimator:Play(showUi and "open" or "close", 0, 0)
end

function SummonUISwitchView:_editableInitView()
	self._goleft = gohelper.findChild(self.viewGO, "left")
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._gomiddle = gohelper.findChild(self.viewGO, "middle")

	SummonUISwitchListModel.instance:initList()

	self._showUI = true

	gohelper.setActive(self._btnShow, false)

	self._rootAnimator = self.viewGO:GetComponent("Animator")
end

function SummonUISwitchView:onUpdateParam()
	return
end

function SummonUISwitchView:onOpen()
	self.addEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.SwitchSceneUI, self._refreshInfo, self)
	self.addEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.UseSceneUI, self.onUseScene, self)
	self.addEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.SwitchVisible, self._onSwitchUIVisible, self)
	MainSceneSwitchDisplayController.instance:hideScene()
	self:refreshUI()
end

function SummonUISwitchView:refreshUI()
	self:_refreshInfo(SummonUISwitchModel.instance:getCurUseUI())
end

function SummonUISwitchView:_refreshBtnStatus(skinId)
	local status = SummonUISwitchModel.getUIStatus(skinId)
	local curSkinId = SummonUISwitchModel.instance:getCurUseUI()
	local showCurScene = skinId == curSkinId
	local isUnlock = status == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(self._btnchange, not showCurScene and isUnlock)
	gohelper.setActive(self._btnget, not showCurScene and status == MainSceneSwitchEnum.SceneStutas.LockCanGet)
	gohelper.setActive(self._goshowing, showCurScene and isUnlock)
	gohelper.setActive(self._goLocked, not showCurScene and status == MainSceneSwitchEnum.SceneStutas.Lock)
end

function SummonUISwitchView:onUseScene(skinId)
	TaskDispatcher.cancelTask(self.forceEndBlock, self)
	UIBlockMgr.instance:endBlock(SummonUISwitchView.UIBlockKey)

	if self.selectId ~= SummonUISwitchModel.instance:getCurUseUI() then
		self:_showTip()
	end

	self:_refreshInfo(skinId)
	SummonUISwitchListModel.instance:refreshScroll()
end

function SummonUISwitchView:forceEndBlock()
	logError("抽卡场景页面锁屏超时")
	TaskDispatcher.cancelTask(self.forceEndBlock, self)
	UIBlockMgr.instance:endBlock(SummonUISwitchView.UIBlockKey)
end

function SummonUISwitchView:_showTip()
	GameFacade.showToast(ToastEnum.SceneSwitchSuccess)
	self._rootAnimator:Play("open", 0, 0)
end

function SummonUISwitchView:onTabSwitchOpen()
	MainHeroView.resetPostProcessBlur()
	self._rootAnimator:Play("open", 0, 0)
end

function SummonUISwitchView:onTabSwitchClose()
	MainHeroView.setPostProcessBlur()
end

function SummonUISwitchView:_refreshInfo(skinId)
	self.summonConfig = SummonUISwitchConfig.instance:getSummonSwitchConfig(skinId)

	if self.summonConfig == nil then
		return
	end

	self.selectId = skinId

	local itemId = self.summonConfig.itemId
	local itemConfig = lua_item.configDict[itemId]

	if not itemConfig then
		return
	end

	self._txtSceneName.text = itemConfig.name
	self._txtSceneDescr.text = itemConfig.desc

	if self.summonConfig.defaultUnlock == 1 then
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
		end
	end

	self:_refreshBtnStatus(skinId)
end

function SummonUISwitchView:onClose()
	MainSceneSwitchDisplayController.instance:showCurScene()
	TaskDispatcher.cancelTask(self.forceEndBlock, self)
	self.removeEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.SwitchSceneUI, self._refreshInfo, self)
	self.removeEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.UseSceneUI, self.onUseScene, self)
	self.removeEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.SwitchVisible, self._onSwitchUIVisible, self)
end

function SummonUISwitchView:onDestroyView()
	return
end

return SummonUISwitchView
