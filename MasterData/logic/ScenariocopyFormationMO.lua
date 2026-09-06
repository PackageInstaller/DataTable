-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/model/ScenariocopyFormationMO.lua

module("logic.extensions.scenariocopy.model.ScenariocopyFormationMO", package.seeall)

local ScenariocopyFormationMO = class("ScenariocopyFormationMO", FormationMO)

function ScenariocopyFormationMO:_getPet(id)
	return ScenariocopyModel.instance:getPet(id)
end

return ScenariocopyFormationMO
