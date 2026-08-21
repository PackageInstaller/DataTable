-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\ProbabilityTips.lua

local ResClientProbShow = require("ClientData/ResClientProbShow")
local ProbabilityTipsCell = Class("ProbabilityTipsCell", UIControls.Child)

function ProbabilityTipsCell:ctor()
	self.textTitle = UIControls.Label(self, "TextName")
	self.textProb = UIControls.Label(self, "TextNum")
end

function ProbabilityTipsCell:setData(probData, totalRate)
	self.textTitle:setText(probData.desc or "")
	self.textProb:setText(string.format("%.2f%%", 100 * probData.rate / totalRate))
end

local strClassName = "ProbabilityTips"
local ProbabilityTips = Class(strClassName, UIControls.Tips)

function ProbabilityTips:ctor()
	self:initUI()
end

function ProbabilityTips:initUI()
	self.probCells = {}
end

function ProbabilityTips:_setObj(grid)
	self.srcGrid = grid
	self.item = grid.object

	if not self.item or not self.item.resData then
		return
	end

	local probId = self.item.resData.prob_id
	local probData = ResClientProbShow[probId]

	if not probData then
		return
	end

	for index = #self.probCells, #probData - 1 do
		local newCell = ProbabilityTipsCell(self, "ProbabilityPanel/BgPanel/ProbabilityListPanel/Content", "System/Common/CellItemProbabilityNum")

		table.insert(self.probCells, newCell)
	end

	local totalRate = 0

	for _, d in ipairs(probData) do
		totalRate = totalRate + d.rate
	end

	for index, cell in ipairs(self.probCells) do
		if probData[index] then
			cell:setVisible(true)
			cell:setData(probData[index], totalRate)
		else
			cell:setVisible(false)
		end
	end
end

return ProbabilityTips
