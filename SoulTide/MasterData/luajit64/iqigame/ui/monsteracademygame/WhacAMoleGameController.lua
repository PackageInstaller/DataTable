-- chunkname: @IQIGame\\UI\\MonsterAcademyGame\\WhacAMoleGameController.lua

local WhacAMoleGameCellItem = require("IQIGame.UI.MonsterAcademyGame.WhacAMoleGameCellItem")
local m = {
	TotalScore = 0,
	IsGaming = false,
	cellItems = {},
	moleCells = {}
}

function m.New(viewRoot)
	local obj = Clone(m)

	obj:__Init(viewRoot)

	return obj
end

function m:__Init(viewRoot)
	self.ViewRoot = viewRoot

	LuaCodeInterface.BindOutlet(self.ViewRoot, self)
	self:__PrepareCellItems()
end

function m:StartGame(gameConfig, successCallback)
	self.gameConfig = gameConfig
	self.successCallback = successCallback
	self.TotalScore = 0
	self.timer = Timer.New(function()
		self:__RandomCell(self.gameConfig.Grade[2])
	end, self.gameConfig.Grade[1], -1)

	self:__SetCellItemClickToggle(true)
	self.timer:Start()

	self.IsGaming = true
end

function m:StopGame()
	self:__SetCellItemClickToggle(false)

	self.IsGaming = false

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	for i = 1, #self.cellItems do
		self.cellItems[i]:ShowNormal()
	end
end

function m:__PrepareCellItems()
	self.cellItems = {}

	local cnt = self.goCellArea.transform.childCount

	for i = 0, cnt - 1 do
		local cellRoot = self.goCellArea.transform:GetChild(i).gameObject
		local cellItem = WhacAMoleGameCellItem.New(cellRoot)

		cellItem.CanClick = false

		function cellItem.MoleClickResult(result)
			self:__OnCellItemClickResult(result)
		end

		table.insert(self.cellItems, cellItem)
	end
end

function m:__SetCellItemClickToggle(canClick)
	for index, cellItem in pairs(self.cellItems) do
		cellItem.CanClick = canClick
	end
end

function m:__OnCellItemClickResult(success)
	if not self.IsGaming then
		return
	end

	if success then
		GameEntry.Sound:PlaySound(10266, Constant.SoundGroup.UI)

		self.TotalScore = self.TotalScore + 1
	end

	if self.TotalScore >= self.gameConfig.SucScore then
		self.successCallback()
	end
end

function m:__ClearCellItems()
	for i = 1, #self.cellItems do
		self.cellItems[i]:OnDestroy()
	end

	self.cellItems = nil
end

function m:__RandomCell(count)
	local cellIndexList = self:__RandomCellList(#self.cellItems, count)

	for i = 1, #cellIndexList do
		local cell = self.cellItems[cellIndexList[i]]

		if not cell.isMole then
			cell:ShowMole(1)
		end
	end
end

function m:__RandomCellList(max, count)
	local list = {}
	local map = {}

	for i = 1, count do
		local r_num = math.random(i, max)
		local value = map[r_num] and map[r_num] or r_num

		table.insert(list, value)

		map[r_num] = map[i] or i
	end

	return list
end

function m:OnDestroy()
	self:__ClearCellItems()
	LuaCodeInterface.ClearOutlet(self.ViewRoot, self)

	self.ViewRoot = nil
end

return m
