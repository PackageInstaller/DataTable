-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NNCItemSeat.lua

module("logic.extensions.niannianchall.view.lightking.NNCItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local NNCItemSeat = class("NNCItemSeat", ItemSeat)

function NNCItemSeat.AddOnce(go)
	local component = NNCItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, NNCItemSeat)

	return component
end

function NNCItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, NNCItemSeat))
end

function NNCItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, NNCItemSeat)
end

function NNCItemSeat:_getPet(petId)
	return NianNianChallModel.instance:getPet(petId)
end

return NNCItemSeat
