-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanEpisodeLevelView.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanEpisodeLevelView", package.seeall)

local HuiDiaoLanEpisodeLevelView = class("HuiDiaoLanEpisodeLevelView", BaseView)

function HuiDiaoLanEpisodeLevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._gostoryPath = gohelper.findChild(self.viewGO, "#go_storyPath")
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._gostoryStages = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_Title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_Title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/image_LimitTimeBG/#txt_limittime")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goreddot = gohelper.findChild(self.viewGO, "#btn_Task/#go_reddot")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HuiDiaoLanEpisodeLevelView:addEvents()
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._touch:AddClickDownListener(self._onClickDown, self)
	self._scrollStory:AddOnValueChanged(self._onScrollValueChanged, self)
	self.addEventCb(self, HuiDiaoLanGameController.instance, HuiDiaoLanEvent.SelectEpisode, self.onSelectEpisode, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self, LuaEventSystem.Low)
end

function HuiDiaoLanEpisodeLevelView:removeEvents()
	self._btnTask:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._touch:RemoveClickDownListener()
	self._scrollStory:RemoveOnValueChanged()
	self.removeEventCb(self, HuiDiaoLanGameController.instance, HuiDiaoLanEvent.SelectEpisode, self.onSelectEpisode, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

HuiDiaoLanEpisodeLevelView.scrollWidth = 5400

function HuiDiaoLanEpisodeLevelView:_btnTaskOnClick()
	local param = {}

	param.activityId = self.activityId

	HuiDiaoLanGameController.instance:openTaskView(param)
end

function HuiDiaoLanEpisodeLevelView:_editableInitView()
	self._scrollStory = gohelper.findChildScrollRect(self.viewGO, "#go_storyPath")
	self._goPath = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/path")
	self._animPath = self._goPath:GetComponent(gohelper.Type_Animator)
	self._taskAnimator = gohelper.findChild(self.viewGO, "#btn_Task/ani"):GetComponentInChildren(typeof(UnityEngine.Animator))
	self.activityId = VersionActivity3_2Enum.ActivityId.HuiDiaoLan

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.Activity220Task, self.activityId, self.refreshReddot, self)
	self:initEpisodeItem()

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local rightOffsetX = -300

	self._offsetX = (width - rightOffsetX) / 2
	self.minContentAnchorX = -HuiDiaoLanEpisodeLevelView.scrollWidth + width
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gostoryPath)
	self._touch = SLFramework.UGUI.UIClickListener.Get(self._gostoryPath)
	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._gostoryPath, DungeonMapEpisodeAudio, self._scrollStory)
end

function HuiDiaoLanEpisodeLevelView:initEpisodeItem()
	self.episodeItemMap = self:getUserDataTb_()

	local parentTran = self._gostoryStages.transform
	local allEpisodeConfigList = HuiDiaoLanConfig.instance:getAllEpisodeConfigList()

	self.stageCount = parentTran.childCount

	for i = 1, self.stageCount do
		local episodeConfig = allEpisodeConfigList[i]
		local episodeItem = self.episodeItemMap[episodeConfig.episodeId]

		if not episodeItem then
			episodeItem = {
				itemParent = parentTran:GetChild(i - 1)
			}

			local name = string.format("item_%s", i)

			episodeItem.episodeItemGO = self:getResInst(self.viewContainer._viewSetting.otherRes[1], episodeItem.itemParent.gameObject, name)
			episodeItem.itemComp = MonoHelper.addNoUpdateLuaComOnceToGo(episodeItem.episodeItemGO, HuiDiaoLanEpisodeItem, {
				episodeConfig = episodeConfig,
				index = i
			})
			episodeItem.index = i
			episodeItem.episodeConfig = episodeConfig
			episodeItem.episodeId = episodeItem.episodeConfig.episodeId
			self.episodeItemMap[episodeItem.episodeId] = episodeItem
		end

		episodeItem.itemComp:onRefreshUI()
	end
end

function HuiDiaoLanEpisodeLevelView:_onDragBegin(param, pointerEventData)
	self._audioScroll:onDragBegin()
end

function HuiDiaoLanEpisodeLevelView:_onDragEnd(param, pointerEventData)
	self._audioScroll:onDragEnd()
end

function HuiDiaoLanEpisodeLevelView:_onScrollValueChanged()
	return
end

function HuiDiaoLanEpisodeLevelView:_onClickDown()
	self._audioScroll:onClickDown()
end

function HuiDiaoLanEpisodeLevelView:onUpdateParam()
	if self.viewParam.episodeId and self.viewParam.episodeId > 0 then
		self.curEpisodeId = self.viewParam.episodeId or HuiDiaoLanModel.instance:getInitEpisodeId()
	end

	self:focusEpisodeItem(self.curEpisodeId, true, true)
end

function HuiDiaoLanEpisodeLevelView:onOpen()
	HuiDiaoLanTaskListModel.instance:init(self.activityId)

	if self.viewParam.episodeId and self.viewParam.episodeId > 0 then
		self.curEpisodeId = self.viewParam.episodeId or HuiDiaoLanModel.instance:getInitEpisodeId()
	end

	self:refreshTime()
	self:refreshEpisodePath()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:focusEpisodeItem(self.curEpisodeId, false, false)
end

function HuiDiaoLanEpisodeLevelView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.activityId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		if offsetSecond > 0 then
			self._txtlimittime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

			return
		end
	end

	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function HuiDiaoLanEpisodeLevelView:refreshEpisodePath()
	local newUnFinishEpisodeId = HuiDiaoLanModel.instance:getInitEpisodeId()
	local curEpisodeItem = self.episodeItemMap[newUnFinishEpisodeId]
	local curEpisodeIndex = Mathf.Max(0, curEpisodeItem.index - 1)
	local pathAnimName = curEpisodeIndex == 0 and "path0" or string.format("path%d_idle", curEpisodeIndex)

	self._animPath:Play(pathAnimName, 0, 0)
	self._animPath:Update(0)
end

function HuiDiaoLanEpisodeLevelView:refreshReddot(reddot)
	reddot:defaultRefreshDot()

	local showRedDot = reddot.show

	self._taskAnimator:Play(showRedDot and "loop" or "idle")
end

function HuiDiaoLanEpisodeLevelView:onSelectEpisode(episodeId)
	for _, episodeItem in pairs(self.episodeItemMap) do
		episodeItem.itemComp:setSelectState(episodeId)
	end

	self.curEpisodeId = episodeId

	self:focusEpisodeItem(episodeId, true)
	AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_level)
end

function HuiDiaoLanEpisodeLevelView:curEpisodeItemPlayFinishAnim()
	local curEpisodeItem = self.episodeItemMap[self.curEpisodeId]

	if curEpisodeItem then
		curEpisodeItem.itemComp:playFinishAnim()
	end

	local nextEpisodeCo = HuiDiaoLanConfig.instance:getNextEpisodeCo(self.curEpisodeId)

	if nextEpisodeCo and nextEpisodeCo.episodeId > 0 then
		local curEpisodeIndex = curEpisodeItem.index

		self._animPath:Play("path" .. curEpisodeIndex, 0, 0)
		self._animPath:Update(0)
		TaskDispatcher.runDelay(self.playEpisodeUnlockAnim, self, 0.2)
		TaskDispatcher.runDelay(self.refreshEpisodePath, self, 0.5)
	end

	AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_level)
end

function HuiDiaoLanEpisodeLevelView:playEpisodeUnlockAnim()
	if self.curEpisodeId and self.curEpisodeId > 0 then
		HuiDiaoLanGameController.instance:dispatchEvent(HuiDiaoLanEvent.NextEpisodePlayUnlockAnim, self.curEpisodeId)
		self:moveToUnlockEpisode()
	end

	HuiDiaoLanModel.instance:setCurEpisodeId(0)
end

function HuiDiaoLanEpisodeLevelView:moveToUnlockEpisode()
	local nextEpisodeId = HuiDiaoLanModel.instance:getInitEpisodeId()

	self:focusEpisodeItem(nextEpisodeId, true, true)
end

function HuiDiaoLanEpisodeLevelView:focusEpisodeItem(episodeId, needPlay, justMove)
	local item = self.episodeItemMap[episodeId]
	local contentAnchorX = recthelper.getAnchorX(item.itemComp.go.transform.parent)
	local offsetX = self._offsetX - contentAnchorX

	if offsetX > 0 then
		offsetX = 0
	elseif offsetX < self.minContentAnchorX then
		offsetX = self.minContentAnchorX
	end

	if needPlay then
		if justMove then
			ZProj.TweenHelper.DOAnchorPosX(self._gostoryScroll.transform, offsetX, 0.26)
		else
			ZProj.TweenHelper.DOAnchorPosX(self._gostoryScroll.transform, offsetX, 0.26, self.onFocusEnd, self, {
				episodeId = episodeId
			})
		end
	else
		ZProj.TweenHelper.DOAnchorPosX(self._gostoryScroll.transform, offsetX, 0)
	end
end

function HuiDiaoLanEpisodeLevelView:onFocusEnd(param)
	self.curEpisodeId = param.episodeId

	local episodeCo = HuiDiaoLanConfig.instance:getEpisodeConfig(self.curEpisodeId)

	if episodeCo.gameId > 0 then
		if episodeCo.storyBefore > 0 then
			local storyParam = {}

			storyParam.episodeId = self.curEpisodeId
			storyParam.mark = true
			storyParam.episodeId = self.curEpisodeId

			StoryController.instance:playStory(episodeCo.storyBefore, storyParam, self.enterGameView, self)
		else
			self:enterGameView()
		end
	elseif episodeCo.storyBefore > 0 then
		StoryController.instance:playStory(episodeCo.storyBefore)
	end

	HuiDiaoLanModel.instance:cleanNewUnlockEpisodeInfoList()
end

function HuiDiaoLanEpisodeLevelView:enterGameView()
	local param = {}

	param.episodeId = self.curEpisodeId

	HuiDiaoLanGameController.instance:openGameView(param)
end

function HuiDiaoLanEpisodeLevelView:sendEpisodeFinished()
	local isEpisodeFinish = HuiDiaoLanModel.instance:getEpisodeFinishState(self.curEpisodeId)

	if isEpisodeFinish then
		return
	end

	Activity220Rpc.instance:sendAct220FinishEpisodeRequest(self.activityId, self.curEpisodeId)
end

function HuiDiaoLanEpisodeLevelView:onCloseViewFinish(viewName)
	if not self.curEpisodeId or self.curEpisodeId == 0 then
		return
	end

	if viewName == ViewName.HuiDiaoLanGameView then
		local isWin = HuiDiaoLanGameModel.instance:getWinState(self.curEpisodeId)
		local episodeCo = HuiDiaoLanConfig.instance:getEpisodeConfig(self.curEpisodeId)

		if episodeCo.storyClear > 0 and not StoryModel.instance:isStoryFinished(episodeCo.storyClear) and isWin then
			local storyParam = {}

			storyParam.mark = true
			storyParam.episodeId = self.curEpisodeId

			self:sendEpisodeFinished()
			StoryController.instance:playStory(episodeCo.storyClear, storyParam, self.curEpisodeItemPlayFinishAnim, self)
		elseif episodeCo.storyClear > 0 and StoryModel.instance:isStoryFinished(episodeCo.storyClear) then
			StoryController.instance:playStory(episodeCo.storyClear)
		elseif episodeCo.storyClear == 0 then
			local isEpisodeFinish = HuiDiaoLanModel.instance:getEpisodeFinishState(self.curEpisodeId)

			if not isEpisodeFinish and isWin then
				self:sendEpisodeFinished()
				self:curEpisodeItemPlayFinishAnim()
			end
		end
	elseif viewName == ViewName.StoryFrontView then
		local isEpisodeFinish = HuiDiaoLanModel.instance:getEpisodeFinishState(self.curEpisodeId)
		local episodeCo = HuiDiaoLanConfig.instance:getEpisodeConfig(self.curEpisodeId)

		if episodeCo.gameId > 0 then
			local isWin = HuiDiaoLanGameModel.instance:getWinState(self.curEpisodeId)

			if not isEpisodeFinish and isWin then
				self:sendEpisodeFinished()
				self:curEpisodeItemPlayFinishAnim()
			end
		elseif not isEpisodeFinish then
			self:sendEpisodeFinished()
			self:curEpisodeItemPlayFinishAnim()
		end
	end
end

function HuiDiaoLanEpisodeLevelView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	HuiDiaoLanModel.instance:setCurEpisodeId(0)
	HuiDiaoLanModel.instance:cleanNewUnlockEpisodeInfoList()
	TaskDispatcher.cancelTask(self.playEpisodeUnlockAnim, self)
	TaskDispatcher.cancelTask(self.refreshEpisodePath, self)
end

function HuiDiaoLanEpisodeLevelView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	HuiDiaoLanModel.instance:reInit()
end

return HuiDiaoLanEpisodeLevelView
