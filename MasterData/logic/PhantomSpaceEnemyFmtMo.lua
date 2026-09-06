-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/model/PhantomSpaceEnemyFmtMo.lua

module("logic.extensions.phantomspace.model.PhantomSpaceEnemyFmtMo", package.seeall)

local PhantomSpaceEnemyFmtMo = class("PhantomSpaceEnemyFmtMo", BaseCustomFmtMo)

function PhantomSpaceEnemyFmtMo:initParams(activityId, mode, buffLv, stageId)
	self.activityId = activityId
	self.mode = mode
	self.buffLv = buffLv
	self.stageId = stageId
	self._phantomMonsterPb = PhantomSpaceModel.instance:getPhantomMonsterPb(activityId)

	self:_setEnemyFmo(self._phantomMonsterPb)

	local cfg = PhantomSpaceConfig.instance:getStageCfgById(activityId, mode, stageId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = PhantomSpaceConfig.instance:getMonsterCfgById(self.creepsMasterId) or {}
	self.creeps = PhantomSpaceConfig.instance:getCreeps(self.creepsMasterId) or {}

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "PhantomSpaceEnemyFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function PhantomSpaceEnemyFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		PhantomSpaceController.instance:sendFight(self.activityId, self.mode, self.buffLv, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function PhantomSpaceEnemyFmtMo:_setEnemyFmo(phantomMonsterPb)
	self._formationMoOfEnemy = self._formationMoOfEnemy or FormationMO.New(GameUtil.handler(self.getPetMoByIdOfEnemy, self))

	local petSimpleView = phantomMonsterPb.petSimpleView

	self._petMapAsRight = {}

	for _, v in ipairs(petSimpleView) do
		local petMo = BagPetMo.New()

		petMo:initBaseView(v)

		petMo.isMyPackPet = false
		self._petMapAsRight[v.petId] = petMo
	end

	local simpleForm = phantomMonsterPb.curForm

	self._formationMoOfEnemy:SetData(simpleForm)
end

function PhantomSpaceEnemyFmtMo:getPetMoByIdOfEnemy(petId)
	return self._petMapAsRight[petId]
end

function PhantomSpaceEnemyFmtMo:getExtParams()
	return self:getFmtInfoConfig()
end

function PhantomSpaceEnemyFmtMo:getMonsterConfigList()
	return {}
end

function PhantomSpaceEnemyFmtMo:getFmtInfoConfig()
	local simpleForm = CustomFmtController.instance:createFormPb(self._formationMoOfEnemy)

	return simpleForm.extParams
end

function PhantomSpaceEnemyFmtMo:getTeamAndFormation(creepCfg)
	local fmtMo = self._formationMoOfEnemy
	local teams, formations, speed = fmtMo:getTeamAndFormation()

	ArraySort.sortOn(teams, "position")

	local resultFormations = {}

	for posId, bagPetMo in pairs(formations) do
		local fightingPowerMo = bagPetMo:toFightingPowerPetMo()

		fightingPowerMo.petId = bagPetMo:getPetId()
		resultFormations[posId] = fightingPowerMo
	end

	return teams, resultFormations
end

return PhantomSpaceEnemyFmtMo
