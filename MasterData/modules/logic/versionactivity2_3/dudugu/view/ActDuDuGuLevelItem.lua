-- chunkname: @modules/logic/versionactivity2_3/dudugu/view/ActDuDuGuLevelItem.lua

module("modules.logic.versionactivity2_3.dudugu.view.ActDuDuGuLevelItem", package.seeall)

local ActDuDuGuLevelItem = class("ActDuDuGuLevelItem", LuaCompBase)

function ActDuDuGuLevelItem:init(go)
	self.go = go
	self._gogameicon = gohelper.findChild(self.go, "unlock/#go_gameicon")
	self._imagegameicon = gohelper.findChildImage(self.go, "unlock/#go_gameicon")
	self._gostagenormal = gohelper.findChild(self.go, "unlock/#go_stagenormal")
	self._gostageunlock = gohelper.findChild(self.go, "unlock/#go_stageunlock")
	self._gostagefinish = gohelper.findChild(self.go, "unlock/#go_stagefinish")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "unlock/#btn_click")
	self._txtname = gohelper.findChildText(self.go, "unlock/info/#txt_stagename")
	self._txtnum = gohelper.findChildText(self.go, "unlock/info/#txt_stageNum")
	self._txtstage = gohelper.findChildText(self.go, "unlock/info/txt_stage")
	self._btnreview = gohelper.findChildButtonWithAudio(self.go, "unlock/info/#btn_review")
	self._gostarno = gohelper.findChild(self.go, "unlock/info/star1/no")
	self._imagestarno = gohelper.findChildImage(self.go, "unlock/info/star1/no")
	self._gostar = gohelper.findChild(self.go, "unlock/info/star1/#go_star")
	self._anim = self.go:GetComponent(gohelper.Type_Animator)
	self._goimagestar = gohelper.findChild(self._gostar, "#image_Star")
	self._animStar = self._goimagestar:GetComponent(gohelper.Type_Animation)
end

function ActDuDuGuLevelItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
	self._btnreview:AddClickListener(self._btnOnReview, self)
end

function ActDuDuGuLevelItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self._btnreview:RemoveClickListener()
end

function ActDuDuGuLevelItem:onDestroy()
	return
end

function ActDuDuGuLevelItem:_btnOnClick()
	if not self._islvunlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	ActDuDuGuModel.instance:setCurLvIndex(self._index)
	self:_playBeforeStory()
end

function ActDuDuGuLevelItem:_playBeforeStory()
	if self._config.beforeStory > 0 then
		local param = {}

		param.mark = true
		param.episodeId = self._config.id

		if self._config.battleId <= 0 then
			DungeonRpc.instance:sendStartDungeonRequest(self._config.chapterId, self._config.id)
		end

		StoryController.instance:playStory(self._config.beforeStory, param, self._enterFight, self)
	else
		self:_enterFight()
	end
end

function ActDuDuGuLevelItem:_enterFight()
	if self._config.battleId and self._config.battleId > 0 then
		DungeonRpc.instance:sendStartDungeonRequest(self._config.chapterId, self._config.id)
		DungeonFightController.instance:enterFightByBattleId(self._config.chapterId, self._config.id, self._config.battleId)
	else
		self:_enterAfterStory()
	end
end

function ActDuDuGuLevelItem:_enterAfterStory()
	if self._config.afterStory > 0 then
		local param = {}

		param.mark = true
		param.episodeId = self._config.id

		StoryController.instance:playStory(self._config.afterStory, param, self._onLevelFinished, self)
	else
		self:_onLevelFinished()
	end
end

function ActDuDuGuLevelItem:_onLevelFinished()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function ActDuDuGuLevelItem:_btnOnReview()
	return
end

function ActDuDuGuLevelItem:setParam(co, index, actId)
	self._config = co
	self.id = co.id
	self._episodeInfo = DungeonModel.instance:getEpisodeInfo(self.id)
	self._actId = actId
	self._index = index

	self:_refreshUI()
end

function ActDuDuGuLevelItem:_refreshUI()
	self._txtname.text = self._config.name
	self._txtnum.text = "0" .. self._index

	gohelper.setActive(self._gogameicon, self._config.battleId > 0)
	self:refreshStatus()
end

function ActDuDuGuLevelItem:refreshStatus()
	self._islvunlock = ActDuDuGuModel.instance:isLevelUnlock(self._actId, self.id)
	self._islvpass = ActDuDuGuModel.instance:isLevelPass(self._actId, self.id)

	if self._islvunlock then
		local animName = self._islvpass and "finishidle" or "normalidle"

		self._anim:Play(animName)
	else
		self._anim:Play("lockidle")
	end
end

function ActDuDuGuLevelItem:lockStatus()
	self._anim:Play("finishidle")
end

function ActDuDuGuLevelItem:isUnlock()
	return self._islvunlock
end

function ActDuDuGuLevelItem:playFinish()
	self._anim:Play("finish", 0, 0)
end

function ActDuDuGuLevelItem:playUnlock()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	self._anim:Play("unlock", 0, 0)
end

function ActDuDuGuLevelItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
	self._animStar:Play()
end

return ActDuDuGuLevelItem
