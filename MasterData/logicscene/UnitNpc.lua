-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/UnitNpc.lua

module("logicscene.scene.unit.impl.UnitNpc", package.seeall)

local UnitNpc = class("UnitNpc", SceneUnitBase)

function UnitNpc:getTag()
	return UnitTag.Npc
end

function UnitNpc:getLayer()
	return SceneLayer.Unit_Value
end

function UnitNpc:_initComponents()
	UnitNpc.super._initComponents(self)
	self:_addComponent("hudTask", UnitCompHudTask)
	self:_addComponent("shadow", UnitCompShadowOther)
	self:_addComponent("hud", UnitCompHudCommon)
	self:_addComponent("talking", UnitCompHudTalking)
	self:_addComponent("npcEffects", UnitCompEffects)
end

function UnitNpc:update(deltaTime)
	self.actions:update(deltaTime)
	self.transform:updateRoatationY(deltaTime)

	if self.greet then
		self.greet:update(deltaTime)
	end

	if self.npcEffects then
		self.npcEffects:update(deltaTime)
	end
end

function UnitNpc:onUnitCreated(params)
	self._wholeScene = self.scene.stage.wholeScene

	self:_setUpComponents()

	local npcCo = SceneConfig.instance:getNpcCo(self.npcId)

	self:_setUpHud(params, npcCo)
	self:_setUpTransform(params, npcCo)

	local npcIconCo = UnlockFacade.instance:getNpcFuncIconCo(self.npcId)

	if npcIconCo then
		self.hud:setHudSign(npcIconCo.icon, npcIconCo.scale)
	end

	GlobalDispatcher:addListener(GlobalNotify.ColorfulEggTriggered, self._onEggsTriggered, self)

	if self.npcEffects then
		self.npcEffects:buildEffects(npcCo.npc_effects)
	end
end

function UnitNpc:_playDefaultIdleAnimation(play)
	local animState
	local npcCo = SceneConfig.instance:getNpcCo(self.npcId)

	if not string.nilorempty(npcCo.idle_strategy) then
		local paramIdle = string.split(npcCo.idle_strategy, "#")

		if paramIdle[1] == "caidan" then
			local eggId = checknumber(paramIdle[2])

			if not ColorfulEggsModel.instance:isEggTriggered(eggId) then
				animState = paramIdle[3]
			end
		end
	end

	if not animState then
		local colorfulEggs = ColorfulEggsModel.instance:getRelatedNpcEggs(self.npcId)

		if colorfulEggs then
			for i = 1, #colorfulEggs do
				if colorfulEggs[i]:getState() == ColorfulEggsConst.States.Triggered then
					animState = "idle"

					break
				end
			end

			animState = animState or colorfulEggs[1].eggCo.idle_strategy
		end
	end

	animState = animState or "idle"

	self.spineMover:setAnimState(animState)
	self.spine:setDefaultAnimState(animState)

	if play and self.spine and self.spine.play then
		pcall(self.spine.play, self.spine, animState, true)
	end
end

function UnitNpc:_setUpComponents()
	if self._wholeScene:IsNpc3DModel(self.npcId) then
		self:_addComponent("spine", UnitCompAnimator)
		self.spine:onInit()
		self:_addComponent("spineMover", UnitCompAnimatorMover)
		self.spineMover:onInit()
		self:_addComponent("greet", UnitCompGreetOnClosed)
		self.greet:onInit()
	else
		self:_addComponent("spine", UnitCompSpineEx)
		self.spine:onInit()
		self:_addComponent("spineMover", UnitCompSpineMover)
		self.spineMover:onInit()
	end
end

function UnitNpc:_setUpHud(params, npcCo)
	local taskHudX, taskHudY, taskHudZ = params.ofsX, params.ofsY, params.ofsZ
	local nameHudX, nameHudY, nameHudZ = params.nameOfsX, params.nameOfsY, params.nameOfsZ

	if nameHudX == 0 and nameHudY == 0 then
		nameHudX = params.ofsX
		nameHudY = params.ofsY - 0.5
		nameHudZ = params.ofsZ
	end

	if npcCo.nameOfs then
		nameHudX = npcCo.nameOfs[1] or nameHudX
		nameHudY = npcCo.nameOfs[2] or nameHudY
	end

	if npcCo.signOfs then
		taskHudX = npcCo.signOfs[1] or taskHudX
		taskHudY = npcCo.signOfs[2] or taskHudY
	end

	self.hudTask:setOffset(taskHudX, taskHudY, taskHudZ)
	self.hudTask:setDepth(taskHudZ)

	self._hudOffsetX = nameHudX
	self._hudOffsetY = nameHudY
	self._hudOffsetZ = nameHudZ
end

function UnitNpc:_setUpTransform(params, npcCo)
	Framework.TransformUtil.SetLocalPos(self.mountRoot:getAvatarRoot().transform, 0, npcCo.modelHeight, 0)
	self.transform:setPos(params.posX, params.posY, 0)
	self.transform:setMoveSpeed(params.moveSpeed)

	if params.moveSpeed then
		if params.moveSpeed <= 0 then
			self.transform:setMoveSpeed(npcCo.moveSpeed or 0)
		end

		local len = 0

		if params.paths and params.moveSpeed > 0 then
			len = params.paths.Length
		end

		if len > 0 then
			self:_runNpcPath(params.posX, params.posY, params.paths, len, params.reverse)

			self._isMotionNpc = true
		end

		if self._isMotionNpc then
			self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
		end

		self.shadow:setScale(npcCo.shadow)

		if self._isMotionNpc then
			self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
		end
	end
end

function UnitNpc:followTarget(unit, distanceConfig, onfinished, onfinishedObj)
	if not self._isMotionNpc then
		self._isMotionNpc = true

		self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
		self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
	end

	return UnitNpc.super.followTarget(self, unit, distanceConfig, onfinished, onfinishedObj)
end

function UnitNpc:onUnitDestroyed()
	if self._isMotionNpc then
		self.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	end

	GlobalDispatcher:removeListener(GlobalNotify.ColorfulEggTriggered, self._onEggsTriggered, self)

	self._wholeScene = nil

	self.actions:stopAllActions()
	self:OnDestroy()
	self:clearSceneUnit()
end

function UnitNpc:_onEggsTriggered(egg)
	if egg and egg.eggCo.npcId and egg.eggCo.npcId[1] == self.npcId then
		local colorfulEggs = ColorfulEggsModel.instance:getRelatedNpcEggs(self.npcId)

		if colorfulEggs then
			self:_playDefaultIdleAnimation(true)
		end
	end
end

function UnitNpc:_runNpcPath(startX, startY, paths, len, reverse)
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

function UnitNpc:_buildNpcActions(startX, startY, paths, len)
	len = len - 1

	local actions = {}
	local idx = 1
	local duration, pathNode

	for i = 0, len do
		actions[idx] = UnitActionMoveTo.New(paths[i].x, paths[i].y, startX, startY)
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

function UnitNpc:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene

	if self._wholeScene then
		local posX, posY = self.transform:getPos()

		self._wholeScene:UpdateNpcUnitPosition(self.npcId, x, y)
	end
end

function UnitNpc:getUnitName()
	local npcCo = SceneConfig.instance:getNpcCo(self.npcId)

	return npcCo.name
end

function UnitNpc:getUnitHudType()
	return SceneHudMgr.HUD_NPC
end

function UnitNpc:getUnitHudOffset()
	return self._hudOffsetX, self._hudOffsetY, self._hudOffsetZ
end

function UnitNpc:getTalkingOffset()
	return self._hudOffsetX, self._hudOffsetY, self._hudOffsetZ
end

function UnitNpc:onUnitVisible(go)
	self:_playDefaultIdleAnimation()
	UnitNpc.super.onUnitVisible(self, go)
end

return UnitNpc
