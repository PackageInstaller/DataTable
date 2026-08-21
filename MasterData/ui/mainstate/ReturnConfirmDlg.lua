-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\ReturnConfirmDlg.lua

local ResRefluxGroupAction = require("ClientData/ResRefluxGroupAction")
local PrivilegeCell = Class("PrivilegeCell", UIControls.Child)

function PrivilegeCell:ctor()
	self.imgPrivilege = UIControls.Image(self, "ImgPrivilege")
	self.textPrivilege = UIControls.Label(self, "TxtPrivilegeDes")
end

function PrivilegeCell:setData(rdata)
	if rdata.icon_path then
		self.imgPrivilege:setImage("Atlas/" .. rdata.icon_path, rdata.icon)
	end

	self.textPrivilege:setText(rdata.desc or "")
end

local strClassName = "ReturnConfirmDlg"
local ReturnConfirmDlg = Class(strClassName, UIControls.Window)

function ReturnConfirmDlg:ctor()
	self.btnClose = UIControls.Button(self, "BtnDeny")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnConfirm = UIControls.Button(self, "BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.cells = {}
end

function ReturnConfirmDlg:onOpen()
	ReturnConfirmDlg.super.onOpen(self)

	local groupId = CurAvatar.unchooseRebackGroup
	local actionData = ResRefluxGroupAction[groupId] or {}

	for index = 1, #actionData do
		local newCell = PrivilegeCell(self, "Bg/ContentPanel", "System/Return/PrivilegeCell")

		newCell:setVisible(true)
		newCell:setData(actionData[index])
		table.insert(self.cells, newCell)
	end
end

function ReturnConfirmDlg:onCloseClick()
	self:setVisible(false)
end

function ReturnConfirmDlg:onBtnConfirmClick()
	RPC.refluxNewSetFlag()
	self:setVisible(false)
end

return ReturnConfirmDlg
