-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stickcouplet/model/StickCoupletModel.lua

module("logic.extensions.stickcouplet.model.StickCoupletModel", package.seeall)

local StickCoupletModel = class("StickCoupletModel", BaseModel)

function StickCoupletModel:ctor()
	return
end

function StickCoupletModel:onInit()
	self:onReset()
end

function StickCoupletModel:onReset()
	self._ModelPool = {}
end

function StickCoupletModel:getModel(activityId)
	if self._ModelPool[activityId] == nil then
		local cur = {}

		cur.todayGameTimes = 0
		cur.gainPrizeIds = {}
		cur.curScore = 0
		cur.totalScore = 0
		cur.clientKey = nil
		cur.serverKey = nil
		self._ModelPool[activityId] = cur
	end

	return self._ModelPool[activityId]
end

function StickCoupletModel:handlePM_StickCoupletGetInfoRes(msg)
	local activityId = msg.activityId
	local curModel = self:getModel(activityId)

	curModel.todayGameTimes = msg.todayGameTimes
	curModel.gainPrizeIds = msg.gainPrizeIds or {}
	curModel.totalScore = msg.totalScore
end

function StickCoupletModel:handlePM_StickCoupletStartGameRes(msg)
	local activityId = msg.activityId
	local curModel = self:getModel(activityId)

	curModel.clientKey = msg.clientKey
	curModel.serverKey = msg.serverKey
end

function StickCoupletModel:handlePM_StickCoupletEndGameRes(msg)
	local activityId = msg.activityId
	local curModel = self:getModel(activityId)

	curModel.curScore = msg.score
	curModel.totalScore = msg.totalScore
end

function StickCoupletModel:handlePM_StickCoupletGainPrizeRes(msg)
	local activityId = msg.activityId
	local curModel = self:getModel(activityId)

	table.insert(curModel.gainPrizeIds, msg.prizeId)
end

function StickCoupletModel:getClientKey(activityId)
	return math.random(1, ServerTime.now()) + activityId
end

function StickCoupletModel:getEncryptedKey(activityId, score)
	local curModel = self:getModel(activityId)

	return (GameUtil.getClientEncryptedKey(curModel.clientKey, curModel.serverKey, {
		score
	}))
end

StickCoupletModel.instance = StickCoupletModel.New()

return StickCoupletModel
