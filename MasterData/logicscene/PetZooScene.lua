-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/PetZooScene.lua

module("logicscene.scene.impl.PetZooScene", package.seeall)

local PetZooScene = class("PetZooScene", TilingScene)

function PetZooScene:_initComponents()
	self:_addComponent("unitFactory", PetZooSceneUnitFactory)
	self:_addComponent("camera", CitySceneCameraEx)
	self:_addComponent("stage", PetZooSceneStage)
	self:_addComponent("pathFinder", ScenePathFinderEx)
	self:_addComponent("joystick", SceneJoystickListenerEx)
	self:_addComponent("picker", ScenePickerEx)
	self:_addComponent("walkEff", MainPlayerWalkDestEff)
	self:_addComponent("resCache", SceneResObjectCache)
	self:_addComponent("elements", TilingElemsMgr)
	self:_addComponent("bgm", TilingSceneBgmMgr)
end

function PetZooScene:getSceneType()
	return SceneType.PetZoo
end

function PetZooScene:getDefaultView()
	return ViewName.ZooMainView
end

function PetZooScene:_onElementCreate(elementId, path, quality, pos)
	PetZooScene.super._onElementCreate(self, elementId, path, quality, pos)

	if ZooModel.instance:isElemBuilding(elementId) then
		local unit = self.unitFactory:createPetZooBuilding(elementId)

		if unit and unit.onUnitCreated then
			unit:onUnitCreated({
				elementId = elementId,
				pos = pos
			})
		end
	end
end

function PetZooScene:_onElementDestroy(elementId, path, quality)
	if ZooModel.instance:isElemBuilding(elementId) then
		self.unitFactory:destryZooBuilding(elementId)
	end

	PetZooScene.super._onElementDestroy(self, elementId, path, quality)
end

function PetZooScene:onEnterFinished()
	PetZooScene.super.onEnterFinished(self)
	GlobalDispatcher:addListener(GlobalNotify.OnUnlockBuilding, self._onUnlockBuilding, self)
	GlobalDispatcher:addListener(GlobalNotify.OnLevelupBuilding, self._onLevelupBuilding, self)
	GlobalDispatcher:addListener(GlobalNotify.ZooCreatePet, self._onZooCreatePet, self)
	GlobalDispatcher:addListener(GlobalNotify.ZooRemovePet, self._onZooRemovePet, self)
	GlobalDispatcher:addListener(GlobalNotify.ZooGetAnimalsInfo, self._onGetZooAnimalInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooChange, self._onZooChanged, self)
	self.stage.wholeScene:AddTrigger(self:getSceneId(), 1)
	self.stage.wholeScene:AddTrigger(self:getSceneId(), 2)
	self.stage.wholeScene:AddTrigger(self:getSceneId(), 3)
	self.stage.wholeScene:AddTrigger(self:getSceneId(), 4)
	self:_updateCurrZoo()
end

function PetZooScene:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnLevelupBuilding, self._onLevelupBuilding, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnUnlockBuilding, self._onUnlockBuilding, self)
	GlobalDispatcher:removeListener(GlobalNotify.ZooGetAnimalsInfo, self._onGetZooAnimalInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ZooCreatePet, self._onZooCreatePet, self)
	GlobalDispatcher:removeListener(GlobalNotify.ZooRemovePet, self._onZooRemovePet, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooChange, self._onZooChanged, self)
	PetZooScene.super.onExit(self)
end

function PetZooScene:onExitFinished()
	self._currZoo = nil

	local sceneId = self:getSceneId()

	PetZooScene.super.onExitFinished(self)
	TilingSceneMgr.instance:clearTilingSceneConfig(sceneId)
end

function PetZooScene:_updateCurrZoo()
	self._currZoo = ZooModel.instance:getCurrZoo()

	self:_refreshBuildings()
	self:_clearAllAnimals()
	self:_buildAllZooAnimals()
end

function PetZooScene:_onZooCreatePet(petId)
	self:_buildOneZooAnimal(petId)
end

function PetZooScene:_onZooRemovePet(petId)
	if not self._currZoo then
		return
	end

	local petUnit = ZooSceneController.instance:getPetUnit(petId)

	if not petUnit then
		return
	end

	if petUnit or self._currZoo:getLostAnimalMo(petUnit.itemId) == nil then
		self.unitFactory:removeUnit(UnitTag.TilingSceneElem, petUnit.id)
	else
		local units = self.unitFactory:getUnits(UnitTag.TilingSceneElem)

		if not units then
			self.unitFactory:removeUnit(UnitTag.TilingSceneElem, petUnit.id)

			return
		end

		local transpointCo = ZooConfig.instance:getBuildingCoByBuildingType(ZooBuildingType.TransPoint)
		local transUnit = self.unitFactory:getUnit(UnitTag.SceneElement, transpointCo.id)

		if transUnit then
			local x, y = transUnit.transform:getPos()

			petUnit.willRemoved = true

			local moveSpd = petUnit.transform:getMoveSpeed()

			if checknumber(moveSpd) <= 0 then
				moveSpd = 1
			end

			petUnit.transform:setMoveSpeed(moveSpd * 2)
			petUnit:runPath(x, y, function()
				self.unitFactory:removeUnit(UnitTag.TilingSceneElem, petUnit.id)
			end)
		else
			self.unitFactory:removeUnit(UnitTag.TilingSceneElem, petUnit.id)
		end
	end
end

function PetZooScene:_onGetZooAnimalInfoRes()
	self:_clearAllAnimals()
	self:_buildAllZooAnimals()
end

function PetZooScene:_buildAllZooAnimals()
	if not self._currZoo then
		return
	end

	local placeAnimIds = self._currZoo:getPlaceAnimalIds()

	if placeAnimIds and #placeAnimIds > 0 then
		for i = 1, #placeAnimIds do
			self:_buildOneZooAnimal(placeAnimIds[i])
			ZooSceneController.instance:createPet(placeAnimIds[i])
		end
	end

	local lostAnimals = self._currZoo:getLostAnimals()

	if lostAnimals then
		for k, v in pairs(lostAnimals) do
			self:_buildOneZooAnimal(v.animalMo.id)
		end
	end
end

function PetZooScene:_buildOneZooAnimal(id)
	if not self._currZoo then
		return
	end

	if self:_isAnimalExist(id) then
		return
	end

	local animMo = self._currZoo:getAnimalById(id) or self._currZoo:getLostAnimalMo(id)

	if not animMo then
		return
	end

	local animCo = ZooConfig.instance:getAnimalById(animMo.raceId)
	local avatarMo = AvatarZooMo.New(animCo.skeletonId)

	avatarMo:setDataByAnimalMo(animMo)

	local params = {
		moveSpeed = 1,
		zoneId = 1,
		tag = "zooAnimal",
		motion = true,
		itemId = id,
		avatarMo = avatarMo,
		hud = {
			clsName = "hud",
			name = animMo.name,
			offset = {
				0,
				1,
				0
			},
			cls = UnitCompHudZooAnimal
		}
	}

	self.unitFactory:createAvatarElemByConfig(params)
end

function PetZooScene:_isAnimalExist(id)
	return ZooSceneController.instance:getPetUnit(id) ~= nil
end

function PetZooScene:_clearAllAnimals()
	local scene = SceneMgr.instance:getCurScene()
	local units = scene.unitFactory:getUnits(UnitTag.TilingSceneElem)

	if not units then
		return
	end

	local temps = table.values(units)

	for i = 1, #temps do
		if temps[i].getUnitTag and temps[i]:getUnitTag() == "zooAnimal" then
			self.unitFactory:removeUnit(UnitTag.TilingSceneElem, temps[i].id)
		end
	end
end

function PetZooScene:_onZooChanged(userId)
	if userId == RoleModel.instance:getUserId() then
		FloatWordMgr.instance:show(lang("petzoo_comeback_home"))
	else
		local friendMo = FriendModel.instance:getFriendMo(userId)

		FloatWordMgr.instance:show(string.format(lang("petzoo_goto_fiend_home"), friendMo:getValue("name")))
	end

	self:_updateCurrZoo()
end

function PetZooScene:_refreshBuildings()
	if not self._currZoo then
		self:_resetBuildings()

		return
	end

	local buildings = self._currZoo:getBuildings()

	for k, v in pairs(buildings) do
		local unit = self.unitFactory:getUnit(UnitTag.SceneElement, v:getBuildingId())

		if unit then
			unit:setBuildingMO(v)
		end
	end
end

function PetZooScene:_resetBuildings()
	local units = self.unitFactory:getUnits(UnitTag.SceneElement)

	if not units then
		return
	end

	for k, v in pairs(units) do
		if ZooModel.instance:isElemBuilding(k) then
			v:setBuildingMO(nil)
		end
	end
end

function PetZooScene:_onUnlockBuilding(buildingId)
	local building = self.unitFactory:getUnit(UnitTag.SceneElement, buildingId)
	local buildingMo

	building:setBuildingMO((self._currZoo or nil) and self._currZoo:getBuildingById(buildingId))
end

function PetZooScene:_onLevelupBuilding(buildingType)
	self:_refreshBuildings()
end

return PetZooScene
