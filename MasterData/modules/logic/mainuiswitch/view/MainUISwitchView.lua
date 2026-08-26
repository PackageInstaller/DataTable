-- chunkname: @modules/logic/mainuiswitch/view/MainUISwitchView.lua

module("modules.logic.mainuiswitch.view.MainUISwitchView", package.seeall)

local MainUISwitchView = class("MainUISwitchView", BaseView)

function MainUISwitchView:onInitView()
	self._gomiddle = gohelper.findChild(self.viewGO, "middle")
	self._gomainUI = gohelper.findChild(self.viewGO, "middle/#go_mainUI")
	self._btnchange = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_change")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_get")
	self._goshowing = gohelper.findChild(self.viewGO, "right/start/#go_showing")
	self._goLocked = gohelper.findChild(self.viewGO, "right/start/#go_Locked")
	self._goSceneName = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_SceneName")
	self._txtSceneName = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName")
	self._txtTime = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName/#txt_Time")
	self._txtSceneDescr = gohelper.findChildText(self.viewGO, "left/#txt_SceneDescr")
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._goleft = gohelper.findChild(self.viewGO, "left")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "left/LayoutGroup/#go_SceneName/#btn_namecheck")
	self._btnShow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_show")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainUISwitchView:addEvents()
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
	self._btnHide:AddClickListener(self._btnHideOnClick, self)
	self._btnShow:AddClickListener(self._btnshowOnClick, self)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, self._onSwitchUIVisible, self)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.SwitchMainUI, self._onSwitchMainUI, self)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, self._onUIMainUI, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshView, self)
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function MainUISwitchView:removeEvents()
	self._btnchange:RemoveClickListener()
	self._btnget:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnShow:RemoveClickListener()
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, self._onSwitchUIVisible, self)
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.SwitchMainUI, self._onSwitchMainUI, self)
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, self._onUIMainUI, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshView, self)
	self.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function MainUISwitchView:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId == 1 then
		if self.viewContainer:getClassify() == MainSwitchClassifyEnum.Classify.UI then
			if tabId == MainEnum.SwitchType.Scene then
				self:onTabSwitchOpen()
			else
				self:onTabSwitchClose()
			end
		else
			self:onTabSwitchClose()
		end
	end
end

function MainUISwitchView:_btnchangeOnClick()
	MainUISwitchController.instance:setCurMainUIStyle(self._selectSkinId)
	MainUISwitchListModel.instance:refreshScroll()
end

function MainUISwitchView:_btngetOnClick()
	local config = lua_scene_ui.configDict[self._selectSkinId]

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, config.itemId)
end

function MainUISwitchView:_onSwitchMainUI(skinId)
	self:_showUIInfo(skinId)
end

function MainUISwitchView:_onUIMainUI(skinId)
	self:_showUIInfo(self._selectSkinId)
	MainUISwitchListModel.instance:refreshScroll()
end

function MainUISwitchView:_btnHideOnClick()
	if self._hideTime and Time.time - self._hideTime < 0.2 then
		return
	end

	self._hideTime = Time.time
	self._showUI = not self._showUI

	gohelper.setActive(self._btnShow, not self._showUI)
	MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.SwitchUIVisible, self._showUI)
end

function MainUISwitchView:_btnshowOnClick()
	if not self._showUI then
		if MainUISwitchController.instance:isClickEagle() then
			MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.ClickEagle)

			return
		end

		if MainUISwitchController.instance:isClickObj("#btn_bird") then
			MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.ClickBird, self.viewName)

			return
		end
	end

	self:_btnHideOnClick()
end

function MainUISwitchView:_onSwitchUIVisible(showUi)
	gohelper.setActive(self._goblurmask, showUi)
	gohelper.setActive(self._goright, showUi)
	gohelper.setActive(self._goleft, showUi)
end

function MainUISwitchView:_editableInitView()
	self._goshow = gohelper.findChild(self.rootGO, "#btn_show")
	self._rootAnimator = self.viewGO:GetComponent("Animator")
	self._useSingleMask = PostProcessingMgr.instance:getUnitPPValue("rolesStoryMaskActive")
end

function MainUISwitchView:onUpdateParam()
	return
end

function MainUISwitchView:onTabSwitchOpen()
	if self._rootAnimator then
		self._rootAnimator:Play("open", 0, 0)
	end

	self:_setrolesStoryMaskActive()
end

function MainUISwitchView:onTabSwitchClose(isClose)
	self:_resetrolesStoryMaskActive()
end

function MainUISwitchView:onOpen()
	MainUISwitchListModel.instance:initList()
	self:_onSwitchUIVisible(true)
	self:_showUIInfo(MainUISwitchModel.instance:getCurUseUI())

	self._showUI = true

	gohelper.setActive(self._btnShow, false)

	self._goblurmask = self._goblurmask or self:getResInst(self.viewContainer:getSetting().otherRes[4], self._gomiddle)

	self:_setrolesStoryMaskActive()
	MainSceneSwitchDisplayController.instance:hideScene()
	WeatherController.instance:onSceneShow()
	self._rootAnimator:Play("open", 0, 0)
end

function MainUISwitchView:_refreshView()
	MainUISwitchListModel.instance:onModelUpdate()
	self:_showUIInfo(self._selectSkinId)
end

function MainUISwitchView:_setrolesStoryMaskActive()
	PostProcessingMgr.instance:setUnitPPValue("rolesStoryMaskActive", false)
end

function MainUISwitchView:_resetrolesStoryMaskActive()
	PostProcessingMgr.instance:setUnitPPValue("rolesStoryMaskActive", self._useSingleMask)
end

function MainUISwitchView:_showUIInfo(skinId)
	self._selectSkinId = skinId

	self:_showBtnStatus(skinId)

	local config = lua_scene_ui.configDict[skinId]

	if config then
		self:_updateInfo(config.itemId, config.defaultUnlock)
	end
end

function MainUISwitchView:_showBtnStatus(skinId)
	local status = MainUISwitchModel.getUIStatus(skinId)
	local curSkinId = MainUISwitchModel.instance:getCurUseUI()
	local showCurScene = skinId == curSkinId
	local isUnlock = status == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(self._btnchange, not showCurScene and isUnlock)
	gohelper.setActive(self._btnget, not showCurScene and status == MainSceneSwitchEnum.SceneStutas.LockCanGet)
	gohelper.setActive(self._goshowing, showCurScene and isUnlock)
	gohelper.setActive(self._goLocked, not showCurScene and status == MainSceneSwitchEnum.SceneStutas.Lock)
end

function MainUISwitchView:_updateInfo(itemId, defaultUnlock)
	local itemConfig = lua_item.configDict[itemId]

	if not itemConfig then
		return
	end

	self._txtSceneName.text = itemConfig.name
	self._txtSceneDescr.text = itemConfig.desc

	if defaultUnlock == 1 then
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
end

function MainUISwitchView:onClose()
	self:_resetrolesStoryMaskActive()
end

function MainUISwitchView:onDestroyView()
	return
end

return MainUISwitchView
