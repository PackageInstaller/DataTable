-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingItemSeat.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local LightKingItemSeat = class("LightKingItemSeat", ItemSeat)

function LightKingItemSeat.AddOnce(go)
	local component = LightKingItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, LightKingItemSeat)

	return component
end

function LightKingItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, LightKingItemSeat))
end

function LightKingItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, LightKingItemSeat)
end

function LightKingItemSeat:_getPet(petId)
	return LightKingModel.instance:getPetMo(petId)
end

return LightKingItemSeat
