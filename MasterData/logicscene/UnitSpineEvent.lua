-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/UnitSpineEvent.lua

module("logicscene.scene.unit.UnitSpineEvent", package.seeall)

local UnitSpineEvent = class("UnitSpineEvent")

UnitSpineEvent.ActionStart = 0
UnitSpineEvent.ActionComplete = 1
UnitSpineEvent.ActionEnd = 2
UnitSpineEvent.ActionInterrupt = 3

return UnitSpineEvent
