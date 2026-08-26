-- chunkname: @modules/logic/seasonver/common/SeasonFightHandler.lua

module("modules.logic.seasonver.common.SeasonFightHandler", package.seeall)

local SeasonFightHandler = class("SeasonFightHandler")

SeasonFightHandler.SeasonFightRuleTipViewList = {
	ViewName.SeasonFightRuleTipView,
	Season123Controller.instance:getFightRuleTipViewName()
}

function SeasonFightHandler.getSeasonEquips(curGroupMO, fightParam)
	local seasonEquips

	return Season123Controller.isEpisodeFromSeason123(fightParam.episodeId) and Season123HeroGroupUtils.getAllHeroActivity123EquipsToFightEquipMO(curGroupMO) or curGroupMO:getAllHeroActivity104Equips()
end

function SeasonFightHandler.closeSeasonFightRuleTipView()
	Activity104Controller.instance:closeSeasonView(Activity104Enum.ViewName.FightRuleTipView)

	if ViewMgr.instance:isOpen(Season123Controller.instance:getFightRuleTipViewName()) then
		ViewMgr.instance:closeView(Season123Controller.instance:getFightRuleTipViewName())
	end
end

function SeasonFightHandler.openSeasonFightRuleTipView(episodeType)
	local isSeasonFightRuleTip = false

	if Activity104Model.instance:isSeasonEpisodeType(episodeType) then
		Activity104Controller.instance:openSeasonFightRuleTipView()

		isSeasonFightRuleTip = true
	elseif Season123Controller.isSeason123EpisodeType(episodeType) then
		Season123Controller.instance:openFightTipViewName()

		isSeasonFightRuleTip = true
	end

	return isSeasonFightRuleTip
end

function SeasonFightHandler.canSeasonShowTips(additionRule, episodeType)
	local show_tips = true

	if Activity104Model.instance:isSeasonEpisodeType(episodeType) then
		local data_list = GameUtil.splitString2(additionRule, true, "|", "#")

		data_list = SeasonConfig.instance:filterRule(data_list)
		show_tips = data_list and #data_list > 0
	elseif Season123Controller.isSeason123EpisodeType(episodeType) then
		local data_list = GameUtil.splitString2(additionRule, true, "|", "#")
		local battleContext = Season123Model.instance:getBattleContext()

		if battleContext then
			data_list = Season123HeroGroupModel.filterRule(battleContext.actId, data_list)

			if battleContext.stage then
				data_list = Season123Config.instance:filterRule(data_list, battleContext.stage)
			end
		end

		show_tips = data_list and #data_list > 0
	end

	return show_tips
end

function SeasonFightHandler.checkSeasonAndOpenGroupFightView(fightParam, episodeCo)
	local isSeasonType = false

	if Activity104Model.instance:isSeasonEpisodeType(episodeCo.type) then
		Activity104HeroGroupController.instance:openGroupFightView(fightParam.battleId, fightParam.episodeId)

		isSeasonType = true
	elseif Season123Controller.isSeason123EpisodeType(episodeCo.type) then
		Season123HeroGroupController.instance:openHeroGroupView(fightParam.battleId, fightParam.episodeId)

		isSeasonType = true
	elseif Season166Controller.isSeason166EpisodeType(episodeCo.type) then
		Season166HeroGroupController.instance:openHeroGroupView(fightParam.battleId, fightParam.episodeId)

		isSeasonType = true
	end

	return isSeasonType
end

function SeasonFightHandler.checkProcessFightReconnect(fightReason)
	Season123Controller.instance:checkProcessFightReconnect()
	Season166Controller.instance:checkProcessFightReconnect()

	if fightReason.episodeId == Activity104Enum.SeasonEpisodeId and fightReason.data ~= "" then
		local datas = string.split(fightReason.data, "#")
		local seasonEpisodeId = tonumber(datas[2])
		local difficult = tonumber(datas[3])
		local buffs = {}

		for i = 4, #datas do
			if tonumber(datas[i]) then
				table.insert(buffs, tonumber(datas[i]))
			end
		end

		FightController.instance:setFightParamByEpisodeBattleId(fightReason.episodeId, FightModel.instance:getBattleId())
	end
end

function SeasonFightHandler.loadSeasonCondition(episodeType, gopasstarget, goconditionitemdesc, goconditionitem)
	local episodeId = DungeonModel.instance.curSendEpisodeId

	if episodeType == DungeonEnum.EpisodeType.SeasonRetail then
		gohelper.setActive(gopasstarget, false)

		local data = Activity104Model.instance:getAct104Retails()
		local chapterId = DungeonModel.instance.curSendChapterId
		local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)
		local hardMode = chapterCo and chapterCo.type == DungeonEnum.ChapterType.Hard

		for i, v in ipairs(data) do
			if v.id == episodeId then
				local conditionConfig = lua_condition.configDict[v.advancedId]

				if conditionConfig then
					gohelper.setActive(gopasstarget, true)

					gohelper.findChildText(goconditionitemdesc, "").text = conditionConfig.desc
					gohelper.findChildText(goconditionitem, "passtargetTip/tip").text = luaLang("season_retail_special_rule_title")

					local retailMo = Activity104Model.instance:getEpisodeRetail(episodeId)
					local tarColor = "#87898C"
					local starImage = hardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"
					local star = gohelper.findChildImage(goconditionitem, "desc/star")

					UISpriteSetMgr.instance:setCommonSprite(star, starImage)
					SLFramework.UGUI.GuiHelper.SetColor(star, tarColor)
				end

				break
			end
		end

		return true
	elseif episodeType == DungeonEnum.EpisodeType.Season166Base then
		local context = Season166Model.instance:getBattleContext()

		if context and context.baseId and context.baseId > 0 then
			gohelper.setActive(goconditionitemdesc, false)

			for level = 1, 3 do
				local descGO = gohelper.clone(goconditionitemdesc, goconditionitem, "desc" .. level)
				local scoreCo = Season166Config.instance:getSeasonScoreCo(context.actId, level)
				local txtTargetCondition = gohelper.findChildText(descGO, "")
				local imageStar = gohelper.findChildImage(descGO, "star")

				gohelper.setActive(descGO, true)

				local descFormat = luaLang("season166_herogroup_fightScoreTarget")

				txtTargetCondition.text = GameUtil.getSubPlaceholderLuaLang(descFormat, {
					scoreCo.needScore
				})

				local curScore = Season166BaseSpotModel.instance:getBaseSpotMaxScore(context.actId, context.baseId)
				local isFinish = curScore >= scoreCo.needScore

				UISpriteSetMgr.instance:setSeason166Sprite(imageStar, isFinish and "season166_result_inclinedbulb2" or "season166_result_inclinedbulb1", true)
				transformhelper.setLocalScale(imageStar.transform, 0.5, 0.5, 0.5)
				SLFramework.UGUI.GuiHelper.SetColor(imageStar, "#FFFFFF")
			end

			return true
		else
			return false
		end
	end

	return false
end

return SeasonFightHandler
