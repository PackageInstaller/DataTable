-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zdlverify/model/ZdlVerifyModel.lua

module("logic.extensions.zdlverify.model.ZdlVerifyModel", package.seeall)

local ZdlVerifyModel = class("ZdlVerifyModel", BaseModel)

function ZdlVerifyModel:onInit()
	self:onReset()
end

function ZdlVerifyModel:onReset()
	self._infoMap = {}
end

function ZdlVerifyModel:onGetInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local activityId = data.activityId
	local hasVerifyIdMap = {}

	if data.hasVerifyId then
		for _, verifyId in ipairs(data.hasVerifyId) do
			hasVerifyIdMap[verifyId] = true
		end
	end

	local hasGainProgressIdMap = {}

	if data.hasGainProgressId then
		for _, progressId in ipairs(data.hasGainProgressId) do
			hasGainProgressIdMap[progressId] = true
		end
	end

	data.hasVerifyIdMap = hasVerifyIdMap
	data.hasGainProgressIdMap = hasGainProgressIdMap
	self._infoMap[activityId] = data
end

function ZdlVerifyModel:onVerifyRace(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		if not info.hasVerifyIdMap then
			info.hasVerifyIdMap[data.verifyId] = true
			info.hasVerifyIdMap = info.hasVerifyIdMap
		end
	end
end

function ZdlVerifyModel:onGainProgress(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		if not info.hasGainProgressIdMap then
			info.hasGainProgressIdMap[data.progressId] = true
			info.hasGainProgressIdMap = info.hasGainProgressIdMap
		end
	end
end

function ZdlVerifyModel:getInfo(activityId)
	return self._infoMap[activityId]
end

function ZdlVerifyModel:hasVerify(activityId, verifyId)
	local info = self._infoMap[activityId]

	if info and info.hasVerifyIdMap then
		return info.hasVerifyIdMap[verifyId] == true
	end

	return false
end

function ZdlVerifyModel:hasGainProgress(activityId, progressId)
	local info = self._infoMap[activityId]

	if info and info.hasGainProgressIdMap then
		return info.hasGainProgressIdMap[progressId] == true
	end

	return false
end

ZdlVerifyModel.instance = ZdlVerifyModel.New()

return ZdlVerifyModel
