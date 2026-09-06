-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/holychallmission/HolyChallItemSeat.lua

module("logic.extensions.kingway.view.holychallmission.HolyChallItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local HolyChallItemSeat = class("HolyChallItemSeat", ItemSeat)

function HolyChallItemSeat.AddOnce(go)
	local component = HolyChallItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, HolyChallItemSeat)

	return component
end

function HolyChallItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, HolyChallItemSeat))
end

function HolyChallItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, HolyChallItemSeat)
end

function HolyChallItemSeat:_getPet(petId)
	return HolyChallModel.instance:getPet(petId)
end

function HolyChallItemSeat:_getCurFormId()
	return HolyChallModel.instance:getCurFormationId()
end

return HolyChallItemSeat
