-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongyanclg/model/OriginLongYanClgModel.lua

module("logic.extensions.originlongyanclg.model.OriginLongYanClgModel", package.seeall)

local OriginLongYanClgModel = class("OriginLongYanClgModel", BaseModel)

function OriginLongYanClgModel:onInit()
	self:onReset()
end

function OriginLongYanClgModel:onReset()
	self._infoMap = {}
	self._lastFightInfo = nil
end

function OriginLongYanClgModel:getInfoByActId(activityId)
	local info = self._infoMap[activityId]

	if not info then
		printInfo("源起龙炎挑战数据不存在，activityId=%d", activityId)
	end

	return self._infoMap[activityId]
end

function OriginLongYanClgModel:getLastFightInfo()
	return self._lastFightInfo
end

function OriginLongYanClgModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._infoMap[activityId] = GameUtil.pbToTable(msg)
end

function OriginLongYanClgModel:handleNotifyChallenge(msg)
	local fightInfo = GameUtil.pbToTable(msg)
	local activityId = fightInfo.activityId

	if fightInfo.stagePass then
		local info = self._infoMap[activityId]

		if info then
			local stageId = fightInfo.stageId

			if stageId > info.passedStageId then
				info.passedStageId = stageId
			end
		end
	end

	self._lastFightInfo = fightInfo
end

OriginLongYanClgModel.instance = OriginLongYanClgModel.New()

return OriginLongYanClgModel
