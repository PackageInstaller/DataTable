-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/factory/CityUnitFactory.lua

module("logicscene.scene.component.factory.CityUnitFactory", package.seeall)

local CityUnitFactory = class("CityUnitFactory", UnitFactoryBase)
local objectInstanceId = -1

CityUnitFactory.UnitSpecialElement = "UnitSpecElem_"
CityUnitFactory.UnitMainPlayerPet = "UnitMainPlayerPet_"
CityUnitFactory.UnitPlayerZoo = "UnitPlayerZoo_"
CityUnitFactory.UnitCommomElem = "UnitCommomElem_"
CityUnitFactory.UnitCommomAvatarElem = "UnitCommomAvatarElem_"

function CityUnitFactory:ctor(scene)
	CityUnitFactory.super.ctor(self, scene)
end

function CityUnitFactory:onInit()
	CityUnitFactory.super.onInit(self)
end

function CityUnitFactory:getAllUnit()
	return self._units
end

function CityUnitFactory:onEnterScene(sceneId, bornX, bornZ)
	CityUnitFactory.super.onEnterScene(self, sceneId, bornX, bornZ)
end

function CityUnitFactory:onExitSceneFinished()
	self:removeAll()
end

function CityUnitFactory:removeUnit(unitTag, id)
	if self._elemsConfigs then
		self._elemsConfigs[id] = nil
	end

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

function CityUnitFactory:removeAll()
	for k, v in pairs(self._units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			if self._elemsConfigs then
				self._elemsConfigs[k2] = nil
			end

			if v2.onUnitDestroyed then
				v2:onUnitDestroyed()
			end

			v2.isDestroyed = true

			goutil.destroy(v2.go)

			sameUnits[k2] = nil
		end

		self._units[k] = nil
	end
end

function CityUnitFactory:showUnitsByTag(tag, show)
	local sameUnits = self._units[tag]

	if sameUnits then
		for k, v in pairs(sameUnits) do
			if v then
				v:setVisible(show)
			end
		end
	end
end

function CityUnitFactory:showUnits(show)
	for k, v in pairs(self._units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			v2:setVisible(show)
		end
	end
end

function CityUnitFactory:showUnit(tag, id, show)
	local sameUnits = self._units[tag]

	if sameUnits then
		local unit = sameUnits[id]

		if unit then
			unit:setVisible(show)
		end
	end
end

function CityUnitFactory:createNpcById(npcId)
	local unitNpc = self:getUnit(UnitTag.Npc, npcId)

	if not unitNpc then
		self._scene.stage.wholeScene:CreateNpc(npcId)

		return self:getUnit(UnitTag.Npc, npcId)
	end

	return unitNpc
end

function CityUnitFactory:destroyNpcById(npcId)
	self._scene.stage.wholeScene:DestroyNpc(npcId)
end

function CityUnitFactory:createNpcUnit(npcId)
	local npcCo = SceneConfig.instance:getNpcCo(npcId)

	if not npcCo then
		printInfo(npcId)

		return
	end

	local unitGo = goutil.create("NPC_" .. npcId, false)
	local unit = UnitNpc.New(unitGo)

	unit.scene = self._scene

	unit:Awake()

	unit.radius = npcCo.radius
	unit.id = npcId
	unit.npcId = npcId

	self:addUnit(unit)

	return unit
end

function CityUnitFactory:createOtherPlayer(mo)
	local unitPlayer = self:getUnit(UnitTag.Player, mo.id)

	if not unitPlayer then
		self._scene.stage.wholeScene:CreatePlayer(mo.id, nil, mo.x, mo.y, mo.scale or 1, mo.boundX or 3, mo.boundY or 5)
	end
end

function CityUnitFactory:destroyOtherPlayer(playerId)
	self._scene.stage.wholeScene:DestroyPlayer(playerId)
end

function CityUnitFactory:createOtherPlayerUnit(userId)
	local unitGo = goutil.create("Player_" .. userId, false)
	local unit = UnitOtherPlayer.New(unitGo)

	unit.scene = self._scene

	unit:Awake()

	unit.radius = 0.3
	unit.id = userId

	self:addUnit(unit)

	return unit
end

function CityUnitFactory:createMonster(zoneId, mstId)
	local petId = SceneConfig.instance:getMonsterPetId(mstId)
	local petCo = CharacterConfig.instance:getPetCo(petId)

	if petCo then
		local insId = self:generateObjectInstanceId()
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))

		if modelCo then
			local resPath = modelCo.followResName

			if not resPath or #resPath == 0 then
				resPath = modelCo.resName
			end

			resPath = GameUrl.getSpineUrl(resPath)

			local cfgCo = SceneConfig.instance:getMonsterConfigCo(mstId)
			local scale = 0.3
			local speed = 0
			local boundsX = 3
			local boundsY = 5

			if cfgCo then
				scale = cfgCo.scale or 1
				speed = cfgCo.speed
				bounds = cfgCo.bounds

				if bounds and #bounds > 0 then
					boundsX = bounds[1]
					boundsY = bounds[1]
				end

				if scale == 0 then
					scale = 1
				end

				if boundsX == 0 then
					boundsX = 3
				end

				if boundsY == 0 then
					boundsY = 5
				end
			end

			self._scene.stage.wholeScene:CreateMonster(zoneId, insId, mstId, resPath, boundsX, boundsY, scale, speed > 0)
		end
	end
end

function CityUnitFactory:createMonsterUnit(insId, mstId, zoneId)
	local petId = SceneConfig.instance:getMonsterPetId(mstId)
	local petCo = CharacterConfig.instance:getPetCo(petId)
	local unitGo = goutil.create("Monster_" .. insId, false)
	local unit = UnitSceneMonster.New(unitGo)

	unit.scene = self._scene

	unit:Awake()

	local cfgCo = SceneConfig.instance:getMonsterConfigCo(mstId)

	unit.radius = cfgCo and cfgCo.radius and cfgCo.radius > 0 and cfgCo.radius or 1
	unit.id = insId
	unit.monsterId = mstId
	unit.modelId = checknumber(petCo.faceIds)
	unit.zoneId = zoneId

	self:addUnit(unit)

	return unit
end

function CityUnitFactory:destroyMonsterById(instanceId)
	self._scene.stage.wholeScene:DestroyMonster(instanceId)
end

function CityUnitFactory:generateObjectInstanceId()
	objectInstanceId = objectInstanceId - 1

	if objectInstanceId >= 0 then
		objectInstanceId = -1
	end

	return objectInstanceId
end

function CityUnitFactory:getInstanceId()
	return objectInstanceId
end

function CityUnitFactory:createMainPlayerPet(posX, posY)
	local raceId = 10140
	local insId = self:generateObjectInstanceId()
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))
	local scale = 0.15
	local boundsX = 3
	local boundsY = 5

	self._scene.stage.wholeScene:CreateCommonObject(UnitTag.Pet, insId, raceId, resPath, posX, posY, boundsX, boundsY, scale, true, CityUnitFactory.UnitMainPlayerPet)

	return (self:getUnit(UnitTag.Pet, insId))
end

function CityUnitFactory:createUnitPet(itemId, posX, posY, usrData)
	local insId = self:generateObjectInstanceId()
	local scale = 1
	local speed = ConstConfig.instance:getNumValueByKey("PetFollowSpeed")
	local boundsX = 3
	local boundsY = 5

	self._scene.stage.wholeScene:CreateCommonObject(UnitTag.Pet, insId, itemId, nil, posX, posY, boundsX, boundsY, scale, speed > 0, usrData)
end

function CityUnitFactory:createSpecialElement(itemId, resName, posX, posY, addParam)
	local insId = self:generateObjectInstanceId()

	if not resName or #resName == 0 then
		print("not exit res" .. resName)

		return
	end

	local resPath = GameUrl.getSceneMiscUrl(resName)
	local scale = 1
	local boundsX = 3
	local boundsY = 5
	local usrData = CityUnitFactory.UnitSpecialElement

	usrData = addParam and usrData .. tostring(itemId) .. tostring(addParam) or usrData .. tostring(itemId)

	self._scene.stage.wholeScene:CreateCommonObject(UnitTag.SceneElement, insId, itemId, resPath, posX, posY, boundsX, boundsY, scale, false, usrData)
end

function CityUnitFactory:createElemByConfig(params)
	local insId = self:generateObjectInstanceId()
	local resPath = params.resPath

	if not params.itemId then
		if not params.scale then
			local scale = 1

			if scale == 0 then
				scale = 1
			end

			local boundsX = 5
			local boundsY = 5

			if not params.zoneId then
				local zoneId = 0
				local posX, posY = self._scene.stage.wholeScene:GetRandomWalkablePosInZone(nil, zoneId, nil, nil)

				self._elemsConfigs = self._elemsConfigs or {}
				self._elemsConfigs[insId] = params

				self._scene.stage.wholeScene:CreateCommonObject(UnitTag.TilingSceneElem, insId, params.itemId, resPath, posX, posY, boundsX, boundsY, scale, params.motion or false, CityUnitFactory.UnitCommomElem)

				return self:getUnit(UnitTag.TilingSceneElem, insId)
			end
		end
	end
end

function CityUnitFactory:createAvatarElemByConfig(params)
	local insId = self:generateObjectInstanceId()

	if not params.itemId then
		if not params.scale then
			local scale = 1

			if scale == 0 then
				scale = 1
			end

			local boundsX = 5
			local boundsY = 5

			if not params.zoneId then
				local zoneId = 0
				local posX, posY = self._scene.stage.wholeScene:GetRandomWalkablePosInZone(nil, zoneId, nil, nil)

				self._elemsConfigs = self._elemsConfigs or {}
				self._elemsConfigs[insId] = params

				self._scene.stage.wholeScene:CreateCommonObject(UnitTag.TilingSceneElem, insId, params.itemId, nil, posX, posY, boundsX, boundsY, scale, params.motion or false, CityUnitFactory.UnitCommomAvatarElem)

				return self:getUnit(UnitTag.TilingSceneElem, insId)
			end
		end
	end
end

function CityUnitFactory:createTilingElem(elemData)
	local elemDataCo = elemData.elemData
	local insId = self:generateObjectInstanceId()
	local resPath = elemDataCo.assetPath .. ".prefab"

	if not elemDataCo.scale then
		local scale = 1

		if scale == 0 then
			scale = 1
		end

		local boundsX = 3
		local boundsY = 5
		local sceneConfig = TilingSceneMgr.instance:getTilingMapConfig(self._scene:getSceneId())
		local pos = elemData.position

		if not pos then
			if elemDataCo.scene == TilingElemScene.Exitrance then
				pos = sceneConfig.tansPoint
			elseif elemDataCo.scene == TilingElemScene.Box or elemDataCo.scene == TilingElemScene.HugeBox then
				local x, y = self._scene.stage:getBirthPos()
				local found, posX, posY = self._scene.stage.wholeScene:FindNotBerrierAround(nil, x, y, false, nil, nil)

				if not found then
					posX = x
					posY = y
				end

				pos = Vector2.New(x, y)
			else
				pos = sceneConfig:GetRandomElemPos()
			end

			elemData.position = pos
		end

		self._scene.stage.wholeScene:CreateCommonObject(UnitTag.TilingSceneElem, insId, elemDataCo.id, resPath, pos.x, pos.y, boundsX, boundsY, scale, elemDataCo.speed > 0, nil, elemDataCo.layer)

		local unit = self:getUnit(UnitTag.TilingSceneElem, insId)

		unit.elemData = elemData

		return unit
	end
end

function CityUnitFactory:destroyCommonObject(objectTag, insId)
	self:removeUnit(objectTag, insId)
	self._scene.stage.wholeScene:DestroyCommonObject(objectTag, insId)

	if self._elemsConfigs then
		self._elemsConfigs[insId] = nil
	end
end

function CityUnitFactory:createCommonObjectUnit(tag, insId, itemId, usrData)
	if tag == UnitTag.Pet then
		if CityUnitFactory.UnitMainPlayerPet == usrData then
			return self:_createMainPlayerUnit(insId, itemId, usrData)
		end

		if string.find(usrData, CityUnitFactory.UnitPlayerZoo) then
			return self:_createPlayerZooUnit(insId, itemId, usrData)
		end

		return self:_createPetUnit(insId, itemId, usrData)
	end

	if tag == UnitTag.SceneElement and string.find(usrData, CityUnitFactory.UnitSpecialElement) then
		return self:_createSpecialElement(insId, itemId, usrData)
	end

	if tag == UnitTag.TilingSceneElem then
		if usrData == CityUnitFactory.UnitCommomElem then
			if self._elemsConfigs then
				if not self._elemsConfigs[insId] then
					do
						local cfg

						return self:_createCommomElement(insId, itemId, cfg)
					end

					if usrData == CityUnitFactory.UnitCommomAvatarElem then
						if self._elemsConfigs then
							if not self._elemsConfigs[insId] then
								local cfg

								return self:_createCommomAvatarElement(insId, itemId, cfg)
							end
						end
					end
				end
			end
		end

		return self:_createTilingElement(insId, itemId, usrData)
	end
end

function CityUnitFactory:_createPetUnit(insId, itemId, usrData)
	local unitGo = goutil.create("UnitPet_" .. insId, false)
	local unit = UnitPet.New(unitGo)

	unit.scene = self._scene

	unit:Awake()

	unit.radius = 1
	unit.id = insId
	unit.petId = itemId
	unit.userData = usrData

	self:addUnit(unit)

	return unit
end

function CityUnitFactory:_createPlayerZooUnit(insId, itemId, usrData)
	local unitGo = goutil.create("UnitZoo_" .. insId, false)
	local unit = UnitZoo.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.id = insId
	unit.petId = itemId
	unit.userData = usrData

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function CityUnitFactory:_createMainPlayerUnit(insId, itemId, usrData)
	local unitGo = goutil.create(CityUnitFactory.UnitMainPlayerPet .. insId, false)
	local unit = UnitMainPlayerPet3D.New(unitGo)

	unit.scene = self._scene

	unit:Awake()

	unit.radius = 1

	local petCo = CharacterConfig.instance:getPetCo(itemId)

	unit.id = insId
	unit.raceId = itemId
	unit.userData = usrData

	self:addUnit(unit)

	return unit
end

function CityUnitFactory:_createSpecialElement(insId, itemId, usrData)
	local name = CityUnitFactory.UnitSpecialElement .. tostring(itemId)
	local addParam = string.sub(usrData, string.len(name) + 1)
	local unitGo = goutil.create(name, false)
	local unit = UnitSpecialElement.New(unitGo, addParam)

	unit.scene = self._scene

	unit:Awake()

	unit.id = insId

	self:addUnit(unit)

	return unit
end

function CityUnitFactory:_createCommomElement(insId, itemId, params)
	local name = UnitTag.TilingSceneElem .. tostring(insId)
	local unitGo = goutil.create(name, false)
	local unit = SceneUnitModel.New(unitGo, params)

	unit.scene = self._scene
	unit.itemId = itemId

	unit:Awake()

	unit.id = insId

	self:addUnit(unit)

	return unit
end

function CityUnitFactory:_createCommomAvatarElement(insId, itemId, params)
	local name = UnitTag.TilingSceneElem .. tostring(insId)
	local unitGo = goutil.create(name, false)
	local unit = UnitCommonAvatar.New(unitGo, params)

	unit.scene = self._scene
	unit.itemId = itemId

	unit:Awake()

	unit.id = insId

	self:addUnit(unit)

	return unit
end

function CityUnitFactory:_createTilingElement(insId, itemId, usrData)
	local name = UnitTag.TilingSceneElem .. "_" .. tostring(insId)
	local unitGo = goutil.create(name, false)
	local unit = UnitTilingElem.New(unitGo)

	unit.scene = self._scene

	unit:Awake()

	unit.id = insId
	unit.itemId = itemId

	self:addUnit(unit)

	return unit
end

return CityUnitFactory
