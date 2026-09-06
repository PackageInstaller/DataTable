-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionFamilyOtherPlayerMove.lua

module("logicscene.scene.unit.action.UnitActionFamilyOtherPlayerMove", package.seeall)

local UnitActionFamilyOtherPlayerMove = class("UnitActionFamilyOtherPlayerMove", UnitActionMoveToXZ)

function UnitActionFamilyOtherPlayerMove:_getMoveSpeedRate()
	return 1 * FamilyScene.PlayerSpeed
end

return UnitActionFamilyOtherPlayerMove
