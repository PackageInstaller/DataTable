-- chunkname: @modules/logic/versionactivity3_9/racingcar/scene/comp/V3a9RacingCarSceneViewComp.lua

module("modules.logic.versionactivity3_9.racingcar.scene.comp.V3a9RacingCarSceneViewComp", package.seeall)

local V3a9RacingCarSceneViewComp = class("V3a9RacingCarSceneViewComp", BaseSceneComp)

function V3a9RacingCarSceneViewComp:onScenePrepared(sceneId, levelId)
	if levelId == V3a9RacingCarEnum.SceneLevelId.Main then
		ViewMgr.instance:openView(ViewName.V3a9RacingCarGameView)
	end
end

function V3a9RacingCarSceneViewComp:onSceneClose(sceneId, levelId)
	ViewMgr.instance:closeView(ViewName.V3a9RacingCarGameView)
end

return V3a9RacingCarSceneViewComp
