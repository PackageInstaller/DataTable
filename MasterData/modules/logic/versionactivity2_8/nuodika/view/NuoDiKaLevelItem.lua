-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaLevelItem.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaLevelItem", package.seeall)

local NuoDiKaLevelItem = class("NuoDiKaLevelItem", LuaCompBase)

function NuoDiKaLevelItem:init(go)
	self.go = go
	self._itemAnim = self.go:GetComponent(gohelper.Type_Animator)
	self._gostagenormal1 = gohelper.findChild(self.go, "unlock/#go_stagenormal1")
	self._txtnum1 = gohelper.findChildText(self.go, "unlock/#go_stagenormal1/info/#txt_stageNum")
	self._txtname1 = gohelper.findChildText(self.go, "unlock/#go_stagenormal1/info/#txt_stagename")
	self._gostar1 = gohelper.findChild(self.go, "unlock/#go_stagenormal1/info/star1")
	self._gostagenormal2 = gohelper.findChild(self.go, "unlock/#go_stagenormal2")
	self._txtnum2 = gohelper.findChildText(self.go, "unlock/#go_stagenormal2/info/#txt_stageNum")
	self._txtname2 = gohelper.findChildText(self.go, "unlock/#go_stagenormal2/info/#txt_stagename")
	self._gostar2 = gohelper.findChild(self.go, "unlock/#go_stagenormal2/info/star1")
	self._gostageunlock = gohelper.findChild(self.go, "unlock/#go_stageunlock")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "unlock/#btn_click")
	self._itemAnim = self.go:GetComponent(typeof(UnityEngine.Animator))
end

function NuoDiKaLevelItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.JumpToEpisode, self._onJumpToEpisode, self)
end

function NuoDiKaLevelItem:_btnOnClick()
	if not self._islvunlock then
		return
	end

	Activity180Rpc.instance:sendAct180EnterEpisodeRequest(self._actId, self.id, self._startEpisodeFinished, self)
end

function NuoDiKaLevelItem:_onJumpToEpisode(episodeId)
	if self.id ~= episodeId then
		return
	end

	Activity180Rpc.instance:sendAct180EnterEpisodeRequest(self._actId, self.id, self._startEpisodeFinished, self)
end

function NuoDiKaLevelItem:_startEpisodeFinished(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId ~= self._actId then
		return
	end

	NuoDiKaModel.instance:updateEpisodeInfo(msg.episode)
	NuoDiKaModel.instance:setCurEpisode(self._index, self.id)
	self:_playBeforeStory()
end

function NuoDiKaLevelItem:_playBeforeStory()
	self._startTime = ServerTime.now()

	local isPass = NuoDiKaModel.instance:isEpisodePass(self.id)

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

	local status = NuoDiKaModel.instance:getEpisodeStatus(self.id)

	if status == NuoDiKaEnum.EpisodeStatus.BeforeStory then
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

function NuoDiKaLevelItem:_onBeforeStoryFinished()
	Activity180Rpc.instance:sendAct180StoryRequest(self._actId, self.id, self._onStartUnlockBeforeStory, self)
end

function NuoDiKaLevelItem:_onStartUnlockBeforeStory(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId ~= self._actId then
		return
	end

	NuoDiKaModel.instance:updateEpisodeInfo(msg.episode)

	if self._isStoryEpisode and self._config.afterStory == 0 then
		NuoDiKaModel.instance:setNewFinishEpisode(self.id)
	end

	self:_enterGame()
end

function NuoDiKaLevelItem:_enterGame()
	local isPass = NuoDiKaModel.instance:isEpisodePass(self.id)

	if isPass then
		if not self._isStoryEpisode then
			local data = {}

			data.episodeId = self.id
			data.callback = self._enterAfterStory
			data.callbackObj = self

			NuoDiKaController.instance:enterGameView(data)
		else
			self:_enterAfterStory()
		end

		return
	end

	local status = NuoDiKaModel.instance:getEpisodeStatus(self.id)

	if status == NuoDiKaEnum.EpisodeStatus.MapGame then
		local data = {}

		data.episodeId = self.id
		data.callback = self._onGameFinished
		data.callbackObj = self

		NuoDiKaController.instance:enterGameView(data)
	else
		self:_enterAfterStory()
	end
end

function NuoDiKaLevelItem:_onGameFinished()
	Activity180Rpc.instance:sendAct180GameFinishRequest(self._actId, self.id, self._onStartUnlockGame, self)
end

function NuoDiKaLevelItem:_onStartUnlockGame(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId ~= self._actId then
		return
	end

	NuoDiKaModel.instance:updateEpisodeInfo(msg.episode)

	if self._config.afterStory == 0 then
		NuoDiKaModel.instance:setNewFinishEpisode(self.id)
	end

	self:_enterAfterStory()
end

function NuoDiKaLevelItem:_enterAfterStory()
	local isPass = NuoDiKaModel.instance:isEpisodePass(self.id)

	if isPass then
		if self._config.afterStory > 0 then
			StoryController.instance:playStory(self._config.afterStory, nil, self._levelFinished, self)
		else
			self:_levelFinished()
		end

		return
	end

	local status = NuoDiKaModel.instance:getEpisodeStatus(self.id)

	if status == NuoDiKaEnum.EpisodeStatus.AfterStory then
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

function NuoDiKaLevelItem:_onAfterStoryFinished()
	Activity180Rpc.instance:sendAct180StoryRequest(self._actId, self.id, self._onStartUnlockAfterStory, self)
end

function NuoDiKaLevelItem:_onStartUnlockAfterStory(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.activityId ~= self._actId then
		return
	end

	NuoDiKaModel.instance:updateEpisodeInfo(msg.episode)
	NuoDiKaModel.instance:setNewFinishEpisode(self.id)
	self:_levelFinished()
end

function NuoDiKaLevelItem:_levelFinished()
	TaskDispatcher.runDelay(self._backToLevel, self, 0.5)
end

function NuoDiKaLevelItem:_backToLevel()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnBackToLevel)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.EpisodeFinished)
end

function NuoDiKaLevelItem:setParam(co, index, actId)
	self._config = co
	self.id = co.episodeId
	self._actId = actId
	self._index = index
	self._isStoryEpisode = self._config.mapId == 0

	self:refreshUI()
end

function NuoDiKaLevelItem:refreshUI()
	self._islvunlock = NuoDiKaModel.instance:isEpisodeUnlock(self.id)
	self._islvpass = NuoDiKaModel.instance:isEpisodePass(self.id)

	gohelper.setActive(self._gostar2, self._islvpass)
	gohelper.setActive(self._gostar1, self._islvpass)

	self._txtname1.text = self._config.name
	self._txtname2.text = self._config.name
	self._txtnum1.text = "STAGE 0" .. self._index
	self._txtnum2.text = "STAGE 0" .. self._index

	if not self._islvunlock then
		self._itemAnim.enabled = true

		self._itemAnim:Play("lockidle", 0, 0)
	elseif not self._islvpass then
		self._itemAnim.enabled = true

		self._itemAnim:Play("normalidle", 0, 0)
	else
		self._itemAnim:Play("finishidle", 0, 0)
	end

	local isMaxEpisode = self.id == NuoDiKaModel.instance:getMaxUnlockEpisodeId()

	gohelper.setActive(self._gostagenormal1, self._islvunlock and not isMaxEpisode)
	gohelper.setActive(self._gostagenormal2, self._islvunlock and isMaxEpisode)
end

function NuoDiKaLevelItem:isUnlock()
	return self._islvunlock
end

function NuoDiKaLevelItem:playFinish()
	self._itemAnim.enabled = true

	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_level_finished)
	self._itemAnim:Play("finish", 0, 0)
	gohelper.setActive(self._gostagenormal1, true)

	self._islvpass = NuoDiKaModel.instance:isEpisodePass(self.id)

	gohelper.setActive(self._gostar2, self._islvpass)
	gohelper.setActive(self._gostar1, self._islvpass)
	gohelper.setActive(self._gostagenormal2, false)
end

function NuoDiKaLevelItem:playUnlock()
	gohelper.setActive(self._gostagenormal1, false)
	gohelper.setActive(self._gostagenormal2, true)

	self._itemAnim.enabled = true

	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_level_unlock)
	self._itemAnim:Play("unlock", 0, 0)
end

function NuoDiKaLevelItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function NuoDiKaLevelItem:removeEventListeners()
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.JumpToEpisode, self._onJumpToEpisode, self)
	self._btnclick:RemoveClickListener()
end

function NuoDiKaLevelItem:onDestroy()
	return
end

return NuoDiKaLevelItem
