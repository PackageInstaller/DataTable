-- chunkname: @modules/logic/rouge2/common/model/Rouge2_ReviewMO.lua

module("modules.logic.rouge2.common.model.Rouge2_ReviewMO", package.seeall)

local Rouge2_ReviewMO = pureTable("Rouge2_ReviewMO")

function Rouge2_ReviewMO:init(info)
	self.playerName = info.playerName
	self.playerLevel = info.playerLevel
	self.portrait = info.portrait
	self.finishTime = info.finishTime
	self.difficulty = info.difficulty
	self.curCareer = info.curCareer
	self.mainCareer = self.curCareer
	self.gainCoin = info.gainCoin
	self.leaderAttrInfo = info.leaderAttrInfo
	self.endId = info.endId
	self.drugId = info.drugId
	self.collectionBag = info.collectionBag
	self.middleLayerId = info.middleLayerId
	self.layerId = info.layerId
	self.endHeroId = info.endHeroId
	self.allItemIdList = info.itemId
	self.bagType2ItemLsit = {}

	for _, itemId in ipairs(info.itemId or {}) do
		local bagType = Rouge2_BackpackHelper.itemId2BagType(itemId)

		if bagType then
			self.bagType2ItemLsit[bagType] = self.bagType2ItemLsit[bagType] or {}

			table.insert(self.bagType2ItemLsit[bagType], itemId)
		end
	end

	self.systemId = info.systemId
	self.score = info.score

	self:_initLastTeamInfo(info.lastTeamInfo)
end

function Rouge2_ReviewMO:getTeamInfo()
	return self.endHeroId
end

function Rouge2_ReviewMO:_initLastTeamInfo(lastTeamInfo)
	self.lastHeroIdList = {}
	self.lastTeamInfoList, self.lastTeamInfoMap = GameUtil.rpcInfosToListAndMap(lastTeamInfo, Rouge2_BattleTeamInfoMO, "pos")

	table.sort(self.lastTeamInfoList, function(a, b)
		return a.pos < b.pos
	end)

	for _, teamInfo in ipairs(self.lastTeamInfoList) do
		local heroId = teamInfo:getHeroId()

		if heroId and heroId ~= 0 then
			table.insert(self.lastHeroIdList, heroId)
		end
	end
end

function Rouge2_ReviewMO:getHeroIdList()
	return self.lastHeroIdList
end

function Rouge2_ReviewMO:getLastTeamInfoList()
	return self.lastTeamInfoList
end

function Rouge2_ReviewMO:getLastTeamInfoByIndex(index)
	return self.lastTeamInfoMap and self.lastTeamInfoMap[index]
end

function Rouge2_ReviewMO:isSucceed()
	return self.endId and self.endId ~= 0
end

function Rouge2_ReviewMO:isInMiddleLayer()
	return self.middleLayerId ~= 0
end

function Rouge2_ReviewMO:getLeaderAttrInfoList()
	return self.leaderAttrInfo
end

function Rouge2_ReviewMO:getItemList(bagType)
	return self.bagType2ItemLsit and self.bagType2ItemLsit[bagType]
end

function Rouge2_ReviewMO:getItemCount(bagType)
	local itemList = self:getItemList(bagType)

	return (itemList or nil) and (#itemList or 0)
end

function Rouge2_ReviewMO:getCollections()
	return self:getItemList(Rouge2_Enum.BagType.Relics)
end

function Rouge2_ReviewMO:getDrugId()
	return self.drugId
end

function Rouge2_ReviewMO:getDifficulty()
	return self.difficulty
end

function Rouge2_ReviewMO:getSystemId()
	return self.systemId
end

function Rouge2_ReviewMO:getScore()
	return self.score
end

function Rouge2_ReviewMO:getCareerId()
	return self.curCareer
end

return Rouge2_ReviewMO
