-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonTower\\ActivitySeasonTowerRuleDlg.lua

local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResOpActTowerBuff = require("ClientData/ResOpActTowerBuff")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local strClassName = "ActivitySeasonTowerRuleDlg"
local ActivitySeasonTowerRuleDlg = Class(strClassName, UIControls.Window)

function ActivitySeasonTowerRuleDlg:ctor()
	self.textRule = UIControls.Label(self, "TextEffect")
end

function ActivitySeasonTowerRuleDlg:onShow(desc, towerId, actData, cb)
	self.actData = actData
	self.cb = cb
	self.towerId = towerId

	self.textRule:setText(desc)
end

function ActivitySeasonTowerRuleDlg:onClose()
	self.actData:saveTowerRuleCached(self.towerId)

	if self.cb then
		self.cb()
	end

	ActivitySeasonTowerRuleDlg.super.onClose(self)
end

return ActivitySeasonTowerRuleDlg
