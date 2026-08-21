-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Rank\\RearHouseRankCell.lua

local strClassName = "RearHouseRankCell"
local RearHouseRankCell = Class(strClassName, UIControls.BtnPlayerRankCellLoop)

function RearHouseRankCell:ctor()
	self:_initUI()
end

function RearHouseRankCell:_initUI()
	self.btnVisit = UIControls.Button(self, "BgPanel/BtnVisit")

	self.btnVisit:addEventClick(self.onBtnVisitClick)
end

function RearHouseRankCell:onBtnVisitClick(...)
	CurAvatar:checkHouseVisitReq(self.data.data.comm.uid)
end

return RearHouseRankCell
