-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMallDlg.lua

local MallDlgBase = require("UI/MainState/Trade/MallDlgBase")
local strClassName = "ActivityMallDlg"
local ActivityMallDlg = Class(strClassName, MallDlgBase)

function ActivityMallDlg:ctor()
	return
end

function ActivityMallDlg:initConfig()
	self.startTabId = 50
	self.tabTypeConfig = {
		[5] = true
	}
end

return ActivityMallDlg
