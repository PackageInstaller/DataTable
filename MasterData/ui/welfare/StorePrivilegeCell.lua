-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\StorePrivilegeCell.lua

local ResPrivilege = require("ClientData/ResPrivilege")
local strClassName = "StorePrivilegeCell"
local StorePrivilegeCell = Class(strClassName, UIControls.Child)

function StorePrivilegeCell:ctor(...)
	self:initUI()
end

function StorePrivilegeCell:initUI(...)
	self.imgIcon = UIControls.Image(self, "Icon")
	self.txtTitle = UIControls.Label(self, "TextTitle")
	self.txtDesc = UIControls.Label(self, "TextDesc")
end

function StorePrivilegeCell:setObj(object)
	self.object = object

	if object == nil then
		self:clear()

		return
	end

	self:_setObj(object)
end

function StorePrivilegeCell:_setObj(object)
	if object.resData and object.resData.extend_args1 and ResPrivilege[object.resData.extend_args1] then
		local resData = ResPrivilege[object.resData.extend_args1]

		if resData.name then
			self.txtTitle:setText(resData.name)
		end

		if resData.desc then
			self.txtDesc:setText(resData.desc)
		end

		if resData.icon and resData.icon_path then
			self.imgIcon:setVisible(true)
			self.imgIcon:setImage("Atlas/StoreAtlas/" .. resData.icon_path, resData.icon)
		end
	end
end

function StorePrivilegeCell:clear(...)
	self.object = nil

	self.imgIcon:setVisible(false)
end

return StorePrivilegeCell
