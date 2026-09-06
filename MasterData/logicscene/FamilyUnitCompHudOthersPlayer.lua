-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/family/FamilyUnitCompHudOthersPlayer.lua

module("logicscene.scene.unit.component.family.FamilyUnitCompHudOthersPlayer", package.seeall)

local FamilyUnitCompHudOthersPlayer = class("FamilyUnitCompHudOthersPlayer", UnitCompHudOthersPlayer)

function FamilyUnitCompHudOthersPlayer:_getModel()
	return FamilySceneModel.instance
end

return FamilyUnitCompHudOthersPlayer
