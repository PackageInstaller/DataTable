-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/data/GswSimpleTierFmtInfoMo.lua

module("logic.extensions.godstatueswar.data.GswSimpleTierFmtInfoMo", package.seeall)

local GswSimpleTierFmtInfoMo = class("GswSimpleTierFmtInfoMo")

function GswSimpleTierFmtInfoMo:ctor()
	self._fmtType = GswEnum.FmtType_Empty
	self._playerId = nil
	self._playerFormId = 0
	self._zdl = 0
	self._speed = 0
	self._petMosByPos = {}
	self._petMosById = {}
	self._name = ""
end

function GswSimpleTierFmtInfoMo:onReset()
	self._fmtType = GswEnum.FmtType_Empty
	self._playerId = nil
	self._playerFormId = 0
	self._zdl = 0
	self._speed = 0
	self._name = ""

	table.clear(self._petMosByPos)
	table.clear(self._petMosById)
end

function GswSimpleTierFmtInfoMo:initMsgData(info)
	self:onReset()

	self._fmtType = GswEnum.FmtType_Player
	self._playerId = info.playerId
	self._playerFormId = info.playerFormId
	self._zdl = info.zdl
	self._speed = info.speed
	self._name = info.playerName

	for _, v in ipairs(info.petList) do
		local skinId = v.faceId
		local raceId = PetSkinConfig.instance:getPetSkinRaceId(v.faceId)
		local petMo = FightingPowerPetMo.createPetByLevel(raceId, v.level, v.awakenLevel, skinId)

		petMo._zdl = v.zdl
		self._petMosByPos[v.posId] = petMo
	end
end

function GswSimpleTierFmtInfoMo:initLocalData(creepsMasterId)
	self:onReset()

	local masterData = GodStatuesWarConfig.instance:getNfbMasterData(creepsMasterId)
	local creepsCfg = GodStatuesWarConfig.instance:getNfbCreepsCfg(creepsMasterId)

	self._fmtType = GswEnum.FmtType_System
	self._name = masterData.name or ""
	self._zdl = masterData.showZdl
	self.forMation = FormationMO.New(GameUtil.handler(self.getPetMoById, self))

	if creepsCfg then
		local fmo = FightingPowerPetMo.New()

		for _, data in ipairs(creepsCfg) do
			fmo:fromChallengeCreepCo(data)

			local petMo = fmo:toBaseBagPetMo()

			self._petMosByPos[data.posId] = petMo
			self._petMosById[petMo:getPetId()] = petMo
		end

		fmo = nil

		local positions = {}

		for i, data in ipairs(creepsCfg) do
			positions[data.posId] = data.creepsId
		end

		for posId = 1, 9 do
			positions[posId] = checknumber(positions[posId])
		end

		self.forMation:setPositionForce(positions)
	end

	_, self._speed = self.forMation:getPowerAndSpeed()
end

function GswSimpleTierFmtInfoMo:getPetMoById(petId)
	return self._petMosById[petId]
end

function GswSimpleTierFmtInfoMo:getFmtType()
	return self._fmtType
end

function GswSimpleTierFmtInfoMo:getFmtName()
	return self._name
end

function GswSimpleTierFmtInfoMo:getPlayerId()
	return self._playerId
end

function GswSimpleTierFmtInfoMo:getPlayerFormId()
	return self._playerFormId
end

function GswSimpleTierFmtInfoMo:getZdl()
	return self._zdl
end

function GswSimpleTierFmtInfoMo:getSpeed()
	return self._speed
end

function GswSimpleTierFmtInfoMo:getSkinId(posId)
	local petMo = self:getPetMo(posId)

	return (petMo or nil) and (petMo.curFaceId or 0)
end

function GswSimpleTierFmtInfoMo:getPetMo(posId)
	return self._petMosByPos[posId]
end

return GswSimpleTierFmtInfoMo
