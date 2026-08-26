-- chunkname: @modules/logic/rouge/view/RougeSettlementView.lua

module("modules.logic.rouge.view.RougeSettlementView", package.seeall)

local RougeSettlementView = class("RougeSettlementView", BaseView)
local DelayTweenRewardPointTime = 1
local DelayTweenExtraPointTime = 1
local DelayTweenRewardProgressTime = 1

function RougeSettlementView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#go_fail/#simage_mask")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/#txt_Title")
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_replay")
	self._simagerightmask = gohelper.findChildSingleImage(self.viewGO, "img_dec/#simage_rightmask")
	self._simageleftmask = gohelper.findChildSingleImage(self.viewGO, "img_dec/#simage_leftmask")
	self._simagerightmask2 = gohelper.findChildSingleImage(self.viewGO, "img_dec/#simage_rightmask2")
	self._simageleftmask2 = gohelper.findChildSingleImage(self.viewGO, "img_dec/#simage_leftmask2")
	self._simagepoint = gohelper.findChildSingleImage(self.viewGO, "img_dec/#simage_point")
	self._simagepoint2 = gohelper.findChildSingleImage(self.viewGO, "img_dec/#simage_point2")
	self._txtscore1 = gohelper.findChildText(self.viewGO, "mode1/#txt_score1")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "mode1/#txt_num1")
	self._txtscore2 = gohelper.findChildText(self.viewGO, "mode2/#txt_score2")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "mode2/#txt_num2")
	self._txtscore3 = gohelper.findChildText(self.viewGO, "mode3/#txt_score3")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "mode3/#txt_num3")
	self._gocollection = gohelper.findChild(self.viewGO, "#go_collection")
	self._txtcollectionscore = gohelper.findChildText(self.viewGO, "#go_collection/#txt_collectionscore")
	self._txtcollectionnum = gohelper.findChildText(self.viewGO, "#go_collection/#txt_collectionnum")
	self._golevel = gohelper.findChild(self.viewGO, "#go_level")
	self._txtlevelscore = gohelper.findChildText(self.viewGO, "#go_level/#txt_levelscore")
	self._txtlevelnum = gohelper.findChildText(self.viewGO, "#go_level/#txt_levelnum")
	self._gotask = gohelper.findChild(self.viewGO, "#go_task")
	self._txttaskscore = gohelper.findChildText(self.viewGO, "#go_task/#txt_taskscore")
	self._txttasknum = gohelper.findChildText(self.viewGO, "#go_task/#txt_tasknum")
	self._goending = gohelper.findChild(self.viewGO, "#go_ending")
	self._txtendingscore = gohelper.findChildText(self.viewGO, "#go_ending/#txt_endingscore")
	self._txtendingnum = gohelper.findChildText(self.viewGO, "#go_ending/#txt_endingnum")
	self._goachieve = gohelper.findChild(self.viewGO, "#go_achieve")
	self._simagetitlebg = gohelper.findChildSingleImage(self.viewGO, "#go_achieve/#simage_titlebg")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_achieve/#scroll_view")
	self._goachieveitem = gohelper.findChild(self.viewGO, "#go_achieve/#scroll_view/Viewport/Content/#go_achieveitem")
	self._simageachieveicon = gohelper.findChildSingleImage(self.viewGO, "#go_achieve/#scroll_view/Viewport/Content/#go_achieveitem/normal/#simage_achieveicon")
	self._goscore = gohelper.findChild(self.viewGO, "#go_score")
	self._txtbase = gohelper.findChildText(self.viewGO, "#go_score/#txt_base")
	self._txtmultiple = gohelper.findChildText(self.viewGO, "#go_score/#txt_multiple")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_score/#txt_total")
	self._txtaddpoint = gohelper.findChildText(self.viewGO, "#go_score/score/#txt_addpoint")
	self._txtextrapoint = gohelper.findChildText(self.viewGO, "#go_score/score/#txt_extrapoint")
	self._sliderprogress = gohelper.findChildSlider(self.viewGO, "#go_score/score/#slider_progress")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_score/collection/#simage_icon")
	self._txtaddgenius = gohelper.findChildText(self.viewGO, "#go_score/collection/#txt_addgenius")
	self._slidergeniusprogress = gohelper.findChildSlider(self.viewGO, "#go_score/collection/#slider_geniusprogress")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gotipscontainer = gohelper.findChild(self.viewGO, "#go_achieve/#go_tipscontainer")
	self._gotips = gohelper.findChild(self.viewGO, "#go_achieve/#go_tipscontainer/#go_tips")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_achieve/#go_tipscontainer/#go_tips/#txt_tips")
	self._btnclosetips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_achieve/#go_tipscontainer/#go_tips/#btn_closetips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeSettlementView:addEvents()
	self._btnreplay:AddClickListener(self._btnreplayOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclosetips:AddClickListener(self._btnclosetipsOnClick, self)
end

function RougeSettlementView:removeEvents()
	self._btnreplay:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnclosetips:RemoveClickListener()
end

function RougeSettlementView:_btnreplayOnClick()
	RougeController.instance:openRougeResultView()
end

function RougeSettlementView:_btncloseOnClick()
	local resultInfo = RougeModel.instance:getRougeResult()

	if resultInfo then
		if not resultInfo.finalScore then
			local finalScore = 0
			local isScoreMuchZero = finalScore > 0

			if isScoreMuchZero then
				local reviewInfo = resultInfo.reviewInfo
				local params = {
					reviewInfo = reviewInfo
				}

				RougeController.instance:openRougeResultReView(params)
			else
				ViewMgr.instance:closeView(ViewName.RougeEndingThreeView)
				ViewMgr.instance:closeView(ViewName.RougeResultView)
				self:closeThis()
			end
		end
	end
end

function RougeSettlementView:_btnclosetipsOnClick()
	gohelper.setActive(self._gotips, false)
end

function RougeSettlementView:_editableInitView()
	self._badgeItemTab = self:getUserDataTb_()

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinishCallBack, self)
	NavigateMgr.instance:addEscape(self.viewName, RougeMapHelper.blockEsc)
end

function RougeSettlementView:onUpdateParam()
	return
end

function RougeSettlementView:onOpen()
	local rougeResult = RougeModel.instance:getRougeResult()
	local isSucc = rougeResult and rougeResult:isSucceed()

	gohelper.setActive(self._gofail, not isSucc)
	gohelper.setActive(self._gosuccess, isSucc)
	self:refrehScores(rougeResult)
	self:updateBadgeList(rougeResult)
end

function RougeSettlementView:refrehScores(resultInfo)
	if not resultInfo then
		return
	end

	local normalFightCount, normalFightScore = resultInfo:getNormalFightCountAndScore()

	self._txtnum1.text = normalFightCount
	self._txtscore1.text = normalFightScore

	local difficlutFightCount, difficlutFightScore = resultInfo:getDifficultFightCountAndScore()

	self._txtnum2.text = difficlutFightCount
	self._txtscore2.text = difficlutFightScore

	local dangerousFightCount, dangerousFightScore = resultInfo:getDangerousFightCountAndScore()

	self._txtnum3.text = dangerousFightCount
	self._txtscore3.text = dangerousFightScore

	self:refreshOverView(resultInfo)
	self:refreshScoreInfo(resultInfo)
	self:refreshRewardPoint(resultInfo)
	self:refreshTalentPoint(resultInfo)
end

function RougeSettlementView:refreshOverView(resultInfo)
	local collectionCount, collectionScore = resultInfo:getCollectionCountAndScore()

	self._txtcollectionnum.text = collectionCount
	self._txtcollectionscore.text = collectionScore

	local layerCount, layerScore = resultInfo:getLayerCountAndScore()

	self._txtlevelnum.text = layerCount
	self._txtlevelscore.text = layerScore

	local entrustCount, entrustScore = resultInfo:getEntrustCountAndScore()

	self._txttasknum.text = entrustCount
	self._txttaskscore.text = entrustScore

	local endCount, endScore = resultInfo:getEndCountAndScore()

	self._txtendingnum.text = endCount
	self._txtendingscore.text = endScore
end

RougeSettlementView.FinalScoreDuration = 2
RougeSettlementView.RewardPointDuration = 2
RougeSettlementView.TalentPointDuration = 2
RougeSettlementView.ExtraPointDuration = 2
RougeSettlementView.RewardPointProgressDuration = 2
RougeSettlementView.TalentPointProgressDuration = 2
RougeSettlementView.MaxProgressValue = 1

function RougeSettlementView:refreshScoreInfo(resultInfo)
	if not resultInfo.beforeScore then
		if not resultInfo.scoreReward then
			local multiple = 0

			if not resultInfo.finalScore then
				local finalScore = 0

				self._txtbase.text = resultInfo.beforeScore
				self._txtmultiple.text = string.format("%s%%", multiple)

				local preFinalScore = 0

				self:killTween("_totalScoreTweenId")

				self._totalScoreTweenId = ZProj.TweenHelper.DOTweenFloat(preFinalScore, finalScore, RougeSettlementView.FinalScoreDuration, self.framChangeScoreCallBack, self.changeScoreDone, self)

				if finalScore > 0 then
					AudioMgr.instance:trigger(AudioEnum.UI.ComputeScore)
				end
			end
		end
	end
end

function RougeSettlementView:framChangeScoreCallBack(finalScore)
	self._txttotal.text = math.ceil(finalScore)
end

function RougeSettlementView:changeScoreDone()
	self._totalScoreTweenId = nil
end

function RougeSettlementView:refreshRewardPoint(resultInfo)
	self:refreshAddPoint(resultInfo)
	self:refreshExtraPoint(resultInfo)
	self:refreshRewardProgress(resultInfo)
end

function RougeSettlementView:refreshAddPoint(resultInfo)
	self._targetAddPoint = resultInfo.addPoint or 0
	self._originRewardPoint = 0

	self:frameRewardPointFunc(self._originRewardPoint)
	TaskDispatcher.cancelTask(self.tweenRewardPoint, self)
	TaskDispatcher.runDelay(self.tweenRewardPoint, self, DelayTweenRewardPointTime)
end

function RougeSettlementView:tweenRewardPoint()
	self:killTween("_rewardPointTweenId")

	self._rewardPointTweenId = ZProj.TweenHelper.DOTweenFloat(self._originRewardPoint, self._targetAddPoint, RougeSettlementView.RewardPointDuration, self.frameRewardPointFunc, self.rewardPointDone, self)
end

function RougeSettlementView:frameRewardPointFunc(addPoint)
	self._txtaddpoint.text = math.ceil(addPoint)
end

function RougeSettlementView:rewardPointDone()
	self._rewardPointTweenId = nil
end

function RougeSettlementView:refreshExtraPoint(resultInfo)
	self._targetExtraAddPoint = resultInfo.extraAddPoint or 0
	self._originExtraAddPoint = 0

	gohelper.setActive(self._txtextrapoint.gameObject, self._targetExtraAddPoint > 0)

	if self._targetExtraAddPoint > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.RougeAddExtraPoint)
		self:frameExtraPointFunc(self._originExtraAddPoint)
		TaskDispatcher.cancelTask(self.tweenExtraPoint, self)
		TaskDispatcher.runDelay(self.tweenExtraPoint, self, DelayTweenExtraPointTime)
	end
end

function RougeSettlementView:tweenExtraPoint()
	self:killTween("_extraPointTweenId")

	self._extraPointTweenId = ZProj.TweenHelper.DOTweenFloat(self._originExtraAddPoint, self._targetExtraAddPoint, RougeSettlementView.ExtraPointDuration, self.frameExtraPointFunc, self.extraPointDone, self)
end

function RougeSettlementView:frameExtraPointFunc(addPoint)
	self._txtextrapoint.text = string.format("+%s", math.ceil(addPoint))
end

function RougeSettlementView:extraPointDone()
	self._extraPointTweenId = nil
end

function RougeSettlementView:refreshRewardProgress(resultInfo)
	local remainScore2Point = resultInfo.remainScore2Point
	local rewardTranslation = tonumber(lua_rouge_const.configDict[RougeEnum.Const.RewardTranslation].value)

	self._targetRewardPointProgress = remainScore2Point / rewardTranslation

	if not resultInfo.preRemainScore2Point then
		self._preRemainScoreProgress = resultInfo.preRemainScore2Point / rewardTranslation

		if self._targetRewardPointProgress < self._preRemainScoreProgress then
			self._targetRewardPointProgress = self._targetRewardPointProgress + RougeSettlementView.MaxProgressValue
		end

		self:frameRewardPointProgressFunc(self._preRemainScoreProgress)
		TaskDispatcher.cancelTask(self.tweenRewardProgress, self)
		TaskDispatcher.runDelay(self.tweenRewardProgress, self, DelayTweenRewardProgressTime)
	end
end

function RougeSettlementView:tweenRewardProgress()
	self:killTween("_rewardPointProgressTweenId")

	self._rewardPointProgressTweenId = ZProj.TweenHelper.DOTweenFloat(self._preRemainScoreProgress, self._targetRewardPointProgress, RougeSettlementView.RewardPointProgressDuration, self.frameRewardPointProgressFunc, self.rewardPointProgressDone, self)
end

function RougeSettlementView:frameRewardPointProgressFunc(rewardProgress)
	local targetRewardProgress = rewardProgress % RougeSettlementView.MaxProgressValue

	self._sliderprogress:SetValue(targetRewardProgress)
end

function RougeSettlementView:rewardPointProgressDone()
	self._rewardPointProgressTweenId = nil
end

function RougeSettlementView:refreshTalentPoint(resultInfo)
	local addGeniusPoint = resultInfo.addGeniusPoint
	local originGeniusPoint = 0

	self:killTween("_talentPointTweenId")

	self._talentPointTweenId = ZProj.TweenHelper.DOTweenFloat(originGeniusPoint, addGeniusPoint, RougeSettlementView.RewardPointDuration, self.frameTalentPointFunc, self.talentPointDone, self)

	local remainScore2GeniusPoint = resultInfo.remainScore2GeniusPoint
	local talentTranslation = tonumber(lua_rouge_const.configDict[RougeEnum.Const.TalentTranslation].value)
	local talentProgress = remainScore2GeniusPoint / talentTranslation

	if not resultInfo.preRemainScore2GeniusPoint then
		local preRemainTalentPoint = 0
		local preRemainTalentProgress = preRemainTalentPoint / talentTranslation

		if talentProgress < preRemainTalentProgress then
			talentProgress = talentProgress + RougeSettlementView.MaxProgressValue
		end

		self:killTween("_talentPointProgressTweenId")

		self._talentPointProgressTweenId = ZProj.TweenHelper.DOTweenFloat(preRemainTalentProgress, talentProgress, RougeSettlementView.TalentPointProgressDuration, self.framTalentPointProgressFunc, self.talentPointProgressDone, self)
	end
end

function RougeSettlementView:frameTalentPointFunc(addGeniusPoint)
	self._txtaddgenius.text = math.ceil(addGeniusPoint)
end

function RougeSettlementView:talentPointDone()
	self._talentPointTweenId = nil
end

function RougeSettlementView:framTalentPointProgressFunc(talentProgress)
	local targetTalentProgress = talentProgress % RougeSettlementView.MaxProgressValue

	self._slidergeniusprogress:SetValue(targetTalentProgress)
end

function RougeSettlementView:talentPointProgressDone()
	self._talentPointProgressTweenId = nil
end

function RougeSettlementView:killTween(tweenIdName)
	local tweenId = self[tweenIdName]

	if tweenId then
		ZProj.TweenHelper.KillById(tweenId)

		self[tweenIdName] = nil
	end
end

local maxShowBageCountOneScreen = 8

function RougeSettlementView:updateBadgeList(resultInfo)
	if not resultInfo then
		return
	end

	local season = resultInfo.season

	self._badgeList = resultInfo.badge2Score
	self._badgeSeason = season

	local useMap = {}

	if self._badgeList then
		if not #self._badgeList then
			local badgeCount = 0
			local showCount = badgeCount > maxShowBageCountOneScreen and badgeCount or maxShowBageCountOneScreen

			for index = 1, showCount do
				local item = self:getOrCreateBadgeItem(index)

				if self._badgeList then
					self:refreshBadgeItemUI(season, item, self._badgeList)

					useMap[item] = true
				end
			end

			if self._badgeItemTab then
				for _, badgeItem in pairs(self._badgeItemTab) do
					if not useMap[badgeItem] then
						gohelper.setActive(badgeItem.viewGO, false)
					end
				end
			end

			if badgeCount > 0 then
				AudioMgr.instance:trigger(AudioEnum.UI.ShowAchievement)
			end
		end
	end
end

function RougeSettlementView:refreshBadgeItemUI(season, item, badge)
	gohelper.setActive(item.viewGO, true)
	gohelper.setActive(item.gonormal, badge ~= nil)
	gohelper.setActive(item.goempty, badge == nil)

	if badge then
		local cfg = RougeConfig.instance:getRougeBadgeCO(season, badge[1])

		item.txtscore.text = badge[2]
		item.txtname.text = cfg.name

		UISpriteSetMgr.instance:setRouge3Sprite(item.imageicon, cfg.icon)
	end
end

function RougeSettlementView:getOrCreateBadgeItem(index)
	local badgeItem = self._badgeItemTab[index]

	if not badgeItem then
		badgeItem = self:getUserDataTb_()
		badgeItem.viewGO = gohelper.cloneInPlace(self._goachieveitem, "item_" .. tostring(index))
		badgeItem.gonormal = gohelper.findChild(badgeItem.viewGO, "normal")
		badgeItem.imageicon = gohelper.findChildImage(badgeItem.viewGO, "normal/#simage_achieveicon")
		badgeItem.txtscore = gohelper.findChildText(badgeItem.viewGO, "normal/#txt_score")
		badgeItem.txtname = gohelper.findChildText(badgeItem.viewGO, "normal/namebg/#txt_name")
		badgeItem.goempty = gohelper.findChild(badgeItem.viewGO, "empty")
		badgeItem.btnclick = gohelper.findChildButtonWithAudio(badgeItem.viewGO, "normal/btn_click")

		badgeItem.btnclick:AddClickListener(self._onClickBadgeItem, self, index)

		self._badgeItemTab[index] = badgeItem
	end

	return badgeItem
end

function RougeSettlementView:_onClickBadgeItem(index)
	local badge = self._badgeList[index]
	local badgeId = badge and badge[1]

	self:openBadgeTips(self._badgeSeason, badgeId, index)
end

function RougeSettlementView:openBadgeTips(season, badgeId, index)
	local badgeCfg = RougeConfig.instance:getRougeBadgeCO(season, badgeId)

	if not badgeCfg then
		return
	end

	gohelper.setActive(self._gotips, true)

	self._txttips.text = badgeCfg.desc

	self:setBadgeTipsPos(index)
end

function RougeSettlementView:setBadgeTipsPos(index)
	local badgeItem = self._badgeItemTab[index]

	if not badgeItem then
		return
	end

	local badgeItemTran = badgeItem.viewGO.transform
	local badgePosX = recthelper.rectToRelativeAnchorPos2(badgeItemTran.position, self._gotipscontainer.transform)

	ZProj.UGUIHelper.RebuildLayout(self._gotips.transform)

	local tipWidth = recthelper.getWidth(self._gotips.transform)
	local containerWidth = recthelper.getWidth(self._gotipscontainer.transform)
	local halfTipWidth = tipWidth / 2
	local halfContainerWidth = containerWidth / 2
	local targetTipPosX = Mathf.Clamp(badgePosX, -halfContainerWidth + halfTipWidth, halfContainerWidth - halfTipWidth)

	recthelper.setAnchorX(self._gotips.transform, targetTipPosX)
end

function RougeSettlementView:_onOpenViewFinishCallBack(viewName)
	if viewName == ViewName.RougeResultReView then
		ViewMgr.instance:closeView(ViewName.RougeEndingThreeView)
		ViewMgr.instance:closeView(ViewName.RougeResultView)
		self:closeThis()
	end
end

function RougeSettlementView:releaseAllBadgeItems()
	if self._badgeItemTab then
		for _, badgeItem in ipairs(self._badgeItemTab) do
			badgeItem.btnclick:RemoveClickListener()
		end
	end
end

function RougeSettlementView:onClose()
	return
end

function RougeSettlementView:onDestroyView()
	TaskDispatcher.cancelTask(self.tweenRewardPoint, self)
	TaskDispatcher.cancelTask(self.tweenExtraPoint, self)
	TaskDispatcher.cancelTask(self.tweenRewardProgress, self)
	self:killTween("_totalScoreTweenId")
	self:killTween("_rewardPointTweenId")
	self:killTween("_talentPointTweenId")
	self:killTween("_rewardPointProgressTweenId")
	self:killTween("_talentPointProgressTweenId")
	self:killTween("_extraPointTweenId")
	self:releaseAllBadgeItems()
end

return RougeSettlementView
