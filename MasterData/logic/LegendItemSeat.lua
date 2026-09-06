-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendItemSeat.lua

module("logic.extensions.legend.view.LegendItemSeat", package.seeall)

local LegendItemSeat = class("LegendItemSeat", ItemSeat)
local LuaComponentContainer = Framework.LuaComponentContainer

function LegendItemSeat.AddOnce(go)
	local component = LegendItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, LegendItemSeat)

	return component
end

function LegendItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, LegendItemSeat))
end

function LegendItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, LegendItemSeat)
end

function LegendItemSeat:_getPet(petId)
	return LegendModel.instance:getPet(petId)
end

function LegendItemSeat:_getCurFormId()
	return LegendModel.instance:getCurFormationId()
end

return LegendItemSeat
