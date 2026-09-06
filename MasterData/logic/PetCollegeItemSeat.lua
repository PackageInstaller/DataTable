-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetCollegeItemSeat.lua

module("logic.extensions.petcollege.view.PetCollegeItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local PetCollegeItemSeat = class("PetCollegeItemSeat", ItemSeat)

function PetCollegeItemSeat.AddOnce(go)
	local component = PetCollegeItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, PetCollegeItemSeat)

	return component
end

function PetCollegeItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, PetCollegeItemSeat))
end

function PetCollegeItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, PetCollegeItemSeat)
end

function PetCollegeItemSeat:_getPet(petId)
	return PetCollegeModel.instance:getPet(petId)
end

function PetCollegeItemSeat:_getCurFormId()
	return PetCollegeModel.instance:getCurFormationId()
end

return PetCollegeItemSeat
