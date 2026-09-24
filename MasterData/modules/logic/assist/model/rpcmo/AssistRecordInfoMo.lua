-- chunkname: @modules/logic/assist/model/rpcmo/AssistRecordInfoMo.lua

module("modules.logic.assist.model.rpcmo.AssistRecordInfoMo", package.seeall)

local AssistRecordInfoMo = pureTable("AssistRecordInfoMo")

function AssistRecordInfoMo:init(info)
	self.heroStats, self.heroStatsMap = GameUtil.rpcInfosToListAndMap(info.heroStats, AssistHeroStatMo, "heroUid")
	self.dungeonStats, self.dungeonStatsMap = GameUtil.rpcInfosToListAndMap(info.dungeonStats, AssistDungeonStatMo, "type")

	table.sort(self.heroStats, function(a, b)
		return a.count > b.count
	end)
end

function AssistRecordInfoMo:getHeroStatMo(heroUid)
	return self.heroStatsMap[heroUid]
end

function AssistRecordInfoMo:getTop3HeroStats()
	local top3MoList = {}

	for i = 1, 3 do
		if self.heroStats[i] then
			top3MoList[i] = self.heroStats[i]
		end
	end

	return top3MoList
end

function AssistRecordInfoMo:getAllLikeCount()
	local count = 0

	for _, v in ipairs(self.dungeonStats) do
		count = count + v.count
	end

	return count
end

function AssistRecordInfoMo:getDungeonStatByType(dungeonType)
	return self.dungeonStatsMap[dungeonType]
end

return AssistRecordInfoMo
