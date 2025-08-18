-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonPlay\\SeasonPlayProbabilityDlg.lua

local SeasonPlayProbabilityTitleCell = Class("SeasonPlayProbabilityTitleCell", UIControls.Child)

function SeasonPlayProbabilityTitleCell:ctor(...)
	self:initUI()
end

function SeasonPlayProbabilityTitleCell:initUI(...)
	self.txtName = UIControls.Label(self, "TextName")
	self.txtNum = UIControls.Label(self, "TextNum")
end

function SeasonPlayProbabilityTitleCell:setData(data)
	self.txtNum:setText(data.probability)
	self.txtName:setText(data.name)
end

local SeasonPlayProbabilityDlg = Class("SeasonPlayProbabilityDlg", UIControls.Window)

function SeasonPlayProbabilityDlg:ctor(...)
	self:initUI()
end

function SeasonPlayProbabilityDlg:initUI(...)
	self.cells = {}
end

function SeasonPlayProbabilityDlg:setData(actObject)
	self.actObject = actObject
	self.actData = self.actObject.actData

	local resProbilityData = self.actData:getResDrawProbilityData()

	if resProbilityData then
		for index, data in ipairs(resProbilityData) do
			if not self.cells[index] then
				local cellPath = "System/SeasonPlayCommon/CellProbabilityNum"

				self.cells[index] = SeasonPlayProbabilityTitleCell(self, "BgPanel/ProbabilityListPanel/Content", cellPath)
			end

			self.cells[index]:setVisible(true)
			self.cells[index]:setData(data)
		end
	end
end

function SeasonPlayProbabilityDlg:onBtnCloseClick()
	self:setVisible(false)
end

return SeasonPlayProbabilityDlg
