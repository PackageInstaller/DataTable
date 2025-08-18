-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataConsumeReplace.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityConsumeReplaceDetail = require("ClientData/ResOpActivityConsumeReplaceDetail")
local ResTurnTableMisc = require("ClientData/ResTurnTableMisc")
local ActivityDataConsumeReplace = Class("ActivityDataConsumeReplace", ActivityDataBase)

function ActivityDataConsumeReplace:ctor()
	self.serverData = {}
	self.clientData = {}
end

function ActivityDataConsumeReplace:updateClientData(actId)
	self.actId = actId
	self.detailData = ResOpActivityConsumeReplaceDetail[self.actId]
end

function ActivityDataConsumeReplace:updateMgrData(opActivityMgrItem)
	self.mgrData = opActivityMgrItem
end

function ActivityDataConsumeReplace:updateRoleData(roleData)
	self.oneDrawTimes = roleData.consume_replace.free_onedraw_counter.count
	self.oneDrawRefreshTime = roleData.consume_replace.free_onedraw_counter.next_reset_time
	self.tenDrawTimes = roleData.consume_replace.consume_tendraw_counter.count
	self.tenDrawRefreshTime = roleData.consume_replace.consume_tendraw_counter.next_reset_time
end

function ActivityDataConsumeReplace:checkNew()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_TURNTABLE) then
		return false
	end

	if self:getFreeTime() > 0 then
		RedDotManager.setKeyState(UIConst.RD_HINT_TURNTABLE, true)

		return true
	else
		RedDotManager.setKeyState(UIConst.RD_HINT_TURNTABLE, false)
	end

	return false
end

function ActivityDataConsumeReplace:onNewDay()
	self.actObject:checkNew()
	self.actObject:refreshUI()
end

function ActivityDataConsumeReplace:getFreeTime()
	if self.oneDrawRefreshTime and ClientUtils.getServerTime() < self.oneDrawRefreshTime then
		return self.detailData.free_onedraw_maxtimes - self.oneDrawTimes
	end

	return self.detailData.free_onedraw_maxtimes
end

function ActivityDataConsumeReplace:getConsumeTenTime()
	if self.tenDrawRefreshTime and ClientUtils.getServerTime() < self.tenDrawRefreshTime then
		return self.detailData.consume_tendraw_maxtimes - self.tenDrawTimes
	end

	return self.detailData.consume_tendraw_maxtimes
end

return ActivityDataConsumeReplace
