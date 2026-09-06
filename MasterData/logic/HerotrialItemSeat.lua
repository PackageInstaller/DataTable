-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialItemSeat.lua

module("logic.extensions.herotrial.view.HerotrialItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local HerotrialItemSeat = class("HerotrialItemSeat", ItemSeat)

function HerotrialItemSeat.AddOnce(go)
	local component = HerotrialItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, HerotrialItemSeat)

	return component
end

function HerotrialItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, HerotrialItemSeat))
end

function HerotrialItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, HerotrialItemSeat)
end

function HerotrialItemSeat:_getPet(petId)
	return HerotrialModel.instance:getPet(petId)
end

function HerotrialItemSeat:_getCurFormId()
	return HerotrialModel.instance:getCurFormationId()
end

return HerotrialItemSeat
