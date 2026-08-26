-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarMainView.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarMainView", package.seeall)

local V3a9RacingCarMainView = class("V3a9RacingCarMainView", BaseView)

function V3a9RacingCarMainView:onInitView()
	self._gofull = gohelper.findChild(self.viewGO, "#go_full")
	self._govideo = gohelper.findChild(self.viewGO, "#go_full/#go_video")
	self._gomask = gohelper.findChild(self.viewGO, "#go_full/#go_mask")
	self._imagemap = gohelper.findChildImage(self.viewGO, "Left/Map/#image_map")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_task")
	self._gotaskContent = gohelper.findChild(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent")
	self._goTask = gohelper.findChild(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent/#go_Task")
	self._goTaskItem = gohelper.findChild(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent/#go_Task/#go_TaskItem")
	self._goBottom = gohelper.findChild(self.viewGO, "#go_Bottom")
	self._gobest = gohelper.findChild(self.viewGO, "#go_Bottom/#go_best")
	self._txttimes = gohelper.findChildText(self.viewGO, "#go_Bottom/#go_best/#txt_times")
	self._gosectionInfo = gohelper.findChild(self.viewGO, "#go_Bottom/#go_sectionInfo")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_Bottom/#go_sectionInfo/#txt_index")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_Bottom/#go_sectionInfo/#txt_name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_Bottom/#go_sectionInfo/mask/txt_desc")
	self._goicon = gohelper.findChild(self.viewGO, "#go_Bottom/#go_icon")
	self._gotag = gohelper.findChild(self.viewGO, "#go_Bottom/#go_tag")
	self._btntalent = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Bottom/#btn_talent")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Bottom/#btn_start")
	self._scrollsection = gohelper.findChildScrollRect(self.viewGO, "#go_Bottom/#scroll_section")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_reward")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_reward")
	self._gorewardunfull = gohelper.findChild(self.viewGO, "Right/#btn_reward/#go_unfull")
	self._txtrewardunfull = gohelper.findChildText(self.viewGO, "Right/#btn_reward/#go_unfull/txt_rewardcount")
	self._gorewardfull = gohelper.findChild(self.viewGO, "Right/#btn_reward/#go_full")
	self._gorewardreddot = gohelper.findChild(self.viewGO, "Right/#btn_reward/reddot")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingCarMainView:addEvents()
	self._btntalent:AddClickListener(self._btntalentOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
end

function V3a9RacingCarMainView:removeEvents()
	self._btntalent:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnreward:RemoveClickListener()
end

function V3a9RacingCarMainView:_btnrewardOnClick()
	V3a9RacingCarController.instance:onOpenRewardView(self.viewParam.actId)
end

function V3a9RacingCarMainView:_btntalentOnClick()
	V3a9RacingCarController.instance:onOpenTalentView(self.viewParam.actId)
end

function V3a9RacingCarMainView:_btnstartOnClick()
	TaskDispatcher.cancelTask(self._refreshLevelInfo, self)

	local config = V3a9RacingCarSectionListModel.instance:getSelectedConfig()

	if not config then
		logError("V3a9RacingCarMainView:_btnstartOnClick config is nil")

		return
	end

	V3a9RacingCarModel.instance:setEpisodeConfig(config)
	V3a9RacingCarController.instance:openV3a9RacingCarRoleListView(self.viewParam.actId)
end

function V3a9RacingCarMainView:_onSelectRacingLevel()
	self._animator.enabled = true

	self._animator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self._refreshLevelInfo, self)
	TaskDispatcher.runDelay(self._refreshLevelInfo, self, 0.16)
end

function V3a9RacingCarMainView:_refreshLevelInfo()
	local episodeConfig = V3a9RacingCarSectionListModel.instance:getSelectedConfig()

	if not episodeConfig then
		return
	end

	local episodeInfo = V3a9RacingCarEpisodeModel.instance:getEpisodeInfo(episodeConfig.episodeId)

	self._txtname.text = episodeConfig.name
	self._txttimes.text = episodeInfo and episodeInfo.bestStar > 0 and self:_formatTime((episodeInfo or nil) and (episodeInfo.bestTimeMs or 0)) or "--:--:--"
	self._txtindex.text = string.format("%02d", V3a9RacingCarSectionListModel.instance:getSelectedConfigIndex())

	if episodeInfo then
		local bestStarStr = tostring(episodeInfo.record or "")
		local gameLevelConfig = lua_racing_game_level.configDict[episodeConfig.gameId]
		local conditionParams = GameUtil.splitString2(gameLevelConfig.starCondition, true, "|", "#")

		self:_setDescScrollText(gameLevelConfig.desc)
		UISpriteSetMgr.instance:setV3a9RacingSprite(self._imagemap, gameLevelConfig.map)

		for i = 1, self._maxStarNum do
			local star = self._starList[i]
			local showStarGo = episodeInfo ~= nil

			gohelper.setActive(star, showStarGo)

			if showStarGo then
				local goFinished = gohelper.findChild(star, "bg/go_finished")
				local targetValue = string.sub(bestStarStr, i, i)
				local isFinished = targetValue == "1"

				gohelper.setActive(goFinished, isFinished)

				local desc = gohelper.findChildText(star, "txt_taskDesc")

				desc.text = string.format(luaLang("v3a9Racing_car_target" .. i), conditionParams[i][2])
			end
		end

		self:_showReward(episodeConfig.clearBonus)

		local name = gameLevelConfig.video

		self._videoPlayer:play(name, true, self._videoStatusUpdate, self)
	end
end

local DescScrollSpacing = 10

function V3a9RacingCarMainView:_setDescScrollText(desc)
	self._txtdescWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self._txtdesc, desc)
	self._descRootWidth = recthelper.getWidth(self._txtdesc.transform.parent.transform)

	recthelper.setWidth(self._txtdesc.transform, self._txtdescWidth)
	recthelper.setAnchorX(self._txtdesc.transform, self._descRootWidth + DescScrollSpacing)

	self._txtdesc.text = desc

	self:_doTweenDescText()
end

function V3a9RacingCarMainView:_doTweenDescText()
	self:_onKillDescTween()

	local x = recthelper.getAnchorX(self._txtdesc.transform)
	local targetX = -self._txtdescWidth - DescScrollSpacing
	local time = (x - targetX) * 0.01

	self._descTweenId = ZProj.TweenHelper.DOAnchorPosX(self._txtdesc.transform, targetX, time, self._onFinishDescTween, self, nil, EaseType.Linear)
end

function V3a9RacingCarMainView:_onFinishDescTween()
	recthelper.setAnchorX(self._txtdesc.transform, self._descRootWidth + DescScrollSpacing)
	self:_doTweenDescText()
end

function V3a9RacingCarMainView:_onKillDescTween()
	if self._descTweenId then
		ZProj.TweenHelper.KillById(self._descTweenId)

		self._descTweenId = nil
	end
end

function V3a9RacingCarMainView:_videoStatusUpdate()
	return
end

function V3a9RacingCarMainView:_showReward(bonus)
	local rewardList = ItemConfig.instance:getRewardGroupRateInfoList(bonus)
	local rewards = {}

	if rewardList then
		for i, v in ipairs(rewardList) do
			local materialData = MaterialDataMO.New()
			local materialType = v.materialType
			local materialId = v.materialId
			local weight = v.weight

			materialData:initValue(materialType, materialId, weight)
			table.insert(rewards, materialData)
		end
	end

	for i, v in ipairs(rewards) do
		self._rewardIcon = self._rewardIcon or IconMgr.instance:getCommonItemIcon(self._goicon)

		self._rewardIcon:onUpdateMO(v)
		self._rewardIcon:setScale(0.6)
		self._rewardIcon:setCountFontSize(40)

		break
	end
end

function V3a9RacingCarMainView:_formatTime(seconds)
	local mins = math.floor(seconds / 60)
	local secs = math.floor(seconds % 60)
	local ms = math.floor(seconds % 1 * 100)

	return string.format("%02d:%02d:%02d", mins, secs, ms)
end

function V3a9RacingCarMainView:_editableInitView()
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.OnSelectRacingLevel, self._onSelectRacingLevel, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._OnCloseView, self)
	self.addEventCb(self, MileStoneController.instance, MileStoneEvent.onGetBonus, self._refreshMilestone, self)

	self._animator = self.viewGO:GetComponent("Animator")
	self._starList = self:getUserDataTb_()

	gohelper.setActive(self._goTaskItem, false)

	self._maxStarNum = V3a9RacingCarEnum.RacingLevelStarMaxCount

	for i = 1, self._maxStarNum do
		self._starList[i] = gohelper.cloneInPlace(self._goTaskItem)
	end

	self._videoPlayer = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._govideo, nil, true, 1920, 800)

	MileStoneRpc.instance:sendGetMilestoneInfoRequest({
		V3a9RacingCarEnum.MileStoneId
	}, self._refreshMilestone, self)
	gohelper.setActive(self._gorewardunfull, false)
	gohelper.setActive(self._gorewardfull, false)
	RedDotController.instance:addRedDot(self._gorewardreddot, RedDotEnum.DotNode.V3a9RacingCarReward)
end

function V3a9RacingCarMainView:_refreshMilestone()
	local curPoint = V3a9RacingRewardListModel.instance:getPoint(V3a9RacingCarEnum.MileStoneId)
	local maxPoint = 0
	local isCanClaim = false
	local list = MileStoneConfig.instance:getBonusList(V3a9RacingCarEnum.MileStoneId)

	if list then
		for _, mo in ipairs(list) do
			local point = mo:getProgress()

			if maxPoint < point then
				maxPoint = point
			end

			local state = MileStoneUtil.getBonusState(V3a9RacingCarEnum.MileStoneId, mo.config.bonusId)

			if state ~= MileStoneEnum.BonusState.HasGet then
				isCanClaim = true
			end
		end
	end

	if isCanClaim then
		local format = luaLang("v3a9Racing_talent_special_level")

		self._txtrewardunfull.text = GameUtil.getSubPlaceholderLuaLangTwoParam(format, curPoint, maxPoint)
	end

	gohelper.setActive(self._gorewardunfull, isCanClaim)
	gohelper.setActive(self._gorewardfull, not isCanClaim)
end

function V3a9RacingCarMainView:_onOpenView(viewName)
	if viewName == ViewName.V3a9RacingCarRoleListView then
		self._animator.enabled = true

		self._animator:Play("switchclose", 0, 0)
		gohelper.setActive(self._gomask, true)
	elseif viewName == ViewName.V3a9RacingTalentView then
		self._animator.enabled = true

		self._animator:Play("switchclose", 0, 0)
		gohelper.setActive(self._govideo, false)
	end
end

function V3a9RacingCarMainView:_OnCloseView(viewName)
	if viewName == ViewName.V3a9RacingCarRoleListView then
		self._animator.enabled = true

		self._animator:Play("switchopen", 0, 0)
		gohelper.setActive(self._gomask, false)
	elseif viewName == ViewName.V3a9RacingTalentView then
		self._animator.enabled = true

		self._animator:Play("switchopen", 0, 0)
		gohelper.setActive(self._govideo, true)
	end
end

function V3a9RacingCarMainView:onUpdateParam()
	return
end

function V3a9RacingCarMainView:onOpen()
	self:_refreshLevelInfo()
end

function V3a9RacingCarMainView:onClose()
	TaskDispatcher.cancelTask(self._refreshLevelInfo, self)
	self:_onKillDescTween()
end

function V3a9RacingCarMainView:onDestroyView()
	if self._videoPlayer then
		self._videoPlayer:stop()
		self._videoPlayer:clear()

		self._videoPlayer = nil
	end
end

return V3a9RacingCarMainView
