-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/view/ZhiXinQuanErStoryItem.lua

module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErStoryItem", package.seeall)

local ZhiXinQuanErStoryItem = class("ZhiXinQuanErStoryItem", LuaCompBase)
local WaitSecBeforPlayAfterStory = 1.5
local WaitEventWorkParam = "PuzzleMazeDrawController;PuzzleEvent;OnGameFinished"

function ZhiXinQuanErStoryItem:init(go)
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
	self._gostagenormal = gohelper.findChild(self.viewGO, "unlock/#go_stagenormal")
	self._gostagenormal2 = gohelper.findChild(self.viewGO, "unlock/#go_stagenormal2")
	self._gostagefinish = gohelper.findChild(self.viewGO, "unlock/#go_stagefinish")
	self._gostagefinish2 = gohelper.findChild(self.viewGO, "unlock/#go_stagefinish2")
	self._txtstageNum = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stageNum")
	self._goCurrent = gohelper.findChild(self.viewGO, "unlock/#go_Current")
	self._focusFlagPosX, self._focusFlagPosY = recthelper.getAnchor(self._goCurrent.transform)
	self._focusFlagAngleX, self._focusFlagAngleY, self._focusFlagAngleZ = transformhelper.getEulerAngles(self._goCurrent.transform)

	self.addEventCb(self, RoleActivityController.instance, RoleActivityEvent.StoryItemClick, self.onStoryItemClick, self)
	self:setFocusFlag(false)
end

function ZhiXinQuanErStoryItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
	self._btnreview:AddClickListener(self._btnOnReview, self)
end

function ZhiXinQuanErStoryItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self._btnreview:RemoveClickListener()
end

function ZhiXinQuanErStoryItem:_btnOnClick()
	if not self.unlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, self.index)
end

function ZhiXinQuanErStoryItem:onStoryItemClick(index)
	if self.index == index then
		return
	end

	self:destroyWorkFlow()
end

function ZhiXinQuanErStoryItem:_btnOnReview()
	self:_btnOnClick()
end

function ZhiXinQuanErStoryItem:setParam(co, _index, _actId)
	self.config = co
	self.id = co.id
	self.actId = _actId
	self.index = _index

	self:_refreshUI()
end

local LockedTitleColor = "#F3F3DC"
local UnlockedTitleColor = "#F3F3DC"
local LockedTitleAlpha = 0.5
local UnlockedTitleAlpha = 1

function ZhiXinQuanErStoryItem:_refreshUI()
	self:refreshStatus()

	self._txtname.text = self.config.name
	self._txtnum.text = "0" .. self.index
	self._txtstageNum.text = "0" .. self.index

	SLFramework.UGUI.GuiHelper.SetColor(self._txtname, (self.unlock or nil) and (UnlockedTitleColor or LockedTitleColor))
	ZProj.UGUIHelper.SetColorAlpha(self._txtname, (self.unlock or nil) and (UnlockedTitleAlpha or LockedTitleAlpha))
end

function ZhiXinQuanErStoryItem:refreshStatus()
	self.unlock = RoleActivityModel.instance:isLevelUnlock(self.actId, self.id)

	gohelper.setActive(self._golock, not self.unlock)

	self.isPass = RoleActivityModel.instance:isLevelPass(self.actId, self.id)

	gohelper.setActive(self._gostar, self.isPass)
	gohelper.setActive(self._gostarNo, not self.isPass)

	self.hasElement = Activity176Config.instance:getElementCo(self.actId, self.id) ~= nil

	gohelper.setActive(self._gostagenormal, not self.unlock and not self.hasElement)
	gohelper.setActive(self._gostagenormal2, not self.unlock and self.hasElement)
	gohelper.setActive(self._gostagefinish, self.unlock and not self.hasElement)
	gohelper.setActive(self._gostagefinish2, self.unlock and self.hasElement)
end

function ZhiXinQuanErStoryItem:lockStatus()
	gohelper.setActive(self._golock, true)
	gohelper.setActive(self._gostar, false)
	gohelper.setActive(self._gostarNo, true)
end

function ZhiXinQuanErStoryItem:isUnlock()
	return self.unlock
end

function ZhiXinQuanErStoryItem:playStory()
	self:destroyWorkFlow()

	self._flow = FlowSequence.New()

	if not self.isPass then
		self._flow:addWork(FunctionWork.New(self.onStartEpisode, self))
	end

	if self.config.beforeStory ~= 0 then
		self._flow:addWork(PlayStoryWork.New(self.config.beforeStory))
	end

	local littleGameCo = Activity176Config.instance:getElementCo(self.actId, self.id)

	if littleGameCo then
		self._flow:addWork(FunctionWork.New(PuzzleMazeDrawController.openGame, PuzzleMazeDrawController.instance, littleGameCo))
		self._flow:addWork(WaitEventWork.New(WaitEventWorkParam))
	end

	if not self.isPass then
		self._flow:addWork(FunctionWork.New(self.onFinishedEpisode, self))
	end

	if littleGameCo then
		self._flow:addWork(FunctionWork.New(self._lockScreen, self, true))
		self._flow:addWork(WorkWaitSeconds.New(WaitSecBeforPlayAfterStory))
		self._flow:addWork(BpCloseViewWork.New(ViewName.PuzzleMazeDrawView))
		self._flow:addWork(FunctionWork.New(self._lockScreen, self, false))
	end

	if self.config.afterStory ~= 0 then
		self._flow:addWork(PlayStoryWork.New(self.config.afterStory))
	end

	self._flow:start()
end

function ZhiXinQuanErStoryItem:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("ZhiXinQuanErStoryItem")
	else
		UIBlockMgr.instance:endBlock("ZhiXinQuanErStoryItem")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function ZhiXinQuanErStoryItem:onStartEpisode()
	DungeonRpc.instance:sendStartDungeonRequest(self.config.chapterId, self.id)
end

function ZhiXinQuanErStoryItem:onFinishedEpisode()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function ZhiXinQuanErStoryItem:destroyWorkFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function ZhiXinQuanErStoryItem:playFinish()
	self._anim:Play("finish")
end

function ZhiXinQuanErStoryItem:playUnlock()
	AudioMgr.instance:trigger(AudioEnum.UI.Act176_UnlockNewEpisode)
	self._anim:Play("unlock")
	gohelper.setActive(self._gostagefinish, not self.hasElement)
	gohelper.setActive(self._gostagefinish2, self.hasElement)
end

function ZhiXinQuanErStoryItem:playStarAnim()
	self:refreshStatus()
	self._animStar:Play()
end

function ZhiXinQuanErStoryItem:setFocusFlag(isFocus)
	gohelper.setActive(self._goCurrent, isFocus)
	recthelper.setAnchor(self._goCurrent.transform, self._focusFlagPosX, self._focusFlagPosY)
end

function ZhiXinQuanErStoryItem:setFocusFlagDir(isLeft)
	transformhelper.setEulerAngles(self._goCurrent.transform, self._focusFlagAngleX, isLeft and 180 or 0, self._focusFlagAngleZ)
end

function ZhiXinQuanErStoryItem:getFocusFlagTran()
	return self._goCurrent.transform
end

function ZhiXinQuanErStoryItem:onDestroy()
	self:destroyWorkFlow()
	self:_lockScreen(false)
end

return ZhiXinQuanErStoryItem
