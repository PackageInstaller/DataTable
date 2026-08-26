-- chunkname: @modules/logic/versionactivity3_3/marsha/view/MarshaGameView.lua

module("modules.logic.versionactivity3_3.marsha.view.MarshaGameView", package.seeall)

local MarshaGameView = class("MarshaGameView", BaseView)

function MarshaGameView:onInitView()
	self._btnStop = gohelper.findChildButtonWithAudio(self.viewGO, "UI/#btn_Stop")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "UI/#btn_Reset")
	self._goJoyStick = gohelper.findChild(self.viewGO, "UI/#go_JoyStick")
	self._gobackground = gohelper.findChild(self.viewGO, "UI/#go_JoyStick/#go_background")
	self._gohandle = gohelper.findChild(self.viewGO, "UI/#go_JoyStick/#go_background/#go_handle")
	self._goTargetList = gohelper.findChild(self.viewGO, "UI/Target/#go_TargetList")
	self._goTargetItem = gohelper.findChild(self.viewGO, "UI/Target/#go_TargetList/LayoutGroup/#go_TargetItem")
	self._goStar = gohelper.findChild(self.viewGO, "UI/Target/#go_Star")
	self._txtTarget = gohelper.findChildText(self.viewGO, "UI/Target/#txt_Target")
	self._goTimeBg1 = gohelper.findChild(self.viewGO, "UI/LeftTime/#go_TimeBg1")
	self._goTimeBg2 = gohelper.findChild(self.viewGO, "UI/LeftTime/#go_TimeBg2")
	self._txtLeftTime = gohelper.findChildText(self.viewGO, "UI/LeftTime/#txt_LeftTime")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MarshaGameView:addEvents()
	self._btnStop:AddClickListener(self._btnStopOnClick, self)
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
end

function MarshaGameView:removeEvents()
	self._btnStop:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

MarshaGameView.AddInterval = 1

function MarshaGameView:_btnStopOnClick(manual)
	self._isRunning = false

	MarshaController.instance:dispatchEvent(MarshaEvent.GamePause)

	if not manual then
		local time = math.floor(self.gameCo.time - self.time)

		ViewMgr.instance:openView(ViewName.MarshaPauseView, time)
	end
end

function MarshaGameView:_btnResetOnClick()
	self:stopGame()
	GameFacade.showMessageBox(MessageBoxIdDefine.MarshaGameResetConfirm, MsgBoxEnum.BoxType.Yes_No, self.resetGame, self.resumeGame, nil, self, self)
end

function MarshaGameView:_editableInitView()
	self.targetItemMap = {}
	self.goSkills = {}
	self.goSkillCds = {}
	self.imageCds = {}
	self.txtCds = {}
	self.goSkillTips = {}
	self.txtCdTimes = {}
	self.btnLongPress = {}
	self.clickListener = {}
	self.isLongPress = {
		false,
		false
	}

	for i = 1, 2 do
		local go = gohelper.findChild(self.viewGO, "UI/Skill/go_Skill" .. i)

		self.goSkillCds[i] = gohelper.findChild(go, "go_Cd")
		self.imageCds[i] = gohelper.findChildImage(go, "go_Cd/image_Cd")
		self.txtCds[i] = gohelper.findChildText(go, "go_Cd/txt_Cd")
		self.goSkillTips[i] = gohelper.findChild(go, "go_SkillTip")
		self.txtCdTimes[i] = gohelper.findChildText(go, "go_SkillTip/txt_CdTime")
		self.goSkills[i] = go

		local eventMgr = ZProj.TouchEventMgr.Get(go)

		eventMgr.Fobidden = true

		eventMgr:SetScrollWheelCb(self.clickSkillUp, self)

		local goClick = gohelper.findChild(go, "clickArea")

		self.btnLongPress[i] = SLFramework.UGUI.UILongPressListener.Get(goClick)

		self.btnLongPress[i]:SetLongPressTime({
			0.5,
			99999
		})
		self.btnLongPress[i]:AddLongPressListener(self.onLongPress, self, i)

		self.clickListener[i] = SLFramework.UGUI.UIClickListener.Get(goClick)

		self.clickListener[i]:AddClickUpListener(self.clickSkillUp, self, i + 2)
	end

	self.skillCdTimes = {}
	self.skillCdCntDown = {}
	self.skillUsages = {}
	self.joystick = MonoHelper.addNoUpdateLuaComOnceToGo(self._goJoyStick, VirtualFixedJoystick)
	self._isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()

	LateUpdateBeat:Add(self._onLateUpdate, self)
	TaskDispatcher.runRepeat(self.addTime, self, MarshaGameView.AddInterval)

	self.goArrow = gohelper.findChild(self._goJoyStick, "#go_background/node_roll")
	self.animTime = self._goTimeBg2:GetComponent(gohelper.Type_Animator)
end

function MarshaGameView:onOpen()
	self.navigateView = self.viewContainer.navigateView

	self.navigateView:setOverrideClose(self.overrideClose, self)
	self.navigateView:setOverrideHelp(self.onClickHelp, self)
	self.addEventCb(self, MarshaController.instance, MarshaEvent.GameStart, self.onGameStart, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseModalView, self.onPauseViewClose, self)
	self.addEventCb(self, MarshaController.instance, MarshaEvent.GameRestart, self.onGameRestart, self)
	self.addEventCb(self, MarshaController.instance, MarshaEvent.GameEnd, self.onGameEnd, self)
	self.addEventCb(self, MarshaController.instance, MarshaEvent.BallDead, self.onBallDead, self)

	self.gameCo = MarshaConfig.instance:getGameConfig(self.viewParam)
	self._txtTarget.text = self.gameCo.targetDesc

	local txt = luaLang("v3a3_marsha_gameview_remaintime")

	self._txtLeftTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, self.gameCo.time)

	local targetParams = string.split(self.gameCo.targets, "#")

	if targetParams[1] == MarshaEnum.TargetType.KillType then
		local unitTypes = string.splitToNumber(targetParams[2], ",")

		for _, unitType in ipairs(unitTypes) do
			local config = MarshaConfig.instance:getBallConfig(unitType)
			local targetItem = self:getUserDataTb_()
			local go = gohelper.cloneInPlace(self._goTargetItem)
			local image = gohelper.findChildImage(go, "image_Icon")

			if not string.nilorempty(config.image) then
				UISpriteSetMgr.instance:setV3a3MarshaSprite(image, config.image)
			end

			targetItem.allCnt = MarshaConfig.instance:getMapBallCnt(self.gameCo.mapId, unitType)
			targetItem.txtNum = gohelper.findChildText(go, "txt_Num")
			self.targetItemMap[unitType] = targetItem
		end

		gohelper.setActive(self._goTargetItem)
	end

	gohelper.setActive(self._goTargetList, targetParams[1] == MarshaEnum.TargetType.KillType)

	if not string.nilorempty(self.gameCo.useSkill) then
		self.skillIds = string.splitToNumber(self.gameCo.useSkill, "#")

		for k, skillId in ipairs(self.skillIds) do
			if skillId ~= 0 then
				local config = MarshaConfig.instance:getSkillConfig(skillId)

				self.skillCdTimes[k] = config.cd

				local txt = luaLang("marshagameview_cd")

				self.txtCdTimes[k].text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, config.cd)
			end

			gohelper.setActive(self.goSkills[k], skillId ~= 0)
		end
	end

	ViewMgr.instance:openView(ViewName.MarshaReadyView, self.viewParam)
end

function MarshaGameView:onDestroyView()
	LateUpdateBeat:Remove(self._onLateUpdate, self)
	TaskDispatcher.cancelTask(self.addTime, self)

	for i = 1, 2 do
		self.btnLongPress[i]:RemoveLongPressListener()
		self.clickListener[i]:RemoveClickUpListener()
	end
end

function MarshaGameView:overrideClose()
	self:stopGame()
	GameFacade.showMessageBox(MessageBoxIdDefine.MarshaGameExitConfirm, MsgBoxEnum.BoxType.Yes_No, self.yesClose, self.resumeGame, nil, self, self)
end

function MarshaGameView:yesClose()
	self:stat(MarshaEnum.Result.Esc)
	self:closeThis()
end

function MarshaGameView:onGameStart()
	self:refreshTargetItem()

	self.time = 0
	self._beginTime = os.time()
	self._isRunning = true

	for k, _ in pairs(self.skillCdTimes) do
		self.skillCdCntDown[k] = 0
		self.skillUsages[k] = {
			skill_num = 0,
			skill_id = self.skillIds[k]
		}

		self:refreshSkill(k)
	end

	if self.gameCo.mapId == 133101 and not GuideModel.instance:isGuideFinish(33030) then
		TaskDispatcher.runDelay(self.stopGame, self, 0.2)
		MarshaController.instance:dispatchEvent(MarshaEvent.ZTrigger, 133101)
	elseif self.gameCo.mapId == 133102 and not GuideModel.instance:isGuideFinish(33031) then
		TaskDispatcher.runDelay(self.stopGame, self, 0.2)
		MarshaController.instance:dispatchEvent(MarshaEvent.ZTrigger, 133102)
	end
end

function MarshaGameView:onPauseViewClose(viewName)
	if viewName == ViewName.MarshaPauseView or viewName == ViewName.HelpView then
		self:resumeGame()
	end
end

function MarshaGameView:resumeGame()
	self._isRunning = true

	MarshaController.instance:dispatchEvent(MarshaEvent.GameResume)
end

function MarshaGameView:onGameRestart()
	self:resetGame(true)
end

function MarshaGameView:resetGame(restart)
	if not restart then
		self:stat(MarshaEnum.Result.Reset)
	end

	MarshaController.instance:dispatchEvent(MarshaEvent.GameReset)
	ViewMgr.instance:openView(ViewName.MarshaReadyView, self.viewParam)
end

function MarshaGameView:onGameEnd(isSuccess, failReason)
	gohelper.setActive(self._goStar, isSuccess)
	self:stopGame()

	if isSuccess then
		if not MarshaEnum.Result.Success then
			local result = MarshaEnum.Result.Fail

			self:stat(result, failReason)

			local param = {
				isSuccess = isSuccess,
				gameCfg = self.gameCo
			}

			ViewMgr.instance:openView(ViewName.MarshaResultView, param)
		end
	end
end

function MarshaGameView:addTime()
	if not self._isRunning then
		return
	end

	self.time = self.time + MarshaGameView.AddInterval

	local remainTime = self.gameCo.time - self.time

	if remainTime <= 10 then
		self.animTime:Play("warring", 0, 0)
	end

	local txt = luaLang("v3a3_marsha_gameview_remaintime")

	self._txtLeftTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, math.floor(remainTime))

	gohelper.setActive(self._goTimeBg1, remainTime > 10)
	gohelper.setActive(self._goTimeBg2, remainTime <= 10)

	for k, _ in pairs(self.skillCdTimes) do
		if self.skillCdCntDown[k] > 0 then
			self.skillCdCntDown[k] = self.skillCdCntDown[k] - MarshaGameView.AddInterval

			self:refreshSkill(k)
		end
	end

	if self.time - self.gameCo.time >= 0 then
		MarshaController.instance:dispatchEvent(MarshaEvent.GameEnd, false, MarshaEnum.FailReason.NoTime)
	end
end

function MarshaGameView:refreshSkill(index)
	if self.skillCdCntDown[index] > 0 then
		self.imageCds[index].fillAmount = self.skillCdCntDown[index] / self.skillCdTimes[index]
		self.txtCds[index].text = string.format("%ds", self.skillCdCntDown[index])
	end

	gohelper.setActive(self.goSkillCds[index], self.skillCdCntDown[index] > 0)
end

function MarshaGameView:_onLateUpdate()
	if not self._isRunning then
		return
	end

	local pressKeyX, pressKeyY

	if not self._isMobilePlayer then
		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
			pressKeyX = 1
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
			pressKeyX = -0.99
		end

		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
			pressKeyY = 1
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.S) then
			pressKeyY = -1
		end
	end

	if pressKeyX or pressKeyY then
		self.joystick:setInPutValue(pressKeyX, pressKeyY)
	end

	local playerEntity = MarshaEntityMgr.instance:getPlayerEntity(true)

	if not playerEntity or playerEntity.unControl then
		return
	end

	local isDragging = self.joystick:getIsDragging()

	if isDragging or pressKeyX or pressKeyY then
		local input = self.joystick:getInputValue()

		playerEntity:move(input)

		self._needReset = true

		local angle = MarshaHelper.SignedAngle(Vector2.right, input)

		playerEntity:setAngle(angle)
		transformhelper.setEulerAngles(self.goArrow.transform, 0, 0, angle)
		gohelper.setActive(self.goArrow, true)
	elseif self._needReset then
		self:_resetJoystick()

		self._needReset = false

		playerEntity:setAngle()
		gohelper.setActive(self.goArrow, false)
	end
end

function MarshaGameView:_resetJoystick()
	if not self.joystick then
		return
	end

	self.joystick:reset()
end

function MarshaGameView:stat(result, failReason)
	StatController.instance:track(StatEnum.EventName.ExitMarshaGame, {
		[StatEnum.EventProperties.EpisodeId] = tostring(self.gameCo.mapId),
		[StatEnum.EventProperties.Result] = tostring(result),
		[StatEnum.EventProperties.UseTime] = os.time() - self._beginTime,
		[StatEnum.EventProperties.TotalRound] = self.time,
		[StatEnum.EventProperties.FailReason] = tostring(failReason),
		[StatEnum.EventProperties.SkillUsage] = self.skillUsages
	})
end

function MarshaGameView:stopGame()
	self._isRunning = false

	MarshaController.instance:dispatchEvent(MarshaEvent.GamePause)
end

function MarshaGameView:onClickHelp()
	self:stopGame()
	HelpController.instance:showHelp(self.navigateView.helpId)
end

function MarshaGameView:onBallDead(unitType)
	self:refreshTargetItem(unitType)
end

function MarshaGameView:refreshTargetItem(unitType)
	if unitType then
		local targetItem = self.targetItemMap[unitType]

		if targetItem then
			local curCnt = MarshaEntityMgr.instance:getBallCnt(unitType)
			local isFinish = curCnt == targetItem.allCnt

			targetItem.txtNum.text = isFinish and string.format("<color=#9c9c9c>%s/%s</color>", targetItem.allCnt - curCnt, targetItem.allCnt) or string.format("%s/%s", targetItem.allCnt - curCnt, targetItem.allCnt)

			gohelper.setActive(targetItem.goFinished, isFinish)
		end
	else
		for unitType, targetItem in pairs(self.targetItemMap) do
			local curCnt = MarshaEntityMgr.instance:getBallCnt(unitType)
			local isFinish = curCnt == targetItem.allCnt

			targetItem.txtNum.text = isFinish and string.format("<color=#9c9c9c>%s/%s</color>", targetItem.allCnt - curCnt, targetItem.allCnt) or string.format("%s/%s", targetItem.allCnt - curCnt, targetItem.allCnt)

			gohelper.setActive(targetItem.goFinished, isFinish)
		end
	end
end

function MarshaGameView:clickSkillUp(i)
	local touchCall = i <= 2

	if i > 2 then
		i = i - 2
	end

	if touchCall then
		if self.isLongPress[i] then
			self.isLongPress[i] = false
		elseif self.skillCdCntDown[i] <= 0 then
			MarshaSkillHelper.UseSkill(self.skillIds[i])

			self.skillCdCntDown[i] = self.skillCdTimes[i]
			self.skillUsages[i].skill_num = self.skillUsages[i].skill_num + 1

			self:refreshSkill(i)
		end
	else
		gohelper.setActive(self.goSkillTips[i], false)
	end
end

function MarshaGameView:onLongPress(i)
	self.isLongPress[i] = true

	gohelper.setActive(self.goSkillTips[i], true)
end

return MarshaGameView
