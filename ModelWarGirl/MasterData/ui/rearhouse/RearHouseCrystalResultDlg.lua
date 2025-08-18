-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseCrystalResultDlg.lua

local strClassName = "RearHouseCrystalResultDlg"
local RearHouseCrystalResultDlg = Class(strClassName, UIControls.Window)

function RearHouseCrystalResultDlg:ctor(...)
	self:initUI()
end

function RearHouseCrystalResultDlg:onOpen(...)
	RearHouseCrystalResultDlg.super.onOpen(self)

	local timer = Timer(Slot(self._close, self), 1.8, 1)

	timer:Start()
end

function RearHouseCrystalResultDlg:_close(...)
	self:setVisible(false)
end

function RearHouseCrystalResultDlg:initUI(...)
	self.txtLv = UIControls.Label(self, "BgPanel/TextLv")
end

function RearHouseCrystalResultDlg:setData(lv)
	self.txtLv:setText(lv)
end

return RearHouseCrystalResultDlg
