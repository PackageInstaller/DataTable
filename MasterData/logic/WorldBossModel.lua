-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/model/WorldBossModel.lua

module("logic.extensions.worldboss.model.WorldBossModel", package.seeall)

local WorldBossModel = class("WorldBossModel", BaseListModel)

function WorldBossModel:ctor()
	WorldBossModel.super.ctor(self)
	self:_initData()
end

function WorldBossModel:onInit()
	WorldBossModel.super.onInit(self)

	self._daySec = 86400
end

function WorldBossModel:onReset()
	WorldBossModel.super.onReset(self)

	self._bossInfo = nil
end

function WorldBossModel:_initData()
	return
end

function WorldBossModel:getBossSchedule()
	if self._bossInfo then
		return self._bossInfo
	end

	self._bossInfo = {}

	for i = 1, 7 do
		local _worldBossLayout = WorldBossConfig.instance:getWorldBossLayoutByGameDay(ServerTime.now() + (i - 4) * self._daySec)

		for j, cfg in ipairs(_worldBossLayout) do
			local creepsCfg = WorldBossConfig.instance:getWorldBossCreepsById(cfg.bossId)
			local bossInfo = {
				index = i,
				raceId = creepsCfg[1].raceId,
				name = creepsCfg[1].creepsName,
				id = _worldBossLayout[j].id,
				prize = WorldBossConfig.instance:getWorldBossCommonConfigValueByKey("SCHEEDULE")
			}

			table.insert(self._bossInfo, bossInfo)
		end
	end

	return self._bossInfo
end

function WorldBossModel:getOriginalCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function WorldBossModel:_getCurFormation()
	local formation = self:getOriginalCurFormation()

	for pos, petid in pairs(formation._positions) do
		if WorldBossController.instance:isLockPetIds(petid) then
			formation:SetPosition(pos, 0)
		end
	end

	return formation
end

function WorldBossModel:getAllShowPetList()
	return BagPetsController.instance:getFightBagPet() or {}
end

WorldBossModel.instance = WorldBossModel.New()

return WorldBossModel
