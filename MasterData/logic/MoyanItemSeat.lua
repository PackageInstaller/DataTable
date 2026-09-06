-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/mission/MoyanItemSeat.lua

module("logic.extensions.mission.view.MoyanItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local MoyanItemSeat = class("MoyanItemSeat", ItemSeat)

function MoyanItemSeat.AddOnce(go)
	local component = MoyanItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, MoyanItemSeat)

	return component
end

function MoyanItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, MoyanItemSeat))
end

function MoyanItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, MoyanItemSeat)
end

MoyanItemSeat.curGetPetCallBack = nil

function MoyanItemSeat:_getPet(petId)
	return MoyanItemSeat.curGetPetCallBack(petId)
end

return MoyanItemSeat
