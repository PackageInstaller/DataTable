-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarcontroller/AvatarMountLogicController.lua

module("logiccommon.common.avatar.avatarcontroller.AvatarMountLogicController", package.seeall)

local AvatarMountLogicController = class("AvatarMountLogicController", AvatarController)

function AvatarMountLogicController:ctor(avatarBase)
	AvatarMountLogicController.super.ctor(self, avatarBase)

	self._logicModule = nil
end

function AvatarMountLogicController:_getControllerType()
	return AvatarControllerType.Logic
end

function AvatarMountLogicController:onAvatarLoaded()
	AvatarMountLogicController.super.onAvatarLoaded(self)
end

function AvatarMountLogicController:onAvatarLoadedCallBack()
	AvatarMountLogicController.super.onAvatarLoadedCallBack(self)
	self:_buildLogicModule()
end

function AvatarMountLogicController:onAvatarInvisible()
	AvatarMountLogicController.super.onAvatarInvisible(self)
	self:onAvatarReset()
end

function AvatarMountLogicController:onAvatarVisible()
	AvatarMountLogicController.super.onAvatarVisible(self)
end

function AvatarMountLogicController:onAvatarReset()
	AvatarMountLogicController.super.onAvatarReset(self)

	if self._logicModule then
		self._logicModule:onReset()
	end

	self._logicModule = nil
end

function AvatarMountLogicController:onAvatarDestroy()
	AvatarMountLogicController.super.onAvatarDestroy(self)
end

function AvatarMountLogicController:_buildLogicModule()
	if self._logicModule then
		self._logicModule:dispose()

		self._logicModule = nil
	end

	local mountCo

	if self._avatar then
		mountCo = self._avatar._ctrl:getCurMountCfg()
	end

	if mountCo and not string.nilorempty(mountCo.logic_cls) and mountCo.logic_cls == MountModel.Logic_Balloon then
		local userId = self._avatar._ctrl._avatar:getOwnerUserId()

		self._logicModule = AvatarMountLogicBalloon.New(self._avatar, MountConfig.instance:getMountLogicParams(mountCo.id), userId)

		self._logicModule:start()
	end
end

return AvatarMountLogicController
