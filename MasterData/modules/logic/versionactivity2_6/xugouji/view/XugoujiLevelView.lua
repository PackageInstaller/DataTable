-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiLevelView.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiLevelView", package.seeall)

local XugoujiLevelView = class("XugoujiLevelView", BaseView)
local actId = VersionActivity2_6Enum.ActivityId.Xugouji

function XugoujiLevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task", AudioEnum.UI.play_ui_mission_open)
	self._goTaskAni = gohelper.findChild(self.viewGO, "#btn_Task/ani")
	self._btnChallenge = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ChallengeBtn")
	self._gostages = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._gostoryPath = gohelper.findChild(self.viewGO, "#go_storyPath")
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._scrollStory = gohelper.findChildScrollRect(self._gostoryPath, "")
	self._gored = gohelper.findChild(self.viewGO, "#btn_Task/#go_reddot")
	self._goPath = gohelper.findChild(self._goscrollcontent, "path/path_2")
	self._animPath = self._goPath:GetComponent(gohelper.Type_Animator)
	self._pathAnimator = ZProj.ProjAnimatorPlayer.Get(self._goPath)
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/#txt_limittime")
	self._taskAnimator = self._goTaskAni:GetComponent(gohelper.Type_Animator)
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/image_TryBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function XugoujiLevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnChallenge:AddClickListener(self._btnChallengeOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.EpisodeUpdate, self._onEpisodeUpdate, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshTask, self)
	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V2a6XugoujiTask)
end

function XugoujiLevelView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshTask, self)
end

function XugoujiLevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.config.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function XugoujiLevelView:_btnTrialOnClick()
	if ActivityHelper.isOpen(actId) then
		local episodeId = self.config.tryoutEpisode

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

function XugoujiLevelView:_btntaskOnClick()
	XugoujiController.instance:openTaskView()
end

function XugoujiLevelView:_btnChallengeOnClick()
	XugoujiController.instance:enterEpisode(XugoujiEnum.ChallengeEpisodeId)
end

function XugoujiLevelView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function XugoujiLevelView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function XugoujiLevelView:_onClickDown()
	self._audioScroll:onClickDown()
end

function XugoujiLevelView:_editableInitView()
	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local rightOffsetX = -300

	self._offsetX = (width - rightOffsetX) / 2
	self.minContentAnchorX = -6560 + width
	self._bgWidth = recthelper.getWidth(self._simageFullBG.transform)
	self._minBgPositionX = BootNativeUtil.getDisplayResolution() - self._bgWidth
	self._maxBgPositionX = 0
	self._bgPositonMaxOffsetX = math.abs(self._maxBgPositionX - self._minBgPositionX)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gostoryPath)
	self._touch = SLFramework.UGUI.UIClickListener.Get(self._gostoryPath)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._touch:AddClickDownListener(self._onClickDown, self)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._gostoryPath, DungeonMapEpisodeAudio, self._scrollStory)
end

function XugoujiLevelView:onOpen()
	self:refreshTime()
	self:_initStages()
	self:refreshChallengeBtn()
	self:_refreshTask()
	TaskDispatcher.runRepeat(self.refreshTime, self, 60)

	local index = self:getCurEpisodeIndex()
	local curEpisodeId = Activity188Model.instance:getCurEpisodeId()

	self:focusEpisodeItem(index + 1, curEpisodeId, false, false)
end

function XugoujiLevelView:_initStages()
	if self._stageItemList then
		return
	end

	local stagePrefabPath = self.viewContainer:getSetting().otherRes[1]

	self._stageItemList = {}
	self._curOpenEpisodeCount = Activity188Model.instance:getFinishedCount() + 1

	local curFinishedCount = Activity188Model.instance:getFinishedCount()
	local episodeCfgList = Activity188Config.instance:getEpisodeCfgList(actId)

	self.config = ActivityConfig.instance:getActivityCo(actId)

	local selectIndex = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_6XugoujiSelect .. actId, "1")

	selectIndex = tonumber(selectIndex) or 1
	selectIndex = Mathf.Clamp(selectIndex, 1, #episodeCfgList)

	if episodeCfgList[selectIndex] then
		if not episodeCfgList[selectIndex] then
			local selectedEpisode = episodeCfgList[1]
			local selectedEpisodeId = selectedEpisode.episodeId

			Activity188Model.instance:setCurEpisodeId(selectedEpisodeId)

			for i = 1, #episodeCfgList do
				local stageGo = gohelper.findChild(self._gostages, "stage" .. i)
				local cloneGo = self:getResInst(stagePrefabPath, stageGo)
				local stageItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, XugoujiLevelViewStageItem, self)

				stageItem:refreshItem(episodeCfgList[i], i)
				table.insert(self._stageItemList, stageItem)
			end

			if self._curOpenEpisodeCount == 1 then
				gohelper.setActive(self._goPath, false)
			elseif curFinishedCount == #episodeCfgList then
				gohelper.setActive(self._goPath, true)
				self._animPath:Play("go" .. curFinishedCount - 2, 0, 1)
			else
				gohelper.setActive(self._goPath, true)
				self._animPath:Play("go" .. curFinishedCount, 0, 1)
			end
		end
	end
end

function XugoujiLevelView:getCurEpisodeIndex()
	local curEpisodeId = Activity188Model.instance:getCurEpisodeId()
	local config = Activity188Config.instance:getEpisodeCfg(actId, curEpisodeId)

	if not config then
		return 1
	end

	if config then
		if not config.episodeId then
			local checkEpisodeId = 0

			for index, episodeItem in ipairs(self._stageItemList) do
				if episodeItem.episodeId == checkEpisodeId then
					return index
				end
			end
		end
	end
end

function XugoujiLevelView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		if offsetSecond > 0 then
			self._txtlimittime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

			return
		end
	end
end

function XugoujiLevelView:refreshChallengeBtn()
	local isLastLevelPass = Activity188Model.instance:isEpisodeUnlock(XugoujiEnum.ChallengeEpisodeId)

	gohelper.setActive(self._btnChallenge, isLastLevelPass)
end

function XugoujiLevelView:focusEpisodeItem(index, episodeId, isGame, needPlay, justMove)
	local item = self._stageItemList[index]

	if not item then
		return
	end

	local contentAnchorX = recthelper.getAnchorX(item.viewGO.transform.parent)
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
				episodeId,
				isGame
			})
		end
	else
		ZProj.TweenHelper.DOAnchorPosX(self._gostoryScroll.transform, offsetX, 0)
	end
end

function XugoujiLevelView:onFocusEnd(params)
	return
end

function XugoujiLevelView:_onEpisodeFinish(resultData)
	local act188StatMo = XugoujiController.instance:getStatMo()

	act188StatMo:sendDungeonFinishStatData()

	local finishCount = Activity188Model.instance:getFinishedCount()

	if finishCount < self._curOpenEpisodeCount then
		return
	end

	self._curOpenEpisodeCount = finishCount + 1

	gohelper.setActive(self._goPath, true)
	self._animPath:Play("go" .. finishCount, 0, 0)
	self._stageItemList[finishCount]:onPlayFinish()

	if self._stageItemList[finishCount + 1] then
		self._stageItemList[finishCount + 1]:onPlayUnlock()
	end

	self:_refreshTask()
end

function XugoujiLevelView:_onEpisodeUpdate()
	local finishCount = Activity188Model.instance:getFinishedCount()

	if finishCount < self._curOpenEpisodeCount then
		return
	end

	self._curOpenEpisodeCount = finishCount + 1
	self._needFinishAni = true

	self:refreshChallengeBtn()
end

function XugoujiLevelView:doEpisodeFinishedDisplay()
	if not self._needFinishAni then
		return
	end

	self._needFinishAni = false

	local finishCount = Activity188Model.instance:getFinishedCount()

	self._stageItemList[finishCount]:playFinishAni()
	gohelper.setActive(self._goPath, true)
	self._animPath:Play("go" .. finishCount, 0, 0)

	if self._stageItemList[finishCount + 1] then
		TaskDispatcher.runDelay(self.doNewEpisodeUnlockDisplay, self, 0.5)
	end
end

function XugoujiLevelView:doNewEpisodeUnlockDisplay()
	local finishCount = Activity188Model.instance:getFinishedCount()

	if self._stageItemList[finishCount + 1] then
		self._stageItemList[finishCount + 1]:playUnlockAni()

		local curEpisodeId = Activity188Model.instance:getCurEpisodeId()

		self:focusEpisodeItem(finishCount + 1, curEpisodeId, false, true)
	end
end

function XugoujiLevelView:_refreshTask()
	local hasRewards = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a6XugoujiTask, 0)

	if hasRewards then
		self._taskAnimator:Play(UIAnimationName.Loop, 0, 0)
	else
		self._taskAnimator:Play(UIAnimationName.Idle, 0, 0)
	end
end

function XugoujiLevelView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	TaskDispatcher.cancelTask(self.doNewEpisodeUnlockDisplay, self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	if self._touch then
		self._touch:RemoveClickDownListener()

		self._touch = nil
	end
end

function XugoujiLevelView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

return XugoujiLevelView
