-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\PrivilegePanel.lua

local strClassName = "PrivilegePanel"
local PrivilegePanel = Class(strClassName, UIControls.Panel)

function PrivilegePanel:ctor()
	self:initUI()
end

function PrivilegePanel:initUI()
	self.imgPrivilegeList = {}

	for idx = 1, 7 do
		local imgPrivilege = UIControls.Image(self, self.mPath .. "/Content/Icon" .. idx)

		self.imgPrivilegeList[idx] = imgPrivilege
	end

	self.btnSelf = UIControls.Button(self, self.mPath)

	self.btnSelf:addEventClick(self.onBtnSelfClick)
end

function PrivilegePanel:onRefresh()
	local privilegeInfoList = CurAvatar:getAllPrivilegeInfoList()

	if #privilegeInfoList > 0 then
		self:setVisible(true)

		for idx, imgPrivilege in ipairs(self.imgPrivilegeList) do
			if privilegeInfoList[idx] then
				imgPrivilege:setVisible(true)
				imgPrivilege:setImage(privilegeInfoList[idx].resData.icon_path, privilegeInfoList[idx].resData.icon)
			else
				imgPrivilege:setVisible(false)
			end
		end
	else
		self:setVisible(false)
	end
end

function PrivilegePanel:onBtnSelfClick()
	local activityPrivilegePreviewDlg = UIManager.getUI("activityPrivilegePreviewDlg", true)
end

return PrivilegePanel
