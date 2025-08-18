-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataTurnTable.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityTurnTableDetail = require("ClientData/ResOpActivityTurnTableDetail")
local ResOpActivityClientTemplate = require("ClientData/ResOpActivityClientTemplate")
local ResTurnTableMisc = require("ClientData/ResTurnTableMisc")
local ActivityDataTurnTable = Class("ActivityDataTurnTable", ActivityDataBase)

function ActivityDataTurnTable:ctor()
	return
end

function ActivityDataTurnTable:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityTurnTableDetail[actId] or {}

	local miscIndex = self.actObject.templateData.param[1]

	if miscIndex then
		self.miscData = ResTurnTableMisc[miscIndex]
	end
end

function ActivityDataTurnTable:updateRoleData(roleData, fromDataUpdate)
	self.turnTableData = roleData.turn_table.data
	self.totalDrawCount = self.turnTableData.count or 0
	self.rareRoundCount = self.turnTableData.rare_round_count or 0
end

function ActivityDataTurnTable:updateMgrData(opActivityMgrItem)
	self.freezeTime = opActivityMgrItem.time.freezetime
end

function ActivityDataTurnTable:checkNew()
	if self.miscData then
		local drawItemId = self.miscData.turn_item_id
		local drawItemNum = CurAvatar:getItemNumById(drawItemId)

		return drawItemNum >= self.miscData.turn_item_num
	end

	return false
end

return ActivityDataTurnTable
