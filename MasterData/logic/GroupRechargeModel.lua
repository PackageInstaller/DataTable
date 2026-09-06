-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/model/GroupRechargeModel.lua

module("logic.extensions.grouprecharge.model.GroupRechargeModel", package.seeall)

local GroupRechargeModel = class("GroupRechargeModel", BaseModel)

function GroupRechargeModel:ctor()
	self.activityId = 180001

	self:onReset()
end

function GroupRechargeModel:onInit()
	self:onReset()
end

function GroupRechargeModel:onReset()
	self._requests = {}
	self._requestMap = {}
	self._personalPrizeMap = {}
	self._teamPrizeMap = {}
	self._teamInfo = GroupRechargeTeamInfo.New()
	self._cacheLastOpenTagId = 1
	self._cachePrize = {}
	self.activityConf = GroupRechargeConfig.instance:getActivityConfig(self.activityId)
	self._bInitInfo = false
	self.bInActivityTime = false
end

function GroupRechargeModel:getTeamInfo()
	return self._teamInfo
end

function GroupRechargeModel:getActivityId()
	return self.activityId
end

function GroupRechargeModel:handleInfoRes(msg)
	local personalPrize = msg.personalPrize

	self._personalPrizeMap = {}

	for _, id in ipairs(personalPrize) do
		self._personalPrizeMap[id] = true
	end

	local teamPrize = msg.teamPrize

	self._teamPrizeMap = {}

	for _, id in ipairs(teamPrize) do
		self._teamPrizeMap[id] = true
	end

	self._recharge = msg.recharge

	self._teamInfo:updateInfo(msg.teamInfo)

	self._bInitInfo = true
end

function GroupRechargeModel:handleRequestListRes(msg)
	local requests = GameUtil.pbToTable(msg.requests) or {}

	for i, request in ipairs(requests) do
		self:add2RequestList(request)
	end
end

function GroupRechargeModel:add2RequestList(request)
	if not self._requestMap[request.teamId] then
		table.insert(self._requests, request)
	end

	self._requestMap[request.teamId] = request
end

function GroupRechargeModel:removeFromRequestList(userId)
	for i, request in ipairs(self._requests) do
		if request.headInfo.userId == userId then
			table.remove(self._requests, i, 1)

			self._requestMap[request.teamId] = nil

			return request
		end
	end
end

function GroupRechargeModel:getRequestList()
	return self._requests
end

function GroupRechargeModel:beforeHandlerSendRequestRes(userId, action)
	self._cacheHandlerRequest = {
		userId = userId,
		action = action
	}
end

function GroupRechargeModel:handleHandlerRequestRes(msg)
	if self._cacheHandlerRequest then
		self:removeFromRequestList(self._cacheHandlerRequest.userId)
	else
		printWarn("[grouprecharge]handleHandlerRequestRes cant find userId", (self._cacheHandlerRequest or nil) and self._cacheHandlerRequest.userId)
	end

	self._cacheHandlerRequest = nil
end

function GroupRechargeModel:beforeGainSinglePrizeRes(type, ids)
	self._cachePrize = {
		type = type,
		ids = ids
	}
end

function GroupRechargeModel:handleGainPrizeRes(msg)
	if self._cachePrize then
		local map = self._cachePrize.type == GroupRechargeConfig.Personal and self._personalPrizeMap or self._teamPrizeMap

		for _, id in ipairs(self._cachePrize.ids) do
			map[id] = true
		end
	else
		printWarn("[grouprecharge]handleGainPrizeRes failed")
	end

	self._cachePrize = nil
end

function GroupRechargeModel:handleNotifyReceivedRequestRes(msg)
	local request = msg.request

	self:add2RequestList(request)
end

function GroupRechargeModel:setLastOpenTagId(tagId)
	self._cacheLastOpenTagId = tagId
end

function GroupRechargeModel:getLastOpenTagId()
	return self._cacheLastOpenTagId
end

function GroupRechargeModel:isGainChargePrize(type, id)
	if type == GroupRechargeConfig.Personal then
		return self._personalPrizeMap[id] == true
	else
		return self._teamPrizeMap[id] == true
	end
end

function GroupRechargeModel:getRechargePrizePlanId(type)
	if type == GroupRechargeConfig.Personal then
		return self.activityConf.personalPrizePlanId
	else
		return self.activityConf.teamPrizePlanId
	end
end

function GroupRechargeModel:getChargeNum(type)
	if type == GroupRechargeConfig.Personal then
		return self._recharge or "0"
	else
		return math.max(checknumber(self._teamInfo:getTotalRecharge()), checknumber(self:getChargeNum(GroupRechargeConfig.Personal)))
	end
end

function GroupRechargeModel:isReach2GainCurPrize(type, curConfig)
	local chargeNum = self:getChargeNum(type)

	return checknumber(chargeNum) >= checknumber(curConfig.consumeMoney)
end

function GroupRechargeModel:getCanGainPrizeIds(type, ignoreTeamPrizeCodition)
	local result = {}

	if type == GroupRechargeConfig.Team and not ignoreTeamPrizeCodition and not StringUtil.CompareTwoNumber(self:getMyRechargeNum(), self.activityConf.teamPrizeNeedRecharge) then
		return result
	end

	local configs = GroupRechargeConfig.instance:getRechargePrizeConfigs(type, self:getRechargePrizePlanId(type))

	for i, config in ipairs(configs) do
		if config and config.id and self:isReach2GainCurPrize(type, config) and not self:isGainChargePrize(type, config.id) then
			table.insert(result, config.id)
		end
	end

	return result
end

function GroupRechargeModel:getMyRechargeNum()
	return self._recharge
end

GroupRechargeModel.instance = GroupRechargeModel.New()

return GroupRechargeModel
