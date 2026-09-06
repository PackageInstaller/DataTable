-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachingItemSeat.lua

module("logic.extensions.teachingdungeon.view.TeachingItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local TeachingItemSeat = class("TeachingItemSeat", ItemSeat)

function TeachingItemSeat.AddOnce(go)
	local component = TeachingItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, TeachingItemSeat)

	return component
end

function TeachingItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, TeachingItemSeat))
end

function TeachingItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, TeachingItemSeat)
end

function TeachingItemSeat:_getPet(petId)
	return TeachingDungeonModel.instance:getPet(petId)
end

function TeachingItemSeat:_getCurFormId()
	return TeachingDungeonModel.instance:getCurFormationId()
end

return TeachingItemSeat
