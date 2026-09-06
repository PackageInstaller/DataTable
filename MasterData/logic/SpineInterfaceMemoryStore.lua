-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/controller/SpineInterfaceMemoryStore.lua

module("logic.extensions.spineinterface.controller.SpineInterfaceMemoryStore", package.seeall)

local SpineInterfaceMemoryStore = class("SpineInterfaceMemoryStore")
local KEY_FORMAT = "SpineInterfaceMemory_%s_%s"

function SpineInterfaceMemoryStore.getKey(skinPlanId, profile)
	if profile == nil or string.nilorempty(profile.profileId) then
		return nil
	end

	return string.format(KEY_FORMAT, checknumber(skinPlanId), profile.profileId)
end

function SpineInterfaceMemoryStore.load(skinPlanId, profile)
	local key = SpineInterfaceMemoryStore.getKey(skinPlanId, profile)

	if string.nilorempty(key) then
		return nil
	end

	return GameUtil.getUserData(key)
end

function SpineInterfaceMemoryStore.save(skinPlanId, profile, snapshot)
	local key = SpineInterfaceMemoryStore.getKey(skinPlanId, profile)

	if string.nilorempty(key) or snapshot == nil then
		return
	end

	GameUtil.saveUserData(key, snapshot)
end

return SpineInterfaceMemoryStore
