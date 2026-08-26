-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorStoryItem.lua

module("modules.logic.versionactivity3_3.igor.view.IgorStoryItem", package.seeall)

local IgorStoryItem = class("IgorStoryItem", LuaCompBase)

function IgorStoryItem:init(go)
	self.viewGO = go
	self.transform = self.viewGO.transform
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#btn_click")
	self._typeNode = {}

	self:_initNode()
end

function IgorStoryItem:_initNode()
	self._gonormal = gohelper.findChild(self.viewGO, "unlock/#go_Normal")
	self._gostorygame = gohelper.findChild(self.viewGO, "unlock/#go_Normal/#go_StageBG1")
	self._gonormalgame = gohelper.findChild(self.viewGO, "unlock/#go_Normal/#go_StageBG2")
	self._txtnormalName = gohelper.findChildText(self.viewGO, "unlock/#go_Normal/#txt_stageName")
	self._txtnormalNum = gohelper.findChildText(self.viewGO, "unlock/#go_Normal/#txt_stageNum")
	self._gostar = gohelper.findChild(self.viewGO, "unlock/#go_Normal/#txt_stageName/Star/#go_star")
	self._gonostar = gohelper.findChild(self.viewGO, "unlock/#go_Normal/#txt_stageName/Star/no")
	self._btnclick = gohelper.findChildButton(self.viewGO, "unlock/#btn_click")
	self._goCurrent = gohelper.findChild(self.viewGO, "unlock/#go_Current")
	self._govxfinish = gohelper.findChild(self.viewGO, "unlock/vx_finish")
	self._animFinish = self._govxfinish:GetComponent(typeof(UnityEngine.Animator))
	self._gounlock = gohelper.findChild(self.viewGO, "unlock")
	self._govxunlockeff = gohelper.setActive(self.viewGO, "unlock/vx_unlock")
	self._gostoryLock = gohelper.findChild(self.viewGO, "unlock/#go_Normal/#go_Locked1")
	self._gonormalLock = gohelper.findChild(self.viewGO, "unlock/#go_Normal/#go_Locked2")
	self._animstoryLock = self._gostoryLock:GetComponent(typeof(UnityEngine.Animator))
	self._animnormalLock = self._gonormalLock:GetComponent(typeof(UnityEngine.Animator))
end

function IgorStoryItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
end

function IgorStoryItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function IgorStoryItem:_btnOnClick()
	if not self._isunlock then
		return
	end

	if self._config.storyBefore > 0 then
		local param = {}

		param.mark = true

		StoryController.instance:playStory(self._config.storyBefore, param, self._enterGame, self)
	else
		self:_enterGame()
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, self._index)
end

function IgorStoryItem:setParam(co, index, actId)
	self._config = co
	self.id = co.episodeId
	self._actId = actId
	self._index = index
	self._isStoryEpisode = self._config.gameId == 0
	self.gameId = self._config.gameId

	self:refreshUI()
end

function IgorStoryItem:refreshUI()
	self._isunlock = self:isEpisodeUnlock()
	self._ispass = self:isEpisodePass()

	local isCurrent = self.id == self:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)

	self._txtnormalName.text = self._config.name
	self._txtnormalNum.text = string.format("%02d", self._index)

	gohelper.setActive(self._gonostar, not self._ispass)
	gohelper.setActive(self._gostar, self._ispass)
	gohelper.setActive(self._gostorygame, self._isStoryEpisode)
	gohelper.setActive(self._gonormalgame, not self._isStoryEpisode)
	gohelper.setActive(self._gostoryLock, self._isStoryEpisode)
	gohelper.setActive(self._gonormalLock, not self._isStoryEpisode)
	gohelper.setActive(self._govxfinish, self._ispass)

	if self._isunlock then
		if self._isStoryEpisode then
			self._animstoryLock:Play("idle_unlock")
		else
			self._animnormalLock:Play("idle_unlock")
		end
	elseif self._isStoryEpisode then
		self._animstoryLock:Play("idle_lock")
	else
		self._animnormalLock:Play("idle_lock")
	end
end

function IgorStoryItem:_enterGame()
	if self._isStoryEpisode then
		self:_onGameFinished()
	else
		IgorController.instance:enterGame(self._config)
	end
end

function IgorStoryItem:_onGameFinished()
	Activity220Controller.instance:onGameFinished(self._actId, self.id)
end

function IgorStoryItem:isUnlock()
	return self._isunlock
end

function IgorStoryItem:playFinish()
	self._ispass = self:isEpisodePass()

	gohelper.setActive(self._goCurrent, false)
	gohelper.setActive(self._govxfinish, true)
	self._animFinish:Play("finish", 0, 0)

	if self._isunlock then
		gohelper.setActive(self._gonostar, not self._ispass)
		gohelper.setActive(self._gostar, self._ispass)
	end
end

function IgorStoryItem:setFocusFlag(isFocus)
	gohelper.setActive(self._goCurrent, isFocus)
end

function IgorStoryItem:playUnlock()
	self._isunlock = self:isEpisodeUnlock()

	local isCurrent = self.id == self:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
	gohelper.setActive(self._govxunlockeff, true)

	if self._isStoryEpisode then
		self._animstoryLock:Play("unlock", 0, 0)
	else
		self._animnormalLock:Play("unlock", 0, 0)
	end
end

function IgorStoryItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function IgorStoryItem:isEpisodePass()
	local episodeInfo = Activity220Model.instance:getEpisodeInfo(self._actId, self.id)

	return episodeInfo and episodeInfo:isEpisodePass() or false
end

function IgorStoryItem:isEpisodeUnlock()
	local mo = Activity220Model.instance:getById(self._actId)

	return mo:isEpisodeUnlock(self.id)
end

function IgorStoryItem:getCurEpisode()
	local mo = Activity220Model.instance:getById(self._actId)

	return mo:getCurEpisode()
end

return IgorStoryItem
