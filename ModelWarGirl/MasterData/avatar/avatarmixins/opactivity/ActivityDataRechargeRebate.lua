-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataRechargeRebate.lua

local ResOpActivityDetail = require("ClientData/ResOpActivityDetail")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ActivityDataRechargeRebate = Class("ActivityDataRechargeRebate", ActivityDataBase)

function ActivityDataRechargeRebate:ctor()
	self.serverData = {}
end

function ActivityDataRechargeRebate:updateClientData(actId)
	self.clientData = ResOpActivityDetail[actId] or {}
end

function ActivityDataRechargeRebate:updateRoleData(roleData)
	self.serverData = roleData.rebate
end

function ActivityDataRechargeRebate:isCanGet()
	local isCanget = true

	if self.serverData.get_flag == 0 and self.serverData.gem > 0 then
		return isCanget
	else
		return false
	end
end

function ActivityDataRechargeRebate:isOver()
	local isOver = true

	if self.serverData.get_flag ~= 0 and self.serverData.gem > 0 then
		return isOver
	else
		return false
	end
end

return ActivityDataRechargeRebate
