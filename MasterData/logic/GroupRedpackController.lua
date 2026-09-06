-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/controller/GroupRedpackController.lua

module("logic.extensions.groupredpack.controller.GroupRedpackController", package.seeall)

local GroupRedpackController = class("GroupRedpackController", BaseController)
local RedpackHudPath = "ui/views/groupredpack/groupredpackhudview.prefab"

function GroupRedpackController:ctor()
	return
end

function GroupRedpackController:onInit()
	return
end

function GroupRedpackController:onReset()
	self._groupRedpackRpCache = nil
end

function GroupRedpackController:sendGroupRedPackGetInfoReq(actId)
	GroupRedPackAgent.instance:sendPM_GroupRedPackGetInfoReq(actId)
end

function GroupRedpackController:handleGroupRedPackGetInfoRes(status, msg)
	if status == 0 then
		GroupRedpackModel.instance:handleGroupRedPackGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GroupRedPackGetInfoRes)
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_GROUPREDPACK_CAN_GRAB, self:_checkRedPoint())
	end
end

function GroupRedpackController:sendGroupRedPackGrapReq(actId, redPackId, type)
	GroupRedPackAgent.instance:sendPM_GroupRedPackGrapReq(actId, redPackId, type)
end

function GroupRedpackController:handleGroupRedPackGrapRes(status, msg)
	if status == 0 then
		local changeSetId = checknumber(msg.changeSetId)
		local matMos = MaterialModel.instance:getMaterialMos(changeSetId)
		local prizeStrList = {}

		for _, mo in ipairs(matMos) do
			local prizeStr = mo:toString()

			table.insert(prizeStrList, prizeStr)
		end

		MaterialController.instance:saveChangeSetToTemp(changeSetId)
		GlobalDispatcher:dispatch(GlobalNotify.GroupRedPackGrapRes, msg.grabSuc, changeSetId, prizeStrList)
		self:sendGroupRedPackGetInfoReq(msg.actId)

		self._groupRedpackRpCache = nil
	end
end

function GroupRedpackController:sendGroupRedPackGetRecordsReq(actId)
	GroupRedPackAgent.instance:sendPM_GroupRedPackGetRecordsReq(actId)
end

function GroupRedpackController:handleGroupRedPackGetRecordsRes(status, msg)
	if status == 0 then
		GroupRedpackModel.instance:handleGroupRedPackGetRecordsRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GroupRedPackGetRecordsRes)
	end
end

function GroupRedpackController:sendGroupRedPackSendReq(actId, type, coverId, sloganId)
	GroupRedPackAgent.instance:sendPM_GroupRedPackSendReq(actId, type, coverId, sloganId)
end

function GroupRedpackController:handleGroupRedPackSendRes(status, msg)
	if status == 0 then
		local changeSetId = checknumber(msg.changeSetId)
		local matMos = MaterialModel.instance:getMaterialMos(changeSetId)
		local prizeStrList = {}

		for _, mo in ipairs(matMos) do
			local prizeStr = mo:toString()

			table.insert(prizeStrList, prizeStr)
		end

		MaterialController.instance:saveChangeSetToTemp(changeSetId)
		GlobalDispatcher:dispatch(GlobalNotify.GroupRedPackSendRes, changeSetId, prizeStrList)
		self:sendGroupRedPackGetInfoReq(msg.actId)
	end
end

function GroupRedpackController:sendGroupRedPackGetRankInfoReq(actId, groupId)
	GroupRedPackAgent.instance:sendPM_GroupRedPackGetRankInfoReq(actId, groupId)
end

function GroupRedpackController:handleGroupRedPackGetRankInfoRes(status, msg)
	if status == 0 then
		GroupRedpackModel.instance:handleGroupRedPackGetRankInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GroupRedPackGetRankInfo)
	end
end

function GroupRedpackController:handleNotifyNewGroupRedPacksRes(status, msg)
	if status == 0 then
		GroupRedpackModel.instance:handleNotifyNewGroupRedPacksRes(msg)
	end
end

function GroupRedpackController:isExpire(data)
	local activityId = GroupRedpackModel.instance:getActivityId()
	local planId = GroupRedpackConfig.instance:getGroupRedpackCfgsByActId(activityId).redPackPlanId
	local duration = GroupRedpackConfig.instance:getGroupRedpackPlanCfgsById(planId, data.type).duration

	return math.floor(ServerTime.nowMs()) >= data.timestamp + duration * 1000
end

function GroupRedpackController:isTodayGainLimit(data)
	local activityId = GroupRedpackModel.instance:getActivityId()
	local planId = GroupRedpackConfig.instance:getGroupRedpackCfgsByActId(activityId).redPackPlanId
	local dailyGainLimit = GroupRedpackConfig.instance:getGroupRedpackPlanCfgsById(planId, data.type).dailyGainLimit
	local countList = GroupRedpackModel.instance:getCountList()

	return dailyGainLimit <= countList[data.type].todayGainTimes
end

function GroupRedpackController:isTodayCoinGainLimit(data)
	local activityId = GroupRedpackModel.instance:getActivityId()
	local dailyGainLimit = GroupRedpackConfig.instance:getGroupRedpackCfgsByActId(activityId).consolationPrizeDailyLimit
	local todayCoinGetCount = GroupRedpackModel.instance:getTodayConsolationTimes()

	return dailyGainLimit <= todayCoinGetCount
end

function GroupRedpackController:_checkRedPoint()
	if self._groupRedpackRpCache then
		return self._groupRedpackRpCache
	end

	self._groupRedpackRpCache = false

	local activityId = GroupRedpackModel.instance:getActivityId()
	local redpackList = GroupRedpackModel.instance:getRedpackList()

	for i, v in ipairs(redpackList) do
		local isExpire = self:isExpire(v)
		local isLimit = self:isTodayGainLimit(v)

		if not isExpire and v.state == 0 and v.remainCount > 0 and not isLimit then
			self._groupRedpackRpCache = true

			break
		end
	end

	return self._groupRedpackRpCache
end

function GroupRedpackController:getIsTime(actId, timeKey)
	local timeStr = GoddessContestConfig.instance:getTimeStrByActIdAndTimeKey(actId, timeKey)

	if string.nilorempty(timeStr) then
		return fasle
	end

	local timeStrParams = string.split(timeStr, "#")

	return GameUtil.checkIsInTimePeriod(timeStrParams[1], timeStrParams[2]), GameUtil.getTimePeriodType(timeStrParams[1], timeStrParams[2])
end

function GroupRedpackController:setCurrContainer(con, viewName)
	if not goutil.isNil(self._container) then
		self:clearContainer()
	end

	self._curViewName = viewName
	self._container = con
	self._cellProxy = nil

	self:refreshRedpack()
end

function GroupRedpackController:clearContainer()
	self._container = nil

	if self._cellProxy then
		MaterialMgr.resetPorxy(self._cellProxy)

		self._cellProxy = nil
	end
end

function GroupRedpackController:refreshRedpack()
	if self._curViewName and not ViewMgr.instance:isOpen(self._curViewName) then
		return
	end

	local newRedpackStack = GroupRedpackModel.instance:getNewRedpackStack()
	local peek = newRedpackStack:peek()

	if peek and peek.state == 0 then
		if self._cellProxy == nil then
			self._cellProxy = MaterialMgr.getProxyWithOutPool(RedpackHudPath, RedpackHudCell, self._container)
		end

		if self._cellProxy then
			self._cellProxy.binder:refresh(peek)
		end
	else
		self:clearContainer()
	end
end

GroupRedpackController.instance = GroupRedpackController.New()

return GroupRedpackController
