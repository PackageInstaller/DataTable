-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EpisodeDetailView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EpisodeDetailView", package.seeall)

local Season123_3_5EpisodeDetailView = class("Season123_3_5EpisodeDetailView", BaseView)

function Season123_3_5EpisodeDetailView:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._simagestageicon = gohelper.findChildSingleImage(self.viewGO, "#go_info/left/#simage_stageicon")
	self._animatorRight = gohelper.findChildComponent(self.viewGO, "#go_info/right", typeof(UnityEngine.Animator))
	self._txtlevelnamecn = gohelper.findChildText(self.viewGO, "#go_info/left/#txt_levelnamecn")
	self._descScroll = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View")
	self._animScroll = self._descScroll:GetComponent(typeof(UnityEngine.Animator))
	self._descContent = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View/Viewport/Content")
	self._goDescItem = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View/Viewport/Content/#go_descitem")
	self._txtcurindex = gohelper.findChildText(self.viewGO, "#go_info/right/position/center/#txt_curindex")
	self._txtmaxindex = gohelper.findChildText(self.viewGO, "#go_info/right/position/center/#txt_maxindex")
	self._btnlast = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/position/#btn_last")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/position/#btn_next")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/btns/#btn_start")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/btns/#btn_reset")
	self._btnReplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/btns/#btn_storyreplay")
	self._godecorate = gohelper.findChild(self.viewGO, "#go_info/right/decorate")
	self._gocenter = gohelper.findChild(self.viewGO, "#go_info/right/position/center")
	self._goleftscrolltopmask = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View/mask2")
	self.goTaskItem = gohelper.findChild(self.viewGO, "#go_info/right/condition/#go_taskitem")

	gohelper.setActive(self.goTaskItem, false)

	self.taskItemList = {}
	self._gorecommendattr = gohelper.findChild(self.viewGO, "#go_info/right/#go_recommendAttr")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_info/right/#go_recommendAttr/attrlist/#go_attritem")
	self._txtrecommonddes = gohelper.findChildTextMesh(self.viewGO, "#go_info/right/#go_recommendAttr/#txt_recommonddes")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5EpisodeDetailView:addEvents()
	self._btnlast:AddClickListener(self._btnlastOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function Season123_3_5EpisodeDetailView:removeEvents()
	self._btnlast:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnreset:RemoveClickListener()
end

function Season123_3_5EpisodeDetailView:_editableInitView()
	self._txtseasondesc = gohelper.findChildText(self.viewGO, "#go_info/left/Scroll View/Viewport/Content/#go_descitem/txt_desc")
end

function Season123_3_5EpisodeDetailView:onDestroyView()
	Season123EpisodeDetailController.instance:onCloseView()
	self._simagestageicon:UnLoadImage()
end

function Season123_3_5EpisodeDetailView:onOpen()
	self.addEventCb(self, Season123Controller.instance, Season123Event.DetailSwitchLayer, self.handleDetailSwitchLayer, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.RefreshDetailView, self.refreshShowInfo, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.ResetStageFinished, self.closeThis, self)
	Season123EpisodeDetailController.instance:onOpenView(self.viewParam.actId, self.viewParam.stage, self.viewParam.layer)

	local actMO = ActivityModel.instance:getActMO(self.viewParam.actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		return
	end

	self:resetData()
	self:noAudioShowInfoByOpen()
end

function Season123_3_5EpisodeDetailView:onOpenFinish()
	local loadingViewName = Season123Controller.instance:getEpisodeLoadingViewName()

	ViewMgr.instance:closeView(loadingViewName, true)
end

function Season123_3_5EpisodeDetailView:onClose()
	TaskDispatcher.cancelTask(self._delayShowInfo, self)
end

function Season123_3_5EpisodeDetailView:handleDetailSwitchLayer(param)
	self._animatorRight:Play(UIAnimationName.Switch, 0, 0)
	self._animScroll:Play(UIAnimationName.Switch, 0, 0)
	TaskDispatcher.cancelTask(self._delayShowInfo, self)
	TaskDispatcher.runDelay(self._delayShowInfo, self, 0.2)
end

function Season123_3_5EpisodeDetailView:_delayShowInfo()
	self:_showInfo()
end

function Season123_3_5EpisodeDetailView:refreshShowInfo()
	self:_showInfo()
end

function Season123_3_5EpisodeDetailView:_btnstartOnClick()
	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage
	local layer = Season123EpisodeDetailModel.instance.layer
	local episodeId = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer).episodeId

	Season123EpisodeDetailController.instance:checkEnterFightScene()
end

function Season123_3_5EpisodeDetailView:resetData()
	return
end

function Season123_3_5EpisodeDetailView:noAudioShowInfoByOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(self._goinfo, true)
	self:_showInfo()
end

function Season123_3_5EpisodeDetailView:_showInfo()
	self:_setInfo()
	self:_setButton()
end

function Season123_3_5EpisodeDetailView:_setButton()
	gohelper.setActive(self._btnreset, false)
	gohelper.setActive(self._btnstart, true)
end

Season123_3_5EpisodeDetailView.NomalStageTagPos = Vector2(46.3, 2.7)
Season123_3_5EpisodeDetailView.NewStageTagPos = Vector2(4.37, 2.7)

function Season123_3_5EpisodeDetailView:_setInfo()
	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage
	local layer = Season123EpisodeDetailModel.instance.layer
	local episodeCo = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer)

	if not episodeCo then
		return
	end

	local afterStory = Season123Model.instance:isEpisodeAfterStory(actId, stage, layer)

	gohelper.setActive(self._btnReplay, afterStory and episodeCo.afterStoryId and episodeCo.afterStoryId ~= 0 or false)

	self._txtlevelnamecn.text = episodeCo.layerName
	self._txtseasondesc.text = episodeCo.desc
	self._txtcurindex.text = string.format("%02d", layer)

	local maxLayer = Season123ProgressUtils.getMaxLayer(actId, stage)

	self._txtmaxindex.text = string.format("%02d", maxLayer)

	local isNewStage = Season123EpisodeDetailModel.instance:isNextLayerNewStarGroup(layer)

	gohelper.setActive(self._godecorate, isNewStage)

	if isNewStage then
		if not Season123_3_5EpisodeDetailView.NewStageTagPos then
			local targetStageTagPos = Season123_3_5EpisodeDetailView.NomalStageTagPos

			recthelper.setAnchor(self._gocenter.transform, targetStageTagPos.x, targetStageTagPos.y)

			local folder = Season123Model.instance:getSingleBgFolder()
			local urlStr = ResUrl.getSeason123LayerDetailBg(folder, episodeCo.layerPicture)

			if not string.nilorempty(urlStr) then
				self._simagestageicon:LoadImage(urlStr)
			end

			self._btnlast.button.interactable = layer > 1
			self._btnnext.button.interactable = layer < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer()

			self:refreshTask(episodeCo.episodeId)
			self:_recommendCareer()
		end
	end
end

function Season123_3_5EpisodeDetailView:refreshTask(episodeId)
	local advancedCondition = DungeonConfig.instance:getEpisodeAdvancedCondition(episodeId)
	local conditionList = string.splitToNumber(advancedCondition, "|")
	local taskList = {
		luaLang("v3a5_season_detailview_txt_star1")
	}

	for i = 1, #conditionList do
		local conditionId = conditionList[i]
		local condition = lua_condition.configDict[conditionId]

		table.insert(taskList, (condition or nil) and (condition.desc or ""))
	end

	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage
	local layer = Season123EpisodeDetailModel.instance.layer
	local seasonMo = Season123Model.instance:getActInfo(actId)
	local stageMo = seasonMo:getStageMO(stage)
	local episodeMo = stageMo:getEpisodeMo(layer)
	local curStar = episodeMo.star

	for i = 1, math.max(#self.taskItemList, #taskList) do
		local taskItem = self.taskItemList[i]

		if not taskItem then
			taskItem = self:getUserDataTb_()
			taskItem.go = gohelper.cloneInPlace(self.goTaskItem, tostring(i))
			taskItem.txtTask = gohelper.findChildTextMesh(taskItem.go, "#txt_task")
			taskItem.goFinish = gohelper.findChild(taskItem.go, "point/finish")
			taskItem.goUnFinish = gohelper.findChild(taskItem.go, "point/unfinish")
			self.taskItemList[i] = taskItem
		end

		local desc = taskList[i]

		if desc then
			taskItem.txtTask.text = desc

			local isFinish = i <= curStar

			gohelper.setActive(taskItem.goFinish, isFinish)
			gohelper.setActive(taskItem.goUnFinish, not isFinish)
			gohelper.setActive(taskItem.go, true)
		else
			gohelper.setActive(taskItem.go, false)
		end
	end
end

function Season123_3_5EpisodeDetailView:_recommendCareer()
	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage
	local layer = Season123EpisodeDetailModel.instance.layer
	local episodeConfig = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer)

	FightController.instance:setFightParamByEpisodeId(episodeConfig.episodeId, false, 1)

	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, gohelper.findChild(self._gorecommendattr.gameObject, "attrlist"), self._goattritem)

	self._txtrecommonddes.text = #recommended == 0 and luaLang("new_common_none") or ""
end

function Season123_3_5EpisodeDetailView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function Season123_3_5EpisodeDetailView:_btnlastOnClick()
	if Season123EpisodeDetailController.instance:canSwitchLayer(false) then
		Season123EpisodeDetailController.instance:switchLayer(false)
	end
end

function Season123_3_5EpisodeDetailView:_btnnextOnClick()
	if Season123EpisodeDetailController.instance:canSwitchLayer(true) then
		Season123EpisodeDetailController.instance:switchLayer(true)
	end
end

function Season123_3_5EpisodeDetailView:_btnresetOnClick()
	Season123Controller.instance:openResetView({
		actId = Season123EpisodeDetailModel.instance.activityId,
		stage = Season123EpisodeDetailModel.instance.stage,
		layer = Season123EpisodeDetailModel.instance.layer
	})
end

return Season123_3_5EpisodeDetailView
