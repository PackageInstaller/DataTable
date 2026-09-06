-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/SccopyItemSeat.lua

module("logic.extensions.scenariocopy.view.SccopyItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local SccopyItemSeat = class("SccopyItemSeat", ItemSeat)

function SccopyItemSeat.AddOnce(go)
	local component = SccopyItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, SccopyItemSeat)

	return component
end

function SccopyItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, SccopyItemSeat))
end

function SccopyItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, SccopyItemSeat)
end

function SccopyItemSeat:_getPet(petId)
	return ScenariocopyModel.instance:getPet(petId)
end

function SccopyItemSeat:_getCurFormId()
	return ScenariocopyModel.instance:getCurFormationId()
end

return SccopyItemSeat
