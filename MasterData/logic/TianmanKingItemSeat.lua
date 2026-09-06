-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmanKingItemSeat.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.TianmanKingItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local TianmanKingItemSeat = class("TianmanKingItemSeat", ItemSeat)

function TianmanKingItemSeat.AddOnce(go)
	local component = TianmanKingItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, TianmanKingItemSeat)

	return component
end

function TianmanKingItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, TianmanKingItemSeat))
end

function TianmanKingItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, TianmanKingItemSeat)
end

function TianmanKingItemSeat:_getPet(petId)
	return TianmanKingModel.instance:getPetMo(petId)
end

return TianmanKingItemSeat
