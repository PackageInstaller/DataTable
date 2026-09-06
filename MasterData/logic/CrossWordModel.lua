-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crossword/model/CrossWordModel.lua

module("logic.extensions.crossword.model.CrossWordModel", package.seeall)

local CrossWordModel = class("CrossWordModel", BaseModel)

function CrossWordModel:onInit()
	self:onReset()
end

function CrossWordModel:onReset()
	self._msgPool = {}
end

function CrossWordModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._msgPool[activityId] = GameUtil.pbToTable(msg)
end

function CrossWordModel:onFinishGrid(msg)
	local activityId = msg.activityId
	local info = self._msgPool[activityId]

	if info then
		info.finishedGrids = info.finishedGrids or {}

		table.insert(info.finishedGrids, msg.gridId)

		info.todayFinishGridTimes = msg.todayFinishGridTimes
	end
end

function CrossWordModel:onGainPrize(msg)
	local activityId = msg.activityId
	local info = self._msgPool[activityId]

	if info then
		info.gainPrizeIds = info.gainPrizeIds or {}

		table.insert(info.gainPrizeIds, msg.prizeId)
	end
end

function CrossWordModel:getInfo(activityId)
	return self._msgPool[activityId]
end

CrossWordModel.instance = CrossWordModel.New()

return CrossWordModel
