-- chunkname: @modules/logic/turnback/model/TurnbackRecommendModel.lua

module("modules.logic.turnback.model.TurnbackRecommendModel", package.seeall)

local TurnbackRecommendModel = class("TurnbackRecommendModel", BaseModel)

function TurnbackRecommendModel:onInit()
	self.recommendOpenMap = {}
	self.turnbackId = 0
end

function TurnbackRecommendModel:reInit()
	self.recommendOpenMap = {}
	self.turnbackId = 0
end

function TurnbackRecommendModel:initReommendShowState(turnbackId)
	self.turnbackId = turnbackId

	local allRecommend = TurnbackConfig.instance:getAllRecommendCo(turnbackId) or {}

	for id, config in pairs(allRecommend) do
		self.recommendOpenMap[turnbackId] = self.recommendOpenMap[turnbackId] or {}
		self.recommendOpenMap[turnbackId][id] = self:checkReommendShowState(turnbackId, id)
	end
end

function TurnbackRecommendModel:checkReommendShowState(turnbackId, id)
	local config = TurnbackConfig.instance:getRecommendCo(turnbackId, id)

	if not config then
		return false
	end

	local isInTime = self:checkRecommendIsInTime(config)

	return isInTime and (string.nilorempty(config.relateActId) and config.openId > 0 or nil) and OpenModel.instance:isFunctionUnlock(config.openId)
end

function TurnbackRecommendModel:checkRecommendIsInTime(config)
	local leaveTime = TurnbackModel.instance:getLeaveTime()
	local hasOnlineTime = not string.nilorempty(config.onlineTime)
	local hasOfflineTime = not string.nilorempty(config.offlineTime)
	local hasConstTime = not string.nilorempty(config.constTime)
	local isStart = hasOnlineTime and ServerTime.now() - ((hasOnlineTime or nil) and TimeUtil.stringToTimestamp(config.onlineTime) + ServerTime.clientToServerOffset()) >= 0
	local isEnd = hasOfflineTime and ServerTime.now() - ((hasOfflineTime or nil) and TimeUtil.stringToTimestamp(config.offlineTime) + ServerTime.clientToServerOffset()) > 0
	local isInConstTime = hasConstTime and ((hasConstTime or nil) and TimeUtil.stringToTimestamp(config.constTime) + ServerTime.clientToServerOffset()) - leaveTime > 0 and leaveTime > 0
	local hasOpenRelateAct = self:checkHasOpenRelateAct(config)
	local hasRelateAct = not string.nilorempty(config.relateActId)

	if leaveTime <= 0 then
		return false
	end

	if hasRelateAct and hasOpenRelateAct and isInConstTime then
		return true
	elseif hasRelateAct and hasOpenRelateAct and not hasConstTime then
		return true
	elseif not hasRelateAct and not hasConstTime then
		return true
	elseif not hasRelateAct and isStart and not isEnd and isInConstTime then
		return true
	else
		return false
	end
end

function TurnbackRecommendModel:checkHasOpenRelateAct(config)
	local hasRelateAct = not string.nilorempty(config.relateActId)

	if hasRelateAct then
		for index, actId in ipairs((string.splitToNumber(config.relateActId, "#"))) do
			local state = ActivityHelper.getActivityStatusAndToast(actId)

			if state == ActivityEnum.ActivityStatus.Normal then
				return true
			end
		end
	end

	return false
end

function TurnbackRecommendModel:checkRecommendCanShow(config)
	if not string.nilorempty(config.prepose) then
		local preposeList = string.splitToNumber(config.prepose, "#")

		for _, id in pairs(preposeList) do
			local co = TurnbackConfig.instance:getRecommendCo(self.turnbackId, id)

			if not co then
				logError("推荐页或前置推荐页id不存在,请检查配置，id: " .. tostring(id))

				return
			end

			local checkState = self:checkRecommendCanShow(co)

			if checkState then
				return false
			end
		end
	end

	return self.recommendOpenMap[self.turnbackId][config.id]
end

function TurnbackRecommendModel:getCanShowRecommendList()
	local canShowRecommends = {}
	local allRecommend = tabletool.copy(TurnbackConfig.instance:getAllRecommendCo(self.turnbackId))

	for id, config in pairs(allRecommend) do
		if self:checkRecommendCanShow(config) then
			table.insert(canShowRecommends, config)
		end
	end

	return canShowRecommends
end

function TurnbackRecommendModel:getCanShowRecommendCount()
	local recommendList = self:getCanShowRecommendList()

	return #recommendList
end

TurnbackRecommendModel.instance = TurnbackRecommendModel.New()

return TurnbackRecommendModel
