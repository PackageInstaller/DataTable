-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmimengli/model/OriginMiMengLiModel.lua

module("logic.extensions.originmimengli.model.OriginMiMengLiModel", package.seeall)

local OriginMiMengLiModel = class("OriginMiMengLiModel", BaseModel)

function OriginMiMengLiModel:onInit()
	self:onReset()
end

function OriginMiMengLiModel:onReset()
	self._infoMap = {}
end

function OriginMiMengLiModel:onGetInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._infoMap[data.activityId] = data
end

function OriginMiMengLiModel:onNotifyClg(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if not info then
		info = {
			activityId = data.activityId
		}
		self._infoMap[data.activityId] = info
	end

	info.lastClgResult = data
end

function OriginMiMengLiModel:getInfo(activityId)
	return self._infoMap[activityId]
end

function OriginMiMengLiModel:getPassStage(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info.passStage or 0
	end

	return 0
end

function OriginMiMengLiModel:hasGainPrize(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info.hasGainPrize == true
	end

	return false
end

function OriginMiMengLiModel:getLastClgResult(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info.lastClgResult
	end

	return nil
end

OriginMiMengLiModel.instance = OriginMiMengLiModel.New()

return OriginMiMengLiModel
