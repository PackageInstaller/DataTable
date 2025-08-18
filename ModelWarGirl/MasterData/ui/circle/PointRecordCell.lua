-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\PointRecordCell.lua

local strClassName = "PointRecordCell"
local PointRecordCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function PointRecordCell:ctor()
	self:initUI()
end

function PointRecordCell:initUI()
	self.txtTime = UIControls.Label(self, "TextTime")
	self.txtAction = UIControls.Label(self, "TextAction")
	self.txtNum = UIControls.Label(self, "TextNum")
end

function PointRecordCell:setPointRecordData(pointRecordData)
	self.pointRecordData = pointRecordData

	local scoreLogStr = CurAvatar:getScoreLogStr(self.pointRecordData.optype, self.pointRecordData.param1, self.pointRecordData.param2, self.pointRecordData.param3, self.pointRecordData.name)

	self.txtAction:setText(scoreLogStr)
	self.txtNum:setText(utils.format(Lang.get(40577), self.pointRecordData.score))

	local timeStr = os.date("%Y-%m-%d %H:%M:%S", self.pointRecordData.tick)

	self.txtTime:setText(timeStr)
end

return PointRecordCell
