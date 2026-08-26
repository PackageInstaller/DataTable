-- chunkname: @modules/logic/versionactivity/view/VersionActivityPushBoxGameView.lua

module("modules.logic.versionactivity.view.VersionActivityPushBoxGameView", package.seeall)

local VersionActivityPushBoxGameView = class("VersionActivityPushBoxGameView", BaseView)

function VersionActivityPushBoxGameView:onInitView()
	self._btnforward = gohelper.findChildButton(self.viewGO, "controllarea/#btn_forward")
	self._btnleft = gohelper.findChildButton(self.viewGO, "controllarea/#btn_left")
	self._btnright = gohelper.findChildButton(self.viewGO, "controllarea/#btn_right")
	self._btnback = gohelper.findChildButton(self.viewGO, "controllarea/#btn_back")
	self._btnundo = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_undo")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._txtsecurityvalue = gohelper.findChildText(self.viewGO, "securitybg/#txt_securityvalue")
	self._txtsecurityvalueeffect = gohelper.findChildText(self.viewGO, "securitybg/#txt_securityvalue_effect")
	self._goresult = gohelper.findChild(self.viewGO, "#go_result")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_result/#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_result/#go_fail")
	self._simageresulticon = gohelper.findChildSingleImage(self.viewGO, "#go_result/#go_success/succeed")
	self._simagedecorate = gohelper.findChildSingleImage(self.viewGO, "#go_result/#simage_decorate")
	self._simageleft = gohelper.findChildSingleImage(self.viewGO, "#go_result/#simage_left")
	self._simageright = gohelper.findChildSingleImage(self.viewGO, "#go_result/#simage_right")
	self._btnquit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#go_fail/#btn_quit")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#go_fail/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityPushBoxGameView:addEvents()
	self._btnforward:AddClickListener(self._btnforwardOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnundo:AddClickListener(self._btnundoOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnquit:AddClickListener(self._btnquitOnClick, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.RefreshWarningNum, self._onRefreshWarningNum, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.GameWin, self._onGameWin, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.GameOver, self._onGameOver, self)
end

function VersionActivityPushBoxGameView:removeEvents()
	self._btnforward:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self._btnundo:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnquit:RemoveClickListener()
end

function VersionActivityPushBoxGameView:_btnforwardOnClick()
	self:_walk(PushBoxGameMgr.Direction.Up)
end

function VersionActivityPushBoxGameView:_btnbackOnClick()
	self:_walk(PushBoxGameMgr.Direction.Down)
end

function VersionActivityPushBoxGameView:_btnleftOnClick()
	self:_walk(PushBoxGameMgr.Direction.Left)
end

function VersionActivityPushBoxGameView:_btnrightOnClick()
	self:_walk(PushBoxGameMgr.Direction.Right)
end

function VersionActivityPushBoxGameView:_btnundoOnClick()
	self._game_mgr:revertStep()
end

function VersionActivityPushBoxGameView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.ResetPushBox, MsgBoxEnum.BoxType.Yes_No, function()
		self:_statEnd(StatEnum.Result.Reset)
		self:_statStart()
		self._game_mgr:revertGame()
	end)
end

function VersionActivityPushBoxGameView:_btnrestartOnClick()
	self._game_mgr:revertGame()

	self._gameDone = nil

	gohelper.setActive(self._goresult, false)
	self:_statStart()
end

function VersionActivityPushBoxGameView:_btnquitOnClick()
	if self._gameDone and Time.realtimeSinceStartup - self._gameDone < 1.5 then
		return
	end

	self:_onBtnClose()
end

function VersionActivityPushBoxGameView:_btntaskrewardOnClick()
	PushBoxRpc.instance:sendReceiveTaskRewardRequest(nil, 1)
end

function VersionActivityPushBoxGameView:_editableInitView()
	self._simagedecorate:LoadImage(ResUrl.getActivityWarmUpBg("bg_bodian"))

	self._bgMaterial = MonoHelper.addNoUpdateLuaComOnceToGo(self._simagedecorate.gameObject, SingleBgToMaterial)

	self._bgMaterial:loadMaterial(self._simagedecorate, "ui_black2transparent")
	self._simageleft:LoadImage(ResUrl.getVersionActivityIcon("pushbox/btn_zt1"))
	self._simageright:LoadImage(ResUrl.getVersionActivityIcon("pushbox/btn_zt2"))

	self._statViewTime = nil
end

function VersionActivityPushBoxGameView:onUpdateParam()
	return
end

function VersionActivityPushBoxGameView:onOpen()
	self.viewContainer._navigateButtonView:setOverrideClose(self._onNavigateCloseCallback, self)

	self._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	self._txtsecurityvalue.text = 0
	self._success_click = gohelper.findChildClickWithAudio(self.viewGO, "#go_result/#go_success")

	self._success_click:AddClickListener(self._successClick, self)
	TaskDispatcher.runRepeat(self._onFrame, self, 0.001)
	self:_statStart()
end

function VersionActivityPushBoxGameView:_onFrame()
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.W) then
		self:_walk(PushBoxGameMgr.Direction.Up)
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.S) then
		self:_walk(PushBoxGameMgr.Direction.Down)
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.A) then
		self:_walk(PushBoxGameMgr.Direction.Left)
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.D) then
		self:_walk(PushBoxGameMgr.Direction.Right)
	end
end

function VersionActivityPushBoxGameView:_onRefreshWarningNum(num)
	if self._game_mgr:gameIsFinish() then
		return
	end

	self._last_num = self._last_num or 0
	self._txtsecurityvalue.text = num
	self._txtsecurityvalueeffect.text = num

	if self._last_num ~= num then
		gohelper.setActive(self._txtsecurityvalueeffect.gameObject, false)
		gohelper.setActive(self._txtsecurityvalueeffect.gameObject, true)
	end

	self._last_num = num
end

function VersionActivityPushBoxGameView:_onGameWin(cur_warning)
	self._cur_warning = cur_warning

	local episodeConfig = self._game_mgr:getConfig()
	local mapId = episodeConfig.id
	local v1 = "OnPushBoxWinPause" .. mapId
	local v2 = GuideEvent[v1]
	local v3 = GuideEvent.OnPushBoxWinContinue
	local v4 = self._onWinPauseGuideOver
	local v5 = self

	GuideController.instance:GuideFlowPauseAndContinue(v1, v2, v3, v4, v5)
end

function VersionActivityPushBoxGameView:_onWinPauseGuideOver()
	self._gameDone = Time.realtimeSinceStartup

	local url

	self._simageresulticon:LoadImage(ResUrl.getPushBoxResultIcon(self._cur_warning >= 60 and "img_tcst" or self._cur_warning >= 30 and "img_scgm" or "img_jctq"))
	gohelper.setActive(self._goresult, true)
	gohelper.setActive(self._gosuccess, true)
	gohelper.setActive(self._gofail, false)

	self._win = PushBoxGameMgr.finishNewEpisode

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_develop_success)
	self:_statEnd(StatEnum.Result.Success)
end

function VersionActivityPushBoxGameView:_onGameOver()
	self._gameDone = Time.realtimeSinceStartup

	self._simageresulticon:LoadImage(ResUrl.getPushBoxResultIcon("img_shibai_jhsb"))
	gohelper.setActive(self._goresult, true)
	gohelper.setActive(self._gofail, true)
	gohelper.setActive(self._gosuccess, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_develop_fail)
	self:_statEnd(StatEnum.Result.Fail)
end

function VersionActivityPushBoxGameView:_successClick()
	if self._gameDone and Time.realtimeSinceStartup - self._gameDone < 1.5 then
		return
	end

	self:_onBtnClose()
end

function VersionActivityPushBoxGameView:_walk(direction)
	if self._gameDone then
		return
	end

	if not self._last_time then
		self._last_time = Time.realtimeSinceStartup
	elseif Time.realtimeSinceStartup - self._last_time < 0.3 then
		return
	end

	self._last_time = Time.realtimeSinceStartup

	self._game_mgr:_onMove(direction)
end

function VersionActivityPushBoxGameView:_onBtnClose()
	local param = {}

	param.id = GameSceneMgr.instance:getCurScene().gameMgr:getCurStageID()
	param.win = self._win

	ViewMgr.instance:openView(ViewName.VersionActivityPushBoxLevelView, param)
	self:closeThis()
end

function VersionActivityPushBoxGameView:onClose()
	self.viewContainer._navigateButtonView:setOverrideClose(nil, nil)
	TaskDispatcher.cancelTask(self._onFrame, self)
	self._success_click:RemoveClickListener()
	self._simageresulticon:UnLoadImage()
	self:_statEnd(StatEnum.Result.Abort)
end

function VersionActivityPushBoxGameView:_onNavigateCloseCallback()
	local red = TimeUtil.getDayFirstLoginRed("PushBoxFirstQuitGameNotice")

	if red then
		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, function()
			TimeUtil.setDayFirstLoginRed("PushBoxFirstQuitGameNotice")
			self:_onBtnClose()
		end)
	else
		self:_onBtnClose()
	end
end

function VersionActivityPushBoxGameView:onDestroyView()
	self._simagedecorate:UnLoadImage()
	self._bgMaterial:dispose()
	self._simageleft:UnLoadImage()
	self._simageright:UnLoadImage()
end

function VersionActivityPushBoxGameView:_statStart()
	if self._statViewTime then
		return
	end

	self._statViewTime = ServerTime.now()
end

function VersionActivityPushBoxGameView:_statEnd(result)
	if not self._statViewTime then
		return
	end

	local useTime = ServerTime.now() - self._statViewTime
	local episodeConfig = self._game_mgr:getConfig()
	local mapId = episodeConfig.id
	local mapName = episodeConfig.name

	self._statViewTime = nil

	StatController.instance:track(StatEnum.EventName.ExitSokoban, {
		[StatEnum.EventProperties.UseTime] = useTime,
		[StatEnum.EventProperties.MapId] = tostring(mapId),
		[StatEnum.EventProperties.MapName] = mapName,
		[StatEnum.EventProperties.Result] = result
	})
end

return VersionActivityPushBoxGameView
