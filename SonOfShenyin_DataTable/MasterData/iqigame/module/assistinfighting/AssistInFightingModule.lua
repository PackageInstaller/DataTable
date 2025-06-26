-- chunkname: @IQIGame\\Module\\AssistInFighting\\AssistInFightingModule.lua

AssistInFightingModule = {}

function AssistInFightingModule.Reload(helpHeros)
	for i, v in pairs(helpHeros) do
		AssistInFightingModule.WarlockList[i] = WarlockModule.WarlockDataDic[v.hero.cid]
	end
end

function AssistInFightingModule.Initialize()
	AssistInFightingModule.WarlockList = {}
	AssistInFightingModule.CurOperationWarlockData = {}
	AssistInFightingModule.PreloadAssetPath = {}
	AssistInFightingModule.FriendHelpHeroList = {}
	AssistInFightingModule.HelpHeroBoxPos = nil
end

function AssistInFightingModule.CreateWarlockData(FormationPOD, index)
	return
end

function AssistInFightingModule.UpdatePlayerSetHeroData(POD)
	return
end

function AssistInFightingModule.GethelpHeroList(pos)
	local dataArr = CfgDiscreteDataTable[27].Data
	local quality = dataArr[pos]
	local list = {}

	for i, v in pairs(WarlockModule.WarlockDataDic) do
		if AssistInFightingModule.isInFightHelpList(i) == false then
			table.insert(list, v)
		end
	end

	return list
end

function AssistInFightingModule.isInFightHelpList(cid)
	for i, v in pairs(AssistInFightingModule.WarlockList) do
		if cid == v.cid then
			return true
		end
	end

	return false
end

function AssistInFightingModule.GetSkillConfig(skillCid)
	return CfgSkillTable[skillCid]
end

function AssistInFightingModule.SetPreloadAssetPath(index, path)
	AssistInFightingModule.PreloadAssetPath[index] = {}
	AssistInFightingModule.PreloadAssetPath[index].cid = index
	AssistInFightingModule.PreloadAssetPath[index].path = path
end

function AssistInFightingModule.SetHelpHero(pos, heroCid)
	net_player.setHelpHero(pos, heroCid)
end

function AssistInFightingModule.RecommendHelpHeros(maxLv)
	net_centerFriend.recommendHelpHeros(maxLv)
end

function AssistInFightingModule.ChooseHelpHero(cid, pos, helpHeroPOD)
	return
end

function AssistInFightingModule.ClearHelpHero(cid)
	net_formation.clearHelpHero(cid)
end

function AssistInFightingModule.SetHelpHeroSucceed(code, baseInfo)
	AssistInFightingModule.Reload(baseInfo.helpHeros)
	EventDispatcher.Dispatch(EventID.AssisInFightingChange, AssistInFightingModule.CurOperationWarlockData.pos, baseInfo.helpHeros[AssistInFightingModule.CurOperationWarlockData.pos])

	AssistInFightingModule.CurOperationWarlockData = {}
end

function AssistInFightingModule.RecommendHelpHerosResult(code, helpHeros)
	local index = 0

	for i, helpHeroPOD in pairs(helpHeros) do
		index = index + 1

		local itemData = {}

		for key, value in pairs(helpHeroPOD) do
			itemData[key] = value
		end

		local IsApplied = FriendModule.IsApplied(itemData.pid)

		itemData.type = IsApplied and 5 or nil
		itemData.isFriend = FriendModule.GetFriendByPId(itemData.pid) ~= nil
		itemData.BaseData = CfgHeroTable[itemData.hero.cid]
		AssistInFightingModule.FriendHelpHeroList[index] = itemData
	end

	EventDispatcher.Dispatch(EventID.GetHelpHerosResult)
end

function AssistInFightingModule.ChooseHelpHeroResult(code, formation)
	return
end

function AssistInFightingModule.ClearHelpHeroResult(code, formation)
	return
end
