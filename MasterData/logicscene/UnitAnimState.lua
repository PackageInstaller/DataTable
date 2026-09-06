-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/UnitAnimState.lua

module("logic.common.scene.unit.component.spine.UnitAnimState", package.seeall)

local UnitAnimState = {}

UnitAnimState.Idle = "idle"
UnitAnimState.Idle_Front = "idle_z"
UnitAnimState.Idle_Back = "idle_b"
UnitAnimState.Walk = "run"
UnitAnimState.Walk_Front = "run_z"
UnitAnimState.Walk_Back = "run_b"
UnitAnimState.Walk2 = "walk"
UnitAnimState.Eat = "eat"
UnitAnimState.Touch = "touch"

return UnitAnimState
