-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/AvatarsMgrNew.lua

module("logiccommon.common.avatar.AvatarsMgrNew", package.seeall)

local AvatarsMgrNew = class("AvatarsMgrNew")

function AvatarsMgrNew:ctor()
	self:onReset()
end

function AvatarsMgrNew:onReset()
	if self._avatarPools then
		for k, v in pairs(self._avatarPools) do
			v:clear()
		end
	end

	self._avatarPools = {}
	self._avatarPools[AvatarCreateType.Player] = ObjectPool.New(20, function()
		return AvatarPlayer.New()
	end, function(avatar)
		avatar:destroy()
	end, function(avatar)
		avatar:reset()
	end)
	self._avatarPools[AvatarCreateType.Zoo] = ObjectPool.New(20, function()
		return AvatarZoo.New()
	end, function(avatar)
		avatar:destroy()
	end, function(avatar)
		avatar:reset()
	end)
	self._avatarPools[AvatarCreateType.Pig] = ObjectPool.New(20, function()
		return AvatarPig.New()
	end, function(avatar)
		avatar:destroy()
	end, function(avatar)
		avatar:reset()
	end)
end

function AvatarsMgrNew:getAvatarByMo(mo)
	if mo and mo.skeleton then
		local type = AvatarConfig.instance:getSkeletonCfgById(mo.skeleton).type
		local avatar = self:getAvatarByType(type)

		avatar:preSetMo(mo)

		return avatar
	else
		printError("avatar mgr get nil mo")
	end
end

function AvatarsMgrNew:getAvatarByType(type)
	if table.keyof(AvatarCreateType, type) then
		if self._avatarPools[type] then
			return self._avatarPools[type]:fetchObject()
		elseif type == AvatarCreateType.Base then
			print("A AvatarBase Create")

			return AvatarBase.New()
		end
	else
		printError("Get Error avatar type")
	end
end

function AvatarsMgrNew:getAvatarAndMoByCfgId(id)
	local mo = AvatarConfig.instance:getAvatarMoByCfgId(id)
	local avatar = self:getAvatarByType(mo:getAvatarType())

	mo:setDefaultState()
	avatar:preSetMo(mo)

	return avatar, mo
end

function AvatarsMgrNew:removeAvatar(removeAvatar)
	if removeAvatar then
		local type = removeAvatar:getAvatarCreateType()

		if type == AvatarCreateType.Player then
			removeAvatar:updateExtBgParent(nil, nil)
		end

		if self._avatarPools[type] then
			self._avatarPools[type]:returnObject(removeAvatar)
		elseif type == AvatarCreateType.Base then
			print("A AvatarBase destroy")
			removeAvatar:destroy()
		else
			removeAvatar:destroy()
		end
	else
		printError("Remove Nil Avatar")
	end
end

function AvatarsMgrNew:newObject(resPath, loadedHandler, handlerTarget)
	return ResCache.instance:newObject(resPath, loadedHandler, handlerTarget)
end

function AvatarsMgrNew:recycleObject(handler)
	ResCache.instance:recycleObject(handler)
end

AvatarsMgrNew.instance = AvatarsMgrNew.New()

return AvatarsMgrNew
