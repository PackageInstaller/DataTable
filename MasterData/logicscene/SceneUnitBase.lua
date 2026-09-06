-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/SceneUnitBase.lua

module("logicscene.scene.unit.impl.SceneUnitBase", package.seeall)

local SceneUnitBase = class("SceneUnitBase", UnitBase)
local typeOfBoxCollider = typeof(UnityEngine.BoxCollider)

SceneUnitBase.UnitPet = "UnitPet"
SceneUnitBase.UnitCute = "UnitCute"
SceneUnitBase.UnitZoo = "UnitZoo"
SceneUnitBase.UnitMainPlayerPet = "UnitMainPlayerPet"
SceneUnitBase.UnitFakePlayer = "UnitFakePlayer"

function SceneUnitBase:ctor(componetContainer)
	SceneUnitBase.super.ctor(self, componetContainer)

	self.sceneUnit = nil
	self.radius = 0.5
	self.petUnits = nil
	self.isDestroyed = nil
	self._isVisible = true
	self._isClipping = true
	self._gameObject = nil
	self._moveable = true
end

function SceneUnitBase:_initComponents()
	self:_addComponent("mountRoot", UnitCompMountRoot)
	self:_addComponent("transform", UnitCompTransform)
	self:_addComponent("actions", UnitCompActions)
end

function SceneUnitBase:getMountPoint(mountType)
	if mountType == GameEnum.MountPointType.Head then
		return self:getHangPoint(UnitConst.spineHeadPointPath)
	elseif mountType == GameEnum.MountPointType.Center then
		return self:getHangPoint(UnitConst.spineCenterPointPath)
	elseif mountType == GameEnum.MountPointType.Foot then
		return self:getHangPoint(UnitConst.spineFootPointPath)
	elseif mountType == GameEnum.MountPointType.Front then
		return self:getHangPoint(UnitConst.spineFrontPointPath)
	else
		return self.mountRoot:getEffectRoot()
	end
end

function SceneUnitBase:frozenMove()
	self._moveable = false

	self:pauseAllActions()
end

function SceneUnitBase:isFrozenMove()
	return not self._moveable
end

function SceneUnitBase:unfrozenMove()
	if self.spine and self.spine.handleQueryFindWay then
		self.spine:handleQueryFindWay()
	end

	self._moveable = true

	self:resumeAllActions()
end

function SceneUnitBase:handleQueryFindWay()
	if self.spine and self.spine.handleQueryFindWay then
		self.spine:handleQueryFindWay()
	end

	if not self._moveable then
		return
	end

	return true
end

function SceneUnitBase:getHangPoint(mountName)
	if mountName == UnitConst.effectPointPath then
		return self.mountRoot:getEffectRoot()
	end

	if self._gameObject then
		return goutil.findChild(self._gameObject, mountName)
	end
end

function SceneUnitBase:getGameObject()
	return self._gameObject
end

function SceneUnitBase:isBodyLoaded()
	return true
end

function SceneUnitBase:update(deltaTime)
	self.actions:update(deltaTime)
end

function SceneUnitBase:stopAllActions(doNotStopAnim)
	UnitCompActions.doNotStopAnimOnMoveActionFinish = doNotStopAnim

	self.actions:stopAllActions()

	UnitCompActions.doNotStopAnimOnMoveActionFinish = nil
end

function SceneUnitBase:pauseAllActions()
	self.actions:pause(true)
end

function SceneUnitBase:resumeAllActions()
	self.actions:pause(false)
end

function SceneUnitBase:isAround(unit)
	if not unit then
		return
	end

	local x, y = unit.transform:getPos()
	local dist = self.transform:dist(x, y)

	if dist <= self.radius and self:isUnderBridge() == unit:isUnderBridge() then
		return true
	end
end

function SceneUnitBase:stopAction(action, doNotStopAnim)
	UnitCompActions.doNotStopAnimOnMoveActionFinish = doNotStopAnim

	self.actions:stopAction(action)

	UnitCompActions.doNotStopAnimOnMoveActionFinish = nil
end

function SceneUnitBase:runArcPath(startX, startY, destX, destY, radius, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local action = UnitActionMoveCircleArc.New(startX, startY, destX, destY, radius)

	action.onFinished = onfinished
	action.onFinishedObj = onfinishedObj

	self.actions:runAction(action)

	return action
end

function SceneUnitBase:runPath(destX, destY, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local px, py = self.transform:getPos()

	if px == destX and py == destY then
		if onfinished then
			if onfinishedObj then
				onfinished(onfinishedObj)
			else
				onfinished()
			end
		end
	else
		local action = UnitActionPathTo.New(destX, destY)

		action.onFinished = onfinished
		action.onFinishedObj = onfinishedObj

		self.actions:runAction(action)

		return action
	end
end

function SceneUnitBase:runPathWithCheck(destX, destY, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local currScene = self.scene

	if currScene and currScene.stage and currScene.stage.wholeScene and not currScene:isPositionReachable(self.sceneUnit, destX, destY) then
		local hasPos, dx, dy = currScene.stage.wholeScene:FindNotBerrierAround(self.sceneUnit, destY, destX, false, nil, nil)

		if not hasPos then
			return
		end

		destX = dx
		destY = dy
	end

	local action = UnitActionPathTo.New(destX, destY)

	action.onFinished = onfinished
	action.onFinishedObj = onfinishedObj

	self.actions:runAction(action)

	return action:getFinalDestPos()
end

function SceneUnitBase:gotoUnit(unit, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local action = UnitActionGotoUnit.New(unit)

	action.onFinished = onfinished
	action.onFinishedObj = onfinishedObj

	self.actions:runAction(action)

	return action
end

function SceneUnitBase:followTarget(unit, distanceConfig, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local action = UnitActionFollowTgt.New(unit)

	action.distanceConfig = distanceConfig
	action.onFinished = onfinished
	action.onFinishedObj = onfinishedObj

	self.actions:runAction(action)

	return action
end

function SceneUnitBase:gotoScene(sceneId, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local scene = self.scene

	if scene:getSceneId() == sceneId and scene.isReady then
		if onfinished then
			onfinished(onfinishedObj)
		end

		return
	end

	if not SceneMgr.instance:isTransitionEnabled() then
		local actionList = self:getFullScenePathActions(scene:getSceneId(), sceneId)
		local actions = UnitActionSequence.New(actionList)

		actions.onFinished = onfinished
		actions.onFinishedObj = onfinishedObj
		actions.dontStopCrossScene = true

		self.actions:runAction(actions)

		return actions
	else
		local action = UnitActionGotoScene.New(sceneId)

		action.onFinished = onfinished
		action.onFinishedObj = onfinishedObj

		self.actions:runAction(action)

		return action
	end
end

function SceneUnitBase:gotoTrigger(triggerId, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local action = UnitActionGotoTrigger.New(triggerId)

	action.onFinished = onfinished
	action.onFinishedObj = onfinishedObj

	self.actions:runAction(action)

	return action
end

function SceneUnitBase:gotoNpc(npcId, onfinished, onfinishedObj)
	self:stopAllActions(true)

	if not self._moveable then
		return
	end

	local action = UnitActionSelectNpc.New(npcId)

	action.onFinished = onfinished
	action.onFinishedObj = onfinishedObj

	self.actions:runAction(action)

	return action
end

function SceneUnitBase:gotoElement(elementId, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local action = UnitActionSelectElement.New(elementId)

	action.onFinished = onfinished
	action.onFinishedObj = onfinishedObj

	self.actions:runAction(action)

	return action
end

function SceneUnitBase:gotoChallengeNpcCrossScene(challengeId, onfinished, onfinishedObj)
	local challengeNpc = UnlockFacade.instance:getChallengeNpc(challengeId)

	if challengeNpc and challengeNpc > 0 then
		return self:gotoNpcCrossScene(challengeNpc, onfinished, onfinishedObj)
	end
end

function SceneUnitBase:gotoNpcCrossScene(npcId, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local scene = self.scene
	local npcCo = SceneConfig.instance:getNpcCo(npcId)

	if npcCo and (scene:getSceneId() ~= npcCo.sceneId or not scene.isReady) then
		local gotoScene = UnitActionGotoScene.New(npcCo.sceneId)
		local lockScene = UnitActionWaitSceneLoaded.New(npcCo.sceneId)
		local gotoNpc = UnitActionSelectNpc.New(npcId)
		local actions = UnitActionSequence.New({
			gotoScene,
			lockScene,
			gotoNpc
		})

		actions.onFinished = onfinished
		actions.onFinishedObj = onfinishedObj
		actions.dontStopCrossScene = true

		self.actions:runAction(actions)

		return actions
	else
		return self:gotoNpc(npcId, onfinished, onfinishedObj)
	end
end

function SceneUnitBase:gotoNpcCrossSceneWithFullScenePath(npcId, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local scene = self.scene
	local npcCo = SceneConfig.instance:getNpcCo(npcId)
	local currSceneId = scene:getSceneId()

	if npcCo and (currSceneId ~= npcCo.sceneId or not scene.isReady) then
		local actionsList = self:getFullScenePathActions(currSceneId, npcCo.sceneId)
		local gotoNpc = UnitActionSelectNpc.New(npcId)

		table.insert(actionsList, gotoNpc)

		local actions = UnitActionSequence.New(actionsList)

		actions.onFinished = onfinished
		actions.onFinishedObj = onfinishedObj
		actions.dontStopCrossScene = true

		self.actions:runAction(actions)

		return actions
	else
		return self:gotoNpc(npcId, onfinished, onfinishedObj)
	end
end

function SceneUnitBase:closeToNpcCrossSceneWithFullScenePath(npcId, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local scene = self.scene
	local npcCo = SceneConfig.instance:getNpcCo(npcId)
	local currSceneId = scene:getSceneId()

	if npcCo and (currSceneId ~= npcCo.sceneId or not scene.isReady) then
		local actionsList = self:getFullScenePathActions(currSceneId, npcCo.sceneId)
		local gotoNpc = UnitActionCloseToNpc.New(npcId)

		table.insert(actionsList, gotoNpc)

		local actions = UnitActionSequence.New(actionsList)

		actions.onFinished = onfinished
		actions.onFinishedObj = onfinishedObj
		actions.dontStopCrossScene = true

		self.actions:runAction(actions)

		return actions
	else
		if not self._moveable then
			return
		end

		local action = UnitActionCloseToNpc.New(npcId)

		action.onFinished = onfinished
		action.onFinishedObj = onfinishedObj

		self.actions:runAction(action)

		return action
	end
end

function SceneUnitBase:getFullScenePathActions(fromSceneId, toSceneId)
	local scenePaths = SceneConfig.instance:getScenePath(fromSceneId, toSceneId)
	local actionsList = {}

	if scenePaths and #scenePaths > 0 then
		for i = 1, #scenePaths do
			local gotoScene = UnitActionGotoScene.New(scenePaths[i])
			local lockScene = UnitActionWaitSceneLoaded.New(scenePaths[i])

			table.insert(actionsList, gotoScene)
			table.insert(actionsList, lockScene)
		end
	end

	local gotoScene = UnitActionGotoScene.New(toSceneId)
	local lockScene = UnitActionWaitSceneLoaded.New(toSceneId)

	table.insert(actionsList, gotoScene)
	table.insert(actionsList, lockScene)

	return actionsList
end

function SceneUnitBase:gotoMonster(mstId, onfinished, onfinishedObj)
	self:stopAllActions(true)

	if not self._moveable then
		return
	end

	local action = UnitActionSelectMonster.New(mstId)

	action.onFinished = onfinished
	action.onFinishedObj = onfinishedObj

	self.actions:runAction(action)

	return action
end

function SceneUnitBase:gotoTilingElem(mstId, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local action = UnitActionSelectTilingElem.New(mstId)

	action.onFinished = onfinished
	action.onFinishedObj = onfinishedObj

	self.actions:runAction(action)

	return action
end

function SceneUnitBase:gotoMonsterZone(zoneId, onfinished, onfinishedObj)
	local zoneCo = SceneConfig.instance:getSceneIdBySceneZoneId(zoneId)
	local scene = self.scene

	if scene:getSceneId() ~= zoneCo.sceneId or not scene.isReady then
		local gotoScene = UnitActionGotoScene.New(npcCo.sceneId)
		local lockScene = UnitActionWaitSceneLoaded.New(npcCo.sceneId)
		local gotoZone = UnitActionGotoMonsterZone.New(zoneId)
		local actions = UnitActionSequence.New({
			gotoScene,
			lockScene,
			gotoZone
		})

		actions.onFinished = onfinished
		actions.onFinishedObj = onfinishedObj
		actions.dontStopCrossScene = true

		self.actions:runAction(actions)

		return actions
	else
		local px, py = self.transform:getPos()

		if not scene.stage.wholeScene:IsInMonsterZone(zoneId, px, py) then
			local posX, posY = scene.stage.wholeScene:GetMonsterZonePos(zoneId, nil, nil)

			return self:runPath(posX, posY, onfinished, onfinishedObj)
		elseif onfinished then
			if onfinishedObj then
				onfinished(onfinishedObj)
			else
				onfinished()
			end
		end
	end
end

function SceneUnitBase:gotoSceneZone(sceneId, zoneId, onfinished, onfinishedObj)
	local scene = self.scene

	if scene:getSceneId() ~= sceneId or not scene.isReady then
		local gotoScene = UnitActionGotoScene.New(sceneId)
		local lockScene = UnitActionWaitSceneLoaded.New(sceneId)
		local gotoZone = UnitActionGotoMonsterZone.New(zoneId)
		local actions = UnitActionSequence.New({
			gotoScene,
			lockScene,
			gotoZone
		})

		actions.onFinished = onfinished
		actions.onFinishedObj = onfinishedObj
		actions.dontStopCrossScene = true

		self.actions:runAction(actions)

		return actions
	else
		local px, py = self.transform:getPos()

		if not scene.stage.wholeScene:IsInMonsterZone(zoneId, px, py) then
			local posX, posY = scene.stage.wholeScene:GetMonsterZonePos(zoneId, nil, nil)

			return self:runPath(posX, posY, onfinished, onfinishedObj)
		elseif onfinished then
			if onfinishedObj then
				onfinished(onfinishedObj)
			else
				onfinished()
			end
		end
	end
end

function SceneUnitBase:gotoScenePosition(sceneId, destX, destY, onfinished, onfinishedObj)
	local scene = self.scene

	if scene:getSceneId() ~= sceneId or not scene.isReady then
		local gotoScene = UnitActionGotoScene.New(sceneId)
		local lockScene = UnitActionWaitSceneLoaded.New(sceneId)
		local gotoZone = UnitActionPathTo.New(destX, destY)
		local actions = UnitActionSequence.New({
			gotoScene,
			lockScene,
			gotoZone
		})

		actions.onFinished = onfinished
		actions.onFinishedObj = onfinishedObj
		actions.dontStopCrossScene = true

		self.actions:runAction(actions)

		return actions
	else
		self:runPath(destX, destY, onfinished, onfinishedObj)
	end
end

function SceneUnitBase:gotoScenePositionWithFullScenePath(sceneId, destX, destY, onfinished, onfinishedObj)
	local scene = self.scene

	if scene:getSceneId() ~= sceneId or not scene.isReady then
		local actionList = self:getFullScenePathActions(scene:getSceneId(), sceneId)
		local gotoZone = UnitActionPathTo.New(destX, destY)

		table.insert(actionList, gotoZone)

		local actions = UnitActionSequence.New(actionList)

		actions.onFinished = onfinished
		actions.onFinishedObj = onfinishedObj
		actions.dontStopCrossScene = true

		self.actions:runAction(actions)

		return actions
	else
		self:runPath(destX, destY, onfinished, onfinishedObj)
	end
end

function SceneUnitBase:patrolInZone(zoneId)
	self:stopAllActions(true)

	local action = UnitActionPatrolInZone.New(zoneId)

	action.onFinished = onfinished
	action.onFinishedObj = onfinishedObj

	self.actions:runAction(action)

	return action
end

function SceneUnitBase:patrolInRect(rect)
	self:stopAllActions(true)

	local action = UnitActionPatrolInRect.New(rect)

	action.onFinished = onfinished
	action.onFinishedObj = onfinishedObj

	self.actions:runAction(action)

	return action
end

function SceneUnitBase:isInFrustum()
	return GameUtil.isInFrustum(self.transform:getPos())
end

function SceneUnitBase:setSceneUnit(unit)
	self:clearSceneUnit()

	self.sceneUnit = unit

	if self.sceneUnit then
		self.sceneUnit:AddBridgeStateListener(self._onBridgeStateChange, self)
		self.sceneUnit:AddBridgeListener(self._onBridgeChange, self)
		self.sceneUnit:AddLateUpdateListener(self._onLateUpdate, self)
	end
end

function SceneUnitBase:clearSceneUnit()
	if self.sceneUnit then
		self.sceneUnit:RemoveBridgeStateListener()
		self.sceneUnit:RemoveBridgeListener()
		self.sceneUnit:RemoveLateUpdateListener()

		self.sceneUnit = nil
	end
end

function SceneUnitBase:isUnderBridge()
	if self.sceneUnit then
		return self.sceneUnit:IsUnderBridge()
	end

	return false
end

function SceneUnitBase:setUnderBridge(under)
	if self.sceneUnit then
		self.sceneUnit:SetUnderBridge(under)
	end

	self.shadow:onBridgeStateChange(under)
end

function SceneUnitBase:setVisible(visible)
	if self._isVisible == visible then
		return
	end

	self._isVisible = visible

	goutil.setActive(self.go, visible)

	if self._compList then
		local cnt = #self._compList

		for i = 1, cnt do
			local comp = self._compList[i]

			if comp.setActive then
				comp:setActive(visible)
			end
		end
	end

	if self.petUnits then
		for k, v in pairs(self.petUnits) do
			v:setVisible(self._isVisible)
		end
	end
end

function SceneUnitBase:isVisible()
	return self._isVisible
end

function SceneUnitBase:isClipping()
	return self._isClipping
end

function SceneUnitBase:addPetUnit(key, unit)
	if key and unit then
		self.petUnits = self.petUnits or {}
		self.petUnits[key] = unit
	end
end

function SceneUnitBase:removePetUnit(key)
	if key and self.petUnits then
		self.petUnits[key] = nil
	end
end

function SceneUnitBase:removeAllPetUnit()
	self.petUnits = nil
end

function SceneUnitBase:getPetUnit(key)
	local var_50_0

	if key then
		::label_50_0::

		var_50_0 = self.petUnits and self.petUnits[key]
	end

	return var_50_0
end

function SceneUnitBase:getAllPetUnit()
	return self.petUnits
end

function SceneUnitBase:getUnitName()
	return
end

function SceneUnitBase:getUnitHudType()
	return
end

function SceneUnitBase:getUnitHudOffset()
	return
end

function SceneUnitBase:getTalkingOffset()
	return 0, 0, 0
end

function SceneUnitBase:faceToUnit(unit)
	if unit then
		local x, y, z = unit.transform:getPos()
		local dx, dy = self.transform:dir(x, y, z)
		local y = GameUtil.getRotationYByDir(dx, dy)

		if y then
			self.transform:setLocalRotationY(y, true)
		end
	end
end

function SceneUnitBase:onUnitVisible(go)
	self._gameObject = go
	self._isClipping = nil

	if self._compList then
		local cnt = #self._compList

		for i = 1, cnt do
			local comp = self._compList[i]

			if comp.onUnitVisible then
				comp:onUnitVisible(go)
			end
		end
	end

	if not self._isVisible then
		self._isVisible = true

		self:setVisible(false)
	end
end

function SceneUnitBase:onUnitInVisible(go)
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

function SceneUnitBase:_onBridgeStateChange(under)
	self.shadow:onBridgeStateChange(under)
end

function SceneUnitBase:_onBridgeChange(bridgeId, zPos)
	self.shadow:onBridgeChange(bridgeId, zPos)
end

function SceneUnitBase:_onLateUpdate()
	self.shadow:lateUpdate()
end

function SceneUnitBase:_ensureBoxCollider(go)
	local boxCollider = go:GetComponent(typeOfBoxCollider)

	boxCollider = boxCollider or go:AddComponent(typeOfBoxCollider)
	boxCollider.center = Vector3.New(0, 1, 0)
	boxCollider.size = Vector3.New(1, 2, 1)
end

function SceneUnitBase:OnDestroy()
	SceneUnitBase.super.OnDestroy(self)

	self.go = nil
	self._gameObject = nil
	self.scene = nil
end

return SceneUnitBase
