-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/model/OriginDragonNoahModel.lua

module("logic.extensions.origindragonnoah.model.OriginDragonNoahModel", package.seeall)

local OriginDragonNoahModel = class("OriginDragonNoahModel", BaseModel)

function OriginDragonNoahModel:ctor()
	return
end

function OriginDragonNoahModel:onInit()
	self:onReset()
end

function OriginDragonNoahModel:onReset()
	self._infos = {}
	self._customFmtMoPool = {}
	self._stageInfoMap = {}
end

function OriginDragonNoahModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = OriginDragonNoahFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function OriginDragonNoahModel:getStageInfoMap(activityId)
	return self._stageInfoMap[activityId]
end

function OriginDragonNoahModel:getInfo(activityId)
	return self._infos[activityId]
end

function OriginDragonNoahModel:handlePM_OriginDragonNoahClgInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
	self._stageInfoMap[msg.activityId] = self._stageInfoMap[msg.activityId] or {}

	local stageInfoMap = self._stageInfoMap[msg.activityId]
	local info = self._infos[msg.activityId]

	if not info.stageInfos then
		local stageInfos = {}

		for _, stageInfo in ipairs(stageInfos) do
			stageInfoMap[stageInfo.stageId] = stageInfo

			local curStageInfo = stageInfoMap[stageInfo.stageId]

			curStageInfo.scores = curStageInfo.scores or {}
			curStageInfo.lockRaceIds = curStageInfo.lockRaceIds or {}
		end
	end
end

function OriginDragonNoahModel:handlePM_OriginDragonNoahClgResetRes(msg)
	local stageInfoMap = self._stageInfoMap[msg.activityId]

	stageInfoMap[msg.stageId] = nil
end

function OriginDragonNoahModel:handlePM_OriginFightNotifyBattleRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._stageInfoMap[msg.activityId] = self._stageInfoMap[msg.activityId] or {}

	local stageInfoMap = self._stageInfoMap[pb.activityId]

	stageInfoMap[pb.stageId] = pb.stageInfo

	local curStageInfo = stageInfoMap[pb.stageId]

	curStageInfo.scores = curStageInfo.scores or {}
	curStageInfo.lockRaceIds = curStageInfo.lockRaceIds or {}

	TableUtil.printTable(curStageInfo)
end

function OriginDragonNoahModel:getNoahAoJiuTotalScore(activityId)
	local noahTotalScore = 0
	local aoJiuTotalScore = 0
	local stageInfoMap = self._stageInfoMap[activityId]

	for i, stageInfo in pairs(stageInfoMap) do
		noahTotalScore = noahTotalScore + checknumber(stageInfo.scores[OriginDragonNoahController.BuffIdx.noah])
		aoJiuTotalScore = aoJiuTotalScore + checknumber(stageInfo.scores[OriginDragonNoahController.BuffIdx.aoJiu])
	end

	return noahTotalScore, aoJiuTotalScore
end

function OriginDragonNoahModel:getLockRaceIdMap(activityId)
	local lockRaceIdMap = {}
	local stageInfoMap = self._stageInfoMap[activityId]

	for k, info in pairs(stageInfoMap) do
		for _, lockRaceId in ipairs(info.lockRaceIds) do
			lockRaceIdMap[lockRaceId] = true
		end
	end

	return lockRaceIdMap
end

OriginDragonNoahModel.instance = OriginDragonNoahModel.New()

return OriginDragonNoahModel
