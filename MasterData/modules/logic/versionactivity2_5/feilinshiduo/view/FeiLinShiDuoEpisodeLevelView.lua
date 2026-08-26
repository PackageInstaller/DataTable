-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoEpisodeLevelView.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoEpisodeLevelView", package.seeall)

local FeiLinShiDuoEpisodeLevelView = class("FeiLinShiDuoEpisodeLevelView", BaseView)

function FeiLinShiDuoEpisodeLevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageFullBG1 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG1")
	self._gostoryPath = gohelper.findChild(self.viewGO, "#go_storyPath")
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._gostoryStages = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_Title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_Title/#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_Title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/#txt_limittime")
	self._btnPlayBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Title/#btn_PlayBtn")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goreddot = gohelper.findChild(self.viewGO, "#btn_Task/#go_reddot")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._scrollStory = gohelper.findChildScrollRect(self._gostoryPath, "")
	self._goPath = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/path/path_2")
	self._animPath = self._goPath:GetComponent(gohelper.Type_Animator)
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/image_TryBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FeiLinShiDuoEpisodeLevelView:addEvents()
	self._btnPlayBtn:AddClickListener(self._btnPlayBtnOnClick, self)
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._touch:AddClickDownListener(self._onClickDown, self)
	self._scrollStory:AddOnValueChanged(self._onScrollValueChanged, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	self.addEventCb(self, FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.SelectEpisode, self.onSelectEpisode, self)
	self.addEventCb(self, FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, self.playEpisodeUnlockAnim, self)
	self.addEventCb(self, FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.SwitchBG, self.switchBG, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self, LuaEventSystem.Low)
end

function FeiLinShiDuoEpisodeLevelView:removeEvents()
	self._btnPlayBtn:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._touch:RemoveClickDownListener()
	self._scrollStory:RemoveOnValueChanged()
	self._btnTrial:RemoveClickListener()
	self.removeEventCb(self, FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.SelectEpisode, self.onSelectEpisode, self)
	self.removeEventCb(self, FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, self.playEpisodeUnlockAnim, self)
	self.removeEventCb(self, FeiLinShiDuoGameController.instance, FeiLinShiDuoEvent.SwitchBG, self.switchBG, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

function FeiLinShiDuoEpisodeLevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.config.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function FeiLinShiDuoEpisodeLevelView:_btnTrialOnClick()
	if ActivityHelper.isOpen(self.activityId) then
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

function FeiLinShiDuoEpisodeLevelView:_btnPlayBtnOnClick()
	local activityMo = ActivityModel.instance:getActMO(self.activityId)

	if activityMo then
		::label_6_0::

		local var_6_0 = activityMo.config

		if activityMo.config then
			local storyId = activityMo.config.storyId

			StoryController.instance:playStory(storyId)
		end
	end
end

function FeiLinShiDuoEpisodeLevelView:_btnTaskOnClick()
	local param = {}

	param.activityId = self.activityId

	FeiLinShiDuoGameController.instance:openTaskView(param)
end

function FeiLinShiDuoEpisodeLevelView:_editableInitView()
	self._taskAnimator = self._btnTask.gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a5_Act185Task, nil, self.refreshReddot, self)

	self.activityId = VersionActivity2_5Enum.ActivityId.FeiLinShiDuo
	self.config = ActivityConfig.instance:getActivityCo(self.activityId)

	self:initEpisodeItem()

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local rightOffsetX = -300

	self._offsetX = (width - rightOffsetX) / 2
	self.minContentAnchorX = -4760 + width
	self._bgWidth = recthelper.getWidth(self._simageFullBG1.transform)
	self._minBgPositionX = BootNativeUtil.getDisplayResolution() - self._bgWidth
	self._maxBgPositionX = 0
	self._bgPositonMaxOffsetX = math.abs(self._maxBgPositionX - self._minBgPositionX)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gostoryPath)
	self._touch = SLFramework.UGUI.UIClickListener.Get(self._gostoryPath)
	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._gostoryPath, DungeonMapEpisodeAudio, self._scrollStory)
end

function FeiLinShiDuoEpisodeLevelView:initEpisodeItem()
	self.episodeItemList = self:getUserDataTb_()

	local parentTran = self._gostoryStages.transform

	self.stageCount = parentTran.childCount

	for i = 1, self.stageCount do
		local itemParent = parentTran:GetChild(i - 1)
		local name = string.format("item_%s", i)
		local itemObj = self:getResInst(self.viewContainer._viewSetting.otherRes[1], itemParent.gameObject, name)
		local item = MonoHelper.addLuaComOnceToGo(itemObj, FeiLinShiDuoEpisodeItem)

		item:onInit(itemObj)
		table.insert(self.episodeItemList, item)
	end
end

function FeiLinShiDuoEpisodeLevelView:_onDragBegin(param, pointerEventData)
	self._audioScroll:onDragBegin()
end

function FeiLinShiDuoEpisodeLevelView:_onDragEnd(param, pointerEventData)
	self._audioScroll:onDragEnd()
end

function FeiLinShiDuoEpisodeLevelView:_onScrollValueChanged()
	return
end

function FeiLinShiDuoEpisodeLevelView:_onClickDown()
	self._audioScroll:onClickDown()
end

function FeiLinShiDuoEpisodeLevelView:onOpen()
	self:refreshTime()
	self:refreshUI()
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)

	local index = self:getCurEpisodeIndex()

	self:focusEpisodeItem(index, self.curEpisodeId, false, false)
end

function FeiLinShiDuoEpisodeLevelView:getCurEpisodeIndex()
	local config = FeiLinShiDuoConfig.instance:getEpisodeConfig(self.activityId, self.curEpisodeId)

	if config.mapId > 0 then
		if not config.preEpisodeId then
			local checkEpisodeId = config.episodeId

			for index, episodeItem in ipairs(self.episodeItemList) do
				if episodeItem.episodeId == checkEpisodeId then
					return index
				end
			end

			return 1
		end
	end
end

function FeiLinShiDuoEpisodeLevelView:refreshUI()
	self:refreshTaskInfo()
	self:refreshEpisode()
	self:refreshEpisodeItem()
end

function FeiLinShiDuoEpisodeLevelView:refreshTaskInfo()
	FeiLinShiDuoTaskListModel.instance:init(self.activityId)
end

function FeiLinShiDuoEpisodeLevelView:refreshEpisode()
	self.curEpisodeId = FeiLinShiDuoModel.instance:getCurEpisodeId()

	local curFinishStage = FeiLinShiDuoModel.instance:getFinishStageIndex()

	if curFinishStage == 0 then
		gohelper.setActive(self._goPath, false)
	else
		gohelper.setActive(self._goPath, true)

		self._animPath.speed = 1

		self._animPath:Play("go" .. curFinishStage, 0, 1)
	end

	if curFinishStage < self.stageCount then
		if curFinishStage + 1 == self.stageCount then
			local stageEpisodes = FeiLinShiDuoConfig.instance:getStageEpisodes(self.stageCount)

			for _, episodeCo in pairs(stageEpisodes) do
				if not FeiLinShiDuoModel.instance.episodeFinishMap[episodeCo.episodeId] and episodeCo.storyId > 0 then
					self._simageFullBG:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. self.stageCount - 1))
					self._simageFullBG1:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. self.stageCount))

					break
				else
					self._simageFullBG:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. self.stageCount))
					self._simageFullBG1:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg0"))

					break
				end
			end
		else
			self._simageFullBG:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. curFinishStage))
			self._simageFullBG1:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. curFinishStage + 1))
		end
	else
		self._simageFullBG:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg" .. self.stageCount))
		self._simageFullBG1:LoadImage(ResUrl.getV2a5FeiLinShiDuoBg("v2a5_feilinshiduo_stage_fullbg0"))
	end
end

function FeiLinShiDuoEpisodeLevelView:isAllEpisodeFinish()
	local episodeConfigList = FeiLinShiDuoConfig.instance:getEpisodeConfigList()

	for index, episodeCo in ipairs(episodeConfigList) do
		if not FeiLinShiDuoModel.instance.episodeFinishMap[episodeCo.episodeId] then
			return false
		end
	end

	return true
end

function FeiLinShiDuoEpisodeLevelView:refreshEpisodeItem()
	local noGameEpisodeList = FeiLinShiDuoConfig.instance:getNoGameEpisodeList(self.activityId)

	if #noGameEpisodeList > #self.episodeItemList then
		logError("配置关卡数量不匹配，请检查")

		return
	end

	for index, item in ipairs(self.episodeItemList) do
		if index > #noGameEpisodeList then
			item:isShowItem(false)
		else
			local config = noGameEpisodeList[index]

			item:setInfo(index, config)
		end
	end
end

function FeiLinShiDuoEpisodeLevelView:onSelectEpisode(index, episodeId, isGame)
	self.curEpisodeId = episodeId

	self:focusEpisodeItem(index, episodeId, isGame, true)
end

function FeiLinShiDuoEpisodeLevelView:focusEpisodeItem(index, episodeId, isGame, needPlay, justMove)
	local item = self.episodeItemList[index]
	local contentAnchorX = recthelper.getAnchorX(item._go.transform.parent)
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

function FeiLinShiDuoEpisodeLevelView:onFocusEnd(param)
	self.curEpisodeId = param[1]
	self.isGame = param[2]

	if self.isGame then
		local gameEpisodeConfig = FeiLinShiDuoConfig.instance:getGameEpisode(self.curEpisodeId)

		if gameEpisodeConfig and gameEpisodeConfig.mapId > 0 then
			local viewParam = {
				mapId = gameEpisodeConfig.mapId,
				gameConfig = gameEpisodeConfig
			}

			FeiLinShiDuoGameController.instance:openGameView(viewParam)
		else
			logError(self.curEpisodeId .. " 该关卡没有对应的游戏关卡")
		end
	else
		local config = FeiLinShiDuoConfig.instance:getEpisodeConfig(self.activityId, self.curEpisodeId)
		local storyId = config and config.storyId

		if not storyId then
			logError("剧情关卡没有配置剧情， 请检查：" .. self.curEpisodeId)

			return
		end

		if FeiLinShiDuoModel.instance:getEpisodeFinishState(self.curEpisodeId) then
			StoryController.instance:playStory(storyId)

			return
		end

		local param = {}

		param.mark = true
		param.episodeId = self.curEpisodeId

		StoryController.instance:playStory(storyId, param, self.onStoryFinished, self)
	end
end

function FeiLinShiDuoEpisodeLevelView:onStoryFinished()
	FeiLinShiDuoGameController.instance:finishEpisode(self.activityId, self.curEpisodeId)
end

function FeiLinShiDuoEpisodeLevelView:onCloseViewFinish(viewName)
	if viewName == ViewName.FeiLinShiDuoResultView or viewName == ViewName.StoryFrontView then
		self:onEpisodeFinish(viewName)
	end
end

function FeiLinShiDuoEpisodeLevelView:onEpisodeFinish(viewName)
	if viewName == ViewName.StoryFrontView then
		FeiLinShiDuoStatHelper.instance:sendDungeonFinish()
	end

	local curFinishEpisodeId = FeiLinShiDuoModel.instance:getCurFinishEpisodeId()

	if curFinishEpisodeId and curFinishEpisodeId > 0 then
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.EpisodeItemPlayFinishAnim, curFinishEpisodeId)
	end

	FeiLinShiDuoModel.instance:setCurFinishEpisodeId(0)
end

function FeiLinShiDuoEpisodeLevelView:playEpisodeUnlockAnim(episodeId)
	self.curEpisodeId = episodeId

	local index = self:getCurEpisodeIndex()

	self:focusEpisodeItem(index, self.curEpisodeId, false, true, true)
	self:switchBG()
end

function FeiLinShiDuoEpisodeLevelView:switchBG(needSwitchAnim)
	self:refreshEpisode()

	if needSwitchAnim then
		self._animPlayer:Play("switch", self.switchBGFinish, self)
	end
end

function FeiLinShiDuoEpisodeLevelView:switchBGFinish()
	return
end

function FeiLinShiDuoEpisodeLevelView:refreshReddot(reddot)
	reddot:defaultRefreshDot()

	local showRedDot = reddot.show

	self._taskAnimator:Play(showRedDot and "loop" or "idle")
end

function FeiLinShiDuoEpisodeLevelView:refreshTime()
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

function FeiLinShiDuoEpisodeLevelView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	FeiLinShiDuoModel.instance:setCurEpisodeId(0)
end

function FeiLinShiDuoEpisodeLevelView:onDestroyView()
	self._simageFullBG:UnLoadImage()
	self._simageFullBG1:UnLoadImage()
	FeiLinShiDuoModel.instance:reInit()
end

return FeiLinShiDuoEpisodeLevelView
