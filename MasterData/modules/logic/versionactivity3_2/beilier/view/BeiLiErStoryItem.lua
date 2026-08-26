-- chunkname: @modules/logic/versionactivity3_2/beilier/view/BeiLiErStoryItem.lua

module("modules.logic.versionactivity3_2.beilier.view.BeiLiErStoryItem", package.seeall)

local BeiLiErStoryItem = class("BeiLiErStoryItem", LuaCompBase)

function BeiLiErStoryItem:init(go)
	self.viewGO = go
	self.transform = self.viewGO.transform
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#btn_click")
	self._typeNode = {}

	self:_initNode()

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function BeiLiErStoryItem:_initNode()
	self._gonormal = gohelper.findChild(self.viewGO, "unlock/#go_Normal")
	self._goendless = gohelper.findChild(self.viewGO, "unlock/#go_EndLess")
	self._gonormalgame = gohelper.findChild(self.viewGO, "unlock/#go_Normal/#txt_stageName/#go_Fight")
	self._txtnormalName = gohelper.findChildText(self.viewGO, "unlock/#go_Normal/#txt_stageName")
	self._txtnormalNum = gohelper.findChildText(self.viewGO, "unlock/#go_Normal/#txt_stageNum")
	self._gostar = gohelper.findChild(self.viewGO, "unlock/#go_Normal/#txt_stageName/Star/#go_star")
	self._gonostar = gohelper.findChild(self.viewGO, "unlock/#go_Normal/#txt_stageName/Star/no")
	self._btnclick = gohelper.findChildButton(self.viewGO, "unlock/#btn_click")
	self._goCurrent = gohelper.findChild(self.viewGO, "unlock/#go_Current")
	self._govxfinish = gohelper.findChild(self.viewGO, "unlock/vx_finish")
	self._gounlock = gohelper.findChild(self.viewGO, "unlock")
	self._govxunlockeff = gohelper.setActive(self.viewGO, "unlock/vx_unlock")
end

function BeiLiErStoryItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
end

function BeiLiErStoryItem:_btnOnClick()
	if self._isStoryEpisode then
		if self._config.storyBefore > 0 then
			local param = {}

			param.mark = true

			StoryController.instance:playStory(self._config.storyBefore, param, self._onGameFinished, self)
		else
			self:_onGameFinished()
		end
	elseif self._config.storyBefore > 0 then
		local param = {}

		param.mark = true

		StoryController.instance:playStory(self._config.storyBefore, param, self._enterGame, self)
	else
		self:_enterGame()
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, self._index)
end

function BeiLiErStoryItem:setParam(co, index, actId)
	self._config = co
	self.id = co.episodeId
	self._actId = actId
	self._index = index
	self._isStoryEpisode = self._config.gameId == 0
	self.gameId = self._config.gameId

	self:refreshUI()
end

function BeiLiErStoryItem:refreshUI()
	self._isunlock = BeiLiErModel.instance:isEpisodeUnlock(self.id)
	self._ispass = BeiLiErModel.instance:isEpisodePass(self.id)

	local isCurrent = self.id == BeiLiErModel.instance:getCurEpisode()

	gohelper.setActive(self._gounlock, self._isunlock)
	gohelper.setActive(self._goCurrent, isCurrent)

	self._txtnormalName.text = self._config.name
	self._txtnormalNum.text = string.format("%02d", self._index)

	gohelper.setActive(self._gonostar, not self._ispass)
	gohelper.setActive(self._gostar, self._ispass)
	gohelper.setActive(self._gonormalgame, not self._isStoryEpisode)
end

function BeiLiErStoryItem:_enterGame()
	if BeiLiErModel.instance:checkEpisodeFinishGame(self.id) and not BeiLiErModel.instance:isEpisodePass(self.id) then
		self:_onGameFinished()
	else
		BeiLiErGameController.instance:enterGame(self.id)
	end
end

function BeiLiErStoryItem:_onGameFinished()
	BeiLiErController.instance:_onGameFinished(self._actId, self.id)
end

function BeiLiErStoryItem:isUnlock()
	return self._isunlock
end

function BeiLiErStoryItem:playFinish()
	self._ispass = BeiLiErModel.instance:isEpisodePass(self.id)

	gohelper.setActive(self._goCurrent, false)
	gohelper.setActive(self._govxfinish, false)

	self._anim.enabled = true

	self._anim:Play("finish", 0, 0)

	if self._isunlock then
		gohelper.setActive(self._gonostar, not self._ispass)
		gohelper.setActive(self._gostar, self._ispass)
	end
end

function BeiLiErStoryItem:setFocusFlag(isFocus)
	gohelper.setActive(self._goCurrent, isFocus)
end

function BeiLiErStoryItem:playUnlock()
	self._isunlock = BeiLiErModel.instance:isEpisodeUnlock(self.id)

	local isCurrent = self.id == BeiLiErModel.instance:getCurEpisode()

	gohelper.setActive(self._govxfinish, false)
	gohelper.setActive(self._goCurrent, isCurrent)
	gohelper.setActive(self._govxunlockeff, true)
	self._anim:Play("unlock", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_2.BeiLiEr.play_ui_shengyan_beilier_open_2)
end

function BeiLiErStoryItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function BeiLiErStoryItem:removeEventListeners()
	BeiLiErController.instance:unregisterCallback(BeiLiErEvent.JumpToEpisode, self._onJumpToEpisode, self)
	self._btnclick:RemoveClickListener()
end

return BeiLiErStoryItem
