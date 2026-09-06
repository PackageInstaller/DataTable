-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/buzhen/ScuffleFormationRightView.lua

module("logic.extensions.scuffle.view.buzhen.ScuffleFormationRightView", package.seeall)

local ScuffleFormationRightView = class("ScuffleFormationRightView", FormationRightView)

function ScuffleFormationRightView:getPetMoById(petId)
	return (ScuffleModel.instance:getPet(petId))
end

function ScuffleFormationRightView:getAllShowPetList()
	return ScuffleModel.instance:getAllPets()
end

function ScuffleFormationRightView:_getCurFormation()
	return ScuffleModel.instance:getFormation()
end

return ScuffleFormationRightView
