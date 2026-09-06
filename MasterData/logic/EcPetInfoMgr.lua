-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/view/EcPetInfoMgr.lua

module("logic.extensions.eternalchallenge.view.EcPetInfoMgr", package.seeall)

local EcPetInfoMgr = class("EcPetInfoMgr")

function EcPetInfoMgr:ctor(activityId)
	self._activityId = activityId
	self._fmo = FightingPowerPetMo.New()
	self._petInfoPool = {}
	self._raceIdList = {}

	local dataLists = EternalChallengeConfig.instance:getEcPetDataLists(self._activityId)

	for _, dataList in pairs(dataLists) do
		local raceId = dataList[1].raceId
		local curLevel = 0

		self:updatePetInfo(raceId, curLevel)
		table.insert(self._raceIdList, raceId)
	end
end

function EcPetInfoMgr:updatePetInfo(raceId, curLevel)
	local data = EternalChallengeConfig.instance:getEcPetData(self._activityId, raceId, curLevel)
	local creepsId = data.creepId
	local creepsData = EternalChallengeConfig.instance:getEcPetCreepsData(creepsId)

	if creepsData == nil then
		printError(string.format("缺失精灵配置( raceId=%s, level=%s )( ys运营-神曜阿瑞斯挑战.xlsx | export_精灵配置 )", raceId, curLevel))
	end

	if not self._petInfoPool[raceId] then
		local info = {}

		self._petInfoPool[raceId] = info
		info.raceId = raceId
		info.curLevel = curLevel
		info.creepsId = creepsId

		if creepsData then
			self._fmo:fromChallengeCreepCo(creepsData)

			info.petMo = self._fmo:toBaseBagPetMo()
		end
	end
end

function EcPetInfoMgr:getActivityId()
	return self._activityId
end

function EcPetInfoMgr:getCurLevel(raceId)
	local info = self:getPetInfo(raceId)

	return (info or nil) and info.curLevel
end

function EcPetInfoMgr:getCreepsId(raceId)
	local info = self:getPetInfo(raceId)

	return (info or nil) and info.creepsId
end

function EcPetInfoMgr:getPetMo(raceId)
	local info = self:getPetInfo(raceId)

	return (info or nil) and info.petMo
end

function EcPetInfoMgr:getRaceIdList()
	return self._raceIdList
end

function EcPetInfoMgr:getPetInfo(raceId)
	return self._petInfoPool[raceId]
end

return EcPetInfoMgr
