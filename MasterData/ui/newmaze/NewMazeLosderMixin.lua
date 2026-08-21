-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeLosderMixin.lua

local NewMazeLosderTipsInfoPanel = require("UI/NewMaze/NewMazeLosderTipsInfoPanel")
local NewMazeLosderGrid = require("UI/NewMaze/NewMazeLosderGrid")
local NewMazeLosderMixin = {}

function NewMazeLosderMixin:ctorMixin(...)
	self:initCommonUI()
end

function NewMazeLosderMixin:initCommonUI(...)
	self.losderTipsPanel = UIControls.Panel(self, "MainInfoPanel/LosderPanel/LosderTipsPanel")
	self.losderTipsInfoPanel = NewMazeLosderTipsInfoPanel(self, "MainInfoPanel/LosderPanel/LosderTipsPanel", "System/Rogue/LosderTipsInfoPanel")
	self.fettersCellList = {}
	self.uIClickThrough = UIControls.Button(self, "MainInfoPanel/LosderPanel/LosderTipsPanel/UIClickThrough")

	self.uIClickThrough:addEventClick(self.onUIClickThroughClick)
end

function NewMazeLosderMixin:refreshFettersUI(allFetters)
	self.allFetters = allFetters or self.newMazeData:getAllFetters()

	for i, fetters in pairs(self.allFetters) do
		local fettersCell = self.fettersCellList[i]

		if fettersCell == nil then
			fettersCell = NewMazeLosderGrid(self, "MainInfoPanel/LosderPanel/LosderList/Content", "System/Common/Grid/GridLosder", 0, 0, true)
		end

		fettersCell:setData(fetters)
		fettersCell:setGridClick(Slot(self.gridLosderClick, self))

		self.fettersCellList[i] = fettersCell
	end

	if #self.fettersCellList > #self.allFetters then
		for i = #self.allFetters + 1, #self.fettersCellList do
			self.fettersCellList[i]:destroy()

			self.fettersCellList[i] = nil
		end
	end
end

function NewMazeLosderMixin:checkPlayLosderEfx(lastAllFetters)
	local needPlayEfxFetters = {}

	for _, fetter in ipairs(lastAllFetters) do
		for _, nowFetter in ipairs(self.allFetters or {}) do
			if fetter.type == nowFetter.type then
				if fetter.formationNum + #fetter.halo < nowFetter.formationNum + #nowFetter.halo then
					table.insert(needPlayEfxFetters, fetter.type)
				end

				break
			end
		end
	end

	for i, cell in ipairs(self.fettersCellList) do
		if utils.tableIsContainsElement(needPlayEfxFetters, cell.fettersType) then
			cell:playEfx()
		end
	end
end

function NewMazeLosderMixin:gridLosderClick(grid)
	self.losderTipsInfoPanel:setData(grid.fettersData, grid.fettersTableData)
	self.losderTipsInfoPanel:setVisible(true)
	self.losderTipsPanel:setVisible(true)

	for i, cell in pairs(self.fettersCellList) do
		cell.imgSel:setVisible(grid.fettersType == cell.fettersType)
	end
end

function NewMazeLosderMixin:onUIClickThroughClick()
	self.losderTipsInfoPanel:setVisible(false)
	self.losderTipsPanel:setVisible(false)

	for i, cell in pairs(self.fettersCellList) do
		cell.imgSel:setVisible(false)
	end
end

return NewMazeLosderMixin
