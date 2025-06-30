-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROPuzzleGame\\ROPuzzleGameData.lua

local m = {
	score = 0,
	isGameStart = false,
	maxLine = 10,
	maxColumn = 10,
	tileMaps = {},
	randomBlock = {}
}
local ROPuzzleMapTileData = require("IQIGame.Module.CommonActivity.RestaurantOperation.ROPuzzleGame.ROPuzzleMapTileData")

function m.New(cfgData)
	local o = Clone(m)

	o:Init(cfgData)

	return o
end

function m:Init(cfgData)
	self.score = 0
	self.cfgPuzzleGameControlData = cfgData
	self.tileMaps = self:CreateTiles()
	self.isGameStart = true
end

function m:CreateTiles()
	local tab = {}
	local index = 0

	for line = 1, self.maxLine do
		for column = 1, self.maxColumn do
			index = index + 1

			local tileData = ROPuzzleMapTileData.New(index, line, column, 0)

			tab[index] = tileData
		end
	end

	return tab
end

function m:RefreshRandomBlock()
	self.randomBlock = {}

	local blockGroup = table.clone(self.cfgPuzzleGameControlData.BlockGroup)

	for i = #blockGroup, 2, -1 do
		local random_index = math.random(i)

		blockGroup[i], blockGroup[random_index] = blockGroup[random_index], blockGroup[i]
	end

	for i = 1, self.cfgPuzzleGameControlData.BlockNum do
		local id = blockGroup[i]

		table.insert(self.randomBlock, id)
	end
end

function m:RemoveBlock(cid)
	local index = table.indexOf(self.randomBlock, cid)

	if index ~= -1 then
		table.remove(self.randomBlock, index)
	end
end

function m:Eliminate()
	local lines = {}
	local columns = {}

	for i = 1, self.maxLine do
		local isFull = true

		for j = 1, self.maxColumn do
			local pos = (i - 1) * self.maxLine + j

			if self.tileMaps[pos].blockId == 0 then
				isFull = false

				break
			end
		end

		if isFull then
			table.insert(lines, i)
		end
	end

	for j = 1, self.maxColumn do
		local isFull = true

		for i = 1, self.maxLine do
			local pos = (i - 1) * self.maxLine + j

			if self.tileMaps[pos].blockId == 0 then
				isFull = false

				break
			end
		end

		if isFull then
			table.insert(columns, j)
		end
	end

	local totalNum = #lines + #columns

	return totalNum, lines, columns
end

function m:AddScore(score)
	self.score = self.score + score
end

function m:CheckBlockCellCanPutDown(blockCell)
	local posTab = blockCell.blockData

	for i, tileData in pairs(self.tileMaps) do
		local canPutDown = false

		if tileData.blockId == 0 then
			for j, pos in pairs(posTab) do
				-- block empty
			end
		end
	end

	return false
end

return m
