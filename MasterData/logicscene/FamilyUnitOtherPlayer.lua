-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/family/FamilyUnitOtherPlayer.lua

module("logicscene.scene.unit.impl.family.FamilyUnitOtherPlayer", package.seeall)

local FamilyUnitOtherPlayer = class("FamilyUnitOtherPlayer", UnitOtherPlayer)

function FamilyUnitOtherPlayer:getModelInstance()
	return FamilySceneModel.instance
end

function FamilyUnitOtherPlayer:_initComponents()
	FamilyUnitOtherPlayer.super._initComponents(self)
	self.transform:setSceneType(SceneType.Family)
end

function FamilyUnitOtherPlayer:_addUnitCompHudOthersPlayer()
	self:_addComponent("hud", FamilyUnitCompHudOthersPlayer)
	self:_addComponent("subhud", UnitCompSubHudPlayer)
end

function FamilyUnitOtherPlayer:onUnitVisible(go)
	self._isClipping = nil

	self:updateUserVariables()
end

function FamilyUnitOtherPlayer:updateModel()
	if self._isClipping then
		return
	end

	if self.spine then
		local playerMo = self:getModelInstance():getPlayerMo(self.id)

		if playerMo then
			local avatarMo = DressModel.instance:getAvatarByUserVar(playerMo.userVar)

			self.spine:setBody(avatarMo)
			self.spine:onUnitVisible()
		end
	end
end

function FamilyUnitOtherPlayer:onUnitCreated(params)
	self.transform:setPos(params.posX, 0, params.posY)
	self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	self.spineMover:playDefaultIdleAnim()

	local playerMo = self:getModelInstance():getPlayerMo(self.id)

	if playerMo then
		self:setUnderBridge(playerMo.underBridge)
	end

	self:updateSceneParams()
	self:onUnitVisible()

	local scale = FamilySceneMainPlayer.localScale

	Framework.TransformUtil.SetLocalScale(self.go.transform, scale, scale, scale)
	GameUtil.setLocalRotation(self.go, 15, 0, 0)
	self.hud:setOffsetY3D(FamilySceneMainPlayer.OffsetY3D)
end

function FamilyUnitOtherPlayer:onUnitDestroyed()
	self.spine:removeListener(UnitNotify.SpineLoaded, self._onPlayerBodyLoaded, self)
	self.scene:removeAllUnitPet(self)
	self.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	self.actions:stopAllActions()

	self._wholeScene = nil
	self.isRunningCmdAction = nil
	self._playIdleDelay = nil

	self:clearSceneUnit()

	if self.go then
		goutil.destroy(self.go)

		self.go = nil
	end

	self:OnDestroy()
end

function FamilyUnitOtherPlayer:_onPlayerBodyLoaded()
	local playerMo = self:getModelInstance():getPlayerMo(self.id)

	if playerMo then
		UnitOtherPlayer.super._onPlayerBodyLoaded(self)

		local go = self.spine:getAvatarGo()

		UnitOtherPlayer.super.onUnitVisible(self, go)
		self.idleAnimation:onPlayerBodyLoaded()
	end

	self.transform:setLocalRotationY(180, true)
	self.shadow:setLocalRotation(58, 0, 0)
end

function FamilyUnitOtherPlayer:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene
end

function FamilyUnitOtherPlayer:pushMoveCmdXZ(x, z, underBridge, isteleport)
	local startX, y, startZ = self.transform:getPos()
	local cmd = FamilyUnitCmdPos.New(x, z, startX, startZ, isteleport)

	cmd.underBridge = underBridge

	self:pushCmd(cmd)
end

function FamilyUnitOtherPlayer:_onCmdActionFinish()
	self.isRunningCmdAction = nil
	self._playIdleDelay = 0.01

	if self._hander then
		if self._handerTgt then
			self._hander(self._handerTgt, self)
		else
			self:_hander()
		end
	end

	self._hander = nil
	self._handerTgt = nil

	self:_runNextCmd()
end

return FamilyUnitOtherPlayer
