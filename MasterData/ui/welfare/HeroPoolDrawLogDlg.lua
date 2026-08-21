-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\HeroPoolDrawLogDlg.lua

local DrawRecordPanel = require("UI/DrawCard/DrawRecordPanel")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local strClassName = "HeroPoolDrawLogDlg"
local HeroPoolDrawLogDlg = Class(strClassName, UIControls.Window)

function HeroPoolDrawLogDlg:ctor()
	self:initUI()
end

function HeroPoolDrawLogDlg:initUI()
	self.recordPanel = DrawRecordPanel(self, "DrawLogPanel")
end

function HeroPoolDrawLogDlg:setData(poolId, opId)
	self.poolId = poolId

	local record

	if self.poolId then
		DrawCardUtils.syncDrawRecord(self.poolId)

		record = DrawCardUtils.getDrawRecord(self.poolId)
	else
		DrawCardUtils.syncDrawRecord(nil, opId)

		record = DrawCardUtils.getDrawRecord(nil, opId)
	end

	self.recordPanel:setVisible(true)
	self.recordPanel:setRecordData(record)
end

return HeroPoolDrawLogDlg
