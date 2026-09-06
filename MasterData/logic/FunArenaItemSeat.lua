-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/formation/FunArenaItemSeat.lua

module("logic.extensions.funarena.view.formation.FunArenaItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local FunArenaItemSeat = class("FunArenaItemSeat", ItemSeat)

function FunArenaItemSeat.AddOnce(go)
	local component = FunArenaItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, FunArenaItemSeat)

	return component
end

function FunArenaItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, FunArenaItemSeat))
end

function FunArenaItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, FunArenaItemSeat)
end

function FunArenaItemSeat:_getPet(petId)
	return FunArenaModel.instance:getPetMo(petId)
end

return FunArenaItemSeat
