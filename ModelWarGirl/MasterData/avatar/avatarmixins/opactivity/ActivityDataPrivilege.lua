-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataPrivilege.lua

local ResOpActivityPrivilegeDetail = require("ClientData/ResOpActivityPrivilegeDetail")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ActivityDataPrivilege = Class("ActivityDataPrivilege", ActivityDataBase)

function ActivityDataPrivilege:ctor()
	return
end

function ActivityDataPrivilege:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityPrivilegeDetail[actId]
end

function ActivityDataPrivilege:getActPrivilegeValue(priType, isAbs)
	if self.clientData then
		for index, info in ipairs(self.clientData) do
			if info.privilege_type == priType then
				if isAbs then
					return info.abs_add
				else
					return info.percent_add
				end
			end
		end
	end
end

function ActivityDataPrivilege:isActPrivilegeValid(priType)
	if self.clientData then
		for index, info in ipairs(self.clientData) do
			if info.privilege_type == priType then
				return true
			end
		end
	end

	return false
end

return ActivityDataPrivilege
