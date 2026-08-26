-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiLevelItem.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiLevelItem", package.seeall)

local WuErLiXiLevelItem = class("WuErLiXiLevelItem", LuaCompBase)

function WuErLiXiLevelItem:init(go)
	self.go = go
	self._anim = self.go:GetComponent(gohelper.Type_Animator)
	self._gostagenormal1 = gohelper.findChild(self.go, "unlock/#go_stagenormal1")
	self._txtnum1 = gohelper.findChildText(self.go, "unlock/#go_stagenormal1/info/#txt_stageNum")
	self._txtname1 = gohelper.findChildText(self.go, "unlock/#go_stagenormal1/info/#txt_stagename")
	self._gostarno1 = gohelper.findChild(self.go, "unlock/#go_stagenormal1/info/star1/no")
	self._imagestarno1 = gohelper.findChildImage(self.go, "unlock/#go_stagenormal1/info/star1/no")
	self._gostar1 = gohelper.findChild(self.go, "unlock/#go_stagenormal1/info/star1/#go_star")
	self._goimagestar1 = gohelper.findChild(self._gostar1, "#image_Star")
	self._animStar1 = self._goimagestar1:GetComponent(gohelper.Type_Animation)
	self._gostagenormal2 = gohelper.findChild(self.go, "unlock/#go_stagenormal2")
	self._txtnum2 = gohelper.findChildText(self.go, "unlock/#go_stagenormal2/info/#txt_stageNum")
	self._txtname2 = gohelper.findChildText(self.go, "unlock/#go_stagenormal2/info/#txt_stagename")
	self._gostarno2 = gohelper.findChild(self.go, "unlock/#go_stagenormal2/info/star1/no")
	self._imagestarno2 = gohelper.findChildImage(self.go, "unlock/#go_stagenormal2/info/star1/no")
	self._gostar2 = gohelper.findChild(self.go, "unlock/#go_stagenormal2/info/star1/#go_star")
	self._goimagestar2 = gohelper.findChild(self._gostar2, "#image_Star")
	self._animStar2 = self._goimagestar2:GetComponent(gohelper.Type_Animation)
	self._gostageunlock = gohelper.findChild(self.go, "unlock/#go_stageunlock")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "unlock/#btn_click")
end

function WuErLiXiLevelItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
end

function WuErLiXiLevelItem:_btnOnClick()
	if not self._islvunlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	Activity180Rpc.instance:sendAct180EnterEpisodeRequest(self._actId, self.id, self._startEpisodeFinished, self)
end

function WuErLiXiLevelItem:_startEpisodeFinished(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId ~= self._actId then
		return
	end

	WuErLiXiModel.instance:updateEpisodeInfo(msg.episode)
	WuErLiXiModel.instance:setCurEpisodeIndex(self._index)
	self:_playBeforeStory()
end

function WuErLiXiLevelItem:_playBeforeStory()
	self._startTime = ServerTime.now()

	local isPass = WuErLiXiModel.instance:isEpisodePass(self.id)

	if isPass then
		if self._config.beforeStory > 0 then
			local param = {}

			param.mark = true

			StoryController.instance:playStory(self._config.beforeStory, param, self._enterGame, self)
		else
			self:_enterGame()
		end

		return
	end

	local status = WuErLiXiModel.instance:getEpisodeStatus(self.id)

	if status == WuErLiXiEnum.EpisodeStatus.BeforeStory then
		if self._config.beforeStory > 0 then
			local param = {}

			param.mark = true

			StoryController.instance:playStory(self._config.beforeStory, param, self._onBeforeStoryFinished, self)
		else
			self:_enterGame()
		end
	else
		self:_enterGame()
	end
end

function WuErLiXiLevelItem:_onBeforeStoryFinished()
	Activity180Rpc.instance:sendAct180StoryRequest(self._actId, self.id, self._onStartUnlockBeforeStory, self)
end

function WuErLiXiLevelItem:_onStartUnlockBeforeStory(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId ~= self._actId then
		return
	end

	WuErLiXiModel.instance:updateEpisodeInfo(msg.episode)

	if self._isStoryEpisode and self._config.afterStory == 0 then
		WuErLiXiModel.instance:setNewFinishEpisode(self.id)
	end

	self:_enterGame()
end

function WuErLiXiLevelItem:_enterGame()
	local isPass = WuErLiXiModel.instance:isEpisodePass(self.id)

	if isPass then
		if not self._isStoryEpisode then
			local data = {}

			data.episodeId = self.id
			data.callback = self._enterAfterStory
			data.callbackObj = self

			WuErLiXiController.instance:enterGameView(data)
		else
			self:_enterAfterStory()
		end

		return
	end

	local status = WuErLiXiModel.instance:getEpisodeStatus(self.id)

	if status == WuErLiXiEnum.EpisodeStatus.MapGame then
		local data = {}

		data.episodeId = self.id
		data.callback = self._onGameFinished
		data.callbackObj = self

		WuErLiXiController.instance:enterGameView(data)
	else
		self:_enterAfterStory()
	end
end

function WuErLiXiLevelItem:_onGameFinished()
	Activity180Rpc.instance:sendAct180GameFinishRequest(self._actId, self.id, self._onStartUnlockGame, self)
end

function WuErLiXiLevelItem:_onStartUnlockGame(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId ~= self._actId then
		return
	end

	WuErLiXiModel.instance:updateEpisodeInfo(msg.episode)

	if self._config.afterStory == 0 then
		WuErLiXiModel.instance:setNewFinishEpisode(self.id)
	end

	self:_enterAfterStory()
end

function WuErLiXiLevelItem:_enterAfterStory()
	local isPass = WuErLiXiModel.instance:isEpisodePass(self.id)

	if isPass then
		if self._config.afterStory > 0 then
			StoryController.instance:playStory(self._config.afterStory, nil, self._levelFinished, self)
		else
			self:_levelFinished()
		end

		return
	end

	local status = WuErLiXiModel.instance:getEpisodeStatus(self.id)

	if status == WuErLiXiEnum.EpisodeStatus.AfterStory then
		if self._config.afterStory > 0 then
			local param = {}

			param.mark = true

			StoryController.instance:playStory(self._config.afterStory, param, self._onAfterStoryFinished, self)
		else
			self:_levelFinished()
		end
	else
		self:_levelFinished()
	end
end

function WuErLiXiLevelItem:_onAfterStoryFinished()
	Activity180Rpc.instance:sendAct180StoryRequest(self._actId, self.id, self._onStartUnlockAfterStory, self)
end

function WuErLiXiLevelItem:_onStartUnlockAfterStory(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId ~= self._actId then
		return
	end

	WuErLiXiModel.instance:updateEpisodeInfo(msg.episode)
	WuErLiXiModel.instance:setNewFinishEpisode(self.id)
	self:_levelFinished()
end

function WuErLiXiLevelItem:_levelFinished()
	StatController.instance:track(StatEnum.EventName.WuErLiXiDungeonFinish, {
		[StatEnum.EventProperties.EpisodeId] = tostring(self.id),
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - self._startTime
	})
	TaskDispatcher.runDelay(self._backToLevel, self, 0.5)
end

function WuErLiXiLevelItem:_backToLevel()
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.OnBackToLevel)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.EpisodeFinished)
end

function WuErLiXiLevelItem:setParam(co, index, actId)
	self._config = co
	self.id = co.episodeId
	self._actId = actId
	self._index = index
	self._isStoryEpisode = self._config.mapId == 0

	self:refreshUI()
end

function WuErLiXiLevelItem:refreshUI()
	self._islvunlock = WuErLiXiModel.instance:isEpisodeUnlock(self.id)
	self._islvpass = WuErLiXiModel.instance:isEpisodePass(self.id)
	self._txtname1.text = self._config.name
	self._txtname2.text = self._config.name
	self._txtnum1.text = "0" .. self._index
	self._txtnum2.text = "0" .. self._index

	if not self._islvunlock then
		self._anim.enabled = true

		self._anim:Play("lockidle", 0, 0)
	elseif not self._islvpass then
		self._anim.enabled = true

		self._anim:Play("normalidle", 0, 0)
	end

	self._anim:Play("finishidle", 0, 0)
	gohelper.setActive(self._gostagenormal1, self._islvunlock and self._isStoryEpisode)
	gohelper.setActive(self._gostagenormal2, self._islvunlock and not self._isStoryEpisode)
end

function WuErLiXiLevelItem:isUnlock()
	return self._islvunlock
end

function WuErLiXiLevelItem:playFinish()
	self._anim.enabled = true

	self._anim:Play("finish", 0, 0)
end

function WuErLiXiLevelItem:playUnlock()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	gohelper.setActive(self._gostagenormal1, self._isStoryEpisode)
	gohelper.setActive(self._gostagenormal2, not self._isStoryEpisode)

	self._anim.enabled = true

	self._anim:Play("unlock", 0, 0)
end

function WuErLiXiLevelItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function WuErLiXiLevelItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function WuErLiXiLevelItem:onDestroy()
	return
end

return WuErLiXiLevelItem
