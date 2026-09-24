-- chunkname: @modules/logic/matchgame/outside/result/MatchGameChallengeResultView.lua

module("modules.logic.matchgame.outside.result.MatchGameChallengeResultView", package.seeall)

local MatchGameChallengeResultView = class("MatchGameChallengeResultView", BaseView)

function MatchGameChallengeResultView:onInitView()
	self._txtScore = gohelper.findChildText(self.viewGO, "Left/go_target/#go_item/#txt_score")
	self._goAchievementList = gohelper.findChild(self.viewGO, "Left/go_achievement/#go_listitem")
	self._goAchievementItem = gohelper.findChild(self.viewGO, "Left/go_achievement/#go_listitem/#go_item")
	self._txtLevelName = gohelper.findChildText(self.viewGO, "Right/levelbg/#txt_levelname")
	self._goAllGet = gohelper.findChild(self.viewGO, "Right/#go_reward/#go_allget")
	self._txtTips = gohelper.findChildText(self.viewGO, "Right/#go_reward/#txt_Tips")
	self._goRewardList = gohelper.findChild(self.viewGO, "Right/#go_reward/#go_rewardlist")
	self._goRewardItem = gohelper.findChild(self.viewGO, "Right/#go_reward/#go_rewardlist/#go_rewarditem")
	self._btnBack = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btn/#btn_return")
	self._btnAgain = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btn/#btn_again")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btn/#btn_reward")
	self._goRewardRedDot = gohelper.findChild(self.viewGO, "Right/Btn/#btn_reward/#go_rewardreddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameChallengeResultView:addEvents()
	self._btnBack:AddClickListener(self._btnBackOnClick, self)
	self._btnAgain:AddClickListener(self._btnAgainOnClick, self)
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
end

function MatchGameChallengeResultView:removeEvents()
	self._btnBack:RemoveClickListener()
	self._btnAgain:RemoveClickListener()
	self._btnReward:RemoveClickListener()
end

function MatchGameChallengeResultView:_btnBackOnClick()
	MatchGameController.instance:onGameFinished(self._episodeId, true)
	MatchGameStatHelper.instance:statResultClick(self.viewName, MatchGameEnum.StatClickType.Back, self._episodeId, true)
end

function MatchGameChallengeResultView:_btnAgainOnClick()
	local isOpen = MatchGameModel.instance:checkEpisodeOpen(self._episodeId, true)

	if not isOpen then
		return
	end

	MatchGameController.instance:openHeroGroupView(self._episodeId)
	MatchGameStatHelper.instance:statResultClick(self.viewName, MatchGameEnum.StatClickType.Again, self._episodeId, true)
	self:closeThis()
end

function MatchGameChallengeResultView:_btnRewardOnClick()
	MatchGameController.instance:openRewardView(MatchGameEnum.RewardType.Challenge)
end

function MatchGameChallengeResultView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self._btnBackOnClick, self)
	RedDotController.instance:addRedDot(self._goRewardRedDot, RedDotEnum.DotNode.MatchGameChallengeReward)
end

function MatchGameChallengeResultView:onOpen()
	self._episodeId = self.viewParam and self.viewParam.episodeId
	self._episodeMo = MatchGameModel.instance:getEpisodeInfoById(self._episodeId)
	self._episodeCo = self._episodeMo and self._episodeMo.episodeCo
	self._totalScore = MatchGameModel.instance:getCurRewardScore(MatchGameEnum.LevelType.Challenge)
	self._curScore = self.viewParam and self.viewParam.score
	self._curScore = self._curScore or 0

	AudioMgr.instance:trigger(MatchGameAudioEnum.EnterSuccessView)
	self:refreshUI()
end

function MatchGameChallengeResultView:refreshUI()
	if not self._episodeMo or not self._episodeCo then
		return
	end

	self._txtScore.text = self._curScore or 0

	self:refreshAchievementList()
	self:refreshRewardList()
end

function MatchGameChallengeResultView:refreshAchievementList()
	local achievementList = {
		{
			type = MatchGameEnum.AchievementType.MaxChain,
			value = MatchGameFightModel.instance:getMaxChainNum()
		},
		{
			type = MatchGameEnum.AchievementType.WeakAttack,
			value = MatchGameFightModel.instance:getWeakAttackNum()
		},
		{
			type = MatchGameEnum.AchievementType.Cure,
			value = MatchGameFightModel.instance:getTotalCureNum()
		},
		{
			type = MatchGameEnum.AchievementType.SkillUse,
			value = MatchGameFightModel.instance:getTotalSkillUseNum()
		}
	}

	gohelper.CreateObjList(self, self._refreshAchievementItem, achievementList, self._goAchievementList, self._goAchievementItem)
end

function MatchGameChallengeResultView:_refreshAchievementItem(goAchievement, achievementInfo, index)
	local txtName = gohelper.findChildText(goAchievement, "txt_name")

	txtName.text = luaLang("matchgameachievement_" .. achievementInfo.type)

	local txtValue = gohelper.findChildText(goAchievement, "txt_name/txt_value")

	txtValue.text = achievementInfo.value
end

function MatchGameChallengeResultView:refreshRewardList()
	local actId = MatchGameModel.instance:getCurActId()
	local nextRewardCo = MatchGameConfig.instance:getChallengeNextScoreReward(actId, self._totalScore)
	local hasNextReward = nextRewardCo ~= nil

	gohelper.setActive(self._goAllGet, not hasNextReward)
	gohelper.setActive(self._txtTips.gameObject, hasNextReward)
	gohelper.setActive(self._goRewardList, hasNextReward)

	if not hasNextReward then
		return
	end

	local remainScore = math.max(nextRewardCo.score - self._totalScore, 0)

	self._txtTips.text = remainScore > 0 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("matchgamechallengeresultview_nextscore"), remainScore) or luaLang("matchgamechallengeresultview_allget")

	local allBonus = DungeonConfig.instance:getRewardItems(nextRewardCo.rewardId)

	gohelper.CreateObjList(self, self._refreshRewardItem, allBonus, self._goRewardList, self._goRewardItem, MatchGameChallengeResultRewardItem)
end

function MatchGameChallengeResultView:_refreshRewardItem(rewardItem, rewardParam, index)
	rewardItem:onUpdateMO(rewardParam, index)
end

function MatchGameChallengeResultView:onClose()
	return
end

function MatchGameChallengeResultView:onDestroyView()
	return
end

return MatchGameChallengeResultView
