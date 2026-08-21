-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeSolderAwardDlg.lua

local NewMazeGridComp = require("UI/NewMaze/NewMazeGridComp")
local ResNewMazeEnchanter = require("ClientData/ResNewMazeEnchanter")
local strClassName = "NewMazeSolderAwardDlg"
local NewMazeSolderAwardDlg = Class(strClassName, UIControls.Window)

function NewMazeSolderAwardDlg:ctor()
	self:initUI()
end

function NewMazeSolderAwardDlg:initUI()
	self.solderGrids = {}
end

function NewMazeSolderAwardDlg:onShow(itemIds)
	for index = #self.solderGrids, #itemIds - 1 do
		local newGrid = NewMazeGridComp.SolderItemGrid(self, "Bg/AwardList/Content", "System/Rogue/GridEnchant")

		table.insert(self.solderGrids, newGrid)
	end

	for index, grid in ipairs(self.solderGrids) do
		if itemIds[index] then
			local itemId = itemIds[index]

			itemId = itemId.id

			local itemData = ResNewMazeEnchanter[itemId]
			local solderId = itemData.effect_id

			grid:setData(solderId, 1, itemId)
			grid:setVisible(true)
		else
			grid:setVisible(false)
		end
	end
end

return NewMazeSolderAwardDlg
