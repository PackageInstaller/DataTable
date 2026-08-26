-- chunkname: @modules/logic/versionactivity3_0/karong/view/comp/KaRongStoryItem.lua

module("modules.logic.versionactivity3_0.karong.view.comp.KaRongStoryItem", package.seeall)

local KaRongStoryItem = class("KaRongStoryItem", LuaCompBase)
local WaitSecBeforPlayAfterStory = 1.5
local WaitEventWorkParam = "KaRongDrawController;KaRongDrawEvent;OnGameFinished"

function KaRongStoryItem:init(go)
	self.viewGO = go
	self.transform = go.transform
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#btn_click")
	self._txtname = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stagename")
	self._gostar = gohelper.findChild(self.viewGO, "unlock/info/star1/#go_star")
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

	self.addEventCb(self, RoleActivityController.instance, RoleActivityEvent.StoryItemClick, self.onStoryItemClick, self)
	self:setFocusFlag(false)
end

function KaRongStoryItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
end

function KaRongStoryItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function KaRongStoryItem:_btnOnClick()
	if not self.unlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, self.index)
end

function KaRongStoryItem:onStoryItemClick(index)
	if self.index == index then
		return
	end

	self:destroyWorkFlow()
end

function KaRongStoryItem:setParam(co, _index, _actId)
	self.config = co
	self.id = co.id
	self.actId = _actId
	self.index = _index

	self:_refreshUI()
end

local LockedTitleColor = "#F3F3DC"
local UnlockedTitleColor = "AEAEAE"

function KaRongStoryItem:_refreshUI()
	self:refreshStatus()

	self._txtname.text = self.config.name
	self._txtstageNum.text = self.unlock and string.format("<color=#A6AD82>0%s</color>", self.index) or string.format("<color=#AEAEAE>0%s</color>", self.index)

	SLFramework.UGUI.GuiHelper.SetColor(self._txtname, (self.unlock or nil) and (UnlockedTitleColor or LockedTitleColor))
end

function KaRongStoryItem:refreshStatus()
	self.unlock = RoleActivityModel.instance:isLevelUnlock(self.actId, self.id)
	self.isPass = RoleActivityModel.instance:isLevelPass(self.actId, self.id)

	gohelper.setActive(self._gostar, self.isPass)
	gohelper.setActive(self._gostarNo, not self.isPass)

	self.hasElement = Activity176Config.instance:getElementCo(self.actId, self.id) ~= nil

	gohelper.setActive(self._gostagenormal, not self.unlock and not self.hasElement)
	gohelper.setActive(self._gostagenormal2, not self.unlock and self.hasElement)
	gohelper.setActive(self._gostagefinish, self.unlock and not self.hasElement)
	gohelper.setActive(self._gostagefinish2, self.unlock and self.hasElement)
end

function KaRongStoryItem:lockStatus()
	gohelper.setActive(self._gostagefinish, true)
	gohelper.setActive(self._gostar, false)
	gohelper.setActive(self._gostarNo, true)
end

function KaRongStoryItem:isUnlock()
	return self.unlock
end

function KaRongStoryItem:playStory()
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
		self._flow:addWork(FunctionWork.New(KaRongDrawController.openGame, KaRongDrawController.instance, littleGameCo))
		self._flow:addWork(WaitEventWork.New(WaitEventWorkParam))
	end

	if not self.isPass then
		self._flow:addWork(FunctionWork.New(self.onFinishedEpisode, self))
	end

	if littleGameCo then
		self._flow:addWork(FunctionWork.New(self._lockScreen, self, true))
		self._flow:addWork(WorkWaitSeconds.New(WaitSecBeforPlayAfterStory))
		self._flow:addWork(BpCloseViewWork.New(ViewName.KaRongDrawView))
		self._flow:addWork(FunctionWork.New(self._lockScreen, self, false))
	end

	if self.config.afterStory ~= 0 then
		self._flow:addWork(PlayStoryWork.New(self.config.afterStory))
	end

	self._flow:start()
end

function KaRongStoryItem:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("KaRongStoryItem")
	else
		UIBlockMgr.instance:endBlock("KaRongStoryItem")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function KaRongStoryItem:onStartEpisode()
	DungeonRpc.instance:sendStartDungeonRequest(self.config.chapterId, self.id)
end

function KaRongStoryItem:onFinishedEpisode()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function KaRongStoryItem:destroyWorkFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function KaRongStoryItem:playFinish()
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_karong_finish)
	self._anim:Play("finish")
end

function KaRongStoryItem:playUnlock()
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_karong_unlock)
	self._anim:Play("unlock")
	gohelper.setActive(self._gostagefinish, not self.hasElement)
	gohelper.setActive(self._gostagefinish2, self.hasElement)
end

function KaRongStoryItem:playStarAnim()
	self:refreshStatus()
	self._animStar:Play()
end

function KaRongStoryItem:setFocusFlag(isFocus)
	gohelper.setActive(self._goCurrent, isFocus)
end

function KaRongStoryItem:getFocusFlagTran()
	return self._goCurrent.transform
end

function KaRongStoryItem:onDestroy()
	self:destroyWorkFlow()
	self:_lockScreen(false)
end

return KaRongStoryItem
