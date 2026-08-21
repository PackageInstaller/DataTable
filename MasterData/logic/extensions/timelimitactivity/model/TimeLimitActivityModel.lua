-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitactivity/model/TimeLimitActivityModel.lua

module("logic.extensions.timelimitactivity.model.TimeLimitActivityModel", package.seeall)

local M = class("TimeLimitActivityModel", BaseModel)

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._releaseBattleList = {}
end

local TIME_LIMIT_ACTIVITY_IDS = {
	BattleExtension_pb.GameType.FOOTBALLPVP
}
local TIME_LIMIT_ACTIVITY_IDS_TO_ACTIVITY_IDS = {
	[BattleExtension_pb.GameType.FOOTBALLPVP] = ActivityEnum.LogicType.FOOTBALL
}

function M:getAllOpenActIds()
	local openActivityList = {}

	for i, id in ipairs(TIME_LIMIT_ACTIVITY_IDS) do
		local activityCO = TimeLimitActivityConfig.instance:getCfgTimeLimitActivity(id)
		local isOpen = true

		if isOpen then
			table.insert(openActivityList, id)
		end
	end

	return openActivityList
end

function M:getActivityTypeByTimelimitActivityId(id)
	return TIME_LIMIT_ACTIVITY_IDS_TO_ACTIVITY_IDS[id]
end

function M:addReleaseBattleInfo(info)
	if self._releaseBattleList[info.type] then
		printError("该类型战斗还存在缓存？ 类型:", type)
	end

	self._releaseBattleList[info.type] = info
end

function M:getActivityMO(timelimitId)
	local activityType = TimeLimitActivityModel.instance:getActivityTypeByTimelimitActivityId(timelimitId)

	return ActivityModel.instance:getActivityByType(activityType)
end

function M:startBattle(type)
	if self._releaseBattleList[type] then
		if type == BattleExtension_pb.GameType.FOOTBALLPVP then
			printWarn(self._releaseBattleList[type], "self._releaseBattleList[type]")
			BattleMgr.instance:enter(self._releaseBattleList[type], FootBallBattleFlow)
		end

		self._releaseBattleList[type] = nil
	else
		printError("不存在该类型战斗 类型:", type)
	end
end

M.instance = M.New()

return M
