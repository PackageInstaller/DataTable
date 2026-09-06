-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/RecordFormationMO.lua

module(..., package.seeall)

local RecordFormationMO = class("RecordFormationMO", FormationMO)

function RecordFormationMO:_getPet(id)
	return BattleRecordFmtModel.instance:getPet(id)
end

return RecordFormationMO
