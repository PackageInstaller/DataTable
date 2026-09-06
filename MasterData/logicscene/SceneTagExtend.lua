-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneTagExtend.lua

module("logicscene.scene.SceneTagExtend", package.seeall)

local SceneTagExtend = {}

function SceneTagExtend.extend()
	SceneTag.TriggerCameraSide = "TriggerCameraSide"
	SceneTag.GroundCamera = "GroundCamera"
end

return SceneTagExtend
