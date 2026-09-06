-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/UnitAvatar.lua

module("logicscene.scene.unit.impl.UnitAvatar", package.seeall)

local UnitAvatar = class("UnitAvatar", SceneUnitBase)
local DEFAULT_HUD_OFFSET_Y = 1.6
local DEFAULT_SUBHUD_OFFSET_Y = 1

function UnitAvatar:Awake()
	UnitAvatar.super.Awake(self)
	self.spine:addListener(UnitNotify.SpineLoaded, self._onPlayerBodyLoaded, self)
end

function UnitAvatar:_initComponents()
	UnitAvatar.super._initComponents(self)
	self:_addComponent("spine", UnitCompAvatar)
end

function UnitAvatar:getAvatarName()
	return SceneMainPlayer.MainPlayerName
end

function UnitAvatar:getAvatarType()
	return AvatarCreateType.Player
end

function UnitAvatar:onUnitDestroyed()
	self.spine:removeListener(UnitNotify.SpineLoaded, self._onPlayerBodyLoaded, self)
	self:stopAllActions()
	self:clearSceneUnit()

	if self.go then
		goutil.destroy(self.go)

		self.go = nil
	end

	self._syncUserVarUserId = nil

	self:OnDestroy()
end

function UnitAvatar:startMount()
	self.isMounting = true

	if self:getIsCoDriver() then
		return
	end

	self.spine:startMount()
end

function UnitAvatar:dismount()
	self.isMounting = false

	self.spine:dismount()
	self:updateSceneParams()
end

function UnitAvatar:onMountLoadedFinish(mount)
	self:updateSceneParams()

	if self.idleAnimation and self.idleAnimation.onMountLoadedFinish then
		self.idleAnimation:onMountLoadedFinish()
	end

	if self.isMainDriver and mount then
		self.subhud:setFollowTarget(mount:getBoneByPointType(AvatarHangPointType.SubMount))
	end
end

function UnitAvatar:updateSceneParams()
	self:updateMoveSpeed()

	local scale, speed, hudHeight = SceneMgr.instance:getSceneCharactorParams()

	Framework.TransformUtil.SetLocalScale(self.go.transform, scale, scale, scale)

	local avatarMo = self.spine:getAvatarMo()

	self.hud:setFollowTarget(nil)
	self.subhud:setOffsetY3D(DEFAULT_SUBHUD_OFFSET_Y)

	if not avatarMo or not avatarMo.isMount then
		self.hud:setOffsetY3D(hudHeight)

		if self.shadow then
			self.shadow:setLocalPos(0, 0, 0)
			self.shadow:setScale(1)
		end
	else
		local mountCo = MountConfig.instance:getMountCo(avatarMo.mount)

		if mountCo.nameHeight ~= 0 then
			self.hud:setOffsetY3D(mountCo.nameHeight)
		else
			self.hud:setOffsetY3D(DEFAULT_HUD_OFFSET_Y)
		end

		if self.shadow then
			if mountCo.shadowOffset then
				self.shadow:setLocalPos(mountCo.shadowOffset[1] or 0, mountCo.shadowOffset[2] or 0, mountCo.shadowOffset[3] or 0)
			else
				self.shadow:setLocalPos(0, -0.35, 0)
			end

			if mountCo.shadowScale ~= 0 then
				self.shadow:setScale(mountCo.shadowScale)
			else
				self.shadow:setScale(3)
			end
		end
	end
end

function UnitAvatar:updateMoveSpeed()
	local scale, speed, hudHeight = SceneMgr.instance:getSceneCharactorParams()
	local avatarMo = self.spine:getAvatarMo()

	if not avatarMo or not avatarMo.isMount then
		self.transform:setMoveSpeed(speed)
	else
		local mountCo = MountConfig.instance:getMountCo(avatarMo.mount)

		speed = speed * (1 + (mountCo.speed or 0))

		self.transform:setMoveSpeed(speed)
	end
end

function UnitAvatar:isBodyLoaded()
	return self.spine:isBodyLoaded()
end

function UnitAvatar:_onPlayerBodyLoaded()
	local go = self.spine:getAvatarGo()

	go.name = self:getAvatarName()

	self:_ensureBoxCollider(go)

	if self.isMainPlayer then
		self.transform:setLocalRotationY(180, true)
	else
		self.transform:setLocalRotationY(math.random(0, 360), true)
	end
end

function UnitAvatar:setIsCoDriver(isCoDriver)
	self.isCoDriver = isCoDriver

	self:setVisible(not self.isCoDriver)
end

function UnitAvatar:getIsCoDriver()
	return self.isCoDriver
end

function UnitAvatar:setIsMainDriver(isMainDriver)
	self.isMainDriver = isMainDriver
end

function UnitAvatar:getIsMainDriver()
	return self.isMainDriver
end

function UnitAvatar:setSyncUserVarUserId(userId)
	self._syncUserVarUserId = userId
end

function UnitAvatar:getSyncUserVarUserId()
	return self._syncUserVarUserId
end

return UnitAvatar
