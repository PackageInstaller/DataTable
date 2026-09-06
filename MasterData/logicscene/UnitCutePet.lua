-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/cutepet/UnitCutePet.lua

module("logicscene.scene.unit.impl.cutepet.UnitCutePet", package.seeall)

local UnitCutePet = class("UnitCutePet", SceneUnitBase)
local typeOfBoxCollider = typeof(UnityEngine.BoxCollider)

function UnitCutePet:Awake()
	UnitCutePet.super.Awake(self)
	self.spine:addListener(UnitNotify.SpineLoaded, self._onPlayerBodyLoaded, self)
end

function UnitCutePet:getTag()
	return UnitTag.Pet
end

function UnitCutePet:getLayer()
	return SceneLayer.Unit_Value
end

function UnitCutePet:getAvatarName()
	return "UnitCutePet_" .. self.id
end

function UnitCutePet:update(deltaTime)
	self.actions:update(deltaTime)
	self.transform:updateRoatationY(deltaTime)

	self._runTime = (self._runTime or 0) + deltaTime

	if (self._targetTime or 5) < self._runTime then
		self:getNextMovePath()

		self._runTime = 0
	end
end

function UnitCutePet:_initComponents()
	UnitCutePet.super._initComponents(self)
	self:_addComponent("spine", UnitCompCutePetAvatar)
	self:_addComponent("spineMover", UnitCompCutePetMover)
	self:_addComponent("shadow", UnitCompShadowOther)
	self:_addComponent("transform", UnitCompCutePetTransform)
	self:_addComponent("hud", UnitCompHudCutePet)
end

function UnitCutePet:onUnitCreated(params)
	self.transform:setPos(params.posX, 0, params.posY)
	self.transform:setScale(10)

	self._isMotion = false

	if self._isMotion then
		self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	end

	self._avatarPartIds = {}
	self._mo = CutePetModel.instance:getCutePeMo(self.id) or {}
	self._petName = self._mo.name

	self.spineMover:playDefaultIdleAnim()
	self.transform:setMoveSpeed(10)

	if self._isMotion then
		self._wholeScene = self.scene.stage.wholeScene

		self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
	end

	self.shadow:setLocalPos(nil, -0.05)
	self.shadow:setLocalRotation(90)

	self._runTime = 0
	self._targetTime = 5
end

function UnitCutePet:onUnitDestroyed()
	self.spine:removeListener(UnitNotify.SpineLoaded, self._onPlayerBodyLoaded, self)

	if self._isMotion then
		self.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	end

	if self.go then
		goutil.destroy(self.go)

		self.go = nil
	end

	self._avatarPartIds = nil
	self._wholeScene = nil

	self.actions:stopAllActions()
	self:clearSceneUnit()
	self:OnDestroy()
end

function UnitCutePet:onUnitVisible(go)
	self._isClipping = nil

	self:updateModel()
end

function UnitCutePet:onUnitInVisible(go)
	self._gameObject = nil
	self._isClipping = true

	if self._compList then
		local cnt = #self._compList

		for i = 1, cnt do
			local comp = self._compList[i]

			if comp.onUnitInVisible then
				comp:onUnitInVisible(go)
			end
		end
	end
end

function UnitCutePet:updateModel()
	if self._isClipping then
		return
	end

	if self.spine then
		if self._avatarPartIds then
			local mo = CutePetModel.instance:getCutePeMo(self.id)

			if mo then
				local avatarPetMo = AvatarConfig.instance:getAvatarMoByCfgId(mo.config.modelId)

				for k, v in pairs(self._avatarPartIds) do
					local cfg = PigraiseConfig.instance:getModelinfoCfgById(self.petId, k, v)

					if cfg and cfg.partId and cfg.partId > 0 then
						avatarPetMo:setDataByCfgId(cfg.partId)
					end
				end

				self.spine:setBody(avatarPetMo)
				self.spine:onUnitVisible()
			end
		end

		if self.scene:getSceneType() == SceneType.CutePet then
			self.spine:changeGardenState(true)
		else
			self.spine:changeGardenState(false)
		end
	end
end

function UnitCutePet:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	return
end

function UnitCutePet:getOwner()
	return self._owner
end

function UnitCutePet:SetAvatarData(newData)
	return
end

function UnitCutePet:_onPlayerBodyLoaded()
	local go = self.spine:getAvatarGo()

	go.name = self:getAvatarName()

	local go = self.spine:getAvatarGo()

	if go then
		UnitCutePet.super.onUnitVisible(self, go)
	end
end

function UnitCutePet:getTalkingOffset()
	return 0, 1.1, 0
end

function UnitCutePet:getUnitHudType()
	return SceneHudMgr.HUD_NPC
end

function UnitCutePet:getUnitName()
	if self._mo then
		return self._mo.name
	else
		return self._petName
	end
end

function UnitCutePet:setPatrolArea(minX, maxX, minZ, maxZ)
	self._patrolMinX = minX
	self._patrolMaxX = maxX
	self._patrolMinZ = minZ
	self._patrolMaxZ = maxZ
end

function UnitCutePet:setPatrolArea(patrolArea)
	self._patrolMinX = patrolArea.minX
	self._patrolMaxX = patrolArea.maxX
	self._patrolMinZ = patrolArea.minZ
	self._patrolMaxZ = patrolArea.maxZ
end

function UnitCutePet:getNextMovePath()
	self.actions:stopAllActions()

	local posX, posY, posZ = self.transform:getPos()
	local paths = {}
	local randomStep = 1

	for i = 1, randomStep do
		table.insert(paths, {
			stayMin = 10,
			stayMax = 10,
			x = math.random(self._patrolMinX, self._patrolMaxX),
			y = math.random(self._patrolMinZ, self._patrolMaxZ)
		})
	end

	local totalDist = 0
	local stayTime = 0
	local lastX = posX
	local lastZ = posZ

	for i, v in ipairs(paths) do
		local dx = v.x - lastX
		local dz = v.y - lastZ
		local dist = math.sqrt(dx * dx + dz * dz)

		totalDist = totalDist + dist
		stayTime = stayTime + v.stayMax
		lastX = v.x
		lastZ = v.y
	end

	self._targetTime = totalDist / self.transform:getMoveSpeed() + stayTime + math.random(3, 5)

	self:_runNpcPath(posX, posZ, paths, #paths, false)
end

function UnitCutePet:_runNpcPath(startX, startY, paths, len, reverse)
	local actions = self:_buildNpcActions(startX, startY, paths, len)
	local sequence

	if reverse then
		sequence = UnitActionSequence.New(actions)

		local reverse = sequence:reverse()

		actions = {
			sequence,
			reverse
		}
		sequence = UnitActionSequence.New(actions, true)
	else
		sequence = UnitActionSequence.New(actions, true)
	end

	self.actions:runAction(sequence)
end

function UnitCutePet:_buildNpcActions(startX, startY, paths, len)
	local actions = {}
	local idx = 1
	local duration, pathNode

	for i = 1, len do
		actions[idx] = UnitActionMoveToXZ.New(paths[i].x, paths[i].y, startX, startY)
		idx = idx + 1
		startY = paths[i].y
		startX = paths[i].x

		if paths[i].stayMax > 0 then
			actions[idx] = UnitActionEmpty.New((math.random(paths[i].stayMin, paths[i].stayMax)))
			idx = idx + 1
		end
	end

	return actions
end

function UnitCutePet:hidePet(bool)
	return
end

return UnitCutePet
