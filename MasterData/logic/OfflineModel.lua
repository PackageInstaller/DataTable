-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/model/OfflineModel.lua

module("logic.extensions.offline.model.OfflineModel", package.seeall)

local OfflineModel = class("OfflineModel", BaseModel)

function OfflineModel:ctor()
	OfflineModel.super.ctor(self)
end

function OfflineModel:onInit()
	self:onReset()
end

function OfflineModel:onReset()
	self.prizesMap = {}
end

function OfflineModel:setPrizeInfo(activityId, msg)
	self.prizesMap[activityId] = msg.gainPrizeIds
end

function OfflineModel:onGetPirze(activityId, prizeId)
	self.prizesMap[activityId] = self.prizesMap[activityId] or {}

	local prizes = self.prizesMap[activityId]

	table.insert(prizes, prizeId)
end

function OfflineModel:checkHasGetPrize(activityId, prizeId)
	self.prizesMap[activityId] = self.prizesMap[activityId] or {}

	local prizes = self.prizesMap[activityId]

	return table.indexof(prizes, prizeId)
end

OfflineModel.instance = OfflineModel.New()

return OfflineModel
