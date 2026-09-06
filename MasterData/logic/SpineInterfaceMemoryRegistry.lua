-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/controller/SpineInterfaceMemoryRegistry.lua

module("logic.extensions.spineinterface.controller.SpineInterfaceMemoryRegistry", package.seeall)

local SpineInterfaceMemoryRegistry = class("SpineInterfaceMemoryRegistry")

SpineInterfaceMemoryRegistry._profiles = SpineInterfaceMemoryRegistry._profiles or {}

function SpineInterfaceMemoryRegistry.register(skinPlanId, profile)
	skinPlanId = checknumber(skinPlanId)

	if skinPlanId <= 0 or profile == nil then
		return
	end

	if SpineInterfaceMemoryRegistry._profiles[skinPlanId] ~= nil then
		printError(string.format("duplicate spineinterface memory profile, skinPlanId = %s", skinPlanId))
	end

	SpineInterfaceMemoryRegistry._profiles[skinPlanId] = profile
end

function SpineInterfaceMemoryRegistry.ensureDefaults()
	if SpineInterfaceMemoryRegistry._isDefaultRegistered then
		return
	end

	SpineInterfaceMemoryRegistry._isDefaultRegistered = true

	SpineInterfaceMemoryRegistry.register(1802104, FeiNiYaClothesMemoryProfile)
end

function SpineInterfaceMemoryRegistry.getProfile(skinPlanId)
	SpineInterfaceMemoryRegistry.ensureDefaults()

	return SpineInterfaceMemoryRegistry._profiles[checknumber(skinPlanId)]
end

function SpineInterfaceMemoryRegistry.getProfileByComp(comp)
	if comp == nil or not comp.isSpineReloaded or not comp:isSpineReloaded() then
		return nil, nil
	end

	local skinId = comp:getSkinId()

	if checknumber(skinId) <= 0 then
		return nil, nil
	end

	local skinPlanId = SpineInterfaceConfig.instance:getSkinPlanId(skinId)

	return SpineInterfaceMemoryRegistry.getProfile(skinPlanId), skinPlanId
end

return SpineInterfaceMemoryRegistry
