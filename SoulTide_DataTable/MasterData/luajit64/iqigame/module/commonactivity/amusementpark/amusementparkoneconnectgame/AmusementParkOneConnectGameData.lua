-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkOneConnectGame\\AmusementParkOneConnectGameData.lua

local m = {
	ConnectBlocks = {}
}

function m.New(levelData)
	local o = Clone(m)

	o:Init(levelData)

	return o
end

function m:Init(levelData)
	self.LevelData = levelData
	self.ConnectBlocks = {}
end

function m:RestGame()
	self.LevelData:RestLevelBlock()

	self.ConnectBlocks = {}
end

function m:AddBlockData(blockData)
	for i, v in pairs(self.ConnectBlocks) do
		v.IsFirst = false
	end

	blockData.IsFirst = true
	blockData.State = 1

	table.insert(self.ConnectBlocks, blockData)
end

function m:CheckIsConnect(blockData)
	local lastBlockData = self.ConnectBlocks[#self.ConnectBlocks]

	if lastBlockData == nil then
		return true
	end

	if blockData.State == 0 then
		local des = math.abs(blockData.X - lastBlockData.X) + math.abs(blockData.Y - lastBlockData.Y)

		if des == 1 then
			return true
		end
	end

	return false
end

function m:CheckComplete()
	return #self.ConnectBlocks == #self.LevelData.LevelBlocks
end

return m
