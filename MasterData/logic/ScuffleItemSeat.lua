-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/buzhen/ScuffleItemSeat.lua

module("logic.extensions.scuffle.view.buzhen.ScuffleItemSeat", package.seeall)

local ScuffleItemSeat = class("ScuffleItemSeat", ItemSeat)
local LuaComponentContainer = Framework.LuaComponentContainer

function ScuffleItemSeat.AddOnce(go)
	local component = ScuffleItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, ScuffleItemSeat)

	return component
end

function ScuffleItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, ScuffleItemSeat))
end

function ScuffleItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, ScuffleItemSeat)
end

function ScuffleItemSeat:_getPet(petId)
	return ScuffleModel.instance:getPet(petId)
end

function ScuffleItemSeat:_getCurFormId()
	return ScuffleModel.instance:getCurFormationId()
end

return ScuffleItemSeat
