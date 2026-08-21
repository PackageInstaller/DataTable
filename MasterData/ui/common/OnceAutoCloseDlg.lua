-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\OnceAutoCloseDlg.lua

local strClassName = "OnceAutoCloseDlg"
local OnceAutoCloseDlg = Class(strClassName, UIControls.Window)

function OnceAutoCloseDlg:ctor()
	return
end

function OnceAutoCloseDlg:onOpenOver()
	OnceAutoCloseDlg.super.onOpenOver(self)
	self:setVisible(false)
end

return OnceAutoCloseDlg
