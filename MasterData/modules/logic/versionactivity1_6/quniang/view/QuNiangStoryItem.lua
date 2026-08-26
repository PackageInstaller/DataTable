-- chunkname: @modules/logic/versionactivity1_6/quniang/view/QuNiangStoryItem.lua

module("modules.logic.versionactivity1_6.quniang.view.QuNiangStoryItem", package.seeall)

local QuNiangStoryItem = class("QuNiangStoryItem", LuaCompBase)

function QuNiangStoryItem:init(go)
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

function QuNiangStoryItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
	self._btnreview:AddClickListener(self._btnOnReview, self)
end

function QuNiangStoryItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self._btnreview:RemoveClickListener()
end

function QuNiangStoryItem:onDestroy()
	return
end

function QuNiangStoryItem:_btnOnClick()
	if not self.unlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	ActQuNiangController.instance:dispatchEvent(ActQuNiangEvent.StoryItemClick, self.index)
end

function QuNiangStoryItem:_btnOnReview()
	self:_btnOnClick()
end

function QuNiangStoryItem:setParam(co, _index)
	self.config = co
	self.id = co.id
	self.index = _index

	self:_refreshUI()
end

function QuNiangStoryItem:_refreshUI()
	self:refreshStatus()

	self._txtname.text = self.config.name
	self._txtnum.text = "0" .. self.index
end

function QuNiangStoryItem:refreshStatus()
	self.unlock = ActQuNiangModel.instance:isLevelUnlock(self.id)

	gohelper.setActive(self._golock, not self.unlock)

	self.isPass = ActQuNiangModel.instance:isLevelPass(self.id)

	gohelper.setActive(self._gostar, self.isPass)
	gohelper.setActive(self._gostarNo, not self.isPass)
end

function QuNiangStoryItem:lockStatus()
	gohelper.setActive(self._golock, true)
	gohelper.setActive(self._gostar, false)
	gohelper.setActive(self._gostarNo, true)
end

function QuNiangStoryItem:isUnlock()
	return self.unlock
end

function QuNiangStoryItem:playStory()
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

function QuNiangStoryItem:onStoryFinished()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function QuNiangStoryItem:playFinish()
	self._anim:Play("finish")
end

function QuNiangStoryItem:playUnlock()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	self._anim:Play("unlock")
end

function QuNiangStoryItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_story_star)
	self._animStar:Play()
end

return QuNiangStoryItem
