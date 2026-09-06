-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/cutepet/SceneCompCutePetMgr.lua

module("logicscene.scene.component.cutepet.SceneCompCutePetMgr", package.seeall)

local SceneCompCutePetMgr = class("SceneCompCutePetMgr", SceneComponentBase)

function SceneCompCutePetMgr:onInit()
	self._cutePetUnitMap = {}
	self._cutePetCount = 0
	self._tempNpcCreateIndex = 1
end

function SceneCompCutePetMgr:onEnterScene(sceneId, bornX, bornZ)
	SceneCompCutePetMgr.super.onEnterScene(self, sceneId, bornX, bornZ)
end

function SceneCompCutePetMgr:onExitScene()
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_SetCutePetGardenShowStateResp, self._onShowOrHidePet, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_ReleaseCutePetResp, self._onShowOrHidePet, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_NotifyCutePetChangedResp, self._onShowOrHidePet, self)
end

function SceneCompCutePetMgr:onEnterSceneFinished(sceneId, bornX, bornZ)
	self.patrolArea = {
		minZ = -70,
		maxX = 36,
		maxZ = -31,
		minX = -25
	}

	self:buildAllPet()
	GlobalDispatcher:addListener(GlobalNotify.handlePM_SetCutePetGardenShowStateResp, self._onShowOrHidePet, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_ReleaseCutePetResp, self._onShowOrHidePet, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_NotifyCutePetChangedResp, self._onShowOrHidePet, self)
end

function SceneCompCutePetMgr:_onShowOrHidePet(cutePetIds)
	for i, cutePetId in ipairs(cutePetIds) do
		local cutePetMo = CutePetModel.instance:getCutePeMo(cutePetId)

		if cutePetMo and cutePetMo:getState(CutePetMo.STATE_GARDEN_SHOW) then
			self:tryCreatePet(cutePetMo)
		else
			self._scene.unitFactory:removeUnit(UnitTag.Pet, cutePetId)

			if self._cutePetUnitMap[cutePetId] then
				self._cutePetCount = math.max(0, self._cutePetCount - 1)
			end

			self._cutePetUnitMap[cutePetId] = nil
		end
	end
end

function SceneCompCutePetMgr:buildAllPet()
	local map = CutePetModel.instance:getAllCutePet()

	if map then
		for k, cutePetMo in pairs(map) do
			if cutePetMo and cutePetMo:getState(CutePetMo.STATE_GARDEN_SHOW) then
				self:tryCreatePet(cutePetMo)
			end
		end
	end
end

function SceneCompCutePetMgr:hideAllPet()
	for k, unit in pairs(self._cutePetUnitMap) do
		self._isHideing = true

		unit:onUnitInVisible(unit.go)
	end
end

function SceneCompCutePetMgr:showAllPet()
	for k, unit in pairs(self._cutePetUnitMap) do
		self._isHideing = false

		unit:onUnitVisible(unit.go)
	end
end

function SceneCompCutePetMgr:tryCreatePet(cutePetMo)
	local CUTEPET_IN_GARDEN_SCENE_MAX_COUNT = CutePetModel.instance.CUTEPET_IN_GARDEN_SCENE_MAX_COUNT

	self._cutePetUnitMap = self._cutePetUnitMap or {}

	if CUTEPET_IN_GARDEN_SCENE_MAX_COUNT > self._cutePetCount then
		local unit = self._scene.unitFactory:createPetUnit(cutePetMo:getId(), cutePetMo:getDefineId())

		self:randomPosUnit(unit)

		self._cutePetUnitMap[cutePetMo:getId()] = unit
		self._cutePetCount = self._cutePetCount + 1

		if self._isHideing and self._isHideing == true then
			unit:onUnitInVisible(unit.go)
		end
	end
end

function SceneCompCutePetMgr:refreshPetUI()
	for i, unit in pairs(self._cutePetUnitMap) do
		unit.hud:refreshHudView()
	end
end

function SceneCompCutePetMgr:randomPosUnit(unit)
	if unit and unit.onUnitCreated then
		local params = {}

		params.posX = math.random(self.patrolArea.minX, self.patrolArea.maxX)
		params.posY = math.random(self.patrolArea.minZ, self.patrolArea.maxZ)

		unit:onUnitCreated(params)
		unit:setPatrolArea(self.patrolArea)
		unit:getNextMovePath()
		unit:onUnitVisible()
	end
end

function SceneCompCutePetMgr:getPatrolArea()
	return self.patrolArea
end

function SceneCompCutePetMgr:createTravelCutePet(raceId, path, birthPos)
	local unit, id

	self._tempNpcCreateIndex = self._tempNpcCreateIndex + 1
	unit = self._scene.unitFactory:createTravelCutePet(self._tempNpcCreateIndex, raceId)

	local params = {}

	params.posX = birthPos.x
	params.posY = birthPos.z

	unit:onUnitCreated(params)
	unit:setMovePath(path)
	unit:onUnitVisible()

	return unit, self._tempNpcCreateIndex
end

function SceneCompCutePetMgr:removeTravelCutePet(tempId)
	self._scene.unitFactory:removeUnit(UnitTag.Npc, tempId)
end

function SceneCompCutePetMgr:travelPetRun(tempId)
	local unit = self._scene.unitFactory:getUnit(UnitTag.Npc, tempId)

	if unit then
		unit:runNpcPathBySetRoad()
	end
end

return SceneCompCutePetMgr
