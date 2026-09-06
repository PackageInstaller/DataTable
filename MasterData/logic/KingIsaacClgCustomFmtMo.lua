-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingisaacclg/model/KingIsaacClgCustomFmtMo.lua

module("logic.extensions.divinexiuerclg.model.KingIsaacClgCustomFmtMo", package.seeall)

local KingIsaacClgCustomFmtMo = class("KingIsaacClgCustomFmtMo", ICustomFmtMo)

function KingIsaacClgCustomFmtMo:onReset()
	KingIsaacClgCustomFmtMo.super.onReset(self)
end

function KingIsaacClgCustomFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._stageData = KingIsaacClgConfig.instance:getKicStageData(self._activityId, self._stageId)
	self._creepsMasterId = self._stageData.creepsMasterId
	self._masterData = KingIsaacClgConfig.instance:getKicCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = KingIsaacClgConfig.instance:getKicCreepsCfg(self._creepsMasterId)
	self._templateCfg = KingIsaacClgConfig.instance:getKicMirrorTemplateCfg(self._stageData.templateId)
	self._templatePosList = {}

	for i, data in pairs(self._templateCfg) do
		table.insert(self._templatePosList, data.posId)
	end

	table.sort(self._templatePosList, function(a, b)
		return a < b
	end)

	self._templateTagMap = {}

	for posId = 1, 9 do
		self._templateTagMap[posId] = false
	end
end

function KingIsaacClgCustomFmtMo:getTemplatePosList()
	return self._templatePosList
end

function KingIsaacClgCustomFmtMo:updateData()
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self.isHideFmtZdl = true

	self:initPetListOfRight()
	self:refreshRightFormation()
end

function KingIsaacClgCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		KingIsaacClgController.instance:sendPM_KingIsaacClgChallengeReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KingIsaacClgCustomFmtMo:getMonsterConfigList()
	return
end

function KingIsaacClgCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function KingIsaacClgCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function KingIsaacClgCustomFmtMo:initPetListOfRight()
	local fmo = FightingPowerPetMo.New()

	self._petMoOfRight = {}

	for i, data in ipairs(self._creepsCfg) do
		fmo:fromChallengeCreepCo(data)

		local petMo = fmo:toBaseBagPetMo()

		self:addPetToListOfRight(petMo)
	end

	fmo = nil
end

function KingIsaacClgCustomFmtMo:addPetToListOfRight(mo)
	if mo and mo:isExist() then
		self._petMoOfRight = self._petMoOfRight or {}
		self._petMoOfRight[mo.petId] = mo
	end
end

function KingIsaacClgCustomFmtMo:rmPetFormListOfRight(petId)
	self._petMoOfRight[petId] = nil
end

function KingIsaacClgCustomFmtMo:getRightPetMo(petId)
	return self._petMoOfRight[petId]
end

function KingIsaacClgCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function KingIsaacClgCustomFmtMo:_changePetMo(petMo)
	if self.useMaxFightPower then
		return FightingPowerPetMo.getMaxPetMoByData(petMo)
	end

	return petMo
end

function KingIsaacClgCustomFmtMo:refreshRightFormation()
	local positions = {}

	for i, data in ipairs(self._creepsCfg) do
		positions[data.posId] = data.creepsId
	end

	for posId = 1, 9 do
		positions[posId] = checknumber(positions[posId])
	end

	local formationMo = self:getCurRightFormation()

	formationMo:setPositionForce(positions)
end

function KingIsaacClgCustomFmtMo:initFormationMo()
	self.forMationMap = {}
	self.forMationMap[GameEnum.BattleTeam.Left] = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	self.forMationMap[GameEnum.BattleTeam.Right] = FormationMO.New(GameUtil.handler(self.getRightPetMo, self))
	self.formationMo = self:getCurFormation()
end

function KingIsaacClgCustomFmtMo:getCurFormation()
	return self.forMationMap[GameEnum.BattleTeam.Left]
end

function KingIsaacClgCustomFmtMo:getCurRightFormation()
	return self.forMationMap[GameEnum.BattleTeam.Right]
end

function KingIsaacClgCustomFmtMo:onFormationChangeFinish()
	local leftFormation = self:getCurFormation()
	local rightFormation = self:getCurRightFormation()
	local positions = rightFormation:GetPositions()

	for posId = 1, 9 do
		self._templateTagMap[posId] = false
	end

	for idx, templatePosId in ipairs(self._templatePosList) do
		local clonePetMo
		local rowIdx = Mathf.Ceil(templatePosId / 3)

		if not KingIsaacClgEnum.LeftPosMap[rowIdx] then
			for _, posId in ipairs(KingIsaacClgEnum.LeftPosMap[rowIdx]) do
				local tag = self._templateTagMap[posId]
				local petId = leftFormation:GetPosition(posId)

				if tag ~= true and petId > 0 then
					clonePetMo = self:getPetMoById(petId)
					self._templateTagMap[posId] = true

					break
				end
			end

			if clonePetMo then
				local petId = clonePetMo:getPetId()
				local petMo = self:getRightPetMo(petId) or clonePetMo:GetClone()

				positions[templatePosId] = petMo:getPetId()

				self:addPetToListOfRight(petMo)
			else
				positions[templatePosId] = 0
			end
		end
	end

	rightFormation:setPositionForce(positions)
	GlobalDispatcher:dispatch(GlobalNotify.RefreshEnemyFmt)
end

function KingIsaacClgCustomFmtMo:getTeamAndFormation(creepCfg)
	local fmtMo = self:getCurRightFormation()
	local teams, formations, speed = fmtMo:getTeamAndFormation()

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function KingIsaacClgCustomFmtMo:getExtendViewName()
	return ViewName.KingIsaacClgExView
end

return KingIsaacClgCustomFmtMo
