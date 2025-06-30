-- chunkname: @IQIGame\\UI\\MonsterAcademyGame\\JigsawGameController.lua

local JigsawGameBlockItem = require("IQIGame.UI.MonsterAcademyGame.JigsawGameBlockItem")
local m = {
	Row = 1,
	IsGameStart = false,
	Col = 1,
	CanOperation = false,
	BlockItems = {}
}

function m.New(viewRoot, row, col)
	local obj = Clone(m)

	obj:__Init(viewRoot, row, col)

	return obj
end

function m:__Init(viewRoot, row, col)
	self.ViewRoot = viewRoot
	self.Row = row
	self.Col = col
	self.CanOperation = false
	self.IsGameStart = false

	LuaCodeInterface.BindOutlet(self.ViewRoot, self)
	self.ItemTemplate.gameObject:SetActive(false)
end

function m:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.ViewRoot, self)

	for key, block in pairs(self.BlockItems) do
		block:OnDestroy()
	end

	self.BlockItems = nil
end

function m:SetData(texture, ratioW, ratioH)
	self:__GenerateGameLevel(texture, ratioW, ratioH)

	for index, block in pairs(self.BlockItems) do
		local x = self.ItemTemplate.transform.sizeDelta.x * block.LogicRow + self.ItemTemplate.transform.localPosition.x
		local y = self.ItemTemplate.transform.localPosition.y + self.ItemTemplate.transform.sizeDelta.y * block.LogicCol

		block.Root.transform.localPosition = Vector3.New(x, y, 0)
	end

	self.ViewRoot.gameObject:SetActive(true)
end

function m:StartGame()
	self.IsGameStart = true
	self.CanOperation = true
end

function m:EndGame()
	self.IsGameStart = false
	self.CanOperation = false
end

function m:__GetFreeBlock(rowIndex, colIndex)
	local obj = UnityEngine.Object.Instantiate(self.ItemTemplate)

	obj.transform.gameObject:SetActive(true)
	obj.transform:SetParent(self.ItemTemplate.transform.parent, false)

	obj.name = tostring(rowIndex) .. "-" .. tostring(colIndex)

	local block = JigsawGameBlockItem.New(obj, rowIndex, colIndex)

	function block.BlockClickEvent(blockItem)
		self:__OnBlockClickedEventHandler(blockItem)
	end

	table.insert(self.BlockItems, block)

	return block
end

function m:__OnBlockClickedEventHandler(block)
	if not self.CanOperation then
		return
	end

	if not self.IsGameStart then
		return
	end

	if self.GameData_1.select_block == nil then
		self.GameData_1.select_block = block

		self.GameData_1.select_block:SetSelect(true)

		return
	end

	if self.GameData_1.select_block == block then
		self.GameData_1.select_block:SetSelect(false)

		self.GameData_1.select_block = nil

		return
	end

	local tempRow = self.GameData_1.select_block.BlockRow
	local tempCol = self.GameData_1.select_block.BlockCol

	self.GameData_1.select_block:UpdateUVData(block.BlockRow, block.BlockCol)
	block:UpdateUVData(tempRow, tempCol)
	self.GameData_1.select_block:SetSelect(false)

	self.GameData_1.select_block = nil

	self:__CheckComplete()
end

m.GameData_1 = {}

function m:__GenerateGameLevel(texture, ratioW, ratioH)
	local blockList = self.__RandomNumberList(self.Row * self.Col)
	local blockIndex = 1
	local unit_row = 1 / self.Row * ratioW
	local unit_col = 1 / self.Col * ratioH

	for col = 1, self.Col do
		for row = 1, self.Row do
			local block = self:__GetFreeBlock(row - 1, col - 1)
			local blockValue = blockList[blockIndex] - 1
			local block_col = math.modf(blockValue / self.Row)
			local block_row = math.fmod(blockValue, self.Row)

			block:SetData(texture, block_row, unit_row, block_col, unit_col)

			blockIndex = blockIndex + 1
		end
	end
end

function m.__RandomNumberList(count)
	local list = {}
	local map = {}

	for i = 1, count do
		local r_num = math.random(i, count)
		local value = map[r_num] and map[r_num] or r_num

		table.insert(list, value)

		map[r_num] = map[i] or i
	end

	return list
end

function m:__CheckComplete()
	for _, block in pairs(self.BlockItems) do
		if not block:IsPositionCorrect() then
			return
		end
	end

	self.GameSuccessEvent()
end

return m
