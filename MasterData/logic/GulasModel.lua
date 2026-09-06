-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/model/GulasModel.lua

module("logic.extensions.gulas.model.GulasModel", package.seeall)

local GulasModel = class("GulasModel", BaseModel)

function GulasModel:onInit()
	self:onReset()
end

function GulasModel:onReset()
	self._msgPool = {}
	self._fightPbMap = {}
end

function GulasModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function GulasModel:onGetInfo(msg)
	self._msgPool[msg.activityId] = GameUtil.pbToTable(msg)
end

function GulasModel:onResetStage(msg)
	local info = self._msgPool[msg.activityId]

	if info then
		if not info.teamLockRaceIds then
			info.teamLockRaceIds[msg.stageId] = {}
		end
	end
end

function GulasModel:handleFightRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._fightPbMap[msg.activityId] = pb

	local info = self._msgPool[msg.activityId]

	if info then
		if not pb.lockRaceIds then
			if not info.teamLockRaceIds then
				local teamLockRaceIds = {}

				teamLockRaceIds[msg.stageId] = pb.lockRaceIds
			end
		end
	end
end

function GulasModel:getFightPb(activityId)
	return self._fightPbMap[activityId]
end

function GulasModel:getAllLimitPetMap(activityId)
	local map = {}
	local info = self._msgPool[activityId]

	if info then
		if not info.teamLockRaceIds then
			for i, v in pairs(info.teamLockRaceIds) do
				for j, raceId in ipairs(v.list or {}) do
					map[raceId] = true
				end
			end
		end
	end

	return map
end

GulasModel.instance = GulasModel.New()

return GulasModel
