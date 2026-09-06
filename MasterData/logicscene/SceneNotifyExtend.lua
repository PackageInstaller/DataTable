-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneNotifyExtend.lua

module("logicscene.scene.SceneNotifyExtend", package.seeall)

local SceneNotifyExtend = {}

function SceneNotifyExtend.extend()
	SceneNotify.AllUnitsLoaded = 101
	SceneNotify.StageLoaded = 102
end

return SceneNotifyExtend
