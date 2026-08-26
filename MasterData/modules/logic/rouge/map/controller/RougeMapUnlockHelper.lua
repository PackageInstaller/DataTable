-- chunkname: @modules/logic/rouge/map/controller/RougeMapUnlockHelper.lua

module("modules.logic.rouge.map.controller.RougeMapUnlockHelper", package.seeall)

local RougeMapUnlockHelper = class("RougeMapUnlockHelper")

RougeMapUnlockHelper.UnlockType = {
	FinishEntrust = 14,
	PossessPower = 4,
	FinishEnd = 13,
	PossessCollectionCountByTag = 8,
	FinishAnyOneEnd = 12,
	DeadHeroNum = 17,
	PassLayer = 7,
	HadNotUniqueCollectionNum = 18,
	LevelUpSpCollectionCount = 20,
	PossessHero = 3,
	PossessSpCollectionCount = 21,
	FinishDifficulty = 16,
	PossessCollectionCount = 5,
	FinishPiece = 15,
	PossessCollectionCountByRare = 6,
	PossessCoin = 2,
	ActiveOutGenius = 9,
	FinishEvent = 11,
	PossessCollection = 1,
	CurMiddlePieceSelect = 10,
	None = 0
}

function RougeMapUnlockHelper.checkIsUnlock(unlockType, unlockParam)
	RougeMapUnlockHelper._initHandle()

	local handle = RougeMapUnlockHelper.unlockHandleDict[unlockType]

	if not handle then
		return true
	end

	return handle(unlockParam)
end

function RougeMapUnlockHelper.getLockTips(unlockType, unlockParam)
	RougeMapUnlockHelper._initGetTipHandle()

	local handle = RougeMapUnlockHelper.getTipHandleDict[unlockType]

	if not handle then
		return ""
	end

	local descCo = lua_rouge_unlock_desc.configDict[unlockType]

	if not descCo then
		return ""
	end

	local desc = descCo.desc

	return handle(desc, unlockParam)
end

function RougeMapUnlockHelper._initHandle()
	if RougeMapUnlockHelper.unlockHandleDict then
		return
	end

	RougeMapUnlockHelper.unlockHandleDict = {
		[RougeMapUnlockHelper.UnlockType.None] = RougeMapUnlockHelper._defaultCheck,
		[RougeMapUnlockHelper.UnlockType.PossessCollection] = RougeMapUnlockHelper._checkPossessCollection,
		[RougeMapUnlockHelper.UnlockType.PossessCoin] = RougeMapUnlockHelper._checkPossessCoin,
		[RougeMapUnlockHelper.UnlockType.PossessHero] = RougeMapUnlockHelper._checkPossessHero,
		[RougeMapUnlockHelper.UnlockType.PossessPower] = RougeMapUnlockHelper._checkPossessPower,
		[RougeMapUnlockHelper.UnlockType.PossessCollectionCount] = RougeMapUnlockHelper._checkPossessCollectionCount,
		[RougeMapUnlockHelper.UnlockType.PossessCollectionCountByRare] = RougeMapUnlockHelper._checkPossessCollectionCountByRare,
		[RougeMapUnlockHelper.UnlockType.PassLayer] = RougeMapUnlockHelper._checkPassLayer,
		[RougeMapUnlockHelper.UnlockType.PossessCollectionCountByTag] = RougeMapUnlockHelper._checkPossessCollectionCountByTag,
		[RougeMapUnlockHelper.UnlockType.ActiveOutGenius] = RougeMapUnlockHelper._checkActiveOutGenius,
		[RougeMapUnlockHelper.UnlockType.CurMiddlePieceSelect] = RougeMapUnlockHelper._checkCurMiddlePieceSelect,
		[RougeMapUnlockHelper.UnlockType.FinishEvent] = RougeMapUnlockHelper._checkFinishEvent,
		[RougeMapUnlockHelper.UnlockType.FinishAnyOneEnd] = RougeMapUnlockHelper._checkFinishAnyOneEnd,
		[RougeMapUnlockHelper.UnlockType.FinishEnd] = RougeMapUnlockHelper._checkFinishEnd,
		[RougeMapUnlockHelper.UnlockType.FinishEntrust] = RougeMapUnlockHelper._checkFinishEntrust,
		[RougeMapUnlockHelper.UnlockType.FinishPiece] = RougeMapUnlockHelper._checkFinishPiece,
		[RougeMapUnlockHelper.UnlockType.FinishDifficulty] = RougeMapUnlockHelper._checkFinishDifficulty,
		[RougeMapUnlockHelper.UnlockType.DeadHeroNum] = RougeMapUnlockHelper._checkDeadHeroNum,
		[RougeMapUnlockHelper.UnlockType.HadNotUniqueCollectionNum] = RougeMapUnlockHelper._checkHadNotUniqueCollectionNum,
		[RougeMapUnlockHelper.UnlockType.PossessSpCollectionCount] = RougeMapUnlockHelper._checkHadSpCollectionNum,
		[RougeMapUnlockHelper.UnlockType.LevelUpSpCollectionCount] = RougeMapUnlockHelper._checkHadLevelUpSpCollectionNum
	}
end

function RougeMapUnlockHelper._initGetTipHandle()
	if RougeMapUnlockHelper.getTipHandleDict then
		return
	end

	RougeMapUnlockHelper.getTipHandleDict = {
		[RougeMapUnlockHelper.UnlockType.PossessCollection] = RougeMapUnlockHelper._getPossessCollectionTip,
		[RougeMapUnlockHelper.UnlockType.PossessCoin] = RougeMapUnlockHelper._getDefaultTips,
		[RougeMapUnlockHelper.UnlockType.PossessHero] = RougeMapUnlockHelper._getDefaultTips,
		[RougeMapUnlockHelper.UnlockType.PossessPower] = RougeMapUnlockHelper._getDefaultTips,
		[RougeMapUnlockHelper.UnlockType.PossessCollectionCount] = RougeMapUnlockHelper._getDefaultTips,
		[RougeMapUnlockHelper.UnlockType.PossessCollectionCountByRare] = RougeMapUnlockHelper._getPossessCollectionCountByRareTip,
		[RougeMapUnlockHelper.UnlockType.PassLayer] = RougeMapUnlockHelper._getPassLayerTip,
		[RougeMapUnlockHelper.UnlockType.PossessCollectionCountByTag] = RougeMapUnlockHelper._getPossessCollectionCountByTagTip,
		[RougeMapUnlockHelper.UnlockType.ActiveOutGenius] = RougeMapUnlockHelper._getActiveOutGeniusTip,
		[RougeMapUnlockHelper.UnlockType.CurMiddlePieceSelect] = RougeMapUnlockHelper._noParamTips,
		[RougeMapUnlockHelper.UnlockType.FinishEvent] = RougeMapUnlockHelper._getFinishEventTip,
		[RougeMapUnlockHelper.UnlockType.FinishAnyOneEnd] = RougeMapUnlockHelper._noParamTips,
		[RougeMapUnlockHelper.UnlockType.FinishEnd] = RougeMapUnlockHelper._getFinishEndTips,
		[RougeMapUnlockHelper.UnlockType.FinishEntrust] = RougeMapUnlockHelper._noParamTips,
		[RougeMapUnlockHelper.UnlockType.FinishPiece] = RougeMapUnlockHelper._noParamTips,
		[RougeMapUnlockHelper.UnlockType.FinishDifficulty] = RougeMapUnlockHelper._getFinishDifficultyTips,
		[RougeMapUnlockHelper.UnlockType.DeadHeroNum] = RougeMapUnlockHelper._getDefaultTips,
		[RougeMapUnlockHelper.UnlockType.HadNotUniqueCollectionNum] = RougeMapUnlockHelper._getDefaultTips,
		[RougeMapUnlockHelper.UnlockType.PossessSpCollectionCount] = RougeMapUnlockHelper._getDefaultTips,
		[RougeMapUnlockHelper.UnlockType.LevelUpSpCollectionCount] = RougeMapUnlockHelper._getDefaultTips
	}
end

function RougeMapUnlockHelper._defaultCheck()
	return true
end

function RougeMapUnlockHelper._checkPossessCollection(unlockParam)
	local collectionId = tonumber(unlockParam)

	if not collectionId then
		return true
	end

	local collectionList = RougeCollectionModel.instance:getAllCollections()

	for _, collectionMo in ipairs(collectionList) do
		if collectionMo.cfgId == collectionId then
			return true
		end
	end

	return false
end

function RougeMapUnlockHelper._checkPossessCoin(unlockParam)
	local rougeInfo = RougeModel.instance:getRougeInfo()

	return rougeInfo and rougeInfo.coin >= tonumber(unlockParam)
end

function RougeMapUnlockHelper._checkPossessHero(unlockParam)
	local teamInfo = RougeModel.instance:getTeamInfo()

	return teamInfo and teamInfo:getAllHeroCount() >= tonumber(unlockParam)
end

function RougeMapUnlockHelper._checkPossessPower(unlockParam)
	local rougeInfo = RougeModel.instance:getRougeInfo()

	return rougeInfo and rougeInfo.power >= tonumber(unlockParam)
end

function RougeMapUnlockHelper._checkPossessCollectionCount(unlockParam)
	local collectionList = RougeCollectionModel.instance:getAllCollections()

	return collectionList and #collectionList >= tonumber(unlockParam)
end

function RougeMapUnlockHelper._checkPossessCollectionCountByRare(unlockParam)
	local paramList = string.splitToNumber(unlockParam, "#")
	local rare, count = paramList[1], paramList[2]
	local curCount = 0
	local collectionList = RougeCollectionModel.instance:getAllCollections()

	for _, collectionMo in ipairs(collectionList) do
		local collectionCo = RougeCollectionConfig.instance:getCollectionCfg(collectionMo.cfgId)

		if collectionCo.rare == rare then
			curCount = curCount + 1

			if count <= curCount then
				return true
			end
		end
	end

	return count <= curCount
end

function RougeMapUnlockHelper._checkPassLayer(unlockParam)
	local layerId = RougeMapModel.instance:getLayerId()

	return layerId >= tonumber(unlockParam)
end

function RougeMapUnlockHelper._checkPossessCollectionCountByTag(unlockParam)
	local paramList = string.splitToNumber(unlockParam, "#")
	local tag, count = paramList[1], paramList[2]
	local curCount = 0
	local collectionList = RougeCollectionModel.instance:getAllCollections()

	for _, collectionMo in ipairs(collectionList) do
		local tags = RougeCollectionConfig.instance:getCollectionTags(collectionMo.cfgId)

		for _, _tag in ipairs(tags) do
			if _tag == tag then
				curCount = curCount + 1

				if count <= curCount then
					return true
				end
			end

			break
		end
	end

	return count <= curCount
end

function RougeMapUnlockHelper._checkActiveOutGenius(unlockParam)
	return RougeTalentModel.instance:checkNodeLight(tonumber(unlockParam))
end

function RougeMapUnlockHelper._checkCurMiddlePieceSelect(unlockParam)
	if RougeMapModel.instance:isNormalLayer() then
		return false
	end

	local paramList = string.splitToNumber(unlockParam, "#")
	local pieceId, selectId = paramList[1], paramList[2]
	local pieceList = RougeMapModel.instance:getPieceList()

	for _, pieceMo in ipairs(pieceList) do
		if pieceId == pieceMo.id then
			return selectId == pieceMo.selectId
		end
	end

	return false
end

function RougeMapUnlockHelper._checkFinishEvent(eventId)
	return RougeOutsideModel.instance:passedEventId(tonumber(eventId))
end

function RougeMapUnlockHelper._checkFinishAnyOneEnd()
	return RougeOutsideModel.instance:passAnyOneEnd()
end

function RougeMapUnlockHelper._checkFinishEnd(endId)
	return RougeOutsideModel.instance:passEndId(tonumber(endId))
end

function RougeMapUnlockHelper._checkFinishEntrust(entrustId)
	return RougeOutsideModel.instance:passEntrustId(tonumber(entrustId))
end

function RougeMapUnlockHelper._checkFinishPiece(unlockParam)
	if RougeMapModel.instance:isNormalLayer() then
		return false
	end

	local pieceIds = string.splitToNumber(unlockParam, "#")
	local pieceList = RougeMapModel.instance:getPieceList()
	local hasFinished = false

	for _, pieceMo in ipairs(pieceList) do
		if tabletool.indexOf(pieceIds, pieceMo.id) then
			hasFinished = pieceMo:isFinish()

			if hasFinished then
				break
			end
		end
	end

	return hasFinished
end

function RougeMapUnlockHelper._checkFinishDifficulty(unlockParam)
	local difficultyId = tonumber(unlockParam)
	local passedDifficulty = RougeOutsideModel.instance:passedDifficulty()

	return difficultyId <= passedDifficulty
end

function RougeMapUnlockHelper._checkDeadHeroNum(unlockParam)
	local deadHeroNum = RougeModel.instance:getDeadHeroNum()

	return deadHeroNum >= tonumber(unlockParam)
end

function RougeMapUnlockHelper._checkHadNotUniqueCollectionNum(unlockParam)
	local num = tonumber(unlockParam)

	return num <= RougeCollectionHelper.getNotUniqueCollectionNum()
end

function RougeMapUnlockHelper._checkHadSpCollectionNum(unlockParam)
	local num = tonumber(unlockParam)

	return num <= RougeDLCModel102.instance:getAllSpCollectionCount()
end

function RougeMapUnlockHelper._checkHadLevelUpSpCollectionNum(unlockParam)
	local num = tonumber(unlockParam)

	return num <= RougeDLCModel102.instance:getAllCanLevelUpSpCollectionCount()
end

function RougeMapUnlockHelper._noParamTips(desc, unlockParam)
	return desc
end

function RougeMapUnlockHelper._getDefaultTips(desc, unlockParam)
	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, unlockParam)
end

function RougeMapUnlockHelper._getPossessCollectionTip(desc, unlockParam)
	local name = RougeCollectionConfig.instance:getCollectionName(tonumber(unlockParam))

	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, name)
end

function RougeMapUnlockHelper._getPossessCollectionCountByRareTip(desc, unlockParam)
	local paramList = string.splitToNumber(unlockParam, "#")
	local rare, count = paramList[1], paramList[2]
	local rareName = lua_rouge_quality.configDict[rare].name

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, rareName, count)
end

function RougeMapUnlockHelper._getPassLayerTip(desc, unlockParam)
	local layerName = lua_rouge_layer.configDict[tonumber(unlockParam)].name

	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, layerName)
end

function RougeMapUnlockHelper._getPossessCollectionCountByTagTip(desc, unlockParam)
	local paramList = string.splitToNumber(unlockParam, "#")
	local tag, count = paramList[1], paramList[2]
	local tagName = lua_rouge_tag.configDict[tag].name

	return GameUtil.getSubPlaceholderLuaLangTwoParam(desc, tagName, count)
end

function RougeMapUnlockHelper._getActiveOutGeniusTip(desc, unlockParam)
	local geniusId = tonumber(unlockParam)
	local co = RougeTalentConfig.instance:getBranchConfigByID(RougeModel.instance:getSeason() or 1, geniusId)

	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, co.name)
end

function RougeMapUnlockHelper._getFinishEventTip(desc, unlockParam)
	local eventCo = RougeMapConfig.instance:getRougeEvent(tonumber(unlockParam))

	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, eventCo and eventCo.name)
end

function RougeMapUnlockHelper._getFinishEndTips(desc, unlockParam)
	local endCo = lua_rouge_ending.configDict[tonumber(unlockParam)]

	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, endCo and endCo.desc)
end

function RougeMapUnlockHelper._getFinishDifficultyTips(desc, unlockParam)
	local season = RougeModel.instance:getSeason() or 1
	local difficultyId = tonumber(unlockParam)
	local difficultyCo = lua_rouge_difficulty.configDict[season][difficultyId]

	return GameUtil.getSubPlaceholderLuaLangOneParam(desc, difficultyCo and difficultyCo.title)
end

return RougeMapUnlockHelper
