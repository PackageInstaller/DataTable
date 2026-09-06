-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/controller/SpineInterfaceMemoryRuntime.lua

module("logic.extensions.spineinterface.controller.SpineInterfaceMemoryRuntime", package.seeall)

local SpineInterfaceMemoryRuntime = class("SpineInterfaceMemoryRuntime")

SpineInterfaceMemoryRuntime._dirtyMap = SpineInterfaceMemoryRuntime._dirtyMap or {}
SpineInterfaceMemoryRuntime._restoringMap = SpineInterfaceMemoryRuntime._restoringMap or {}

function SpineInterfaceMemoryRuntime.markDirty(comp)
	if comp == nil or SpineInterfaceMemoryRuntime._restoringMap[comp] then
		return
	end

	local profile = SpineInterfaceMemoryRegistry.getProfileByComp(comp)

	if profile == nil then
		return
	end

	SpineInterfaceMemoryRuntime._dirtyMap[comp] = true
end

function SpineInterfaceMemoryRuntime.flush(comp)
	if comp == nil or SpineInterfaceMemoryRuntime._restoringMap[comp] then
		return
	end

	if not SpineInterfaceMemoryRuntime._dirtyMap[comp] then
		return
	end

	local profile, skinPlanId = SpineInterfaceMemoryRegistry.getProfileByComp(comp)

	if profile == nil then
		SpineInterfaceMemoryRuntime._dirtyMap[comp] = nil

		return
	end

	local snapshot = profile:capture(comp)

	if snapshot == nil or not profile:validate(snapshot) then
		return
	end

	SpineInterfaceMemoryStore.save(skinPlanId, profile, snapshot)

	SpineInterfaceMemoryRuntime._dirtyMap[comp] = nil
end

function SpineInterfaceMemoryRuntime.restore(comp)
	if comp == nil then
		return
	end

	local profile, skinPlanId = SpineInterfaceMemoryRegistry.getProfileByComp(comp)

	if profile == nil then
		return
	end

	local snapshot = SpineInterfaceMemoryStore.load(skinPlanId, profile)

	if snapshot == nil or not profile:validate(snapshot) then
		return
	end

	SpineInterfaceMemoryRuntime._restoringMap[comp] = true

	profile:restore(comp, snapshot)

	SpineInterfaceMemoryRuntime._restoringMap[comp] = nil
	SpineInterfaceMemoryRuntime._dirtyMap[comp] = nil
end

function SpineInterfaceMemoryRuntime.clearComp(comp)
	if comp == nil then
		return
	end

	SpineInterfaceMemoryRuntime._dirtyMap[comp] = nil
	SpineInterfaceMemoryRuntime._restoringMap[comp] = nil
end

return SpineInterfaceMemoryRuntime
