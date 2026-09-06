-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/model/TianYanMatchModel.lua

module("logic.extensions.tianyanmatch.model.TianYanMatchModel", package.seeall)

local TianYanMatchModel = class("TianYanMatchModel", BaseModel)

function TianYanMatchModel:ctor()
	TianYanMatchModel.super.ctor(self)
end

function TianYanMatchModel:onInit()
	TianYanMatchModel.super.onInit(self)

	self._info = {}
	self._activeManualMap = {}
	self._gainManualPrizeMap = {}
end

function TianYanMatchModel:onReset()
	TianYanMatchModel.super.onReset(self)
end

function TianYanMatchModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._info[data.activityId] = data

	local activeManualMap = {}

	if self._info[data.activityId].activeManualIds then
		for i, v in ipairs(self._info[data.activityId].activeManualIds) do
			activeManualMap[v] = true
		end
	end

	self._activeManualMap[data.activityId] = activeManualMap

	local gainManualPrizeMap = {}

	if self._info[data.activityId].gainManualPrizeIds then
		for i, v in ipairs(self._info[data.activityId].gainManualPrizeIds) do
			gainManualPrizeMap[v] = true
		end
	end

	self._gainManualPrizeMap[data.activityId] = gainManualPrizeMap
end

function TianYanMatchModel:getMyToyId(activityId)
	if self._info[activityId] then
		return self._info[activityId].toyId
	end

	return 0
end

function TianYanMatchModel:getFriendship(activityId)
	if self._info[activityId] then
		return self._info[activityId].friendship
	end

	return 0
end

function TianYanMatchModel:getMatchToyId(activityId)
	if self._info[activityId] then
		return self._info[activityId].wishMatchToyId
	end

	return 0
end

function TianYanMatchModel:getMatchTime(activityId)
	if self._info[activityId] then
		return self._info[activityId].todayToyCount
	end

	return 0
end

function TianYanMatchModel:saveMyToyId(msg)
	if self._info[msg.activityId] then
		self._info[msg.activityId].toyId = msg.selectToyId
		self._info[msg.activityId].wishMatchToyId = msg.wishMatchToyId
	end
end

function TianYanMatchModel:saveMatchToyId(msg)
	if self._info[msg.activityId] then
		self._info[msg.activityId].wishMatchToyId = msg.wishMatchToyId
	end
end

function TianYanMatchModel:saveUpFriendship(msg)
	if self._info[msg.activityId] then
		self._info[msg.activityId].friendship = msg.targetFriendship
	end
end

function TianYanMatchModel:isActiveManual(activityId, manualId)
	if self._activeManualMap[activityId] then
		return self._activeManualMap[activityId][manualId] or false
	end

	return false
end

function TianYanMatchModel:isGainManualPrize(activityId, manualId)
	if self._gainManualPrizeMap[activityId] then
		return self._gainManualPrizeMap[activityId][manualId] or false
	end

	return false
end

function TianYanMatchModel:saveManualPrize(msg)
	if self._gainManualPrizeMap[msg.activityId] then
		self._gainManualPrizeMap[msg.activityId][msg.manualId] = true
	end
end

function TianYanMatchModel:getMatchResultInfo(activityId)
	if self._info[activityId] then
		return self._info[activityId].matchResult
	end
end

function TianYanMatchModel:clearMatchResultInfo(activityId)
	if self._info[activityId] then
		self._info[activityId].matchResult = nil
	end
end

function TianYanMatchModel:saveMatchResult(msg)
	if self._info[msg.activityId] then
		self._info[msg.activityId].matchResult = msg.matchResult
	end
end

function TianYanMatchModel:saveGainMatchPrize(msg)
	self:clearMatchResultInfo(msg.activityId)

	if self._info[msg.activityId] then
		self._info[msg.activityId].toyId = msg.toyId
		self._info[msg.activityId].friendship = msg.friendship
		self._info[msg.activityId].wishMatchToyId = msg.wishMatchToyId
		self._info[msg.activityId].todayToyCount = msg.todayToyCount

		local activeManualMap = {}

		if msg.activeManualIds then
			for i, v in ipairs(msg.activeManualIds) do
				activeManualMap[v] = true
			end
		end

		self._activeManualMap[msg.activityId] = activeManualMap
	end
end

function TianYanMatchModel:saveRankInfo(msg)
	self._rankInfo = GameUtil.pbToTable(msg)
end

function TianYanMatchModel:getRankInfo()
	return self._rankInfo
end

TianYanMatchModel.instance = TianYanMatchModel.New()

return TianYanMatchModel
