-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeConfirmBox.lua

local NewMazeGridComp = require("UI/NewMaze/NewMazeGridComp")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local strClassName = "NewMazeConfirmBox"
local NewMazeConfirmBox = Class(strClassName, UIControls.Window)

function NewMazeConfirmBox:ctor()
	self:initUI()
end

function NewMazeConfirmBox:initUI()
	self.solderGrids = {}
	self.text = UIControls.Label(self, "Bg/Text")
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm", "Text")

	self.btnConfirm:addEventClick(self.onConfirmClick)

	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny", "Text")

	self.btnDeny:addEventClick(self.onDenyClick)
end

function NewMazeConfirmBox:onConfirmResolve(hero, actObj, confirmCB)
	self.actObj = actObj
	self.actData = actObj.actData
	self.hero = hero

	self.text:setText(ResNewMazeDisplay[13060073].desc)

	self.solderList = self.hero:getMazeSolderState()

	for index, data in ipairs(self.solderList) do
		local newGrid = NewMazeGridComp.SolderItemGrid(self, "Bg/SolderPanel", "System/Rogue/GridEnchant")

		newGrid:setData(data.id, 1)
		newGrid:setVisible(true)
		table.insert(self.solderGrids, newGrid)
	end

	self.confirmCB = confirmCB
end

function NewMazeConfirmBox:onConfirmChange(hero, selectSolderId, actObj, confirmCB)
	self.actObj = actObj
	self.actData = actObj.actData
	self.hero = hero
	self.confirmCB = confirmCB

	self.text:setText(ResNewMazeDisplay[13060074].desc)

	self.solderList = self.hero:getMazeSolderState()

	for index, data in ipairs(self.solderList) do
		local newGrid = NewMazeGridComp.SolderGrid(self, "Bg/SolderPanel", "System/Rogue/GridResolve")

		newGrid:setData(data.id, not data.isDefault)

		newGrid.onGridClick = Slot(self.onSolderGridClick, self)
		newGrid.index = index

		newGrid:setVisible(true)
		table.insert(self.solderGrids, newGrid)
	end

	self.selectChangeSolder = nil

	self:refreshSelectGrid()
	self.btnConfirm:setText(Lang.get(1189))
end

function NewMazeConfirmBox:refreshSelectGrid()
	for index, grid in ipairs(self.solderGrids) do
		grid:setSelected(grid.solderId == self.selectChangeSolder)
	end

	if self.selectChangeSolder then
		self.btnConfirm:setEnable(true)
	else
		self.btnConfirm:setEnable(false)
	end
end

function NewMazeConfirmBox:onSolderGridClick(sender)
	self.selectChangeSolder = sender.solderId
	self.selectChangeSolderIndex = sender.index

	self:refreshSelectGrid()
end

function NewMazeConfirmBox:onConfirmClick()
	self:setVisible(false)

	if self.confirmCB then
		self.confirmCB(self.selectChangeSolderIndex)
	end
end

function NewMazeConfirmBox:onDenyClick()
	self:setVisible(false)
end

return NewMazeConfirmBox
