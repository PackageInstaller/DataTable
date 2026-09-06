-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/UnitMainPlayer.lua

module("logicscene.scene.unit.impl.UnitMainPlayer", package.seeall)

local UnitMainPlayer = class("UnitMainPlayer", UnitAvatar)

function UnitMainPlayer:ctor(componetContainer)
	UnitMainPlayer.super.ctor(self, componetContainer)

	self.isMainPlayer = true
	self.triggerId = nil
	self.transmitGroupId = nil
	self.transmitPoint = nil
	self._isClipping = nil
end

function UnitMainPlayer:getTag()
	return UnitTag.MainPlayer
end

function UnitMainPlayer:getAvatarName()
	return SceneMainPlayer.MainPlayerName
end

function UnitMainPlayer:getLayer()
	return SceneLayer.MainPlayer_Value
end

function UnitMainPlayer:update(deltaTime)
	self.actions:update(deltaTime)
	self.syncPos:update()
	self.transform:updateRoatationY(deltaTime)
	self:_updateShadowState()
	self.birthEff:update(deltaTime)
	self.idleAnimation:update(deltaTime)
	self.moveTrace:update(deltaTime)
end

function UnitMainPlayer:_updateShadowState()
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

function UnitMainPlayer:_initComponents()
	UnitMainPlayer.super._initComponents(self)
	self:_addComponent("mover", UnitCompMoverEx)
	self:_addComponent("syncPos", UnitCompSyncPos)
	self:_addComponent("spineMover", UnitCompAnimatorMover)
	self:_addComponent("shadow", UnitCompShadowForMainPlayer)
	self:_addComponent("hud", UnitCompHudPlayer)
	self:_addComponent("physics2D", UnitCompPhysics2D)
	self:_addComponent("birthEff", UnitCompBirthEff)
	self:_addComponent("idleAnimation", UnitCompIdleAnimation)
	self:_addComponent("moveTrace", UnitCompPlayerMoveTrace)
	self:_addComponent("subhud", UnitCompSubHudPlayer)
end

function UnitMainPlayer:setUnderBridge(under)
	UnitMainPlayer.super.setUnderBridge(self, under)
end

function UnitMainPlayer:clearBridgeState()
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

function UnitMainPlayer:_onBridgeChange(bridgeId, zPos)
	self.shadow:onBridgeChange(bridgeId, zPos)
end

function UnitMainPlayer:_onBridgeStateChange(under)
	local x, y = self.transform:getPos()

	self.syncPos:syncPosition(x, y)
	self.shadow:onBridgeStateChange(under)
end

function UnitMainPlayer:onMountLoadedFinish(mount)
	UnitMainPlayer.super.onMountLoadedFinish(self, mount)
end

function UnitMainPlayer:_onPlayerBodyLoaded()
	UnitMainPlayer.super._onPlayerBodyLoaded(self)
	self.birthEff:playEnterScene()
	self.idleAnimation:onPlayerBodyLoaded()
end

function UnitMainPlayer:setVisible(visible)
	UnitMainPlayer.super.setVisible(self, visible)

	if self:getIsCoDriver() and visible then
		self:setVisible(false)
	end
end

return UnitMainPlayer
