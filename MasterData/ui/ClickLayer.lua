-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\ClickLayer.lua

local strClassName = "ClickLayer"
local ClickLayer = Class(strClassName, UIControls.Window)

function ClickLayer:ctor()
	self.panelEfx = UIControls.Panel(self, "GameObject")
end

function ClickLayer:enableClickEfx(v)
	self.panelEfx:setVisible(v)
end

return ClickLayer
