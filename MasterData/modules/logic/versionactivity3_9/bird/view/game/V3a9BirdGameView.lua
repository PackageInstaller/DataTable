-- chunkname: @modules/logic/versionactivity3_9/bird/view/game/V3a9BirdGameView.lua

module("modules.logic.versionactivity3_9.bird.view.game.V3a9BirdGameView", package.seeall)

local V3a9BirdGameView = class("V3a9BirdGameView", BaseView)

function V3a9BirdGameView:onInitView()
	self._gofull = gohelper.findChild(self.viewGO, "root/fullbg")
	self._gobird = gohelper.findChild(self.viewGO, "root/#go_bird")
	self._gonormal = gohelper.findChild(self.viewGO, "root/obstacleinfo/#go_normal")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/obstacleinfo/#go_normal/#txt_num")
	self._goendless = gohelper.findChild(self.viewGO, "root/obstacleinfo/#go_endless")
	self._txtnumEndless = gohelper.findChildText(self.viewGO, "root/obstacleinfo/#go_endless/#txt_num")
	self._txtScore = gohelper.findChildText(self.viewGO, "root/score/#txt_num")
	self._gostart = gohelper.findChild(self.viewGO, "root/#go_start")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9BirdGameView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, V3a9BirdController.instance, V3a9BirdEvent.onAgainGame, self._onAgainGame, self)
end

function V3a9BirdGameView:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
	self.removeEventCb(self, V3a9BirdController.instance, V3a9BirdEvent.onAgainGame, self._onAgainGame, self)
end

function V3a9BirdGameView:_onOpenViewFinish(viewName)
	if viewName == ViewName.V3a9BirdMainView then
		self:closeThis()
	end
end

function V3a9BirdGameView:_onCloseViewFinish(viewName, viewParam)
	if viewName == ViewName.V3a9BirdResultView and self._isAgainGame or viewName == ViewName.V3a9BirdLoadingView or viewName == ViewName.StoryFrontView then
		self:_readyGame()

		self._isAgainGame = false
	end
end

function V3a9BirdGameView:_readyGame()
	gohelper.setActive(self._gostart, true)

	self._isGaming = false
	self._countdownTime = Time.time

	self._countdownAnimPlayer:Play("game_start_num", self._startGame, self)
	V3a9BirdController.instance:onStartGame()

	self._countdownAudioId = AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_diqiu_count_down)
	self._startAudioId = AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_chongran_seagull)
end

function V3a9BirdGameView:_startGame()
	if self._isGaming then
		return
	end

	self._isGaming = true
	self._countdownTime = nil

	V3a9BirdController.instance:dispatchEvent(V3a9BirdEvent.onStartGame, self._episodeId)
	gohelper.setActive(self._gostart, false)
	self:_stopCountdownAudioId()
end

function V3a9BirdGameView:_editableInitView()
	V3a9BirdController.instance:onStartGame()

	self._frameHandle = UpdateBeat:CreateListener(self._onFrame, self)

	UpdateBeat:AddListener(self._frameHandle)

	self._click = SLFramework.UGUI.UIClickListener.Get(self._gofull)

	self._click:AddClickListener(self._onClickGame, self)

	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._birdAnim = self._gobird:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gostart, false)

	self._countdownAnimPlayer = SLFramework.AnimatorPlayer.Get(self._gostart)
end

function V3a9BirdGameView:_onAgainGame()
	local birdEntity = self.viewContainer:getBirdEntity()

	if not birdEntity then
		local birdMO = V3a9BirdModel.instance:getBirdMO()

		birdEntity = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobird, V3a9BirdEntity)

		birdEntity:setMo(birdMO)
		self.viewContainer:setBirdEntity(birdEntity)
	end

	birdEntity:onStart()
	self._birdAnim:Play("idle", 0, 0)
	self.viewContainer:resetPipes()

	if not self._frameHandle then
		self._frameHandle = UpdateBeat:CreateListener(self._onFrame, self)

		UpdateBeat:AddListener(self._frameHandle)
	end

	self:refreshScore()

	self._isAgainGame = true
end

function V3a9BirdGameView:onUpdateParam()
	return
end

function V3a9BirdGameView:onOpen()
	if self.viewParam then
		self._actId = self.viewParam.actId or V3a9BirdModel.instance:getActId()
	end

	self._episodeId = V3a9BirdModel.instance:getEnterGameEpisodeId()
	self._isGaming = false

	local birdMO = V3a9BirdModel.instance:getBirdMO()
	local birdEntity = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobird, V3a9BirdEntity)

	birdEntity:setMo(birdMO)
	birdEntity:onStart()
	self.viewContainer:setBirdEntity(birdEntity)

	self._gameType = V3a9BirdModel.instance:getGameType(self._episodeId)

	gohelper.setActive(self._gonormal, self._gameType ~= V3a9BirdEnum.BirdGameType.Infinite)
	gohelper.setActive(self._goendless, self._gameType == V3a9BirdEnum.BirdGameType.Infinite)
	self:refreshScore()
end

function V3a9BirdGameView:_onClickGame()
	if V3a9BirdModel.instance:isGameOver() then
		return
	end

	self.viewContainer:flapBird()
end

function V3a9BirdGameView:_onFrame()
	if not self._isGaming then
		if self._countdownTime and Time.time - self._countdownTime > 3 then
			self:_startGame()
		end

		return
	end

	if GuideModel.instance:isGuideRunning(39020) then
		return
	end

	if V3a9BirdModel.instance:isGameOver() then
		if self._frameHandle then
			UpdateBeat:RemoveListener(self._frameHandle)

			self._frameHandle = nil
		end

		self._birdAnim:Play("dead", 0, 0)
		TaskDispatcher.runDelay(self._gameOver, self, 1.333)
		V3a9BirdController.instance:dispatchEvent(V3a9BirdEvent.onGameOver)

		return
	end

	self.viewContainer:UpdateFrame(Time.deltaTime)
end

function V3a9BirdGameView:_gameOver()
	V3a9BirdController.instance:onGameOver()
	V3a9BirdController.instance:checkOpenResultView()
end

function V3a9BirdGameView:refreshScore()
	local count = V3a9BirdModel.instance:getPassCount()

	if self._txtScore then
		self._txtScore.text = V3a9BirdModel.instance:getGameScore()
	end

	if self._gameType == V3a9BirdEnum.BirdGameType.Infinite then
		if self._txtnumEndless then
			self._txtnumEndless.text = count
		end
	elseif self._txtnum then
		local max = V3a9BirdModel.instance:getGameNeedPassNum()
		local str = count

		if count < max then
			str = string.format("%s/<color=#D6683C>%s</color>", count, max)
		else
			str = string.format("%s/%s", count, max)

			if self._frameHandle then
				UpdateBeat:RemoveListener(self._frameHandle)

				self._frameHandle = nil
			end

			self:_gameOver()
			V3a9BirdController.instance:dispatchEvent(V3a9BirdEvent.onGameOver)
		end

		self._txtnum.text = str
	end
end

function V3a9BirdGameView:onClose()
	if self._frameHandle then
		UpdateBeat:RemoveListener(self._frameHandle)

		self._frameHandle = nil
	end

	if self._click then
		self._click:RemoveClickListener()

		self._click = nil
	end

	TaskDispatcher.cancelTask(self._gameOver, self)
	self:_stopCountdownAudioId()

	if self._startAudioId then
		AudioMgr.instance:stopPlayingID(self._startAudioId)

		self._startAudioId = nil
	end
end

function V3a9BirdGameView:_stopCountdownAudioId()
	if self._countdownAudioId then
		AudioMgr.instance:stopPlayingID(self._countdownAudioId)

		self._countdownAudioId = nil
	end
end

function V3a9BirdGameView:onDestroyView()
	return
end

return V3a9BirdGameView
