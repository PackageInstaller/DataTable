-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/mission/DragontrialItemSeat.lua

module("logic.extensions.dragontrial.view.mission.DragontrialItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local DragontrialItemSeat = class("DragontrialItemSeat", ItemSeat)

function DragontrialItemSeat.AddOnce(go)
	local component = DragontrialItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, DragontrialItemSeat)

	return component
end

function DragontrialItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, DragontrialItemSeat))
end

function DragontrialItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, DragontrialItemSeat)
end

function DragontrialItemSeat:_getPet(petId)
	local planId = DragontrialModel.instance:getCurrPetPlanId()
	local petMo

	return planId and planId > 0 and DragontrialModel.instance:getPetWithPlanId(planId, petId) or DragontrialModel.instance:getBagPet(petId)
end

return DragontrialItemSeat
