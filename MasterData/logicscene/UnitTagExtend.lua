-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/UnitTagExtend.lua

module("logicscene.scene.unit.UnitTagExtend", package.seeall)

local UnitTagExtend = {}

function UnitTagExtend.extend()
	UnitTag.SceneElement = "SceneElem"
	UnitTag.TilingSceneElem = "TilingSceneElem"
end

return UnitTagExtend
