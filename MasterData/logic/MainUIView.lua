-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainUIView.lua

module("logic.extensions.mainui.view.MainUIView", package.seeall)

local MainUIView = class("MainUIView", ViewComponent)
local PanelDisplayState = {
	TeamMount = 2,
	Ation = 1,
	None = 0
}

function MainUIView:ctor()
	MainUIView.super.ctor(self)

	self._initTaskView = false
	self._isActivityHided = false
	self._isTaskHided = false
end

function MainUIView:buildUI()
	local _Nego_Player = self:getGo("Nego_Player")

	self._txtName = goutil.findChildTextComponent(_Nego_Player, "txt_name")
	self._ImgC_Head = goutil.findChild(_Nego_Player, "ImgC_Head/mask/img_head")
	self._txtPower = goutil.findChildTextComponent(_Nego_Player, "power/txt_power")
	self._txtLv = goutil.findChildTextComponent(_Nego_Player, "level/txt_lv")
	self._Nego_Chat = self:getGo("Nego_Chat")
	self._Nego_Info = self:getGo("Nego_Info")
	self._TxtC_SceneName = goutil.findChildTextComponent(self._Nego_Info, "txt_scenceName")
	self._TxtC_Position = goutil.findChildTextComponent(self._Nego_Info, "txt_position")
	self._imgScene = goutil.findChild(self._Nego_Info, "img_scence")

	local bottom = self:getGo("bottom")

	self._TxtC_Time = goutil.findChildTextComponent(bottom, "txt_time")
	self._sliderExp = goutil.findChildComponent(bottom, "slider_exp", "Slider")
	self._sliderBattery = goutil.findChildComponent(bottom, "slider_ battery", "Slider")
	self._Nego_Wifi = goutil.findChildComponent(bottom, "Nego_Wifi", "UIImageSpriteChange")
	self._Nego_TaskAndTeam = self:getGo("Nego_TaskAndTeam")
	self._Btn_HideTask = goutil.findChild(self.mainGO, "Btn_HideTask")
	self._Btn_Task = goutil.findChild(self._Nego_TaskAndTeam, "TaskView/Btn_Task")
	self._Btn_Team = goutil.findChild(self._Nego_TaskAndTeam, "TaskView/Btn_Team")
	self._Task_FadeNode = goutil.findChild(self._Nego_TaskAndTeam, "TaskView")
	self._btnVoice = self:getBtn("Nego_Chat/bg/btn_microphone")
	self._btnExp = self:getBtn("bottom/btn_exp")
	self._txtExp = goutil.findChildTextComponent(self.mainGO, "bottom/txt_exp")

	goutil.setActive(self._txtExp.gameObject, false)

	self.goldBarCon = self:getGo("goldBarCon")
	self.bottomLeftGo = self:getGo("bottomLeft")
	self.bottomCenterGo = self:getGo("bottomCenter")
	self._customOpensGo = self:getGo("customOpens")
	self._btnRoleActions = self:getBtn("Nego_Chat/bg/Btn_Actions")
	self._btnRoleActionImg = self._btnRoleActions:GetComponent(ComponentType.UIImageSpriteChange)
	self._btnRoleActionPoint = self:getGo("Nego_Chat/bg/Btn_Actions/imgPoint")

	Framework.ButtonAdapter.Get(self._Btn_HideTask):IngoreGlobalClickListener(true)

	self._iconBuff = self:getGo("buffItems/buffTip")
	self._txtBuffName = self:getTxt("buffItems/buffTip/txtName")
	self._txtBuffDesc = self:getTxt("buffItemsBubble/bubble/txtDesc")
	self._goBubbleBuff = self:getGo("buffItemsBubble/bubble")
	self._btnBuffTip = self:getBtn("buffItems/buffTip")
	self._btnBuffTipClose = self:getBtn("buffItemsBubble/bubble/MaskBlock")
	self._buffItems = self:getGo("buffItems")

	self:_buildUIAthenaBlessEx()

	self._goPopupMsg = self:getGo("popupMsg")

	goutil.setActive(self._goPopupMsg, false)

	self._goPopupMsgContainer = goutil.findChild(self._goPopupMsg, "tableview/Viewport/Content")
	self._redpackTipsCon = self:getGo("redpackTips")
	self._btnTeamMount = self:getGo("Nego_Chat/bg/btnTeamMount")
	self._btnDownload = self:getGo("btnDownload")

	GameUtil.SetActive(self._btnDownload, false)
end

function MainUIView:destroyUI()
	return
end

function MainUIView:bindEvents()
	self.addClickEvent(self, self._Btn_HideTask, self._OnClickBtnHideTask, self)
	self.addClickEvent(self, self._Btn_Team, self._onClickTeam, self)
	self.addClickEvent(self, self._btnVoice, self._onClickVoice, self)
	self.addClickEvent(self, self._btnExp, self._onClickExp, self)
	self._btnRoleActions:AddClickListener(self._onClickBtnActions, self)
	self._btnBuffTip:AddClickListener(self._onBuffOpen, self)
	self._btnBuffTipClose:AddClickListener(self._onBuffClose, self)
	self._athenaBlessEx:bindEvents()
	GameUtil.addClickHandler(self._btnTeamMount, self._onClickTeamMount, self)
	GameUtil.addClickHandler(self._btnDownload, self._onClickInnerDownLoad, self)
end

function MainUIView:setBattery()
	self._sliderBattery.value = UnityEngine.SystemInfo.batteryLevel
end

function MainUIView:setSignal()
	if goutil.isNil(self.mainGO) then
		return
	end

	local result = NetworkUtil.getCurrentNetworkType()

	print("当前信号", result)

	if result == NetworkUtil.NETWORK_TYPE_WIFI then
		print("wifi", SignalStrengthUtil.getWifiStrengthLevel())
		self:_updateWifis(SignalStrengthUtil.getWifiStrengthLevel())
	else
		print("4g", SignalStrengthUtil.getSignalStrengthLevel())

		if SignalStrengthUtil.getSignalStrengthLevel() > 0 then
			self:_updateWifis(5)
		else
			self:_updateWifis(0)
		end
	end
end

function MainUIView:_updateWifis(level)
	if level >= 1 and level <= 2 then
		level = 2
	elseif level >= 4 then
		level = 4
	elseif level <= 0 then
		level = 0
	end

	self._Nego_Wifi:ChangeStateNow(level)
end

function MainUIView:addClickEvent(go, handler, handlerObj)
	if go ~= nil then
		self.btnList = self.btnList or {}

		local btn = GameUtil.asBtn(go)

		btn:AddClickListener(handler, handlerObj)
		table.insert(self.btnList, btn)
	end
end

function MainUIView:rmAllClickEvent()
	for i, btn in ipairs(self.btnList) do
		btn:RemoveClickListener()
	end

	self.btnList = nil
end

function MainUIView:unbindEvents()
	self:rmAllClickEvent()
	self._btnRoleActions:RemoveClickListener()
	self._btnBuffTip:RemoveClickListener()
	self._btnBuffTipClose:RemoveClickListener()
	self._athenaBlessEx:unbindEvents()
	GameUtil.rmClickHandler(self._btnTeamMount)
	GameUtil.rmClickHandler(self._btnDownload)
end

function MainUIView:onEnter()
	settimer(60, self.setBattery, self)
	self:_updatePlayerInfo()
	self:_updateScenePos()
	self:_setCurSceneName(SceneMgr.instance:getCurSceneId())
	self:setBattery()
	self:_SetTime()
	self:_setPlayerPower(RoleModel.instance:getMaxPower())
	self:_updateRoleActionsPoint()

	self._showActions = false

	self:_updateBtnActionsState()
	self:_updateTeamMountBtn()
	self:_switchPanelDisplayState(PanelDisplayState.None)
	self:_initPopupMsg()
	settimer(0.5, self._updateRoleActionsPoint, self)
	SceneMainPlayer.instance:getMainPlayer().transform:addListener(UnitNotify.PosChanged, self._updateScenePos, self)
	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor)
	GlobalDispatcher:dispatch(GlobalNotify.MainUIEntered)
	GlobalDispatcher:addListener(GlobalNotify.OnSignalStrength, self.setSignal, self)
	MainUIController.instance:setMainBottomLeftGo(self.bottomLeftGo, self._viewPresentor)
	MainUIJumpController.instance:setPresentor(self._viewPresentor)
	MainUIJumpController.instance:setMainBottomCenterGo(self.bottomCenterGo)
	MainUIJumpController.instance:setMainRightGo(self._customOpensGo)
	GlobalDispatcher:addListener(GlobalNotify.ServerTimeSync, self._SetTime, self)
	GlobalDispatcher:addListener(GlobalNotify.PlayerStrengthChange, self._setPlayerPower, self)
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._OnSceneLoaded, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._onMatChange, self)
	GlobalDispatcher:addListener(GlobalNotify.TimedItemChange, self._refreshBuffContent, self)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamJoinTeam, self._onJoinTeam, self)
	GlobalDispatcher:addListener(GlobalNotify.PopupMsgReqAddView, self._onAddPopMsg, self)
	GlobalDispatcher:addListener(GlobalNotify.PopupMsgReqDelView, self._onDelPopMsg, self)
	GlobalDispatcher:addListener(GlobalNotify.PopupMsgReqDestroySelf, self._onDestroyPopMsgCell, self)
	OperationSignInController.instance:updateActivityId()

	if rescache.resLoadMode == Framework.ResourceLoadMode.RemoteAssetBundle and BootstrapLauncher.setSleepTimeBetweenGroup then
		BootstrapLauncher.instance:setSleepTimeBetweenGroup(2, 1)
	end

	self._athenaBlessEx:onEnter()
	GroupRedpackController.instance:setCurrContainer(self._redpackTipsCon, self._viewPresentor.viewName)
	self.addGEvent(self, GlobalNotify.TeamMountStatusChanged, self._handleChangeTeamMountStatus, self)
	self.addGEvent(self, GlobalNotify.TaskViewDataListUpdate, self._onTaskViewDataListUpdate, self)
	self.addGEvent(self, GlobalNotify.INNER_DOWNLOAD_INITED, self._onInnerDownloadInited, self)
	self:_onInnerDownloadInited()
end

function MainUIView:_updatePlayerInfo()
	self._txtName.text = RoleModel.instance:getUserName()

	local lv, exp = MofangModel.instance:getCurLvAndExp()
	local needExp = MofangModel.instance:getUpNeedExp(lv)

	self._txtLv.text = lv
	self._sliderExp.value = needExp <= 0 and 1 or exp / needExp
	self._txtExp.text = string.format("%s/%s", exp, needExp)

	HeadItemController.instance:setMyHeadCell(self._ImgC_Head)
end

function MainUIView:onExit()
	removetimer(self._updateRoleActionsPoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.ServerTimeSync, self._SetTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.PlayerStrengthChange, self._setPlayerPower, self)
	GlobalDispatcher:removeListener(GlobalNotify.SceneLoaded, self._OnSceneLoaded, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._onMatChange, self)
	removetimer(self.setBattery, self)
	MainUIController.instance:setMainBottomLeftGo(nil, nil)
	MainUIJumpController.instance:setMainBottomCenterGo(nil)
	MainUIJumpController.instance:setMainRightGo(nil)
	GlobalDispatcher:removeListener(GlobalNotify.OnSignalStrength, self.setSignal, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimedItemChange, self._refreshBuffContent, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamJoinTeam, self._onJoinTeam, self)
	GlobalDispatcher:removeListener(GlobalNotify.PopupMsgReqAddView, self._onAddPopMsg, self)
	GlobalDispatcher:removeListener(GlobalNotify.PopupMsgReqDelView, self._onDelPopMsg, self)
	GlobalDispatcher:removeListener(GlobalNotify.PopupMsgReqDestroySelf, self._onDestroyPopMsgCell, self)
	uGuiUtil.clearImage(self._iconBuff)
	removetimer(self._onBuffClose, self)
	self:_destroyPopMsgs()

	if SceneMainPlayer.instance and SceneMainPlayer.instance:getMainPlayer() then
		SceneMainPlayer.instance:getMainPlayer().transform:removeListener(UnitNotify.PosChanged, self._updateScenePos, self)
	end

	print("mainui exit")
end

function MainUIView:onExitFinished()
	return
end

function MainUIView:_onClickMap()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickMapButton)
	UIStateManager.instance:push(ViewName.Map)
end

function MainUIView:_OnClickBtnHideTask()
	print("click btn hide task")

	self._isTaskHided = not self._isTaskHided

	if self._isTaskHided then
		local x, y, z = Framework.TransformUtil.GetLocalPos(self._Nego_TaskAndTeam.transform, 0, 0, 0)

		self._Nego_TaskAndTeam.transform:DOLocalMoveX(x - 245, 0.3, false)
		self._Btn_HideTask.transform:DOLocalRotate(Vector3.New(0, 0, 180), 0.3, DG.Tweening.RotateMode.Fast)

		local tween = UnityTweens.UITweenFadeTo.StartTween(self._Task_FadeNode, 0, 0.3, UnityTweens.EaseType.easeOutSine)

		tween:AddListener(function()
			self._Task_FadeNode:SetActive(false)
		end, nil)
	else
		local x, y, z = Framework.TransformUtil.GetLocalPos(self._Nego_TaskAndTeam.transform, 0, 0, 0)

		self._Nego_TaskAndTeam.transform:DOLocalMoveX(x + 245, 0.3, false)
		self._Btn_HideTask.transform:DOLocalRotate(Vector3.New(0, 0, 0), 0.1, DG.Tweening.RotateMode.Fast)

		local tween = UnityTweens.UITweenFadeTo.StartTween(self._Task_FadeNode, 1, 0.3, UnityTweens.EaseType.easeOutSine)

		tween:RemoveListener()
		self._Task_FadeNode:SetActive(true)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SpreadButton, not self._isTaskHided)
end

function MainUIView:_OnClickBtnTask()
	UIStateManager.instance:push(ViewName.diamondtask, GameEnum.TaskViewTab.Main)
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickTaskButton)
end

function MainUIView:_onClickTeam()
	FloatWordMgr.instance:show("组队功能尚未开放")
end

function MainUIView:_onClickVoice()
	FloatWordMgr.instance:show("语音功能尚未开放")
end

function MainUIView:_onClickExp()
	print("click exp")

	local isActiveExp = self._txtExp.gameObject.activeSelf

	goutil.setActive(self._txtExp.gameObject, not isActiveExp)
end

function MainUIView:_OnClickChat()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickChatBox)
	UIStateManager.instance:open(ViewName.chat, GameEnum.ChatChannel.World)
end

function MainUIView:_OnClickDiamondTask()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickDiamondTaskButton)
	UIStateManager.instance:push(ViewName.diamondtask)
end

function MainUIView:_onClickBtnActions()
	if MountModel.instance:getIsInTeamMount() then
		if self._curDisplayState == PanelDisplayState.None then
			FloatWordMgr.instance:show("乘坐双人坐骑,不能播放场景动作")
		end

		self:_switchPanelDisplayState(PanelDisplayState.None)

		return
	end

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(146)

	if not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
		FloatWordMgr.instance:show(cfg.lockedTips)

		return
	end

	if self._curDisplayState == PanelDisplayState.None then
		self:_switchPanelDisplayState(PanelDisplayState.Ation)
	else
		self:_switchPanelDisplayState(PanelDisplayState.None)
	end
end

function MainUIView:_updateBtnActions(showActions)
	self._showActions = showActions

	local mainChat = self._viewPresentor:getViewByName("MainChatView")

	mainChat:showActions(showActions)
	self:_updateBtnActionsState()
end

function MainUIView:_updateBtnActionsState()
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(146)

	if FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
		self._btnRoleActions.gameObject:SetActive(true)
	else
		self._btnRoleActions.gameObject:SetActive(false)
	end
end

function MainUIView:_OnSceneLoaded(sceneType, sceneId)
	if not BattleController.instance:isBattling() then
		self:_setCurSceneName(sceneId)
	end
end

function MainUIView:_setCurSceneName(sceneId)
	local sceneCo = SceneConfig.instance:getSceneCo(sceneId)

	if sceneCo then
		self._TxtC_SceneName.text = sceneCo.scene_name

		uGuiUtil.setSpriteToImage(self._imgScene, uGuiUtil.SpriteType.BigBg, GameUrl.getSceneIconUrl(sceneCo.showImage))
	end
end

function MainUIView:_updateScenePos(x, y)
	if x == nil or y == nil then
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		if mainPlayer and mainPlayer.transform then
			local trans = mainPlayer.transform

			x = trans._posX
			y = trans._posY
		end
	end

	x = math.floor(checknumber(x))
	y = math.floor(checknumber(y))
	self._TxtC_Position.text = string.format("E:%s N:%s", x, y)
end

function MainUIView:_setPlayerPower(power)
	self._txtPower.text = power
end

function MainUIView:_SetTime()
	self._TxtC_Time.text = ServerTime.formatNowServerLook("%H:%M")
end

function MainUIView:_onMatChange()
	self:_updatePlayerInfo()
end

function MainUIView:_updateRoleActionsPoint()
	if self._btnRoleActionPoint then
		self._btnRoleActionPoint:SetActive(RoleActionsModel.instance:hasNewActions() and not MountModel.instance:getIsInTeamMount())
	end
end

function MainUIView:_onBuffOpen()
	goutil.setActive(self._goBubbleBuff, true)

	local autoCloseTime = 5

	settimer(autoCloseTime, self._onBuffClose, self)
end

function MainUIView:_onBuffClose()
	removetimer(self._onBuffClose, self)
	goutil.setActive(self._goBubbleBuff, false)
end

function MainUIView:_refreshBuffContent()
	local buffId, itemMo = TimedItemController.instance:getOperationSignInBuffId()
	local buffCfg, buffIcon

	if checknumber(buffId) <= 0 then
		buffId, itemMo = HalloweenGuestModel.instance:getHalloweenBuffInfo()
		buffIcon = "hud_buff"
	end

	if buffId then
		buffCfg = BattleConfig.instance:getBuffCo(buffId)
	end

	if buffCfg then
		if string.nilorempty(buffIcon) then
			uGuiUtil.setSpriteToImage(self._iconBuff, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(buffCfg.icon))
		else
			uGuiUtil.setSpriteToImage(self._iconBuff, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(buffIcon))
		end

		local t1, t2, t3 = GameUtil.getTimeHHMMSS(itemMo.expiredTimeMillis / 1000)
		local nowTime = ServerTime.now()
		local hour, min, sec = GameUtil.getTimeHHMMSS(itemMo.expiredTimeMillis / 1000 - nowTime)

		self._txtBuffDesc.text = string.format("%s\n%2d小时%2d分", buffCfg.desc, hour, min)

		goutil.setActive(self._iconBuff, true)
	else
		goutil.setActive(self._iconBuff, false)
	end
end

function MainUIView:_buildUIAthenaBlessEx()
	local go = self:getResInstance(MainViewPresentor.AthenaBlessEx)

	goutil.addChildToParent(go, self._buffItems)

	self._athenaBlessEx = AthenaBlessEx.New()

	self._athenaBlessEx:buildUI(go)
end

function MainUIView:_onJoinTeam(groupId)
	if groupId ~= 67 then
		UIStateManager.instance:push(ViewName.FormTeamCurTeamView)
	end
end

function MainUIView:_initPopupMsg()
	self:_destroyPopMsgs()

	local queue = MainUIPopupMsgController.instance:getQueue()

	self._msgCells = {}

	for i, data in ipairs(queue) do
		self:_addOnePopupMsg(data)
	end

	self:_invalidatePopMsg()
end

function MainUIView:_addOnePopupMsg(data)
	trycall(function()
		local cellTemplate = self:getGo(data.info.cellName)

		if cellTemplate and data.info.class then
			if data.info.cd == nil and data.info.showInitCD then
				data.info.cd = data.info.showInitCD + ServerTime.now()
				data.cd = data.info.cd
			end

			if data.info.cd and (data.info.cd <= 0 or data.info.cd - ServerTime.now() > 0) or data.info.showInitCD then
				local cell = goutil.cloneAndSetParent(cellTemplate, self._goPopupMsgContainer.transform)

				goutil.setActive(cell, true)

				local instance = data.info.class.New(cell, data)

				instance:startup()

				self._msgCells[data.key] = instance
			else
				dump(data.info)
			end
		else
			printError("cellTemplate or class is nil")
		end
	end)
end

function MainUIView:_destroyPopMsgs()
	if self._msgCells then
		for id, instance in pairs(self._msgCells) do
			instance:dispose()
		end

		self._msgCells = nil
	end

	self:_invalidatePopMsg()
end

function MainUIView:_onAddPopMsg(data)
	self:_addOnePopupMsg(data)
	self:_invalidatePopMsg()
end

function MainUIView:_onDelPopMsg(data)
	self:_onDestroyPopMsgCell(data)
end

function MainUIView:_onDestroyPopMsgCell(data)
	local instance = self._msgCells[data.key]

	if instance then
		instance:dispose()

		self._msgCells[data.key] = nil

		self:_invalidatePopMsg()
		MainUIPopupMsgController.instance:removePopMsg(data.key)
	end
end

function MainUIView:_invalidatePopMsg()
	local bEmpty = true

	if self._msgCells then
		for i, v in pairs(self._msgCells) do
			bEmpty = false

			break
		end
	end

	goutil.setActive(self._goPopupMsg, not bEmpty)
end

function MainUIView:_onClickTeamMount()
	local isInState = MountModel.instance:getIsInTeamMount()

	if not isInState then
		FloatWordMgr.instance:show("您还没有乘坐双人坐骑")
		self:_updateTeamMountBtn()
		self:_switchPanelDisplayState(PanelDisplayState.None)

		return
	end

	if self._curDisplayState ~= PanelDisplayState.TeamMount then
		self:_switchPanelDisplayState(PanelDisplayState.TeamMount)
	end
end

function MainUIView:_updateTeamMountBtn()
	local isInState = MountModel.instance:getIsInTeamMount()

	goutil.setActive(self._btnTeamMount, isInState)
end

function MainUIView:_onTaskViewDataListUpdate(count)
	if count == 0 and not self._isTaskHided then
		self:_OnClickBtnHideTask()
	end
end

function MainUIView:_onInnerDownloadInited()
	local active = InnerDownloadController.instance:getActive()

	GameUtil.SetActive(self._btnDownload, active)
end

function MainUIView:_onClickInnerDownLoad()
	UIStateManager.instance:push(ViewName.InnerdownloadView)
end

function MainUIView:_handleChangeTeamMountStatus()
	local isInState = MountModel.instance:getIsInTeamMount()

	self:_updateTeamMountBtn()

	if self._curDisplayState == PanelDisplayState.TeamMount and not isInState then
		self:_switchPanelDisplayState(PanelDisplayState.None)
	end
end

function MainUIView:_switchPanelDisplayState(state)
	self._curDisplayState = state

	local mainChat = self._viewPresentor:getViewByName("MainChatView")

	mainChat:showActions(false)
	mainChat:showTeamMount(false)
	self._btnRoleActionImg:ChangeStateNow(0)
	NewChatModel.instance:setMaskChatOpen(true)

	if state == PanelDisplayState.None then
		-- block empty
	elseif state == PanelDisplayState.Ation then
		mainChat:showActions(true)
		self._btnRoleActionImg:ChangeStateNow(1)
		NewChatModel.instance:setMaskChatOpen(false)
	elseif state == PanelDisplayState.TeamMount then
		mainChat:showTeamMount(true)
		NewChatModel.instance:setMaskChatOpen(false)
		self._btnRoleActionImg:ChangeStateNow(1)
	end
end

return MainUIView
