-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Privilege\\ProgressPrivilegeCell.lua

local CommonPrivilegeCell = require("UI/OpActivity/Privilege/CommonPrivilegeCell")
local strClassName = "ProgressPrivilegeCell"
local ProgressPrivilegeCell = Class(strClassName, CommonPrivilegeCell)

function ProgressPrivilegeCell:ctor()
	self:_initUI()
end

function ProgressPrivilegeCell:_initUI()
	self.sliderProgress = UIControls.Slider(self, "Slider")
	self.txtProgress = UIControls.Label(self, "TextNum")
end

function ProgressPrivilegeCell:setPrivilegeInfo(privilegeInfo)
	ProgressPrivilegeCell.super.setPrivilegeInfo(self, privilegeInfo)

	if self.privilegeInfo.resData.privilege_type == Const.ACT_PRIVILEGE_TYPE_BY_ACHIEVE then
		local achieveActObj = CurAvatar:getActivityObj(self.privilegeInfo.resData.privilege_arg)

		if achieveActObj and achieveActObj.actData then
			local nData, hasProgress, levelRate, preRoundProgress = achieveActObj.actData:getNextAchieveInfo()

			if nData then
				if nData.type == Const.ACT_ACHIEVE_TYPE_RECHARGE then
					local needProgress = nData.param

					self.txtProgress:setText(hasProgress / 100 .. "/" .. needProgress / 100)
				else
					local needProgress = nData.param

					self.txtProgress:setText(hasProgress .. "/" .. needProgress)
				end

				self.sliderProgress:setValue(levelRate)
			end
		end
	end
end

return ProgressPrivilegeCell
