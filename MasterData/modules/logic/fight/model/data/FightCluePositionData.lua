-- chunkname: @modules/logic/fight/model/data/FightCluePositionData.lua

module("modules.logic.fight.model.data.FightCluePositionData", package.seeall)

local FightCluePositionData = FightDataClass("FightCluePositionData")

function FightCluePositionData:onConstructor(proto)
	if proto then
		self.position = proto.position or 0
	end

	self.clues = {}

	if proto then
		for _, v in ipairs(proto.clues) do
			table.insert(self.clues, FightClueData.New(v))
		end
	end
end

function FightCluePositionData:updateByPosition(positionData)
	if not positionData then
		return
	end

	self.position = positionData.position

	FightDataUtil.coverData(positionData.clues, self.clues)
end

function FightCluePositionData:getClue(uid)
	for _, clueData in ipairs(self.clues) do
		if clueData.uid == uid then
			return clueData
		end
	end
end

function FightCluePositionData:addClue(clueData)
	if not clueData then
		return
	end

	local existClueData = self:getClue(clueData.uid)

	if existClueData then
		existClueData:updateByInfo(clueData)

		return
	end

	table.insert(self.clues, FightClueData.New(clueData))
end

function FightCluePositionData:removeClue(uid)
	for index, clueData in ipairs(self.clues) do
		if clueData.uid == uid then
			table.remove(self.clues, index)

			return
		end
	end
end

function FightCluePositionData:getClueCount()
	return #self.clues
end

return FightCluePositionData
