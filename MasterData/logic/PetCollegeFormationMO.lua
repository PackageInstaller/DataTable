-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/model/PetCollegeFormationMO.lua

module("logic.extensions.petcollege.model.PetCollegeFormationMO", package.seeall)

local PetCollegeFormationMO = class("PetCollegeFormationMO", FormationMO)

function PetCollegeFormationMO:_getPet(id)
	return PetCollegeModel.instance:getPet(id)
end

return PetCollegeFormationMO
