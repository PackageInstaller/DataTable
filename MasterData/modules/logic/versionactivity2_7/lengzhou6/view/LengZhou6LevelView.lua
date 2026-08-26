-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6LevelView.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6LevelView", package.seeall)

local LengZhou6LevelView = class("LengZhou6LevelView", BaseView)
local RIGHT_OFFSET = -300
local PATH_ANIM_TIME = 0.15

function LengZhou6LevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._gostoryPath = gohelper.findChild(self.viewGO, "#go_storyPath")
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._gostoryStages = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	self._gostage1 = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage1")
	self._gostage2 = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage2")
	self._gostage3 = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage3")
	self._gostage4 = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage4")
	self._gostage5 = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage5")
	self._gostage6 = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage6")
	self._gostage7 = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage7")
	self._gostage8 = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage8")
	self._gostage9 = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage9")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_Title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_Title/#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_Title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/#txt_limittime")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goreddot = gohelper.findChild(self.viewGO, "#btn_Task/#go_reddot")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/#btn_Trial")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LengZhou6LevelView:addEvents()
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._touch:AddClickDownListener(self._onClickDown, self)
	self._btnTrial:AddClickListener(self._clickTrial, self)
end

function LengZhou6LevelView:removeEvents()
	self._btnTask:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._touch:RemoveClickDownListener()
	self._btnTrial:RemoveClickListener()
end

function LengZhou6LevelView:_clickTrial()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function LengZhou6LevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function LengZhou6LevelView:_btnTaskOnClick()
	LengZhou6Controller.instance:openTaskView()
end

function LengZhou6LevelView:_editableInitView()
	local taskAni = gohelper.findChild(self.viewGO, "#btn_Task/ani")

	self._taskAnimator = taskAni:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a7LengZhou6Task, nil, self._refreshRedDot, self)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gostoryPath)
	self._touch = SLFramework.UGUI.UIClickListener.Get(self._gostoryPath)
	self._scrollStory = self._gostoryPath:GetComponent(gohelper.Type_ScrollRect)
	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._gostoryPath, DungeonMapEpisodeAudio, self._scrollStory)
	self._transstoryScroll = self._gostoryScroll.transform
	self._ani = self.viewGO:GetComponent(gohelper.Type_Animator)

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	self._offsetX = (width - RIGHT_OFFSET) / 2

	local scrollWidth = recthelper.getWidth(self._transstoryScroll)

	self.minContentAnchorX = -scrollWidth + width
end

function LengZhou6LevelView:onOpen()
	self.actId = LengZhou6Model.instance:getAct190Id()
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self.addEventCb(self, LengZhou6Controller.instance, LengZhou6Event.OnClickEpisode, self._onClickEpisode, self)
	self.addEventCb(self, LengZhou6Controller.instance, LengZhou6Event.OnReceiveEpisodeInfo, self._refreshEpisode, self)
	self.addEventCb(self, LengZhou6Controller.instance, LengZhou6Event.OnFinishEpisode, self._onFinishEpisode, self)
	self.addEventCb(self, LengZhou6Controller.instance, LengZhou6Event.OnClickCloseGameView, self._onClickCloseGameView, self)
	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_open)
	TaskDispatcher.runDelay(self.updateStage, self, 0.5)
	self:initStage()
end

function LengZhou6LevelView:initStage()
	self._allEpisodeItemList = self:getUserDataTb_()

	local allEpisodeIds = LengZhou6Model.instance:getAllEpisodeIds()
	local path = self.viewContainer:getSetting().otherRes[1]

	for i = 1, #allEpisodeIds do
		local episodeId = allEpisodeIds[i]
		local parent = self["_gostage" .. i]
		local itemGO = self:getResInst(path, parent, episodeId)
		local episodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, LengZhou6LevelItem)

		episodeItem:initEpisodeId(i, episodeId)
		table.insert(self._allEpisodeItemList, episodeItem)
		gohelper.setActive(itemGO, false)
	end
end

function LengZhou6LevelView:_refreshEpisode()
	return
end

function LengZhou6LevelView:updateStage()
	self:focusNewestLevelItem()
	TaskDispatcher.cancelTask(self.updateStage, self)

	if self._allEpisodeItemList ~= nil then
		for _, item in pairs(self._allEpisodeItemList) do
			item:updateInfo(false)
		end
	end
end

function LengZhou6LevelView:showLeftTime()
	self._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(LengZhou6Model.instance:getCurActId())
end

function LengZhou6LevelView:onClose()
	return
end

function LengZhou6LevelView:_refreshRedDot(reddot)
	reddot:defaultRefreshDot()

	local showRedDot = reddot.show

	self._taskAnimator:Play(showRedDot and "loop" or "idle")
end

function LengZhou6LevelView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function LengZhou6LevelView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function LengZhou6LevelView:_onClickDown()
	self._audioScroll:onClickDown()
end

function LengZhou6LevelView:_onClickEpisode(actId, episodeId)
	if self.actId ~= actId then
		return
	end

	self:onFocusEnd(episodeId)
end

function LengZhou6LevelView:_onClickCloseGameView()
	self:playOpen1Ani()
end

function LengZhou6LevelView:playOpen1Ani()
	if self._ani then
		AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_open)
		self._ani:Play("open1", 0, 0)
	end
end

function LengZhou6LevelView:_onFinishEpisode(episodeId)
	if episodeId == nil then
		return
	end

	self._waitFinishAnimEpisode = episodeId

	self:playOpen1Ani()
	TaskDispatcher.runDelay(self._onFinishEpisode2, self, 1)
end

function LengZhou6LevelView:_onFinishEpisode2()
	self:focusNewestLevelItem()
	self:playEpisodeFinishAnim()
	UIBlockHelper.instance:endBlock(LengZhou6Enum.BlockKey.OneClickResetLevel)
end

function LengZhou6LevelView:getNewestLevelItem()
	local result = self._allEpisodeItemList[1]
	local newestEpisodeId = LengZhou6Model.instance:getNewestEpisodeId(self.actId)

	for _, episodeItem in ipairs(self._allEpisodeItemList) do
		if episodeItem._episodeId == newestEpisodeId then
			result = episodeItem

			break
		end
	end

	return result
end

function LengZhou6LevelView:focusNewestLevelItem(moveTime)
	local levelItem = self:getNewestLevelItem()

	if not levelItem then
		return
	end

	local contentAnchorX = recthelper.getAnchorX(levelItem.viewGO.transform.parent)
	local offsetX = self._offsetX - contentAnchorX

	if offsetX > 0 then
		offsetX = 0
	elseif offsetX < self.minContentAnchorX then
		offsetX = self.minContentAnchorX
	end

	ZProj.TweenHelper.DOAnchorPosX(self._transstoryScroll, offsetX, moveTime or 0, self.onFocusEnd, self)
end

function LengZhou6LevelView:playEpisodeFinishAnim()
	if not self._waitFinishAnimEpisode then
		return
	end

	for i, episodeItem in ipairs(self._allEpisodeItemList) do
		if episodeItem._episodeId == self._waitFinishAnimEpisode then
			self._finishEpisodeIndex = i

			if not episodeItem:finishStateEnd() then
				episodeItem:updateInfo(true)
				TaskDispatcher.runDelay(self._playEpisodeUnlockAnim, self, PATH_ANIM_TIME)
			else
				episodeItem:updateInfo(false)

				self._finishEpisodeIndex = nil
			end
		end
	end

	self._waitFinishAnimEpisode = nil
end

function LengZhou6LevelView:_playEpisodeUnlockAnim()
	if not self._finishEpisodeIndex then
		return
	end

	local nextEpisodeItem = self._allEpisodeItemList[self._finishEpisodeIndex + 1]

	if nextEpisodeItem then
		nextEpisodeItem:updateInfo(true)
	end

	self._finishEpisodeIndex = nil
end

function LengZhou6LevelView:onFocusEnd(episodeId)
	if not episodeId then
		return
	end

	LengZhou6Controller.instance:enterEpisode(episodeId)
end

function LengZhou6LevelView:onDestroyView()
	TaskDispatcher.cancelTask(self.updateStage, self)
end

return LengZhou6LevelView
