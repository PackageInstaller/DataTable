-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/controller/battlemgr/MiracleHeroUnitMgr.lua

module("logic.extensions.miraclehero.controller.battlemgr.MiracleHeroUnitMgr", package.seeall)

local MiracleHeroUnitMgr = class("MiracleHeroUnitMgr")

function MiracleHeroUnitMgr:ctor()
	self._petMap = {}
	self.myTeamMo = nil
	self.enemyTeamMo = nil
end

function MiracleHeroUnitMgr:initData(activityId, challengeId, stageId)
	self._activityId = activityId

	local idIndex = 1
	local formation = MiracleHeroBattleModel.instance:getPetInfo()

	self._petMap = {}

	local myTeamMo = MiracleHeroTeamMo.New()

	myTeamMo.teamId = MiracleHeroTeamType.MyTeam

	for i, v in ipairs(formation.raceIds) do
		local battlePetMo = MiracleHeroBattlePetMo.New()
		local posMo = MiracleHeroModel.instance:getPositionMo(activityId, i)
		local petCfg = MiracleHeroConfig.instance:getPetCfg(activityId, v)
		local levelCfgs = MiracleHeroConfig.instance:getPropertyCfgs(petCfg.propertyStrategyId)
		local proertyCfg = levelCfgs[posMo.level]
		local info = {
			id = idIndex,
			teamId = myTeamMo.teamId,
			configId = v,
			level = posMo.level,
			hp = proertyCfg.hp,
			attack = proertyCfg.Atk,
			speed = proertyCfg.speed,
			criticalRate = proertyCfg.criticalRate
		}

		battlePetMo:initData(info)

		idIndex = idIndex + 1
		myTeamMo.pos[i] = info.id
		self._petMap[battlePetMo.id] = battlePetMo
	end

	myTeamMo.supportPet = formation.assistId

	myTeamMo:initData()

	self.myTeamMo = myTeamMo

	local enemyTeamMo = MiracleHeroTeamMo.New()

	enemyTeamMo.teamId = MiracleHeroTeamType.EnemyTeam

	local stageCfg = MiracleHeroConfig.instance:getStageCfg(activityId, challengeId, stageId)
	local creepsCfg = MiracleHeroConfig.instance:getCreepsCfg(activityId, stageCfg.creepsMasterId)

	for i, v in ipairs(creepsCfg) do
		local battlePetMo = MiracleHeroBattlePetMo.New()
		local attrData = FightingPowerFormula.instance:parseAttrValues(v.extproperties)
		local info = {
			id = idIndex,
			teamId = enemyTeamMo.teamId,
			configId = v.raceId,
			level = v.lv,
			hp = checknumber(attrData[GameEnum.AttrType.Hp]),
			attack = checknumber(attrData[GameEnum.AttrType.Attack]),
			speed = checknumber(attrData[GameEnum.AttrType.Speed]),
			criticalRate = checknumber(attrData[GameEnum.AttrType.CriticalRate])
		}

		battlePetMo:initData(info)

		idIndex = idIndex + 1
		enemyTeamMo.pos[v.posId] = info.id
		self._petMap[battlePetMo.id] = battlePetMo
	end

	enemyTeamMo:initData()

	self.enemyTeamMo = enemyTeamMo
end

function MiracleHeroUnitMgr:getAllPet()
	return self._petMap
end

function MiracleHeroUnitMgr:getPet(petId)
	return self._petMap[petId]
end

function MiracleHeroUnitMgr:getTeamSpeed(teamType)
	if teamType == MiracleHeroTeamType.MyTeam then
		return self.myTeamMo.allSpeed
	elseif teamType == MiracleHeroTeamType.EnemyTeam then
		return self.enemyTeamMo.allSpeed
	end

	return 0
end

function MiracleHeroUnitMgr:getFirstTeamType()
	if self:getTeamSpeed(MiracleHeroTeamType.MyTeam) >= self:getTeamSpeed(MiracleHeroTeamType.EnemyTeam) then
		return MiracleHeroTeamType.MyTeam
	else
		return MiracleHeroTeamType.EnemyTeam
	end
end

function MiracleHeroUnitMgr:getTeamMo(teamType)
	if teamType == MiracleHeroTeamType.MyTeam then
		return self.myTeamMo
	elseif teamType == MiracleHeroTeamType.EnemyTeam then
		return self.enemyTeamMo
	end
end

function MiracleHeroUnitMgr:isPetSurvival(petId)
	if self._petMap[petId] then
		return self._petMap[petId].curHp > 0
	else
		return false
	end
end

MiracleHeroUnitMgr.instance = MiracleHeroUnitMgr.New()

return MiracleHeroUnitMgr
