-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingnuoya/model/KingNuoyaChallengeModel.lua

module("logic.extensions.kingnuoya.model.KingNuoyaChallengeModel", package.seeall)

local KingNuoyaChallengeModel = class("KingNuoyaChallengeModel", BaseModel)

KingNuoyaChallengeModel.TYPE_DAY = 1
KingNuoyaChallengeModel.TYPE_NIGHT = 2

function KingNuoyaChallengeModel:onInit()
	self:onReset()
end

function KingNuoyaChallengeModel:onReset()
	self._infoMap = {}
end

function KingNuoyaChallengeModel:handlePM_KingNuoYaChallengeInfoRes(msg)
	local activityId = msg.activityId

	self._infoMap[activityId] = GameUtil.pbToTable(msg)
end

function KingNuoyaChallengeModel:getInfo(activityId)
	return self._infoMap[activityId]
end

KingNuoyaChallengeModel.instance = KingNuoyaChallengeModel.New()

return KingNuoyaChallengeModel
