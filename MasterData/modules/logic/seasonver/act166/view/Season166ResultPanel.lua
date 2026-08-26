-- chunkname: @modules/logic/seasonver/act166/view/Season166ResultPanel.lua

module("modules.logic.seasonver.act166.view.Season166ResultPanel", package.seeall)

local Season166ResultPanel = class("Season166ResultPanel", BaseView)

function Season166ResultPanel:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg/#simage_mask")
	self._simagelight = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg/#simage_mask/#simage_light")
	self._goFinish = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_Finish")
	self._imageBattleFinish = gohelper.findChildImage(self.viewGO, "#simage_fullbg/#go_Finish/#image_BattleFinish")
	self._imageBattleFinish2 = gohelper.findChildImage(self.viewGO, "#simage_fullbg/#go_Finish/#image_BattleFinish2")
	self._imageBattleFinish3 = gohelper.findChildImage(self.viewGO, "#simage_fullbg/#go_Finish/#image_BattleFinish3")
	self._imageBattleFinish4 = gohelper.findChildImage(self.viewGO, "#simage_fullbg/#go_Finish/#image_BattleFinish4")
	self._goBaseInfo = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_BaseInfo")
	self._goStarRoot = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_BaseInfo/#go_StarRoot")
	self._imageStar1 = gohelper.findChildImage(self.viewGO, "#simage_fullbg/#go_BaseInfo/#go_StarRoot/star1/#image_Star1")
	self._imageStar2 = gohelper.findChildImage(self.viewGO, "#simage_fullbg/#go_BaseInfo/#go_StarRoot/star2/#image_Star2")
	self._imageStar3 = gohelper.findChildImage(self.viewGO, "#simage_fullbg/#go_BaseInfo/#go_StarRoot/star3/#image_Star3")
	self._txtScore = gohelper.findChildText(self.viewGO, "#simage_fullbg/#go_BaseInfo/#txt_Score")
	self._simageAllFinish = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg/#go_BaseInfo/#simage_AllFinish")
	self._txtScore1 = gohelper.findChildText(self.viewGO, "#simage_fullbg/#go_BaseInfo/#simage_AllFinish/#txt_Score1")
	self._goTargetRoot = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot")
	self._goTarget1 = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target1")
	self._txtTarget1 = gohelper.findChildText(self.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target1/#txt_Target1")
	self._txtIntegral1 = gohelper.findChildText(self.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target1/#txt_Integral1")
	self._goTarget2 = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target2")
	self._txtTarget2 = gohelper.findChildText(self.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target2/#txt_Target2")
	self._txtIntegral2 = gohelper.findChildText(self.viewGO, "#simage_fullbg/#go_BaseInfo/#go_TargetRoot/#go_Target2/#txt_Integral2")
	self._goTrainInfo = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_TrainInfo")
	self._txtTrain = gohelper.findChildText(self.viewGO, "#simage_fullbg/#go_TrainInfo/#txt_Train")
	self._goEpisode1 = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode1/#go_Episode1")
	self._goEpisode2 = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode2/#go_Episode2")
	self._goEpisode3 = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode3/#go_Episode3")
	self._goEpisode4 = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode4/#go_Episode4")
	self._goEpisode5 = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode5/#go_Episode5")
	self._goEpisode6 = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_TrainInfo/Episode/Episode6/#go_Episode6")
	self._txtTip = gohelper.findChildText(self.viewGO, "#simage_fullbg/#txt_Tip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166ResultPanel:addEvents()
	return
end

function Season166ResultPanel:removeEvents()
	return
end

function Season166ResultPanel:onClickModalMask()
	if self.closing then
		return
	end

	if self._isCanSkip then
		self.closing = true

		if self.episodeType == DungeonEnum.EpisodeType.Season166Base then
			self.anim:Play("close1")
		else
			self.anim:Play("close2")
		end

		TaskDispatcher.runDelay(self.closeAnimEnd, self, 0.17)
	end
end

function Season166ResultPanel:closeAnimEnd()
	ViewMgr.instance:openView(ViewName.Season166ResultView)
	self:closeThis()
end

function Season166ResultPanel:_editableInitView()
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function Season166ResultPanel:onOpen()
	self._isCanSkip = false
	self.result = Season166Model.instance:getFightResult()

	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	self.episodeType = episode_config.type

	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_result)
end

function Season166ResultPanel:onClose()
	return
end

function Season166ResultPanel:onDestroyView()
	TaskDispatcher.cancelTask(self._tweenScore, self)
	TaskDispatcher.cancelTask(self._onTweenFinish, self)
	TaskDispatcher.cancelTask(self.openAnimEnd, self)
	TaskDispatcher.cancelTask(self.closeAnimEnd, self)
end

function Season166ResultPanel:refreshUI()
	if self.episodeType == DungeonEnum.EpisodeType.Season166Base then
		gohelper.setActive(self._goTrainInfo, false)
		self:refreshBaseInfo()
		gohelper.setActive(self._goBaseInfo, true)
		self.anim:Play("open1")
	else
		gohelper.setActive(self._goBaseInfo, false)
		self:refreshTrainInfo()
		gohelper.setActive(self._goTrainInfo, true)
		self.anim:Play("open2")
	end

	TaskDispatcher.runDelay(self.openAnimEnd, self, 3)
end

function Season166ResultPanel:openAnimEnd()
	if self.episodeType == DungeonEnum.EpisodeType.Season166Base then
		if not string.nilorempty(self.result.targetInfo) then
			gohelper.setActive(self._goTargetRoot, true)
			TaskDispatcher.runDelay(self._tweenScore, self, 1)
		else
			self:_onTweenFinish()
		end
	else
		self:_onTweenFinish()
	end
end

function Season166ResultPanel:refreshBaseInfo()
	gohelper.setActive(self._imageBattleFinish, true)
	gohelper.setActive(self._imageBattleFinish2, true)
	gohelper.setActive(self._imageBattleFinish3, false)
	gohelper.setActive(self._imageBattleFinish4, false)

	self._txtScore.text = self.result.battleScore
	self._txtScore1.text = self.result.battleScore

	self:refreshStar()
	self:refreshTarget()
end

function Season166ResultPanel:refreshTrainInfo()
	gohelper.setActive(self._imageBattleFinish, false)
	gohelper.setActive(self._imageBattleFinish2, false)
	gohelper.setActive(self._imageBattleFinish3, true)
	gohelper.setActive(self._imageBattleFinish4, true)

	local trainCfgList = Season166Config.instance:getSeasonTrainCos(self.result.activityId)

	for i = 1, 6 do
		local trainCfg = trainCfgList[i]

		if trainCfg then
			local isPass

			if trainCfg.trainId == self.result.id then
				self._txtTrain.text = GameUtil.setFirstStrSize(trainCfg.name, 98)
				isPass = true
			else
				isPass = Season166Model.instance:isTrainPass(self.result.activityId, trainCfg.trainId)
			end

			gohelper.setActive(self["_goEpisode" .. i], isPass)
		end
	end
end

function Season166ResultPanel:refreshStar()
	if self.episodeType ~= DungeonEnum.EpisodeType.Season166Base then
		return
	end

	local scoreLevelCfg = Season166BaseSpotModel.instance:getScoreLevelCfg(self.result.activityId, self.result.id, self.result.totalScore)

	if scoreLevelCfg then
		if not scoreLevelCfg.star then
			local starCnt = 0

			for i = 1, 3 do
				local key = "_imageStar" .. i

				if scoreLevelCfg and scoreLevelCfg.level == 4 then
					UISpriteSetMgr.instance:setSeason166Sprite(self[key], "season166_result_bulb3")
				end

				gohelper.setActive(self[key], i <= starCnt)
			end
		end
	end
end

function Season166ResultPanel:refreshTarget()
	if self.episodeType ~= DungeonEnum.EpisodeType.Season166Base then
		return
	end

	if not string.nilorempty(self.result.targetInfo) then
		local targetInfos = GameUtil.splitString2(self.result.targetInfo, true)

		gohelper.setActive(self._txtScore, #targetInfos < 2)
		gohelper.setActive(self._simageAllFinish, #targetInfos == 2)

		for i = 1, 2 do
			local targetInfo = targetInfos[i]

			if targetInfo then
				local targetId = targetInfo[1]
				local targetParam = targetInfo[2]
				local targetCfg = Season166Config.instance:getSeasonBaseTargetCo(self.result.activityId, self.result.id, targetId)
				local score = Season166Config.instance:getAdditionScoreByParam(targetCfg, targetParam)
				local text = luaLang("season166_resultpanel_target" .. targetId)

				self["_txtTarget" .. i].text = GameUtil.getSubPlaceholderLuaLangOneParam(text, targetParam)
				self["_txtIntegral" .. i].text = "+" .. score

				gohelper.setActive(self["_goTarget" .. i], true)
			else
				gohelper.setActive(self["_goTarget" .. i], false)
			end
		end
	end
end

function Season166ResultPanel:_tweenScore()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_score)
	gohelper.setActive(self._goStarRoot, true)

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(self.result.battleScore, self.result.totalScore, 1, self._onTweenUpdate, nil, self)

	TaskDispatcher.runDelay(self._onTweenFinish, self, 1)
end

function Season166ResultPanel:_onTweenUpdate(value)
	if self._txtScore and self._txtScore1 then
		self._txtScore.text = Mathf.Ceil(value)
		self._txtScore1.text = Mathf.Ceil(value)
	end
end

function Season166ResultPanel:_onTweenFinish()
	self._isCanSkip = true

	gohelper.setActive(self._txtTip, true)
end

return Season166ResultPanel
