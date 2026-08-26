-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSwitchView.lua

module("modules.logic.mainsceneswitch.view.MainSceneSwitchView", package.seeall)

local MainSceneSwitchView = class("MainSceneSwitchView", BaseView)

function MainSceneSwitchView:onInitView()
	self._btnchange = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_change")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_get")
	self._goshowing = gohelper.findChild(self.viewGO, "right/start/#go_showing")
	self._goLocked = gohelper.findChild(self.viewGO, "right/start/#go_Locked")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_card")
	self._btntimerank = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_timerank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_rarerank")
	self._goSceneLogo = gohelper.findChild(self.viewGO, "right/#go_SceneLogo")
	self._goHideBtn = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_HideBtn")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "left/LayoutGroup/#go_HideBtn/#btn_Hide")
	self._btnShow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_show")
	self._goSceneName = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_SceneName")
	self._txtSceneName = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName")
	self._txtTime = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName/#txt_Time")
	self._goTime = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_Time")
	self._txtSceneDescr = gohelper.findChildText(self.viewGO, "left/#txt_SceneDescr")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainSceneSwitchView:addEvents()
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
	self._btntimerank:AddClickListener(self._btntimerankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnHide:AddClickListener(self._btnHideOnClick, self)
	self._btnShow:AddClickListener(self._btnShowOnClick, self)
end

function MainSceneSwitchView:removeEvents()
	self._btnchange:RemoveClickListener()
	self._btnget:RemoveClickListener()
	self._btntimerank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnShow:RemoveClickListener()
end

function MainSceneSwitchView:_btngetOnClick()
	local selectedSceneConfig = lua_scene_switch.configDict[self._selectSceneSkinId]

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, selectedSceneConfig.itemId)
end

function MainSceneSwitchView:_btnHideOnClick()
	if self._hideTime and Time.time - self._hideTime < 0.2 then
		return
	end

	self._hideTime = Time.time
	self._showUI = not self._showUI

	gohelper.setActive(self._btnShow, not self._showUI)
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SceneSwitchUIVisible, self._showUI)
end

function MainSceneSwitchView:_btnShowOnClick()
	self:_btnHideOnClick()
end

function MainSceneSwitchView:_btnchangeOnClick()
	local curSceneConfig = lua_scene_switch.configDict[self._curSceneSkinId]
	local selectedSceneConfig = lua_scene_switch.configDict[self._selectSceneSkinId]

	StatController.instance:track(StatEnum.EventName.ChangeMainInterfaceScene, {
		[StatEnum.EventProperties.BeforeSceneName] = tostring(curSceneConfig.itemId),
		[StatEnum.EventProperties.AfterSceneName] = tostring(selectedSceneConfig.itemId)
	})

	local itemId = selectedSceneConfig.defaultUnlock == 1 and 0 or selectedSceneConfig.itemId

	UIBlockMgrExtend.setNeedCircleMv(false)
	PlayerRpc.instance:sendSetMainSceneSkinRequest(itemId, function(cmd, resultCode, msg)
		if resultCode ~= 0 then
			UIBlockMgrExtend.setNeedCircleMv(true)

			return
		end

		if gohelper.isNil(self.viewGO) then
			return
		end

		UIBlockMgr.instance:startBlock("switchSceneSkin")

		self._waitingSwitchSceneInitFinish = true

		TaskDispatcher.cancelTask(self._delaySwitchSceneInitFinish, self)
		TaskDispatcher.runDelay(self._delaySwitchSceneInitFinish, self, 8)

		self._curSceneSkinId = self._selectSceneSkinId

		MainSceneSwitchModel.instance:setCurSceneId(self._selectSceneSkinId)
		MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.BeforeStartSwitchScene)
		TaskDispatcher.runDelay(self._delaySwitchScene, self, 0.8)
		self._rootAnimator:Play("switch", 0, 0)
	end)
end

function MainSceneSwitchView:_delaySwitchScene()
	MainSceneSwitchController.instance:switchScene()
end

function MainSceneSwitchView:_btntimerankOnClick()
	return
end

function MainSceneSwitchView:_btnrarerankOnClick()
	return
end

function MainSceneSwitchView:_showSceneStatus()
	local sceneStatus = MainSceneSwitchModel.getSceneStatus(self._selectSceneSkinId)
	local showCurScene = self._selectSceneSkinId == self._curSceneSkinId
	local isUnlock = sceneStatus == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(self._btnchange, not showCurScene and isUnlock)
	gohelper.setActive(self._btnget, not showCurScene and sceneStatus == MainSceneSwitchEnum.SceneStutas.LockCanGet)
	gohelper.setActive(self._goshowing, showCurScene and isUnlock)
	gohelper.setActive(self._goLocked, not showCurScene and sceneStatus == MainSceneSwitchEnum.SceneStutas.Lock)
	self:_updateSceneInfo()
end

function MainSceneSwitchView:_editableInitView()
	self._showUI = true
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._goLeft = gohelper.findChild(self.viewGO, "left")
	self._rootAnimator = self.viewGO:GetComponent("Animator")

	gohelper.setActive(self._btnShow, false)
	gohelper.addUIClickAudio(self._btnchange, AudioEnum.MainSceneSkin.play_ui_main_fit_scene)
	gohelper.setActive(self._btnchange, false)
	gohelper.setActive(self._btnget, false)
	gohelper.setActive(self._goshowing, false)
	gohelper.setActive(self._goLocked, false)
	gohelper.setActive(self._goSceneLogo, false)

	self._curSceneSkinId = MainSceneSwitchModel.instance:getCurSceneId()
	self._selectSceneSkinId = self._curSceneSkinId

	MainSceneSwitchListModel.instance:initList()
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.ClickSwitchItem, self._onClickSwitchItem, self)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.SceneSwitchUIVisible, self._onSceneSwitchUIVisible, self)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneInitFinish, self._onSwitchSceneInitFinish, self)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, self._onStartSwitchScene, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function MainSceneSwitchView:_onCloseView(viewName)
	if viewName == ViewName.MainSceneSwitchInfoView then
		self._curSceneSkinId = MainSceneSwitchModel.instance:getCurSceneId()

		self:_showSceneStatus()
		MainSceneSwitchListModel.instance:onModelUpdate()
	end
end

function MainSceneSwitchView:_onStartSwitchScene()
	self._startSwitchTime = Time.time
end

function MainSceneSwitchView:_delaySwitchSceneInitFinish()
	logError("MainSceneSwitchView _delaySwitchSceneInitFinish timeout!")
	self:_onSwitchSceneInitFinish()
end

function MainSceneSwitchView:_onSwitchSceneInitFinish()
	if not self._waitingSwitchSceneInitFinish then
		return
	end

	TaskDispatcher.cancelTask(self._delaySwitchSceneInitFinish, self)

	local closeTime = 0.6
	local loadingTime = Time.time - self._startSwitchTime
	local minLoadingTime = 0.9
	local deltaTime = minLoadingTime - loadingTime

	deltaTime = math.max(0, deltaTime)
	deltaTime = deltaTime + 0.3

	TaskDispatcher.cancelTask(self._delayFinishForPlayLoadingAnim, self)
	TaskDispatcher.runDelay(self._delayFinishForPlayLoadingAnim, self, deltaTime)
	TaskDispatcher.cancelTask(self._playStory, self)
	TaskDispatcher.runDelay(self._playStory, self, deltaTime + closeTime)
end

function MainSceneSwitchView:_delayFinishForPlayLoadingAnim()
	self:_showSceneStatus()
	MainSceneSwitchListModel.instance:refreshScroll()
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.CloseSwitchSceneLoading)
end

function MainSceneSwitchView:_playStory()
	self._waitingSwitchSceneInitFinish = false

	UIBlockMgr.instance:endBlock("switchSceneSkin")
	UIBlockMgrExtend.setNeedCircleMv(true)

	local selectedSceneConfig = lua_scene_switch.configDict[self._selectSceneSkinId]
	local storyId = selectedSceneConfig.storyId

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		local param = {}

		param.mark = true

		StoryController.instance:playStory(storyId, param, function()
			self:_showTip()
			MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SwitchSceneFinishStory)
		end)

		return
	end

	self:_showTip()
end

function MainSceneSwitchView:_showTip()
	GameFacade.showToast(ToastEnum.SceneSwitchSuccess)
	self._rootAnimator:Play("open", 0, 0)
end

function MainSceneSwitchView:onOpenFinish()
	local list = MainSceneSwitchListModel.instance:getList()
	local index = 1

	self:_setSelectedItemMo(list[index], index)
	MainSceneSwitchController.closeReddot()
end

function MainSceneSwitchView:_onSceneSwitchUIVisible(visible)
	self._rootAnimator:Play(visible and "open" or "close", 0, 0)
end

function MainSceneSwitchView:_onClickSwitchItem(mo, index)
	self:_setSelectedItemMo(mo, index)
end

function MainSceneSwitchView:_setSelectedItemMo(mo, index)
	MainSceneSwitchListModel.instance:selectCellIndex(index)

	self._selectSceneSkinId = mo.id

	self:_showSceneStatus()
end

function MainSceneSwitchView:onTabSwitchOpen()
	MainHeroView.resetPostProcessBlur()
	self._rootAnimator:Play("open", 0, 0)
end

function MainSceneSwitchView:_updateSceneInfo()
	local selectedSceneConfig = lua_scene_switch.configDict[self._selectSceneSkinId]

	if not selectedSceneConfig then
		return
	end

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ShowSceneInfo, self._selectSceneSkinId)

	local itemId = selectedSceneConfig.itemId
	local itemConfig = lua_item.configDict[itemId]

	if not itemConfig then
		return
	end

	self._txtSceneName.text = itemConfig.name
	self._txtSceneDescr.text = itemConfig.desc

	gohelper.setActive(self._goTime, false)

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
		end
	end
end

function MainSceneSwitchView:onTabSwitchClose()
	MainHeroView.setPostProcessBlur()
end

function MainSceneSwitchView:onClose()
	MainSceneSwitchController.closeReddot()
end

function MainSceneSwitchView:onDestroyView()
	MainSceneSwitchListModel.instance:clearList()
	TaskDispatcher.cancelTask(self._delaySwitchSceneInitFinish, self)
	UIBlockMgr.instance:endBlock("switchSceneSkin")
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(self._playStory, self)
	TaskDispatcher.cancelTask(self._delayFinishForPlayLoadingAnim, self)
	TaskDispatcher.cancelTask(self._delaySwitchScene, self)
end

return MainSceneSwitchView
