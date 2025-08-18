-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\ShowAwardPrivilegeDlg.lua

local ResPrivilege = require("ClientData/ResPrivilege")
local strClassName = "ShowAwardPrivilegeDlg"
local ShowAwardPrivilegeDlg = Class(strClassName, UIControls.Window)

function ShowAwardPrivilegeDlg:ctor()
	self:initUI()
end

function ShowAwardPrivilegeDlg:initUI()
	self.imgIconPrivilege = UIControls.Image(self, "Bg/PrivilegePanel/IconPrivilege")
	self.txtDes = UIControls.Label(self, "Bg/TxtDes")
	self.txtTime = UIControls.Label(self, "Bg/TimePanel/TxtTime")
end

function ShowAwardPrivilegeDlg:setPrivilegeInfo(privilegeId, endTime)
	local priData = ResPrivilege[privilegeId]

	if priData then
		self.imgIconPrivilege:setImage("Atlas/" .. priData.big_icon_path, priData.big_icon)
		self.txtDes:setText(priData.desc)
	end

	local remainTime = endTime - ClientUtils.getServerTime()

	self.txtTime:setText(utils.calcTimeTxt(remainTime))
end

return ShowAwardPrivilegeDlg
