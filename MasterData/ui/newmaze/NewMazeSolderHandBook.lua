-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeSolderHandBook.lua

local NewMazeGridComp = require("UI/NewMaze/NewMazeGridComp")
local ResNewMazeFettersType = require("ClientData/ResNewMazeFettersType")
local NewMazeLosderTipsInfoPanel = require("UI/NewMaze/NewMazeLosderTipsInfoPanel")
local NewMazeHandBookLoderTipsChild = Class("NewMazeHandBookLoderTipsChild", NewMazeLosderTipsInfoPanel)

function NewMazeHandBookLoderTipsChild:initUI(...)
	NewMazeHandBookLoderTipsChild.super.initUI(self)

	self.btnClickThrough = UIControls.Button(self, "HeroOrHaloTipsPanel/BgPanel1/UIClickThrough")

	self.btnClickThrough:addEventClick(self.onClickThrough)
end

function NewMazeHandBookLoderTipsChild:onClickThrough()
	self.bgPanel1:setVisible(false)
end

local strClassName = "NewMazeSolderHandBook"
local NewMazeSolderHandBook = Class(strClassName, UIControls.Window)

function NewMazeSolderHandBook:ctor()
	self:initUI()
end

function NewMazeSolderHandBook:initUI()
	self.losderDetailTipsInfoPanel = NewMazeHandBookLoderTipsChild(self, "MainInfoPanel/LosderPanel/Content", "System/Rogue/HandbookLosderTipsInfoPanel")

	self.losderDetailTipsInfoPanel:setVisible(true)

	self.solderGrids = {}
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
end

function NewMazeSolderHandBook:setData(actObj)
	self.actObj = actObj
	self.newMazeData = self.actObj.actData
	self.allFetters = self.newMazeData:getHandBookAllFetters()

	for index = #self.solderGrids, #self.allFetters - 1 do
		local newGrid = NewMazeGridComp.SolderGrid(self, "MainInfoPanel/EnchantPanel/GridPanel/Content", "System/Rogue/GridResolve")

		newGrid.onGridClick = Slot(self.onSolderGridClick, self)

		table.insert(self.solderGrids, newGrid)
	end

	for index, grid in ipairs(self.solderGrids) do
		local fetters = self.allFetters[index]

		if fetters then
			grid:setVisible(true)
			grid:setData(fetters.type)

			grid.fetterIndex = index
		else
			grid:setVisible(false)
		end
	end

	self:onSolderGridClick(self.solderGrids[1])
end

function NewMazeSolderHandBook:onSolderGridClick(sender)
	local fettersData = self.allFetters[sender.fetterIndex]
	local fettersTableData = ResNewMazeFettersType[fettersData.type][1]

	self.losderDetailTipsInfoPanel:setData(fettersData, fettersTableData)
	self.losderDetailTipsInfoPanel.textLosderNum:setVisible(false)
	self.losderDetailTipsInfoPanel.textLosderNumMax:setVisible(false)

	for index, grid in ipairs(self.solderGrids) do
		grid:setSelected(grid == sender)
	end
end

function NewMazeSolderHandBook:onBtnCloseClick()
	self:setVisible(false)
end

return NewMazeSolderHandBook
