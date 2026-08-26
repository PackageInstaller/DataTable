-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiLevelView.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiLevelView", package.seeall)

local WuErLiXiLevelView = class("WuErLiXiLevelView", BaseView)
local MaxShowWidth = 464
local MinShowWidth = 0
local NoShowCount = 4
local SlideTime = 0.3

function WuErLiXiLevelView:onInitView()
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._animEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	self._gotime = gohelper.findChild(self.viewGO, "#go_Title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/#txt_limittime")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._taskAnim = gohelper.findChild(self.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	self._goTaskReddot = gohelper.findChild(self.viewGO, "#btn_Task/#go_reddot")

	local goTaskAnim = gohelper.findChild(self.viewGO, "#btn_Task/ani")

	self._animTask = goTaskAnim:GetComponent(gohelper.Type_Animator)
	self._goepisodescroll = gohelper.findChild(self.viewGO, "#scroll_StateList")
	self._goepisodecontent = gohelper.findChild(self.viewGO, "#scroll_StateList/Viewport/Content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WuErLiXiLevelView:addEvents()
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
end

function WuErLiXiLevelView:removeEvents()
	self._btnTask:RemoveClickListener()
end

function WuErLiXiLevelView:_btnTaskOnClick()
	ViewMgr.instance:openView(ViewName.WuErLiXiTaskView)
end

function WuErLiXiLevelView:_onEpisodeFinished()
	local newEpisode = WuErLiXiModel.instance:getNewFinishEpisode()

	if newEpisode then
		self:_playStoryFinishAnim()
	end
end

function WuErLiXiLevelView:_playStoryFinishAnim()
	local newEpisode = WuErLiXiModel.instance:getNewFinishEpisode()

	if newEpisode then
		for k, episodeItem in ipairs(self._episodeItems) do
			if episodeItem.id == newEpisode then
				self._finishEpisodeIndex = k

				episodeItem:playFinish()
				episodeItem:playStarAnim()
				TaskDispatcher.runDelay(self._finishStoryEnd, self, 1.5)

				break
			end
		end

		WuErLiXiModel.instance:clearFinishEpisode()
	end
end

function WuErLiXiLevelView:_onBackToLevel()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_signal)
	self._anim:Play("back", 0, 0)
	self:_refreshTask()
end

function WuErLiXiLevelView:_refreshTask()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a4WuErLiXiTask, 0) then
		self._taskAnim:Play("loop", 0, 0)
	else
		self._taskAnim:Play("idle", 0, 0)
	end
end

function WuErLiXiLevelView:_onCloseTask()
	self:_refreshTask()
end

function WuErLiXiLevelView:_addEvents()
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.OnBackToLevel, self._onBackToLevel, self)
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.OnCloseTask, self._onCloseTask, self)
end

function WuErLiXiLevelView:_removeEvents()
	self.removeEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.removeEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.OnCloseTask, self._onCloseTask, self)
end

function WuErLiXiLevelView:_editableInitView()
	self.actId = VersionActivity2_4Enum.ActivityId.WuErLiXi
	self.actConfig = ActivityConfig.instance:getActivityCo(self.actId)

	self:_initLevelItems()
	self:_addEvents()
end

function WuErLiXiLevelView:onOpen()
	RedDotController.instance:addRedDot(self._goTaskReddot, RedDotEnum.DotNode.V2a4WuErLiXiTask)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_jinru)
	self:_refreshLeftTime()
	self:_refreshTask()
	TaskDispatcher.runRepeat(self._refreshLeftTime, self, 1)
end

function WuErLiXiLevelView:_refreshLeftTime()
	self._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function WuErLiXiLevelView:_initLevelItems()
	local path = self.viewContainer:getSetting().otherRes[1]

	self._episodeItems = {}

	local episodeCos = WuErLiXiConfig.instance:getEpisodeCoList(self.actId)

	for i = 1, #episodeCos do
		local cloneGo = self:getResInst(path, self._goepisodecontent)

		self._episodeItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, WuErLiXiLevelItem, self)

		self._episodeItems[i]:setParam(episodeCos[i], i, self.actId)

		if self._episodeItems[i]:isUnlock() then
			self._curEpisodeIndex = i
		end
	end

	local curEpisodeIndex = WuErLiXiModel.instance:getCurEpisodeIndex()

	self._curEpisodeIndex = curEpisodeIndex > 0 and curEpisodeIndex or self._curEpisodeIndex

	self:_focusLvItem(self._curEpisodeIndex)
end

function WuErLiXiLevelView:_finishStoryEnd()
	if self._finishEpisodeIndex == #self._episodeItems then
		self._curEpisodeIndex = self._finishEpisodeIndex
		self._finishEpisodeIndex = nil
	else
		self._curEpisodeIndex = self._finishEpisodeIndex + 1

		self:_unlockStory()
	end
end

function WuErLiXiLevelView:_unlockStory()
	self._episodeItems[self._finishEpisodeIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
end

function WuErLiXiLevelView:_unlockLvEnd()
	self._episodeItems[self._finishEpisodeIndex + 1]:refreshUI()

	self._finishEpisodeIndex = nil
end

function WuErLiXiLevelView:_focusLvItem(index, needPlay)
	local episodeCos = WuErLiXiConfig.instance:getEpisodeCoList(VersionActivity2_4Enum.ActivityId.WuErLiXi)

	if index < NoShowCount then
		if not MinShowWidth then
			local targetY = MinShowWidth + (index - NoShowCount) * (MaxShowWidth - MinShowWidth) / (#episodeCos - NoShowCount)

			if needPlay then
				ZProj.TweenHelper.DOLocalMoveY(self._goepisodecontent.transform, targetY, SlideTime, self._onFocusEnd, self, index)
			else
				ZProj.TweenHelper.DOLocalMoveY(self._goepisodecontent.transform, targetY, SlideTime)
			end

			WuErLiXiModel.instance:setCurEpisodeIndex(index)
		end
	end
end

function WuErLiXiLevelView:_onFocusEnd(index)
	return
end

function WuErLiXiLevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
end

function WuErLiXiLevelView:onDestroyView()
	self:_removeEvents()

	self._episodeItems = nil
end

return WuErLiXiLevelView
