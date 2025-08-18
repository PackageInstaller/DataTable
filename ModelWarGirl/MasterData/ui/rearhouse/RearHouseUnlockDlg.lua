-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseUnlockDlg.lua

local strClassName = "RearHouseUnlockDlg"
local RearHouseUnlockDlg = Class(strClassName, UIControls.Window)

function RearHouseUnlockDlg:ctor(...)
	self:initUI()
end

function RearHouseUnlockDlg:initUI(...)
	self.panels = {}

	for i = 1, 2 do
		local panel = UIControls.Panel(self, "BgPanel/UnlockPanel" .. i)

		panel.txtContent = UIControls.Label(self, "BgPanel/UnlockPanel" .. i .. "/Text")

		table.insert(self.panels, panel)
	end
end

function RearHouseUnlockDlg:onOpen(...)
	RearHouseUnlockDlg.super.onOpen(self)

	local timer = Timer(Slot(self._close, self), 1.8, 1)

	timer:Start()
end

function RearHouseUnlockDlg:_close(...)
	self:setVisible(false)

	local ui = UIManager.getUI("rearHouseLvUpDlg", nil, false)

	if ui then
		ui:setVisible(false)
	end
end

function RearHouseUnlockDlg:setData(data)
	for i = 1, math.min(#data, #self.panels) do
		self.panels[i]:setVisible(true)
		self.panels[i].txtContent:setText(data[i])
	end
end

return RearHouseUnlockDlg
