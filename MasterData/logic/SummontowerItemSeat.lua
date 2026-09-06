-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerItemSeat.lua

module("logic.extensions.formation.view.SummontowerItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local SummontowerItemSeat = class("SummontowerItemSeat", ItemSeat)

function SummontowerItemSeat.AddOnce(go)
	local component = SummontowerItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, SummontowerItemSeat)

	return component
end

function SummontowerItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, SummontowerItemSeat))
end

function SummontowerItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, SummontowerItemSeat)
end

function SummontowerItemSeat:_getPet(petId)
	return SummontowerPetsModel.instance:getPet(petId)
end

function SummontowerItemSeat:_getCurFormId()
	return SummontowerFmtModel.instance:getCurFormationId()
end

return SummontowerItemSeat
