-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/model/GoddessGloryFormationMO.lua

module("logic.extensions.goddessglory.model.ExpeditionFormationMO", package.seeall)

local GoddessGloryFormationMO = class("GoddessGloryFormationMO", FormationMO)

function GoddessGloryFormationMO:_getPet(id)
	local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	local stageId = GoddessGloryModel.instance:getCurStageId()

	return GoddessGloryPetsModel.instance:getPet(challengeId, stageId, id)
end

return GoddessGloryFormationMO
