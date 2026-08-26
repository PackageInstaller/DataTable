-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSwitchInfoView.lua

module("modules.logic.mainsceneswitch.view.MainSceneSwitchInfoView", package.seeall)

local MainSceneSwitchInfoView = class("MainSceneSwitchInfoView", BaseView)

function MainSceneSwitchInfoView:onInitView()
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

function MainSceneSwitchInfoView:addEvents()
	self._btnHide:AddClickListener(self._btnHideOnClick, self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function MainSceneSwitchInfoView:removeEvents()
	self._btnHide:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function MainSceneSwitchInfoView:_btnequipOnClick()
	self._curSceneSkinId = MainSceneSwitchModel.instance:getCurSceneId()

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

function MainSceneSwitchInfoView:_delaySwitchScene()
	MainSceneSwitchController.instance:switchScene()
end

function MainSceneSwitchInfoView:_delaySwitchSceneInitFinish()
	logError("MainSceneSwitchInfoView _delaySwitchSceneInitFinish timeout!")
	self:_onSwitchSceneInitFinish()
end

function MainSceneSwitchInfoView:_onSwitchSceneInitFinish()
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

function MainSceneSwitchInfoView:_delayFinishForPlayLoadingAnim()
	self:_showSceneStatus()
	self:_updateBtnStatus()
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.CloseSwitchSceneLoading)
end

function MainSceneSwitchInfoView:_playStory()
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

function MainSceneSwitchInfoView:_showTip()
	GameFacade.showToast(ToastEnum.SceneSwitchSuccess)
	self._rootAnimator:Play("open", 0, 0)
end

function MainSceneSwitchInfoView:_btncloseOnClick()
	self:closeThis()
end

function MainSceneSwitchInfoView:_btnHideOnClick()
	if self._hideTime and Time.time - self._hideTime < 0.2 then
		return
	end

	self._hideTime = Time.time
	self._showUI = not self._showUI

	gohelper.setActive(self._goMask, self._showUI)
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.PreviewSceneSwitchUIVisible, self._showUI)
end

function MainSceneSwitchInfoView:_btntimerankOnClick()
	return
end

function MainSceneSwitchInfoView:_btnrarerankOnClick()
	return
end

function MainSceneSwitchInfoView:_showSceneStatus()
	self:_updateSceneInfo()
end

function MainSceneSwitchInfoView:_editableInitView()
	self._goswitchloading = gohelper.findChild(self.viewGO, "loadingmainview")
	self._switchAniamtor = self._goswitchloading:GetComponent("Animator")
	self._showUI = true
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._goLeft = gohelper.findChild(self.viewGO, "left")
	self._goMask = gohelper.findChild(self.viewGO, "MaskBG")
	self._rootAnimator = self.viewGO:GetComponent("Animator")

	gohelper.setActive(self._btnchange, false)
	gohelper.setActive(self._btnget, false)
	gohelper.setActive(self._goshowing, false)
	gohelper.setActive(self._goLocked, false)
	gohelper.setActive(self._goSceneLogo, true)
	gohelper.setActive(self._goUse, false)
	gohelper.setActive(self._btnequip, false)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.PreviewSceneSwitchUIVisible, self._onSceneSwitchUIVisible, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.BeforeStartSwitchScene, self._onStartSwitchScene, self)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.CloseSwitchSceneLoading, self._onCloseSwitchSceneLoading, self)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneInitFinish, self._onSwitchSceneInitFinish, self)
end

function MainSceneSwitchInfoView:_onStartSwitchScene()
	self._startSwitchTime = Time.time

	gohelper.setActive(self._goswitchloading, true)
	self._switchAniamtor:Play("open", 0, 0)
end

function MainSceneSwitchInfoView:_onCloseSwitchSceneLoading()
	self._switchAniamtor:Play("close", 0, 0)
end

function MainSceneSwitchInfoView:_onTouchScreen()
	if not self._showUI then
		self:_btnHideOnClick()
	end
end

function MainSceneSwitchInfoView:_updateBtnStatus()
	local sceneStatus = MainSceneSwitchModel.getSceneStatus(self._selectSceneSkinId)

	if sceneStatus ~= MainSceneSwitchEnum.SceneStutas.Unlock then
		return
	end

	local useScene = self._selectSceneSkinId == MainSceneSwitchModel.instance:getCurSceneId()

	gohelper.setActive(self._btnequip, not useScene)
	gohelper.setActive(self._goUse, useScene)
end

function MainSceneSwitchInfoView:onOpen()
	self._selectSceneSkinId = self.viewParam.sceneSkinId
	self._materialDataMOList = self.viewParam.materialDataMOList

	self:_showSceneStatus()
	self:_updateBtnStatus()
	gohelper.setActive(self._goMask, self._showUI)

	if not self.viewParam.noInfoEffect then
		self._rootAnimator:Play("info", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_get_scene)
	end
end

function MainSceneSwitchInfoView:onClose()
	if self._materialDataMOList and #self._materialDataMOList == 1 then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, self._materialDataMOList)
	end
end

function MainSceneSwitchInfoView:_onSceneSwitchUIVisible(visible)
	self._rootAnimator:Play(visible and "open" or "close", 0, 0)
end

function MainSceneSwitchInfoView:_updateSceneInfo()
	local selectedSceneConfig = lua_scene_switch.configDict[self._selectSceneSkinId]

	if not selectedSceneConfig then
		return
	end

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ShowPreviewSceneInfo, self._selectSceneSkinId)

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

function MainSceneSwitchInfoView:onDestroyView()
	return
end

return MainSceneSwitchInfoView
