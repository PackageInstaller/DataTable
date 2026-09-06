-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetCollegeFmtRightView.lua

module("logic.extensions.petcollege.view.PetCollegeFmtRightView", package.seeall)

local PetCollegeFmtRightView = class("PetCollegeFmtRightView", FormationRightView)

function PetCollegeFmtRightView:_getCurFormation()
	return PetCollegeModel.instance:getFormation()
end

function PetCollegeFmtRightView:getAllShowPetList()
	return PetCollegeModel.instance:getAllPets()
end

return PetCollegeFmtRightView
