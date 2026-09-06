-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/family/FamilyUnitMainPlayer.lua

module("logicscene.scene.unit.impl.family.FamilyUnitMainPlayer", package.seeall)

local FamilyUnitMainPlayer = class("FamilyUnitMainPlayer", UnitAvatar)

function FamilyUnitMainPlayer:ctor(componetContainer)
	FamilyUnitMainPlayer.super.ctor(self, componetContainer)

	self.isMainPlayer = true
	self.triggerId = nil
	self.transmitGroupId = nil
	self.transmitPoint = nil
	self._isClipping = nil
end

function FamilyUnitMainPlayer:getTag()
	return UnitTag.MainPlayer
end

function FamilyUnitMainPlayer:getAvatarName()
	return FamilySceneMainPlayer.MainPlayerName
end

function FamilyUnitMainPlayer:getLayer()
	return SceneLayer.MainPlayer_Value
end

function FamilyUnitMainPlayer:update(deltaTime)
	self.actions:update(deltaTime)
	self.syncPos:update()
	self.transform:updateRoatationY(deltaTime)
	self:_updateShadowState()
	self.idleAnimation:update(deltaTime)
end

function FamilyUnitMainPlayer:_updateShadowState()
	if not self.shadow then
		return
	end

	local scene = SceneMgr.instance:getCurScene()

	if not scene then
		return
	end

	local x, y = self.transform:getPos()
	local cellType = scene.stage.wholeScene:GetCellType(x, y)

	if self.shadow.updateShadowState then
		self.shadow:updateShadowState(cellType)
	end
end

function FamilyUnitMainPlayer:_initComponents()
	FamilyUnitMainPlayer.super._initComponents(self)
	self.transform:setSceneType(SceneType.Family)
	self:_addComponent("mover", FamilyUnitCompMover)
	self:_addComponent("syncPos", FamilyUnitCompSyncPos)
	self:_addComponent("spineMover", UnitCompAnimatorMover)
	self:_addComponent("shadow", UnitCompShadowForMainPlayer)
	self:_addComponent("hud", UnitCompHudPlayer)
	self:_addComponent("physics3D", UnitCompPhysics3D)
	self:_addComponent("idleAnimation", UnitCompIdleAnimation)
	self.hud:setOffsetY3D(FamilySceneMainPlayer.OffsetY3D)
	self:_addComponent("subhud", UnitCompSubHudPlayer)
end

function FamilyUnitMainPlayer:setUnderBridge(under)
	UnitMainPlayer.super.setUnderBridge(self, under)
end

function FamilyUnitMainPlayer:clearBridgeState()
	if self.sceneUnit then
		self.sceneUnit.bridgeId = 0

		if self:isUnderBridge() then
			self:_onBridgeStateChange(false)
			self:setUnderBridge(false)
		end
	end

	if self.shadow.clearBridgeState then
		self.shadow:clearBridgeState()
	end
end

function FamilyUnitMainPlayer:_onBridgeStateChange(under)
	local x, y = self.transform:getPos()

	self.syncPos:syncPosition(x, y)
	self.shadow:onBridgeStateChange(under)
end

function FamilyUnitMainPlayer:onMountLoadedFinish(mount)
	FamilyUnitMainPlayer.super.onMountLoadedFinish(self, mount)
end

function FamilyUnitMainPlayer:_onPlayerBodyLoaded()
	FamilyUnitMainPlayer.super._onPlayerBodyLoaded(self)
	self.idleAnimation:onPlayerBodyLoaded()

	local go = self.spine:getAvatarGo()

	printInfo("test FamilyUnitMainPlayer:_onPlayerBodyLoaded", go.name)

	if self.isMainPlayer then
		self.transform:setLocalRotationY(180, true)
	else
		self.transform:setLocalRotationY(math.random(0, 360), true)
	end

	self.shadow:setLocalRotation(75, 0, 0)
end

function FamilyUnitMainPlayer:runPath(destX, destZ, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local px, py, pz = self.transform:getPos()

	if px == destX and pz == destZ then
		if onfinished then
			if onfinishedObj then
				onfinished(onfinishedObj)
			else
				onfinished()
			end
		end
	else
		local action = UnitActionFamilyOtherPlayerMove.New(destX, destZ)

		action.onFinished = onfinished
		action.onFinishedObj = onfinishedObj

		self.actions:runAction(action)

		return action
	end
end

return FamilyUnitMainPlayer
