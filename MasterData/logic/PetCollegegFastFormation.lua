-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/model/PetCollegegFastFormation.lua

module("logic.extensions.petcollege.model.PetCollegegFastFormation", package.seeall)

local PetCollegegFastFormation = class("PetCollegegFastFormation", FastFormation)

function PetCollegegFastFormation:_getCurFormId()
	return PetCollegeModel.instance:getCurFormationId()
end

function PetCollegegFastFormation:_getCurFormation()
	return PetCollegeModel.instance:getFormation()
end

function PetCollegegFastFormation:_getPets()
	return PetCollegeModel.instance:getAllPets()
end

function PetCollegegFastFormation:_getPet(id)
	return PetCollegeModel.instance:getPet(id)
end

function PetCollegegFastFormation:getMyCurFormationList()
	return nil
end

PetCollegegFastFormation.instance = PetCollegegFastFormation.New()

return PetCollegegFastFormation
