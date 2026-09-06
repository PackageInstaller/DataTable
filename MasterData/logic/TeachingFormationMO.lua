-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/model/TeachingFormationMO.lua

module("logic.extensions.teachingdungeon.model.TeachingFormationMO", package.seeall)

local TeachingFormationMO = class("TeachingFormationMO", FormationMO)

function TeachingFormationMO:_getPet(id)
	return TeachingDungeonModel.instance:getPet(id)
end

return TeachingFormationMO
