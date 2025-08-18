-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\CreateRoleResultDlg.lua

local strClassName = "CreateRoleResultDlg"
local CreateRoleResultDlg = Class(strClassName, UIControls.Window)

function CreateRoleResultDlg:ctor(...)
	self:initUI()
end

function CreateRoleResultDlg:initUI(...)
	coroutine.start(self._yieldCloseDlg, self)
end

function CreateRoleResultDlg:_yieldCloseDlg(...)
	coroutine.step()
	self:setVisible(false)
end

return CreateRoleResultDlg
