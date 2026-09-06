-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/fmtview/HexagramMissionItemSeat.lua

module("logic.extensions.yirenpozhen.view.fmtview.HexagramMissionItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local HexagramMissionItemSeat = class("HexagramMissionItemSeat", ItemSeat)

function HexagramMissionItemSeat.AddOnce(go)
	local component = HexagramMissionItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, HexagramMissionItemSeat)

	return component
end

function HexagramMissionItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, HexagramMissionItemSeat))
end

function HexagramMissionItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, HexagramMissionItemSeat)
end

function HexagramMissionItemSeat:_getPet(petId)
	return YirenPozhenController.instance:getTempMaxPet(petId)
end

return HexagramMissionItemSeat
