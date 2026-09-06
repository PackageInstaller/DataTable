-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/AvatarsMgr.lua

module("logiccommon.common.avatar.AvatarsMgr", package.seeall)

local AvatarsMgr = class("AvatarsMgr", ObjectPool)

function AvatarsMgr:ctor()
	AvatarsMgr.super.ctor(self, 20, function()
		return Avatar.New()
	end, function(avatar)
		avatar:destroy()
	end, function(avatar)
		avatar:reset()
	end)
end

function AvatarsMgr:getAvatar()
	return Avatar.New()
end

function AvatarsMgr:removeAvatar(avatar)
	if avatar then
		avatar:destroy()
	end
end

function AvatarsMgr:newObject(resPath, loadedHandler, handlerTarget)
	return ResCache.instance:newObject(resPath, loadedHandler, handlerTarget)
end

function AvatarsMgr:recycleObject(handler)
	ResCache.instance:recycleObject(handler)
end

AvatarsMgr.instance = AvatarsMgr.New()

return AvatarsMgr
