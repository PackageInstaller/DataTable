-- chunkname: @modules/logic/matchgame/outside/result/MatchGameResultView.lua

module("modules.logic.matchgame.outside.result.MatchGameResultView", package.seeall)

local MatchGameResultView = class("MatchGameResultView", BaseView)

function MatchGameResultView:onInitView()
	self._goSuccessBg = gohelper.findChild(self.viewGO, "Bg/simage_success")
	self._goFailureBg = gohelper.findChild(self.viewGO, "Bg/simage_failure")
	self._goConditionList = gohelper.findChild(self.viewGO, "Left/go_target/#go_listitem")
	self._goConditionItem = gohelper.findChild(self.viewGO, "Left/go_target/#go_listitem/#go_item")
	self._goAchievementList = gohelper.findChild(self.viewGO, "Left/go_achievement/#go_listitem")
	self._goAchievementItem = gohelper.findChild(self.viewGO, "Left/go_achievement/#go_listitem/#go_item")
	self._txtLevelName = gohelper.findChildText(self.viewGO, "Right/levelbg/#txt_levelname")
	self._goRewardList = gohelper.findChild(self.viewGO, "Right/#go_success/#go_reward/#go_rewardlist")
	self._btnBack = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btn/#btn_return")
	self._btnAgain = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btn/#btn_again")
	self._btnNextLevel = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btn/#btn_nextlevel")
	self._btnNextMap = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btn/#btn_nextmap")
	self._goFailure = gohelper.findChild(self.viewGO, "Right/#go_failure")
	self._goSuccess = gohelper.findChild(self.viewGO, "Right/#go_success")
	self._goWin = gohelper.findChild(self.viewGO, "Right/Title/#go_win")
	self._goLose = gohelper.findChild(self.viewGO, "Right/Title/#go_lose")
	self._txtFailTips = gohelper.findChildText(self.viewGO, "Right/#go_failure/#txt_tips")
	self._btnRole = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_failure/#btn_role")
	self._goRoleRedDot = gohelper.findChild(self.viewGO, "Right/#go_failure/#btn_role/#go_reddot")
	self._btnTalent = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_failure/#btn_talent")
	self._goTalentRedDot = gohelper.findChild(self.viewGO, "Right/#go_failure/#btn_talent/#go_reddot")
	self._btnHeroGroup = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_failure/#btn_herogroup")
	self._imageTarget = gohelper.findChildImage(self.viewGO, "Left/go_target/tagbg")
	self._imageAchievement = gohelper.findChildImage(self.viewGO, "Left/go_achievement/tagbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameResultView:addEvents()
	self._btnBack:AddClickListener(self._btnBackOnClick, self)
	self._btnAgain:AddClickListener(self._btnAgainOnClick, self)
	self._btnNextLevel:AddClickListener(self._btnNextLevelOnClick, self)
	self._btnNextMap:AddClickListener(self._btnNextMapOnClick, self)
	self._btnRole:AddClickListener(self._btnRoleOnClick, self)
	self._btnTalent:AddClickListener(self._btnTalentOnClick, self)
	self._btnHeroGroup:AddClickListener(self._btnHeroGroupOnClick, self)
end

function MatchGameResultView:removeEvents()
	self._btnBack:RemoveClickListener()
	self._btnAgain:RemoveClickListener()
	self._btnNextLevel:RemoveClickListener()
	self._btnNextMap:RemoveClickListener()
	self._btnRole:RemoveClickListener()
	self._btnTalent:RemoveClickListener()
	self._btnHeroGroup:RemoveClickListener()
end

function MatchGameResultView:_btnBackOnClick()
	MatchGameController.instance:onGameFinished(self._episodeId, self._isSuccess)
	MatchGameStatHelper.instance:statResultClick(self.viewName, MatchGameEnum.StatClickType.Back, self._episodeId, self._isSuccess)
end

function MatchGameResultView:_btnAgainOnClick()
	MatchGameController.instance:openHeroGroupView(self._episodeId)
	MatchGameStatHelper.instance:statResultClick(self.viewName, MatchGameEnum.StatClickType.Again, self._episodeId, self._isSuccess)
	self:closeThis()
end

function MatchGameResultView:_btnNextLevelOnClick()
	MatchGameController.instance:switchToTargetEpisode(self._nextEpisodeId)
	MatchGameStatHelper.instance:statResultClick(self.viewName, MatchGameEnum.StatClickType.NextLevel, self._episodeId, self._isSuccess)
	self:closeThis()
end

function MatchGameResultView:_btnNextMapOnClick()
	MatchGameController.instance:switchToTargetEpisode(self._nextEpisodeId)
	MatchGameStatHelper.instance:statResultClick(self.viewName, MatchGameEnum.StatClickType.NextMap, self._episodeId, self._isSuccess)
	self:closeThis()
end

function MatchGameResultView:_btnRoleOnClick()
	MatchGameController.instance:openCharacterView(MatchGameEnum.CharacterTabType.Develop)
end

function MatchGameResultView:_btnTalentOnClick()
	MatchGameController.instance:openCharacterView(MatchGameEnum.CharacterTabType.Talent)
end

function MatchGameResultView:_btnHeroGroupOnClick()
	ViewMgr.instance:openView(ViewName.MatchGameHeroGroupEditView, {
		posIndex = 1
	})
end

function MatchGameResultView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self._btnBackOnClick, self)
	RedDotController.instance:addRedDot(self._goRoleRedDot, RedDotEnum.DotNode.MatchGameCharacterEntry)
	RedDotController.instance:addRedDot(self._goTalentRedDot, RedDotEnum.DotNode.MatchGameTalentEntry)

	self._goRewardItem = self:getResInst(MatchGameEnum.MapRewardItemPrefabPath, self._goRewardList, "#go_RewardItem")
end

function MatchGameResultView:onOpen()
	self._episodeId = self.viewParam and self.viewParam.episodeId
	self._isSuccess = self.viewParam and self.viewParam.isSuccess
	self._episodeMo = MatchGameModel.instance:getEpisodeInfoById(self._episodeId)
	self._episodeCo = self._episodeMo and self._episodeMo.episodeCo
	self._recCareer = self._episodeCo and self._episodeCo.recCareer
	self._nextEpisodeCo = MatchGameConfig.instance:getNextEpisodeConfig(self._episodeId)
	self._nextEpisodeId = self._nextEpisodeCo and self._nextEpisodeCo.id
	self._exParam = self.viewParam and self.viewParam.exParam

	if self._exParam then
		self._roundCount = self._exParam.roundCount or 0
	end

	if self._exParam then
		self._maxRoundDamage = self._exParam.maxRoundDamage or 0
	end

	self._isFirstPass = self.viewParam and self.viewParam.isFirstPass

	if self._isSuccess then
		if not MatchGameAudioEnum.EnterSuccessView then
			local audioId = MatchGameAudioEnum.EnterFailView

			AudioMgr.instance:trigger(audioId)
			self:refreshUI()
			self:ListenTeamEvent()
		end
	end
end

function MatchGameResultView:refreshUI()
	if not self._episodeMo or not self._episodeCo then
		return
	end

	self._txtLevelName.text = self._episodeCo.levelName

	gohelper.setActive(self._goSuccessBg, self._isSuccess)
	gohelper.setActive(self._goSuccess, self._isSuccess)
	gohelper.setActive(self._goWin, self._isSuccess)
	gohelper.setActive(self._goFailureBg, not self._isSuccess)
	gohelper.setActive(self._goLose, not self._isSuccess)
	gohelper.setActive(self._goFailure, not self._isSuccess)
	self:refreshConditionList()
	self:refreshAchievementList()
	self:refreshRewardList()
	self:refreshBtnList()

	if not self._isSuccess then
		local careerName = luaLang("career" .. tostring(self._recCareer))

		self._txtFailTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("matchgameresultview_failtips"), careerName)
	end

	ZProj.UGUIHelper.SetGrayscale(self._imageTarget.gameObject, not self._isSuccess)
	ZProj.UGUIHelper.SetGrayscale(self._imageAchievement.gameObject, not self._isSuccess)
end

function MatchGameResultView:refreshConditionList()
	local conditionList = MatchGameHelper.getEpisodeConditionList(self._episodeId) or {}

	gohelper.CreateObjList(self, self._refreshConditionItem, conditionList, self._goConditionList, self._goConditionItem)
end

function MatchGameResultView:_refreshConditionItem(goCondition, condition, index)
	local txtDesc = gohelper.findChildText(goCondition, "#txt_desc")

	txtDesc.text = condition

	local goLightStar = gohelper.findChild(goCondition, "#txt_desc/#go_star2")

	if self._episodeMo then
		local isPass = self._episodeMo:isConditionPass(index)

		gohelper.setActive(goLightStar, self._episodeMo)
	end
end

function MatchGameResultView:refreshAchievementList()
	local achievementList = {
		{
			type = MatchGameEnum.AchievementType.RoundCount,
			value = self._roundCount
		},
		{
			type = MatchGameEnum.AchievementType.MaxRoundDamage,
			value = self._maxRoundDamage
		},
		{
			type = MatchGameEnum.AchievementType.MaxChain,
			value = MatchGameFightModel.instance:getMaxChainNum()
		},
		{
			type = MatchGameEnum.AchievementType.SkillUse,
			value = MatchGameFightModel.instance:getTotalSkillUseNum()
		}
	}

	gohelper.CreateObjList(self, self._refreshAchievementItem, achievementList, self._goAchievementList, self._goAchievementItem)
end

function MatchGameResultView:_refreshAchievementItem(goAchievement, achievementInfo, index)
	local txtName = gohelper.findChildText(goAchievement, "txt_name")

	txtName.text = luaLang("matchgameachievement_" .. achievementInfo.type)

	local txtValue = gohelper.findChildText(goAchievement, "txt_name/txt_value")

	txtValue.text = achievementInfo.value
end

function MatchGameResultView:refreshRewardList()
	if not self._isSuccess then
		return
	end

	local allBonus = {}
	local firstBonus

	if self._isFirstPass then
		firstBonus = GameUtil.splitString2(self._episodeCo.firstBonus, true)

		tabletool.addValues(allBonus, firstBonus)
	end

	local otherBonus = GameUtil.splitString2(self._episodeCo.bonus, true)

	tabletool.addValues(allBonus, otherBonus)

	if firstBonus then
		self._firstBonusEndIndex = #firstBonus or 0
	end

	self._firstBonusStartIndex = self._firstBonusEndIndex > 0 and 1 or 0

	gohelper.CreateObjList(self, self._refreshRewardItem, allBonus, self._goRewardList, self._goRewardItem, MatchGameMapRewardItem)
end

function MatchGameResultView:_refreshRewardItem(rewardItem, rewardParam, index)
	local isFirstBonus = index >= self._firstBonusStartIndex and index <= self._firstBonusEndIndex

	rewardItem:onUpdateMO(rewardParam, isFirstBonus, index)
end

function MatchGameResultView:refreshBtnList()
	local isNextEpisodeUnlock = MatchGameLevelModel.instance:isEpisodeUnlock(self._nextEpisodeId)

	if self._nextEpisodeCo then
		local isSameChapter = self._nextEpisodeCo.chapterId == self._episodeCo.chapterId

		gohelper.setActive(self._btnNextLevel.gameObject, isNextEpisodeUnlock and isSameChapter)
		gohelper.setActive(self._btnNextMap.gameObject, isNextEpisodeUnlock and not isSameChapter)
	end
end

function MatchGameResultView:ListenTeamEvent()
	if self._isSuccess then
		return
	end

	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnSaveTeamSuccess, self._onSaveTeamSuccess, self)
end

function MatchGameResultView:_onSaveTeamSuccess()
	GameFacade.showToast(ToastEnum.MatchGameModifyHeroGroup)
end

function MatchGameResultView:onClose()
	return
end

function MatchGameResultView:onDestroyView()
	return
end

return MatchGameResultView
