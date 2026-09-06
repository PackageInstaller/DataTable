-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankverify/model/RankVerifyModel.lua

module("logic.extensions.rankverify.model.RankVerifyModel", package.seeall)

local RankVerifyModel = class("RankVerifyModel", BaseModel)

function RankVerifyModel:onReset()
	self._actId = 0
	self._finishTaskIds = {}
	self._curProgress = 0
	self._gainPrizeIds = {}
end

function RankVerifyModel:updateGetInfo(msg)
	self:onReset()

	self._actId = checkint(msg.activityId)
	self._finishTaskIds = msg.finishedTaskIds or {}
	self._curprogress = checkint(msg.curProgress) or 0
	self._gainPrizeIds = msg.gainedPrizeIds or {}
end

function RankVerifyModel:updateVerifyTask(msg)
	local taskId = checkint(msg.taskId)

	if taskId > 0 then
		table.insert(self._finishTaskIds, taskId)
	end

	self._curprogress = msg.curProgress or 0
end

function RankVerifyModel:updateGainPrize(msg)
	local prizeId = checkint(msg.prizeId)

	if prizeId > 0 then
		table.insert(self._gainPrizeIds, prizeId)
	end
end

function RankVerifyModel:getIsHasGainPrize(actId, prizeId)
	if actId == self._actId and prizeId then
		return table.keyof(self._gainPrizeIds, prizeId)
	end

	return nil
end

function RankVerifyModel:getIsHasVerifyTask(actId, taskId)
	if actId == self._actId and taskId then
		return table.keyof(self._finishTaskIds, taskId)
	end

	return nil
end

function RankVerifyModel:getCurProgress()
	return self._curprogress
end

RankVerifyModel.instance = RankVerifyModel.New()

return RankVerifyModel
