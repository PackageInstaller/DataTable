-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/battle/BattleResourcesPreload.lua

module("logicscene.scene.component.battle.BattleResourcesPreload", package.seeall)

local BattleResourcesPreload = class("BattleResourcesPreload", SceneComponentBase)

function BattleResourcesPreload:onExitScene()
	self:clearAll()
end

function BattleResourcesPreload:clearAll()
	self._unitSkills = nil
	self._loadedSkillIds = nil
	self._isValid = nil
	self._isNoneSkill = false
end

function BattleResourcesPreload:isLoadedFirstSkill()
	return self._isNoneSkill or self._loadedSkillIds and next(self._loadedSkillIds)
end

function BattleResourcesPreload:startPreloadUnitsSkill()
	if not BattleModel.instance:checkHasBattleIdInitRound() or checkbool(self._isValid) == true then
		return
	end

	self._unitSkills = {}
	self._isValid = true

	local unitFactory = self._scene.unitFactory
	local rounds = BattleModel.instance.rounds

	for i = 1, #rounds do
		local round = rounds[i]

		if round.roundType == BattleRoundBase.Round then
			local result = round:getCharactorResult()

			if result then
				local skillId = result.skillId
				local characterId = result.caster.targetCharacterId
				local teamId = result.caster.targetTeamId
				local view = BattleModel.instance:getCharactorById(teamId, characterId)
				local unit = unitFactory:getUnit(teamId, characterId)

				self:_prepareSkills(unit, skillId)
			end
		end
	end

	self._isNoneSkill = #self._unitSkills == 0

	self:_startLoadUnitSkill()
end

function BattleResourcesPreload:_prepareSkills(unit, skillId)
	if skillId and skillId > 0 then
		local take, female = BattleConfig.instance:getSkillAnimTake(skillId, unit.modelId)

		if take and #take > 0 or female and #female > 0 then
			table.insert(self._unitSkills, {
				unit = unit,
				id = skillId
			})
		end
	end
end

function BattleResourcesPreload:preloadSkill(skillId, skinId, finishCallback, finishCallbackObj)
	if self._loadedSkillIds and self._loadedSkillIds[skillId] and self._loadedSkillIds[skillId][skinId] then
		if finishCallback then
			if finishCallbackObj then
				finishCallback(finishCallbackObj)
			else
				finishCallback(finishCallbackObj)
			end
		end

		return
	end

	local resourcesList = {}
	local uniqueRecord = {}
	local take, female = BattleConfig.instance:getSkillAnimTake(skillId, skinId)

	if take and #take > 0 then
		for _, v in ipairs(take) do
			self:_addResources(v, resourcesList, uniqueRecord)
		end
	end

	if female and #female > 0 then
		for _, v in ipairs(female) do
			self:_addResources(v, resourcesList, uniqueRecord)
		end
	end

	self._scene.resQueue:pushResources(resourcesList, function(loader)
		if not self._isValid then
			return
		end

		self._loadedSkillIds = self._loadedSkillIds or {}
		self._loadedSkillIds[skillId] = self._loadedSkillIds[skillId] or {}
		self._loadedSkillIds[skillId][skinId] = loader

		self:_startLoadUnitSkill()

		if finishCallback then
			if finishCallbackObj then
				finishCallback(finishCallbackObj)
			else
				finishCallback()
			end
		end
	end, self)
end

function BattleResourcesPreload:_startLoadUnitSkill()
	if not self._unitSkills then
		return
	end

	local skillCfg = self._unitSkills[1]

	if not skillCfg then
		return
	end

	table.remove(self._unitSkills, 1)

	if skillCfg.unit:isDead() then
		self:_startLoadUnitSkill()
	else
		self:preloadSkill(skillCfg.id, skillCfg.unit.modelId)
	end
end

function BattleResourcesPreload:_addResources(take, resourcesList, uniqueRecord)
	local prefabs, fmodBanks, hasMoved = AMPlayer.GetTakeResources(take, nil, nil, nil)

	if prefabs then
		local cnt = prefabs.Count - 1

		for i = 0, cnt do
			if prefabs[i] and #prefabs[i] > 0 and not uniqueRecord[prefabs[i]] then
				uniqueRecord[prefabs[i]] = true

				table.insert(resourcesList, prefabs[i])
			end
		end
	end

	if fmodBanks then
		local cnt = fmodBanks.Count - 1

		for i = 0, cnt do
			if fmodBanks[i] and #fmodBanks[i] > 0 then
				FmodBanksManager.instance:loadBank(fmodBanks[i])
			end
		end
	end
end

return BattleResourcesPreload
