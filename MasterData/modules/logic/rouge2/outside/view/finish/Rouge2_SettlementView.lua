-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_SettlementView.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_SettlementView", package.seeall)

local Rouge2_SettlementView = class("Rouge2_SettlementView", BaseView)
local DelayTweenRewardPointTime = 1
local DelayTweenRewardProgressTime = 1

function Rouge2_SettlementView:onInitView()
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._goevent = gohelper.findChild(self.viewGO, "#go_event")
	self._goeventitem = gohelper.findChild(self.viewGO, "#go_event/#go_eventitem")
	self._goachieve = gohelper.findChild(self.viewGO, "#go_achieve")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_achieve/#scroll_view")
	self._goachieveitem = gohelper.findChild(self.viewGO, "#go_achieve/#scroll_view/Viewport/Content/#go_achieveitem")
	self._simageachieveicon = gohelper.findChildSingleImage(self.viewGO, "#go_achieve/#scroll_view/Viewport/Content/#go_achieveitem/normal/#simage_achieveicon")
	self._gotipscontainer = gohelper.findChild(self.viewGO, "#go_achieve/#go_tipscontainer")
	self._gotips = gohelper.findChild(self.viewGO, "#go_achieve/#go_tipscontainer/#go_tips")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_achieve/#go_tipscontainer/#go_tips/#txt_tips")
	self._btnclosetips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_achieve/#go_tipscontainer/#go_tips/#btn_closetips")
	self._goscore = gohelper.findChild(self.viewGO, "#go_score")
	self._txtbase = gohelper.findChildText(self.viewGO, "#go_score/#txt_base")
	self._txtmultiple = gohelper.findChildText(self.viewGO, "#go_score/#txt_multiple")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_score/#txt_total")
	self._txtaddpoint = gohelper.findChildText(self.viewGO, "#go_score/score/#txt_addpoint")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_replay")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_SettlementView:addEvents()
	self._btnclosetips:AddClickListener(self._btnclosetipsOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnreplay:AddClickListener(self._btnreplayOnClick, self)
end

function Rouge2_SettlementView:removeEvents()
	self._btnclosetips:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnreplay:RemoveClickListener()
end

function Rouge2_SettlementView:_btnreplayOnClick()
	Rouge2_OutsideController.instance:openRougeResultView()
end

function Rouge2_SettlementView:_btncloseOnClick()
	ViewMgr.instance:closeView(ViewName.Rouge2_ResultView)
	self:closeThis()

	local resultInfo = Rouge2_Model.instance:getRougeResult()

	if resultInfo then
		if not resultInfo.finalScore then
			local finalScore = 0
			local isScoreMuchZero = finalScore > 0

			if isScoreMuchZero then
				if resultInfo.gainMaterial == nil or #resultInfo.gainMaterial <= 0 then
					local reviewInfo = resultInfo.reviewInfo
					local params = {
						reviewInfo = reviewInfo,
						displayType = Rouge2_OutsideEnum.ResultFinalDisplayType.Result
					}

					Rouge2_OutsideController.instance:openRougeResultFinalView(params)
				else
					local reviewInfo = resultInfo.reviewInfo
					local params = {
						reviewInfo = reviewInfo
					}

					Rouge2_OutsideController.instance:openRougeSettlementUnlockView(params)
				end
			else
				ViewMgr.instance:closeView(ViewName.Rouge2_ResultView)
				self:closeThis()
			end
		end
	end
end

function Rouge2_SettlementView:_btnclosetipsOnClick()
	gohelper.setActive(self._gotips, false)
end

function Rouge2_SettlementView:_editableInitView()
	self._badgeItemTab = self:getUserDataTb_()

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinishCallBack, self)
	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)

	self._coinIcon = gohelper.findChildImage(self.viewGO, "#go_score/score/icon")

	local config = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V3a2Rouge)
	local currencyName = config.icon .. "_1"

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._coinIcon, currencyName)

	self._goAchieveEmpty = gohelper.findChild(self._goachieve, "empty")

	gohelper.setActive(self._goachieveitem, false)
	gohelper.setActive(self._gotips, false)
end

function Rouge2_SettlementView:onUpdateParam()
	return
end

function Rouge2_SettlementView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_rating)

	local rougeResult = Rouge2_Model.instance:getRougeResult()
	local isSucc = rougeResult and rougeResult:isSucceed()

	gohelper.setActive(self._gofail, not isSucc)
	gohelper.setActive(self._gosuccess, isSucc)
	self:refreshScores(rougeResult)
	self:updateBadgeList(rougeResult)
end

function Rouge2_SettlementView:refreshScores(resultInfo)
	if not resultInfo then
		return
	end

	local resultList = {}
	local normalFightCount, normalFightScore = resultInfo:getNormalFightCountAndScore()

	self:setScoreData(resultList, normalFightCount, normalFightScore)

	local difficlutFightCount, difficlutFightScore = resultInfo:getDifficultFightCountAndScore()

	self:setScoreData(resultList, difficlutFightCount, difficlutFightScore)

	local dangerousFightCount, dangerousFightScore = resultInfo:getDangerousFightCountAndScore()

	self:setScoreData(resultList, dangerousFightCount, dangerousFightScore)

	local collectionCount, collectionScore = resultInfo:getCollectionCountAndScore()

	self:setScoreData(resultList, collectionCount, collectionScore)

	local layerCount, layerScore = resultInfo:getLayerCountAndScore()

	self:setScoreData(resultList, layerCount, layerScore)

	local entrustCount, entrustScore = resultInfo:getQuintupleCountAndScore()
	local finalScore = entrustCount * entrustScore

	self:setScoreData(resultList, entrustCount, finalScore)
	self:refreshScoreItem(resultList)
	self:refreshScoreInfo(resultInfo)
	self:refreshAddPoint(resultInfo)
end

function Rouge2_SettlementView:setScoreData(list, num, score)
	local mo = {}

	mo.score = score
	mo.num = num

	table.insert(list, mo)
end

function Rouge2_SettlementView:refreshScoreItem(scoreList)
	gohelper.CreateObjList(self, self.onScoreItemShow, scoreList, self._goevent, self._goeventitem, Rouge2_SettlementScoreItem)
end

function Rouge2_SettlementView:onScoreItemShow(item, data, index)
	item:setInfo(data, index)
end

Rouge2_SettlementView.FinalScoreDuration = 2
Rouge2_SettlementView.RewardPointDuration = 2
Rouge2_SettlementView.TalentPointDuration = 2
Rouge2_SettlementView.ExtraPointDuration = 2
Rouge2_SettlementView.RewardPointProgressDuration = 2
Rouge2_SettlementView.TalentPointProgressDuration = 2
Rouge2_SettlementView.MaxProgressValue = 1

function Rouge2_SettlementView:refreshScoreInfo(resultInfo)
	if not resultInfo.beforeScore then
		if resultInfo.scoreReward1 and resultInfo.scoreReward2 then
			if not (resultInfo.scoreReward1 + resultInfo.scoreReward2) then
				local multiple = 0

				if not resultInfo.finalScore then
					local finalScore = 0

					self._txtbase.text = resultInfo.beforeScore
					self._txtmultiple.text = string.format("%s%%", multiple)

					local preFinalScore = 0

					self:killTween("_totalScoreTweenId")

					self._totalScoreTweenId = ZProj.TweenHelper.DOTweenFloat(preFinalScore, finalScore, Rouge2_SettlementView.FinalScoreDuration, self.framChangeScoreCallBack, self.changeScoreDone, self)

					if finalScore > 0 then
						AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_qiutu_progress_loop)
					end
				end
			end
		end
	end
end

function Rouge2_SettlementView:framChangeScoreCallBack(finalScore)
	self._txttotal.text = math.ceil(finalScore)
end

function Rouge2_SettlementView:changeScoreDone()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.stop_ui_qiutu_progress_loop)

	self._totalScoreTweenId = nil
end

function Rouge2_SettlementView:refreshRewardPoint(resultInfo)
	self:refreshAddPoint(resultInfo)
end

function Rouge2_SettlementView:refreshAddPoint(resultInfo)
	self._targetAddPoint = resultInfo.addCurrency
	self._originRewardPoint = 0

	self:frameRewardPointFunc(self._originRewardPoint)
	TaskDispatcher.cancelTask(self.tweenRewardPoint, self)
	TaskDispatcher.runDelay(self.tweenRewardPoint, self, DelayTweenRewardPointTime)
end

function Rouge2_SettlementView:tweenRewardPoint()
	self:killTween("_rewardPointTweenId")

	self._rewardPointTweenId = ZProj.TweenHelper.DOTweenFloat(self._originRewardPoint, self._targetAddPoint, Rouge2_SettlementView.RewardPointDuration, self.frameRewardPointFunc, self.rewardPointDone, self)
end

function Rouge2_SettlementView:frameRewardPointFunc(addPoint)
	self._txtaddpoint.text = math.ceil(addPoint)
end

function Rouge2_SettlementView:refreshRewardProgress(resultInfo)
	local remainScore2Point = resultInfo.remainScore2Point
	local rewardTranslation = tonumber(lua_rouge_const.configDict[RougeEnum.Const.RewardTranslation].value)

	self._targetRewardPointProgress = remainScore2Point / rewardTranslation

	if not resultInfo.preRemainScore2Point then
		self._preRemainScoreProgress = resultInfo.preRemainScore2Point / rewardTranslation

		if self._targetRewardPointProgress < self._preRemainScoreProgress then
			self._targetRewardPointProgress = self._targetRewardPointProgress + Rouge2_SettlementView.MaxProgressValue
		end

		self:frameRewardPointProgressFunc(self._preRemainScoreProgress)
		TaskDispatcher.cancelTask(self.tweenRewardProgress, self)
		TaskDispatcher.runDelay(self.tweenRewardProgress, self, DelayTweenRewardProgressTime)
	end
end

function Rouge2_SettlementView:tweenRewardProgress()
	self:killTween("_rewardPointProgressTweenId")

	self._rewardPointProgressTweenId = ZProj.TweenHelper.DOTweenFloat(self._preRemainScoreProgress, self._targetRewardPointProgress, Rouge2_SettlementView.RewardPointProgressDuration, self.frameRewardPointProgressFunc, self.rewardPointProgressDone, self)
end

function Rouge2_SettlementView:frameRewardPointProgressFunc(rewardProgress)
	local targetRewardProgress = rewardProgress % Rouge2_SettlementView.MaxProgressValue

	self._sliderprogress:SetValue(targetRewardProgress)
end

function Rouge2_SettlementView:rewardPointProgressDone()
	self._rewardPointProgressTweenId = nil
end

function Rouge2_SettlementView:refreshTalentPoint(resultInfo)
	local addGeniusPoint = resultInfo.addGeniusPoint
	local originGeniusPoint = 0

	self:killTween("_talentPointTweenId")

	self._talentPointTweenId = ZProj.TweenHelper.DOTweenFloat(originGeniusPoint, addGeniusPoint, Rouge2_SettlementView.RewardPointDuration, self.frameTalentPointFunc, self.talentPointDone, self)

	local remainScore2GeniusPoint = resultInfo.remainScore2GeniusPoint
	local talentTranslation = tonumber(lua_rouge_const.configDict[RougeEnum.Const.TalentTranslation].value)
	local talentProgress = remainScore2GeniusPoint / talentTranslation

	if not resultInfo.preRemainScore2GeniusPoint then
		local preRemainTalentPoint = 0
		local preRemainTalentProgress = preRemainTalentPoint / talentTranslation

		if talentProgress < preRemainTalentProgress then
			talentProgress = talentProgress + Rouge2_SettlementView.MaxProgressValue
		end

		self:killTween("_talentPointProgressTweenId")

		self._talentPointProgressTweenId = ZProj.TweenHelper.DOTweenFloat(preRemainTalentProgress, talentProgress, Rouge2_SettlementView.TalentPointProgressDuration, self.framTalentPointProgressFunc, self.talentPointProgressDone, self)
	end
end

function Rouge2_SettlementView:frameTalentPointFunc(addGeniusPoint)
	self._txtaddgenius.text = math.ceil(addGeniusPoint)
end

function Rouge2_SettlementView:talentPointDone()
	self._talentPointTweenId = nil
end

function Rouge2_SettlementView:framTalentPointProgressFunc(talentProgress)
	local targetTalentProgress = talentProgress % Rouge2_SettlementView.MaxProgressValue

	self._slidergeniusprogress:SetValue(targetTalentProgress)
end

function Rouge2_SettlementView:talentPointProgressDone()
	self._talentPointProgressTweenId = nil
end

function Rouge2_SettlementView:killTween(tweenIdName)
	local tweenId = self[tweenIdName]

	if tweenId then
		ZProj.TweenHelper.KillById(tweenId)

		self[tweenIdName] = nil
	end
end

local maxShowBageCountOneScreen = 10

function Rouge2_SettlementView:updateBadgeList(resultInfo)
	if not resultInfo then
		return
	end

	self._badgeList = resultInfo.badge2Score

	local useMap = {}

	if self._badgeList then
		if not #self._badgeList then
			local badgeCount = 0
			local showCount = badgeCount > maxShowBageCountOneScreen and badgeCount or maxShowBageCountOneScreen

			gohelper.setActive(self._goAchieveEmpty, not showCount)

			for index = 1, showCount do
				local item = self:getOrCreateBadgeItem(index)

				if self._badgeList then
					self:refreshBadgeItemUI(item, self._badgeList)

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
		end
	end
end

function Rouge2_SettlementView:refreshBadgeItemUI(item, badge)
	gohelper.setActive(item.viewGO, true)
	gohelper.setActive(item.gonormal, badge ~= nil)
	gohelper.setActive(item.goempty, badge == nil)

	if badge then
		local cfg = Rouge2_Config.instance:getRougeBadgeCO(badge[1])

		item.txtscore.text = badge[2]

		Rouge2_IconHelper.setRougeAchievementIcon(cfg.id, item.simageicon)
	end
end

function Rouge2_SettlementView:getOrCreateBadgeItem(index)
	local badgeItem = self._badgeItemTab[index]

	if not badgeItem then
		badgeItem = self:getUserDataTb_()
		badgeItem.viewGO = gohelper.cloneInPlace(self._goachieveitem, "item_" .. tostring(index))
		badgeItem.gonormal = gohelper.findChild(badgeItem.viewGO, "normal")
		badgeItem.simageicon = gohelper.findChildSingleImage(badgeItem.viewGO, "normal/#simage_achieveicon")
		badgeItem.txtscore = gohelper.findChildText(badgeItem.viewGO, "normal/#txt_score")
		badgeItem.goempty = gohelper.findChild(badgeItem.viewGO, "empty")
		badgeItem.btnclick = gohelper.findChildButtonWithAudio(badgeItem.viewGO, "normal/btn_click")

		badgeItem.btnclick:AddClickListener(self._onClickBadgeItem, self, index)

		self._badgeItemTab[index] = badgeItem
	end

	return badgeItem
end

function Rouge2_SettlementView:_onClickBadgeItem(index)
	local badge = self._badgeList[index]
	local badgeId = badge and badge[1]

	self:openBadgeTips(badgeId, index)
end

function Rouge2_SettlementView:openBadgeTips(badgeId, index)
	local badgeCfg = Rouge2_Config.instance:getRougeBadgeCO(badgeId)

	if not badgeCfg then
		return
	end

	gohelper.setActive(self._gotips, true)

	self._txttips.text = string.format("%s\n%s", badgeCfg.name, badgeCfg.desc)

	self:setBadgeTipsPos(index)
end

function Rouge2_SettlementView:setBadgeTipsPos(index)
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

function Rouge2_SettlementView:_onOpenViewFinishCallBack(viewName)
	if viewName == ViewName.Rouge2_SettlementUnlockView then
		ViewMgr.instance:closeView(ViewName.Rouge2_ResultView)
	end
end

function Rouge2_SettlementView:releaseAllBadgeItems()
	if self._badgeItemTab then
		for _, badgeItem in ipairs(self._badgeItemTab) do
			badgeItem.btnclick:RemoveClickListener()
		end
	end
end

function Rouge2_SettlementView:onClose()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.stop_ui_qiutu_progress_loop)
end

function Rouge2_SettlementView:onDestroyView()
	TaskDispatcher.cancelTask(self.tweenRewardPoint, self)
	TaskDispatcher.cancelTask(self.tweenExtraPoint, self)
	TaskDispatcher.cancelTask(self.tweenRewardProgress, self)
	self:killTween("_totalScoreTweenId")
	self:killTween("_rewardPointTweenId")
	self:killTween("_talentPointTweenId")
	self:killTween("_rewardPointProgressTweenId")
	self:killTween("_talentPointProgressTweenId")
	self:releaseAllBadgeItems()
end

return Rouge2_SettlementView
