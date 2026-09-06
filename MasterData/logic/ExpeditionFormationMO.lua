-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/ExpeditionFormationMO.lua

module("logic.extensions.formation.model.ExpeditionFormationMO", package.seeall)

local ExpeditionFormationMO = class("ExpeditionFormationMO", FormationMO)

function ExpeditionFormationMO:_getPet(id)
	return ExpeditionFmtModel.instance:getPet(id)
end

return ExpeditionFormationMO
