-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/controller/ExtensionRegistry.lua

module("logic.extensions.spineinterface.controller.ExtensionRegistry", package.seeall)

local ExtensionRegistry = class("ExtensionRegistry")

ExtensionRegistry._entries = ExtensionRegistry._entries or {}

function ExtensionRegistry.register(eventName, entry)
	if string.nilorempty(eventName) then
		printError("spineinterface extension eventName is empty")

		return
	end

	if ExtensionRegistry._entries[eventName] ~= nil then
		printError(string.format("duplicate spineinterface extension registration, eventName = %s", eventName))
	end

	ExtensionRegistry._entries[eventName] = entry
end

function ExtensionRegistry.ensureDefaults()
	if ExtensionRegistry._isDefaultRegistered then
		return
	end

	ExtensionRegistry._isDefaultRegistered = true

	ExtensionRegistry.register(MsEnum.Notify_CommonPopSpineScreen, {
		viewName = ViewName.CommonPopSpineScreenView,
		open = function(ctx, array)
			local skinId = array[2]

			return ViewMgr.instance:openAt(ctx.extendRoot, ViewName.CommonPopSpineScreenView, ctx.viewPresentor, ctx.spineComp, skinId)
		end
	})
	ExtensionRegistry.register(MsEnum.Notify_BubblegamePlay, {
		viewName = ViewName.SpineInterfaceBubbleGame,
		open = function(ctx, array)
			return ViewMgr.instance:openAt(ctx.extendRoot, ViewName.SpineInterfaceBubbleGame, ctx.viewPresentor, ctx.spineComp)
		end
	})
	ExtensionRegistry.register(MsEnum.Notify_XiWangShenNvEnvelopeSpineScreenView, {
		viewName = ViewName.XiWangShenNvEnvelopeSpineScreenView,
		open = function(ctx, array)
			local skinId = array[2]

			return ViewMgr.instance:openAt(ctx.extendRoot, ViewName.XiWangShenNvEnvelopeSpineScreenView, ctx.viewPresentor, ctx.spineComp, skinId)
		end
	})
	ExtensionRegistry.register(MsEnum.Notify_FeiNiYaClothesPopWinView, {
		viewName = ViewName.FeiNiYaClothesPopWinView,
		open = function(ctx, array)
			local partKey = array[2]

			return ViewMgr.instance:openAt(ctx.extendRoot, ViewName.FeiNiYaClothesPopWinView, ctx.viewPresentor, ctx.spineComp, partKey)
		end
	})
end

function ExtensionRegistry.openBagExtension(spineComp, extendRoot, viewPresentor, eventParams)
	if spineComp == nil or not spineComp:isSpineReloaded() then
		return
	end

	ExtensionRegistry.ensureDefaults()

	local array = string.split(eventParams, "#")
	local eventName = array[1]
	local entry = ExtensionRegistry._entries[eventName]

	if entry == nil then
		printError(string.format("unsupported spineinterface extension eventName = %s", eventName))

		return nil
	end

	local ctx = {
		spineComp = spineComp,
		extendRoot = extendRoot,
		viewPresentor = viewPresentor,
		eventParams = eventParams
	}

	return entry.open(ctx, array)
end

return ExtensionRegistry
