-- chunkname: @modules/logic/fight/model/data/FightProgressInfoData.lua

module("modules.logic.fight.model.data.FightProgressInfoData", package.seeall)

local FightProgressInfoData = FightDataClass("FightProgressInfoData")

function FightProgressInfoData:onConstructor(progressList)
	for i, v in ipairs(progressList) do
		local tab = {}
		local id = v.id

		tab.id = id
		tab.max = v.max
		tab.value = v.value
		tab.showId = v.showId
		self[id] = tab
	end
end

function FightProgressInfoData:getDataByShowId(showId)
	if not showId then
		return
	end

	for _, data in pairs(self) do
		if data.showId == showId then
			return data
		end
	end
end

return FightProgressInfoData
