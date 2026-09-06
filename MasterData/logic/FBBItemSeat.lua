-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/mission/FBBItemSeat.lua

module("logic.extensions.fbbchallenge.view.mission.FBBItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local FBBItemSeat = class("FBBItemSeat", ItemSeat)

function FBBItemSeat.AddOnce(go)
	local component = FBBItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, FBBItemSeat)

	return component
end

function FBBItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, FBBItemSeat))
end

function FBBItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, FBBItemSeat)
end

function FBBItemSeat:_getPet(petId)
	return FbbchallengeModel.instance:getPetMo(petId)
end

return FBBItemSeat
