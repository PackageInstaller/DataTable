-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarcontroller/AvatarController.lua

module("logiccommon.common.avatar.avatarcontroller.AvatarController", package.seeall)

local AvatarController = class("AvatarController")

function AvatarController:ctor(avatarBase)
	NotifyDispatcher.extend(self)

	self._avatar = avatarBase

	if self._avatar then
		self._avatar:addCtrl(self:_getControllerType(), self)
	else
		printError("AcatarController Get Nil AvatarBase:" .. self:_getControllerType())
	end
end

function AvatarController:_getControllerType()
	return AvatarControllerType.Init
end

function AvatarController:onAvatarLoaded()
	if not self._avatar:getGameObject() then
		print("avatar is Not Load")
	end
end

function AvatarController:onAvatarLoadedCallBack()
	if not self._avatar:getGameObject() then
		print("avatar is Not Load")
	end
end

function AvatarController:onAvatarInvisible()
	return
end

function AvatarController:onAvatarVisible()
	return
end

function AvatarController:onAvatarReset()
	return
end

function AvatarController:onAvatarDestroy()
	return
end

return AvatarController
