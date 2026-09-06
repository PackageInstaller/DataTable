-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompProcedualElems.lua

module("logicscene.scene.component.season.SceneCompProcedualElems", package.seeall)

local SceneCompProcedualElems = class("SceneCompProcedualElems", SceneComponentBase)
local procedualElems = {
	{
		assetPath = "effect/prefabs/story/saiji/cjsaiji/fx_scene_huo2.prefab",
		x = 22.52,
		y = 52.24
	}
}

function SceneCompProcedualElems:lateEnterFinished()
	for i = 1, #procedualElems do
		self._scene.unitFactory:createCustomSeasonUnit(0, procedualElems[i].assetPath, procedualElems[i].x, procedualElems[i].y)
	end
end

return SceneCompProcedualElems
