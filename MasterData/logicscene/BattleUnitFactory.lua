-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/factory/BattleUnitFactory.lua

module("logicscene.scene.component.factory.BattleUnitFactory", package.seeall)

local BattleUnitFactory = class("BattleUnitFactory", UnitFactoryBase)

function BattleUnitFactory:addUnit(unit)
	goutil.addChildToParent(unit.go, self._container)

	local tag = unit.teamId
	local sameUnits = self._units[tag]

	if not sameUnits then
		sameUnits = {}
		self._units[tag] = sameUnits
	end

	sameUnits[unit.id] = unit
end

function BattleUnitFactory:getAllCatchableUnit()
	local units = self:getUnits(BattleModel.instance:getEnemyPlayerTeam())

	if not units then
		return
	end

	local targets = {}

	for k, v in pairs(units) do
		if not v.isSourceMon and not v:isDead() then
			table.insert(targets, v)
		end
	end

	return targets
end

function BattleUnitFactory:getBttleUnits(teamId)
	local units = self:getUnits(teamId)

	if not units then
		return
	end

	local battleUnits = {}

	for k, v in pairs(units) do
		if not v.isSourceMon then
			table.insert(battleUnits, v)
		end
	end

	return battleUnits
end

function BattleUnitFactory:getBttleAliveUnits(teamId)
	local units = self:getUnits(teamId)

	if not units then
		return
	end

	local battleUnits = {}

	for k, v in pairs(units) do
		if not v.isSourceMon and not v:isDead() then
			table.insert(battleUnits, v)
		end
	end

	return battleUnits
end

function BattleUnitFactory:removeUnit(unitTag, id)
	local sameUnits = self._units[unitTag]

	if sameUnits then
		local unit = sameUnits[id]

		if unit then
			if unit.onUnitDestroyed then
				unit:onUnitDestroyed()
			end

			unit.isDestroyed = true
			sameUnits[id] = nil

			goutil.destroy(unit.go)
		end
	end
end

function BattleUnitFactory:getAllUnit()
	return self._units
end

function BattleUnitFactory:removeAll()
	for k, v in pairs(self._units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			if v2.onUnitDestroyed then
				v2:onUnitDestroyed()
			end

			v2.isDestroyed = true

			goutil.destroy(v2.go)
		end
	end

	table.clear(self._units)
end

function BattleUnitFactory:buildUnits()
	local teams = BattleModel.instance.originalStates.teams
	local battleId = BattleModel.instance:getBattleId()

	for team, v in pairs(teams) do
		if v.playerView then
			local characterViews = v.playerView.characterViews

			self:_buildCharacters(v.teamId, battleId, characterViews)

			local extCharacterViews = v.playerView.extCharacterViews

			self:_buildCharacters(v.teamId, battleId, extCharacterViews)
		end
	end
end

function BattleUnitFactory:buildSourceMons()
	local battleId = BattleModel.instance:getBattleId()
	local myTeamId = BattleModel.instance.myTeamId
	local enemyTeamId = BattleModel.instance:getEnemyPlayerTeam()

	self:_buildSourceMons(myTeamId, battleId, BattleItemsModel.instance:getSkillPetIds())
	self:_buildSourceMons(enemyTeamId, battleId, BattleItemsModel.instance:getEnemySkillPetIds())
end

function BattleUnitFactory:_buildCharacters(teamId, battleId, characterViews)
	for k, v in ipairs(characterViews) do
		self:updateCharacter(teamId, battleId, v)
	end
end

function BattleUnitFactory:_createCharacter(teamId, battleId, characterView)
	local v = characterView
	local unit = self:getUnit(teamId, v.id)

	if not unit then
		local unitGo = goutil.create(string.format("team%s character%s battleId:%s", teamId, v.id, battleId), false)

		unit = UnitBattleMonster.New(unitGo)
		unit.id = v.id
		unit.teamId = teamId

		unit:Awake()
		self:addUnit(unit)
	end

	unit.fmtIndex = v.y * 3 + v.x + 1
	unit.raceId = v.raceId
	unit.modelId = checknumber(v.curFaceId)

	if checknumber(v.curFaceId) == 0 then
		unit.modelId = checknumber(v.raceId)
	end

	unit.posRow = v.x + 1
	unit.x = v.x
	unit.y = v.y
	unit.zdl = v.zdl
	unit.awakenLv = v.awakenLv

	local spineDir
	local dirTeamId = BattleModel.instance:getTeamDirection(teamId)

	unit.spine:setDirection(dirTeamId == GameEnum.BattleTeam.Left and UnitSpineDir.Right or UnitSpineDir.Left)

	if checknumber(v.oracleMasterId) > 0 then
		unit:setVisible(false)
		unit.attrs:setIsOraclePet(true)
	end

	if checkbool(v.isSpiritInvocationSummonPet) == true then
		unit:setAlpha(0)
		unit.attrs:setIsSpiritInvocationPet(true)
	end

	return unit
end

function BattleUnitFactory:loadCharacter(unit, loadedCallback, loadedCallbackObj)
	local modelCo = CharacterConfig.instance:getModelCo(unit.modelId)

	if modelCo == nil then
		if not Framework.OSDef.isEditor then
			modelCo = CharacterConfig.instance:getModelCo(unit.raceId)
		else
			modelCo = CharacterConfig.instance:getModelCo(10036)

			printError(">>>>>>>>>>>>>>>>>只在电脑上报错 麻烦 配置好 export_模型表  in  m模型配置表.xlsx 【" .. unit.modelId .. "】")
		end
	end

	local url = GameUrl.getSpineUrl(modelCo.resName, modelCo.battleResName)

	if not unit:checkHasLodUrl(url) then
		unit:load(url, function()
			self._scene:updateUnitOnBorn(unit)

			if loadedCallback then
				if loadedCallbackObj then
					loadedCallback(loadedCallbackObj, unit)
				else
					loadedCallback(unit)
				end
			end
		end)
	elseif loadedCallback then
		if loadedCallbackObj then
			loadedCallback(loadedCallbackObj, unit)
		else
			loadedCallback(unit)
		end
	end
end

function BattleUnitFactory:updateCharacter(teamId, battleId, characterView, loadedCallback, loadedCallbackObj)
	local unit = self:_createCharacter(teamId, battleId, characterView)

	if BattleController.instance.preloadModelsOnLoadScene then
		self:loadCharacter(unit, loadedCallback, loadedCallbackObj)
	end
end

function BattleUnitFactory:_buildSourceMons(teamId, battleId, petIds)
	if not petIds then
		return
	end

	for k, v in ipairs(petIds) do
		local petCo = CharacterConfig.instance:getPetCo(v)
		local modelId = checknumber(petCo.faceIds)
		local unitGo = goutil.create(string.format("team%s character%s battleId:%s", teamId, v, battleId), false)
		local unit = UnitBattleSourceMonster.New(unitGo)

		unit:Awake()

		unit.isSourceMon = true
		unit.id = v
		unit.teamId = teamId
		unit.modelId = modelId
		unit.raceId = v
		unit.posRow = -1
		unit.x = -1
		unit.y = -1

		local modelCo = CharacterConfig.instance:getModelCo(unit.modelId)
		local url = GameUrl.getSpineUrl(modelCo.resName, modelCo.battleResName)

		unit:load(url)
		self:addUnit(unit)
	end
end

return BattleUnitFactory
