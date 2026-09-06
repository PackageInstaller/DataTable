-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/ExpeditionItemSeat.lua

module("logic.extensions.formation.view.ExpeditionItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local ExpeditionItemSeat = class("ExpeditionItemSeat", ItemSeat)

function ExpeditionItemSeat.AddOnce(go)
	local component = ExpeditionItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, ExpeditionItemSeat)

	return component
end

function ExpeditionItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, ExpeditionItemSeat))
end

function ExpeditionItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, ExpeditionItemSeat)
end

function ExpeditionItemSeat:_getPet(petId)
	return ExpeditionFmtModel.instance:getPet(petId)
end

function ExpeditionItemSeat:_getCurFormId()
	return ExpeditionFmtModel.instance:getCurFormationId()
end

return ExpeditionItemSeat
