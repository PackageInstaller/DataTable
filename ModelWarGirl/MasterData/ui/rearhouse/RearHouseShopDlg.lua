-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseShopDlg.lua

local MallDlgBase = require("UI/MainState/Trade/MallDlgBase")
local strClassName = "RearHouseShopDlg"
local RearHouseShopDlg = Class(strClassName, MallDlgBase)

function RearHouseShopDlg:ctor()
	return
end

function RearHouseShopDlg:initConfig()
	self.startTabId = 10
	self.tabTypeConfig = {
		[3] = true
	}
end

function RearHouseShopDlg:refreshUI(...)
	if self.curSubPanel then
		self.curSubPanel:refreshCells()
	end
end

return RearHouseShopDlg
