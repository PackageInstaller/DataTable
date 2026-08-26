-- chunkname: @modules/logic/fight/system/work/FightWorkBeforeStartNoticeView.lua

module("modules.logic.fight.system.work.FightWorkBeforeStartNoticeView", package.seeall)

local FightWorkBeforeStartNoticeView = class("FightWorkBeforeStartNoticeView", BaseWork)

function FightWorkBeforeStartNoticeView:ctor()
	return
end

function FightWorkBeforeStartNoticeView:onStart()
	if not FightDataHelper.stateMgr.isReplay and ViewMgr.instance:isOpen(ViewName.FightQuitTipView) then
		FightController.instance:registerCallback(FightEvent.OnFightQuitTipViewClose, self.bootLogic, self)
	else
		self:bootLogic()
	end
end

function FightWorkBeforeStartNoticeView:bootLogic()
	FightController.instance:unregisterCallback(FightEvent.OnFightQuitTipViewClose, self.bootLogic, self)

	if FightWorkBeforeStartNoticeView.canShowTips() and not FightDataHelper.stateMgr:getIsAuto() then
		FightController.instance:dispatchEvent(FightEvent.SetPlayCardPartOutScreen)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		FightController.instance:openFightSpecialTipView(true)
	else
		self:onDone(true)
	end
end

function FightWorkBeforeStartNoticeView:_onCloseViewFinish(viewName)
	if viewName == ViewName.FightSpecialTipView or tabletool.indexOf(SeasonFightHandler.SeasonFightRuleTipViewList, viewName) then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		self:onDone(true)
	end
end

function FightWorkBeforeStartNoticeView.canShowTips()
	if not GMFightShowState.roundSpecialView then
		return false
	end

	local fightParam = FightModel.instance:getFightParam()
	local show_tips
	local episode_config = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)

	if episode_config and not string.nilorempty(episode_config.battleDesc) then
		show_tips = true
	end

	local battleConfig = lua_battle.configDict[fightParam.battleId]
	local episodeType = episode_config and episode_config.type

	if battleConfig and not string.nilorempty(battleConfig.additionRule) then
		local additionRule = battleConfig.additionRule

		if episodeType == DungeonEnum.EpisodeType.Meilanni then
			local data_list = GameUtil.splitString2(additionRule, true, "|", "#")

			data_list = HeroGroupFightViewRule.meilanniExcludeRules(data_list)
			show_tips = show_tips or data_list and #data_list > 0
		else
			show_tips = SeasonFightHandler.canSeasonShowTips(additionRule, episodeType)
		end
	else
		if episodeType == DungeonEnum.EpisodeType.Rouge then
			local curNode = RougeMapModel.instance:getCurNode()
			local eventMo = curNode and curNode.eventMo
			local surpriseAttackList = eventMo and eventMo:getSurpriseAttackList()

			show_tips = surpriseAttackList and #surpriseAttackList > 0
		end

		if episodeType == DungeonEnum.EpisodeType.Survival then
			local data_list = SurvivalShelterModel.instance:addExRule({})

			show_tips = show_tips or #data_list > 0
		end

		if episode_config.chapterId == AtomicDungeonEnum.TalentChapterId or episode_config.chapterId == AtomicDungeonEnum.TalentChapterId2 then
			local alarmRuleList = AtomicDungeonModel.instance:getAlarmRuleList()

			show_tips = show_tips or alarmRuleList and #alarmRuleList > 0
		end
	end

	local customData = FightDataHelper.fieldMgr.customData

	if customData then
		local dataWeekwalkVer2 = customData[FightCustomData.CustomDataType.WeekwalkVer2]

		if dataWeekwalkVer2 then
			local jsonData = cjson.decode(dataWeekwalkVer2)
			local ruleMap = jsonData.ruleMap

			if ruleMap then
				show_tips = true
			end
		end

		local customData183 = customData[FightCustomData.CustomDataType.Act183]

		if customData183 then
			if customData183.currRules and #customData183.currRules > 0 then
				show_tips = true
			end

			if customData183.transferRules and #customData183.transferRules > 0 then
				show_tips = true
			end
		end

		local data229 = customData[FightCustomData.CustomDataType.Act229]

		if data229 then
			local selectSkillIds = data229.selectSkillIds

			if selectSkillIds and #selectSkillIds > 0 then
				show_tips = true
			end
		end
	end

	local firstGuide = GuideModel.instance:isDoingFirstGuide()
	local forbidGuides = GuideController.instance:isForbidGuides()
	local isReplay = FightDataHelper.stateMgr.isReplay

	if show_tips and (not firstGuide or forbidGuides) and not isReplay then
		return true
	else
		return false
	end

	return false
end

function FightWorkBeforeStartNoticeView:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnFightQuitTipViewClose, self.bootLogic, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	FightController.instance:dispatchEvent(FightEvent.SetPlayCardPartOriginPos)
end

return FightWorkBeforeStartNoticeView
