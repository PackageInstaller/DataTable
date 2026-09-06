-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddailyrank/model/GodDailyRankModel.lua

module("logic.extensions.goddailyrank.model.GodDailyRankModel", package.seeall)

local GodDailyRankModel = class("GodDailyRankModel", BaseModel)

function GodDailyRankModel:onInit()
	self:onReset()
end

function GodDailyRankModel:onReset()
	self._msgGodPool = {}
	self._msgDailyPool = {}
end

function GodDailyRankModel:onGetGodRankInfo(msg)
	local activityId = msg.activityId

	self._msgGodPool[activityId] = GameUtil.pbToTable(msg)
end

function GodDailyRankModel:onGetDailyRankInfo(msg)
	local activityId = msg.activityId

	self._msgDailyPool[activityId] = GameUtil.pbToTable(msg)
end

function GodDailyRankModel:getGodRankInfo(activityId)
	return self._msgGodPool[activityId]
end

function GodDailyRankModel:getDailyRankInfo(activityId)
	return self._msgDailyPool[activityId]
end

GodDailyRankModel.instance = GodDailyRankModel.New()

return GodDailyRankModel
