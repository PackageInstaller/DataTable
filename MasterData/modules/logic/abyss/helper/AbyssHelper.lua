-- chunkname: @modules/logic/abyss/helper/AbyssHelper.lua

module("modules.logic.abyss.helper.AbyssHelper", package.seeall)

local AbyssHelper = _M

function AbyssHelper.getEpisodeConditionDescList(episodeId)
	local conditionDescList = {}

	table.insert(conditionDescList, DungeonConfig.instance:getFirstEpisodeWinConditionText(episodeId))

	local advancedCondition = DungeonConfig.instance:getEpisodeAdvancedCondition(episodeId)

	if LuaUtil.isEmptyStr(advancedCondition) == false then
		local conditionList = string.splitToNumber(advancedCondition, "|")

		for i = #conditionList, 1, -1 do
			local conditionId = conditionList[i]
			local condition = lua_condition.configDict[conditionId]

			table.insert(conditionDescList, condition.desc)
		end
	end

	return conditionDescList
end

function AbyssHelper.getRecommendList(battleId)
	local recommendedList = {}
	local battleConfig = lua_battle.configDict[battleId]

	if battleConfig and not string.nilorempty(battleConfig.monsterGroupIds) then
		local monsterGroupIds = string.splitToNumber(battleConfig.monsterGroupIds, "#")

		recommendedList = FightHelper.getAttributeCounter(monsterGroupIds, false)
	end

	return recommendedList
end

function AbyssHelper.getRecommendTeamList(recommendTeamParam)
	if not string.nilorempty(recommendTeamParam) then
		local tempList = {}
		local teamList = string.split(recommendTeamParam, "#")

		for _, teamId in ipairs(teamList) do
			local teamConfig = HeroConfig.instance:getBattleTagConfigCO(teamId)

			if teamConfig then
				table.insert(tempList, teamConfig.tagName)
			end
		end

		return table.concat(tempList, "|")
	end

	return luaLang("new_common_none")
end

function AbyssHelper.getRuleList(battleId)
	local battleCo = lua_battle.configDict[battleId]

	if battleCo then
		if not battleCo.additionRule then
			local additionRule = ""

			return (FightStrUtil.instance:getSplitString2Cache(additionRule, true, "|", "#"))
		end
	end
end

function AbyssHelper.loadFightCondition(fightTipView, episodeType, episodeId, gopasstarget, goconditionitemdesc, goconditionitem)
	if episodeType == DungeonEnum.EpisodeType.Abyss then
		local commonDesc = DungeonConfig.instance:getFirstEpisodeWinConditionText(episodeId)

		gohelper.setActive(gopasstarget, not string.nilorempty(commonDesc))
		gohelper.setActive(goconditionitemdesc, false)

		local descGO = gohelper.clone(goconditionitemdesc, goconditionitem, "desc_1")
		local battleId = FightModel.instance:getBattleId()

		gohelper.setActive(descGO, true)
		fightTipView:_setConditionText(descGO, commonDesc, false)

		local imageComp = gohelper.findChildImage(descGO, "star")

		SLFramework.UGUI.GuiHelper.SetColor(imageComp, "#FFFFFF")
		UISpriteSetMgr.instance:setFightSprite(imageComp, "icon_star_open", true)

		local advancedCondition = DungeonConfig.instance:getEpisodeAdvancedCondition(episodeId)

		if LuaUtil.isEmptyStr(advancedCondition) == false then
			local conditionList = string.splitToNumber(advancedCondition, "|")
			local descCount = #conditionList

			for i = descCount, 1, -1 do
				local conditionId = conditionList[i]
				local advanceConditionGo = gohelper.clone(goconditionitemdesc, goconditionitem, "desc_" .. tostring(i + 1))

				gohelper.setActive(advanceConditionGo, true)

				local condition = lua_condition.configDict[conditionId]
				local platHighLight = fightTipView:checkPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2(episodeId, i, battleId))
				local desc = condition.desc

				fightTipView:_setConditionText(advanceConditionGo, desc, platHighLight)

				local isFinal = i <= 1
				local imageName = not isFinal and (platHighLight and "icon_star_open" or "icon_star_lock") or platHighLight and "icon_star_open2" or "icon_star_nol2"
				local advanceImageComp = gohelper.findChildImage(advanceConditionGo, "star")

				SLFramework.UGUI.GuiHelper.SetColor(advanceImageComp, "#FFFFFF")
				UISpriteSetMgr.instance:setFightSprite(advanceImageComp, imageName, true)
			end
		end

		local comp = gohelper.onceAddComponent(fightTipView._goconditionitem, gohelper.Type_VerticalLayoutGroup)

		comp.spacing = 36

		return true
	end
end

function AbyssHelper.loadFightRoundCondition(episodeId, gogoal, goconditionitemdesc)
	local data = AbyssHelper.getEpisodeConditionDescList(episodeId)
	local haveTarget = data and next(data)

	gohelper.setActive(gogoal, haveTarget)
	gohelper.setActive(goconditionitemdesc, false)

	if haveTarget then
		for i, v in ipairs(data) do
			local descGO = gohelper.clone(goconditionitemdesc, gogoal, "#go_condition_" .. i)

			gohelper.setActive(descGO, true)

			gohelper.findChildText(descGO, "#txt_condition1").text = v
		end

		local comp = gohelper.onceAddComponent(gogoal, gohelper.Type_VerticalLayoutGroup)

		comp.spacing = 5
	end
end

function AbyssHelper.getValidSkill(stageId, skillId)
	if stageId == nil then
		return 0
	end

	local skillDic = AbyssConfig.instance:getStageSkillIdDic(stageId)

	if not skillDic or not skillDic[skillId] then
		return 0
	end

	return skillId
end

return AbyssHelper
