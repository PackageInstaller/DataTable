-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/cutepet/UnitTravelCutePet.lua

module("logicscene.scene.unit.impl.cutepet.UnitTravelCutePet", package.seeall)

local UnitTravelCutePet = class("UnitTravelCutePet", SceneUnitBase)
local typeOfBoxCollider = typeof(UnityEngine.BoxCollider)

function UnitTravelCutePet:Awake()
	UnitTravelCutePet.super.Awake(self)
	self.spine:addListener(UnitNotify.SpineLoaded, self._onPlayerBodyLoaded, self)
end

function UnitTravelCutePet:getTag()
	return UnitTag.Npc
end

function UnitTravelCutePet:getLayer()
	return SceneLayer.Unit_Value
end

function UnitTravelCutePet:getAvatarName()
	return "UnitTravelCutePet_" .. self.id
end

function UnitTravelCutePet:update(deltaTime)
	self.actions:update(deltaTime)
	self.transform:updateRoatationY(deltaTime)

	self._runTime = (self._runTime or 0) + deltaTime

	if self._isStartTravel == true then
		if (self._targetTime or 5) < self._runTime then
			GlobalDispatcher:dispatch(GlobalNotify.CutePetTravelEndOnScene, self.id)

			self._runTime = 0
			self._isStartTravel = false
		end
	end
end

function UnitTravelCutePet:_initComponents()
	UnitTravelCutePet.super._initComponents(self)
	self:_addComponent("spine", UnitCompCutePetAvatar)
	self:_addComponent("spineMover", UnitCompCutePetMover)
	self:_addComponent("shadow", UnitCompShadowOther)
	self:_addComponent("transform", UnitCompCutePetTransform)
end

function UnitTravelCutePet:onUnitCreated(params)
	self.transform:setPos(params.posX, 0, params.posY)
	self.transform:setScale(10)

	self._isMotion = false

	if self._isMotion then
		self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	end

	self._avatarPartIds = {}

	local raceCfg = CutePetConfig.instance:getCutePetById(self.petId)

	self.spineMover:playDefaultIdleAnim()
	self.transform:setMoveSpeed(17)

	if self._isMotion then
		self._wholeScene = self.scene.stage.wholeScene

		self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
	end

	self.shadow:setLocalPos(nil, -0.05)
	self.shadow:setLocalRotation(90)

	self._runTime = 0
	self._targetTime = 3
end

function UnitTravelCutePet:onUnitDestroyed()
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

function UnitTravelCutePet:onUnitVisible(go)
	self._isClipping = nil

	self:updateModel()
end

function UnitTravelCutePet:onUnitInVisible(go)
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

function UnitTravelCutePet:updateModel()
	if self._isClipping then
		return
	end

	if self.spine and self._avatarPartIds then
		local config = CutePetConfig.instance:getCutePetById(self.petId)
		local avatarPetMo = AvatarConfig.instance:getAvatarMoByCfgId(config.modelId)

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

function UnitTravelCutePet:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	return
end

function UnitTravelCutePet:getOwner()
	return self._owner
end

function UnitTravelCutePet:SetAvatarData(newData)
	return
end

function UnitTravelCutePet:_onPlayerBodyLoaded()
	local go = self.spine:getAvatarGo()

	go.name = self:getAvatarName()

	local go = self.spine:getAvatarGo()

	if go then
		UnitTravelCutePet.super.onUnitVisible(self, go)
	end
end

function UnitTravelCutePet:getTalkingOffset()
	return 0, 1.1, 0
end

function UnitTravelCutePet:getUnitHudType()
	return SceneHudMgr.HUD_NPC
end

function UnitTravelCutePet:setPatrolArea(minX, maxX, minZ, maxZ)
	self._patrolMinX = minX
	self._patrolMaxX = maxX
	self._patrolMinZ = minZ
	self._patrolMaxZ = maxZ
end

function UnitTravelCutePet:setPatrolArea(patrolArea)
	self._patrolMinX = patrolArea.minX
	self._patrolMaxX = patrolArea.maxX
	self._patrolMinZ = patrolArea.minZ
	self._patrolMaxZ = patrolArea.maxZ
end

function UnitTravelCutePet:setMovePath(targetPaths)
	self.actions:stopAllActions()

	local posX, posY, posZ = self.transform:getPos()
	local paths = {}

	table.insert(paths, {
		stayMin = 0.6,
		stayMax = 0.6,
		x = posX,
		y = posZ
	})

	for i, v in ipairs(targetPaths) do
		table.insert(paths, v)
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

	self._targetTime = totalDist / self.transform:getMoveSpeed() + stayTime - 0.5
	self._runTime = 0
	self._isStartTravel = true
	self._curPathInfo = {
		startX = posX,
		startY = posZ,
		paths = paths,
		len = #paths
	}
end

function UnitTravelCutePet:_runNpcPath(startX, startY, paths, len, reverse)
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

function UnitTravelCutePet:runNpcPathBySetRoad()
	if self._curPathInfo then
		self._runTime = 0

		UnityTweens.TweenScale.StartTween(self.go, Vector3.New(10, 10, 10), Vector3.New(10, 10, 10), self._targetTime, UnityTweens.EaseType.easeInCubic, 0.1)
		self:_runNpcPath(self._curPathInfo.startX, self._curPathInfo.startY, self._curPathInfo.paths, self._curPathInfo.len, false)
	end
end

function UnitTravelCutePet:setMovePathAndRun(targetPaths)
	self:setMovePath(targetPaths)
	self:runNpcPathBySetRoad()
end

function UnitTravelCutePet:_buildNpcActions(startX, startY, paths, len)
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

return UnitTravelCutePet
