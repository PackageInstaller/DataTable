-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Privilege\\CommonPrivilegeCell.lua

local strClassName = "CommonPrivilegeCell"
local CommonPrivilegeCell = Class(strClassName, UIControls.Child)

function CommonPrivilegeCell:ctor()
	self:initUI()
end

function CommonPrivilegeCell:initUI()
	self.imgPrivilege = UIControls.Image(self, "ImgPrivilege")
	self.txtName = UIControls.Label(self, "TxtName")
	self.txtDes = UIControls.Label(self, "TxtDes")
	self.txtTime = UIControls.Label(self, "TxtTime")
end

function CommonPrivilegeCell:setPrivilegeInfo(privilegeInfo)
	self.privilegeInfo = privilegeInfo

	self.imgPrivilege:setImage(self.privilegeInfo.resData.icon_path, self.privilegeInfo.resData.icon)
	self.txtName:setText(self.privilegeInfo.resData.title)
	self.txtDes:setText(self.privilegeInfo.resData.desc)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	if self.privilegeInfo.endTime then
		local leftTime = self.privilegeInfo.endTime - ClientUtils.getServerTime()

		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48654), nil, nil)
	elseif self.privilegeInfo.activityObj then
		local leftTime = self.privilegeInfo.activityObj:getRemainOpenTime()

		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48654), nil, nil)
	end
end

return CommonPrivilegeCell
