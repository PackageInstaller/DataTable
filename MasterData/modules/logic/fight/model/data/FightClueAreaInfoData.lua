-- chunkname: @modules/logic/fight/model/data/FightClueAreaInfoData.lua

module("modules.logic.fight.model.data.FightClueAreaInfoData", package.seeall)

local FightClueAreaInfoData = FightDataClass("FightClueAreaInfoData")

function FightClueAreaInfoData:onConstructor(proto)
	self.cluePositions = {}

	if proto then
		for _, v in ipairs(proto.cluePositions) do
			table.insert(self.cluePositions, FightCluePositionData.New(v))
		end
	end
end

function FightClueAreaInfoData:updateByArea(areaInfo)
	if not areaInfo then
		return
	end

	tabletool.clear(self.cluePositions)

	for _, positionData in ipairs(areaInfo.cluePositions) do
		local newPositionData = FightCluePositionData.New()

		newPositionData:updateByPosition(positionData)
		table.insert(self.cluePositions, newPositionData)
	end
end

function FightClueAreaInfoData:getPositionData(position)
	for _, positionData in ipairs(self.cluePositions) do
		if positionData.position == position then
			return positionData
		end
	end
end

function FightClueAreaInfoData:getOrCreatePositionData(position)
	local positionData = self:getPositionData(position)

	if not positionData then
		positionData = FightCluePositionData.New()
		positionData.position = position

		table.insert(self.cluePositions, positionData)
	end

	return positionData
end

function FightClueAreaInfoData:addClues(positionData)
	if not positionData then
		return
	end

	local targetPositionData = self:getOrCreatePositionData(positionData.position)

	for _, clueData in ipairs(positionData.clues) do
		targetPositionData:addClue(clueData)
	end
end

function FightClueAreaInfoData:removeClues(positionData)
	if not positionData then
		return
	end

	local targetPositionData = self:getPositionData(positionData.position)

	if not targetPositionData then
		return
	end

	for _, clueData in ipairs(positionData.clues) do
		targetPositionData:removeClue(clueData.uid)
	end
end

function FightClueAreaInfoData:getClue(uid)
	for _, positionData in ipairs(self.cluePositions) do
		local clueData = positionData:getClue(uid)

		if clueData then
			return clueData
		end
	end
end

function FightClueAreaInfoData:getCluesByEntityUid(entityUid)
	local clueList = {}

	for _, positionData in ipairs(self.cluePositions) do
		for _, clueData in ipairs(positionData.clues) do
			if clueData.entityUid == entityUid then
				table.insert(clueList, clueData)
			end
		end
	end

	return clueList
end

function FightClueAreaInfoData:getClueCount()
	local count = 0

	for _, positionData in ipairs(self.cluePositions) do
		count = count + positionData:getClueCount()
	end

	return count
end

return FightClueAreaInfoData
