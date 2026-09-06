-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerFormationMO.lua

module("logic.extensions.formation.model.SummontowerFormationMO", package.seeall)

local SummontowerFormationMO = class("SummontowerFormationMO", FormationMO)

function SummontowerFormationMO:_getPet(id)
	return SummontowerPetsModel.instance:getPet(id)
end

return SummontowerFormationMO
