-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarmountlogic/AvatarMountLogicBase.lua

module("logiccommon.common.avatar.avatarmountlogic.AvatarMountLogicBase", package.seeall)

local AvatarMountLogicBase = class("AvatarMountLogicBase")

function AvatarMountLogicBase:ctor(avatarBase, logicParams)
	self._avatar = avatarBase
	self._logicParams = logicParams
end

function AvatarMountLogicBase:onReset()
	self._logicParams = nil
end

function AvatarMountLogicBase:start()
	return
end

function AvatarMountLogicBase:dispose()
	self:onReset()
end

return AvatarMountLogicBase
