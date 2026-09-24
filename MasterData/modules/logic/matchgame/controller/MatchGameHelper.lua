-- chunkname: @modules/logic/matchgame/controller/MatchGameHelper.lua

module("modules.logic.matchgame.controller.MatchGameHelper", package.seeall)

local MatchGameHelper = _M

function MatchGameHelper.setCharacterElement(elementId, imageIcon, txtName)
	local elementCo = lua_activity244_element.configDict[elementId]

	if imageIcon then
		local icon = elementCo and elementCo.icon

		UISpriteSetMgr.instance:setMatchGameSprite(imageIcon, icon, true)
	end

	if txtName then
		txtName.text = elementCo and elementCo.name
	end
end

function MatchGameHelper.setCharacterAttr(attrType, imageIcon, txtName)
	local attrCo = lua_activity244_character_attr.configDict[attrType]

	if imageIcon then
		local icon = attrCo and attrCo.icon

		UISpriteSetMgr.instance:setCommonSprite(imageIcon, icon)
	end

	if txtName then
		txtName.text = attrCo and attrCo.name
	end
end

function MatchGameHelper.setItemIcon(itemId, imageIcon, imageRare, iconType)
	local itemCo = lua_activity244_item.configDict[itemId]
	local quality = itemCo and itemCo.quality

	if imageRare then
		UISpriteSetMgr.instance:setCommonSprite(imageRare, "bgequip" .. quality)
	end

	if imageIcon then
		iconType = iconType or MatchGameEnum.ItemIconType.Small

		if iconType == MatchGameEnum.ItemIconType.Small then
			UISpriteSetMgr.instance:setMatchGameSprite(imageIcon, string.format("%s_1", itemCo.icon), true)
		elseif iconType == MatchGameEnum.ItemIconType.Large then
			UISpriteSetMgr.instance:setMatchGameSprite(imageIcon, string.format("%s", itemCo.icon), true)
		end
	end
end

function MatchGameHelper.getEpisodeConditionList(episodeId)
	local episodeCo = lua_activity244_episode.configDict[episodeId]
	local matchLevelId = episodeCo and episodeCo.matchLevelId
	local conditionList = MatchGameConfig.instance:getLevelConditionList(matchLevelId)

	if not conditionList then
		return
	end

	local contentList = {}

	for _, conditionParam in ipairs(conditionList) do
		local handleFunc = MatchGameHelper.conditionProcessFuncMap[tonumber(conditionParam[1])]

		if handleFunc then
			local content = handleFunc(conditionParam)

			table.insert(contentList, content)
		end
	end

	return contentList, conditionList
end

function MatchGameHelper.getConditionContent_MatchElementNum(paramList)
	local elementConfig = MatchGameFightConfig.instance:getElementConfig(paramList[2])

	return GameUtil.getSubPlaceholderLuaLang(luaLang("matchgame_fight_goal_match"), {
		paramList[3],
		elementConfig.name
	})
end

function MatchGameHelper.getConditionContent_KillAll(paramList)
	return luaLang("matchgame_fight_goal_killAll")
end

function MatchGameHelper.getConditionContent_RoundNum(paramList)
	return GameUtil.getSubPlaceholderLuaLang(luaLang("matchgame_fight_goal_roundNum"), {
		paramList[2]
	})
end

MatchGameHelper.conditionProcessFuncMap = {
	[MatchGameFightEnum.FightTargetType.MatchElementNum] = MatchGameHelper.getConditionContent_MatchElementNum,
	[MatchGameFightEnum.FightTargetType.KillAll] = MatchGameHelper.getConditionContent_KillAll,
	[MatchGameFightEnum.FightTargetType.RoundNum] = MatchGameHelper.getConditionContent_RoundNum
}

function MatchGameHelper.isChapterUnlock(chapterId)
	local chapterCo = lua_activity244_chapter.configDict[chapterId]

	if not chapterCo then
		return
	end

	return MatchGameHelper.isConditionUnlock(chapterCo.unlock)
end

function MatchGameHelper.isCharacterUnlock(characterId)
	local characterCo = lua_activity244_character.configDict[characterId]
	local unlockEpisodeId = characterCo and tonumber(characterCo.unlockType)

	if unlockEpisodeId and unlockEpisodeId ~= 0 then
		local unlockEpisodeCo = lua_activity244_episode.configDict[unlockEpisodeId]
		local isUnlock = MatchGameModel.instance:getEpisodeStatus(unlockEpisodeId) >= MatchGameEnum.EpisodeStatus.Finish

		return isUnlock, ToastEnum.MatchGameNotPassEpisode, unlockEpisodeCo and unlockEpisodeCo.levelName
	end

	return true
end

function MatchGameHelper.isConditionUnlock(conditionStr)
	local unlockList = GameUtil.splitString2(conditionStr)

	if unlockList then
		for _, unlockParam in ipairs(unlockList) do
			local unlockType = unlockParam[1]
			local checkFunc = MatchGameHelper.unlockParamFuncMap[unlockType]

			if checkFunc then
				local result, toastId, toastParam = checkFunc(unlockParam)

				if not result then
					return result, toastId, toastParam
				end
			else
				logError(string.format("三消缺少对应的解锁条件判断方法 unlockType = %s", unlockType))
			end
		end
	end

	return true
end

function MatchGameHelper._isConditionPass_StarNum(conditionParam)
	local starNum = tonumber(conditionParam[2]) or 0
	local unlock = starNum <= MatchGameModel.instance:getCurRewardScore(MatchGameEnum.RewardType.Normal)

	return unlock, ToastEnum.MatchGameNotGetStarNum, starNum
end

function MatchGameHelper._isConditionPass_PassEpisode(conditionParam)
	local episodeId = tonumber(conditionParam[2]) or 0
	local episodeCo = lua_activity244_episode.configDict[episodeId]
	local status = MatchGameModel.instance:getEpisodeStatus(episodeId)
	local unlock = status == MatchGameEnum.EpisodeStatus.Finish

	return unlock, ToastEnum.MatchGameNotPassEpisode, episodeCo and episodeCo.levelName
end

MatchGameHelper.unlockParamFuncMap = {
	[MatchGameEnum.UnlockType.StarNum] = MatchGameHelper._isConditionPass_StarNum,
	[MatchGameEnum.UnlockType.PassEpisode] = MatchGameHelper._isConditionPass_PassEpisode
}

function MatchGameHelper.isTalentTeamConditionActive(singleList, conditionStr)
	if string.nilorempty(conditionStr) then
		return
	end

	local conditionList = GameUtil.splitString2(conditionStr, true)

	for _, conditionParam in ipairs(conditionList) do
		local conditionType = conditionParam[1]
		local checkFunc = MatchGameHelper.teamConditionCheckFuncMap[conditionType]
		local isPass = checkFunc and checkFunc(singleList, conditionParam)

		if not isPass then
			return
		end
	end

	return true
end

function MatchGameHelper._isTeamConditionActive_ElementNum(singleMap, conditionParam)
	local curNum = 0

	if not conditionParam[2] then
		if not conditionParam[3] then
			local elementId = 0

			for _, singleMo in pairs(singleMap) do
				if singleMo.heroMo then
					if singleMo.heroMo and singleMo.heroMo.elementId == elementId then
						curNum = curNum + 1
					end

					if conditionParam[2] <= curNum then
						return true
					end
				end
			end
		end
	end
end

MatchGameHelper.teamConditionCheckFuncMap = {
	[MatchGameEnum.TalentTeamConditionType.ElementNum] = MatchGameHelper._isTeamConditionActive_ElementNum
}

return MatchGameHelper
