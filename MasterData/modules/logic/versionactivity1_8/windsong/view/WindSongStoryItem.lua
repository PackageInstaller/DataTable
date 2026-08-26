-- chunkname: @modules/logic/versionactivity1_8/windsong/view/WindSongStoryItem.lua

module("modules.logic.versionactivity1_8.windsong.view.WindSongStoryItem", package.seeall)

local WindSongStoryItem = class("WindSongStoryItem", LuaCompBase)

function WindSongStoryItem:init(go)
	self.viewGO = go
	self.transform = go.transform
	self._golock = gohelper.findChild(self.viewGO, "unlock/#go_stagefinish")
	self._gounLock = gohelper.findChild(self.viewGO, "unlock/#go_stagenormal")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#btn_click")
	self._txtname = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stagename")
	self._txtnum = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stageNum")
	self._gostar = gohelper.findChild(self.viewGO, "unlock/info/star1/#go_star")
	self._btnreview = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/info/#btn_review")
	self._anim = go:GetComponent(gohelper.Type_Animator)
	self._gostarAnim = gohelper.findChild(self._gostar, "#image_Star")
	self._animStar = self._gostarAnim:GetComponent(gohelper.Type_Animation)
	self._gostarNo = gohelper.findChild(self.viewGO, "unlock/info/star1/no")
end

function WindSongStoryItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
	self._btnreview:AddClickListener(self._btnOnReview, self)
end

function WindSongStoryItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self._btnreview:RemoveClickListener()
end

function WindSongStoryItem:onDestroy()
	return
end

function WindSongStoryItem:_btnOnClick()
	if not self.unlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	ActWindSongController.instance:dispatchEvent(ActWindSongEvent.StoryItemClick, self.index)
end

function WindSongStoryItem:_btnOnReview()
	self:_btnOnClick()
end

function WindSongStoryItem:setParam(co, _index)
	self.config = co
	self.id = co.id
	self.index = _index

	self:_refreshUI()
end

function WindSongStoryItem:_refreshUI()
	self:refreshStatus()

	self._txtname.text = self.config.name
	self._txtnum.text = "0" .. self.index
end

function WindSongStoryItem:refreshStatus()
	self.unlock = ActWindSongModel.instance:isLevelUnlock(self.id)

	gohelper.setActive(self._golock, not self.unlock)

	self.isPass = ActWindSongModel.instance:isLevelPass(self.id)

	gohelper.setActive(self._gostar, self.isPass)
	gohelper.setActive(self._gostarNo, not self.isPass)
end

function WindSongStoryItem:lockStatus()
	gohelper.setActive(self._golock, true)
	gohelper.setActive(self._gostar, false)
	gohelper.setActive(self._gostarNo, true)
end

function WindSongStoryItem:isUnlock()
	return self.unlock
end

function WindSongStoryItem:playStory()
	if self.isPass then
		StoryController.instance:playStory(self.config.beforeStory)
	else
		DungeonRpc.instance:sendStartDungeonRequest(self.config.chapterId, self.id)

		local param = {}

		param.mark = true
		param.episodeId = self.config.id

		StoryController.instance:playStory(self.config.beforeStory, param, self.onStoryFinished, self)
	end
end

function WindSongStoryItem:onStoryFinished()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function WindSongStoryItem:playFinish()
	self._anim:Play("finish")
end

function WindSongStoryItem:playUnlock()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	self._anim:Play("unlock")
end

function WindSongStoryItem:playStarAnim()
	self:refreshStatus()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
	self._animStar:Play()
end

return WindSongStoryItem
