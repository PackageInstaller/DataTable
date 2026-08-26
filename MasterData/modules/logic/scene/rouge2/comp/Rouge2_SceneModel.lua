-- chunkname: @modules/logic/scene/rouge2/comp/Rouge2_SceneModel.lua

module("modules.logic.scene.rouge2.comp.Rouge2_SceneModel", package.seeall)

local Rouge2_SceneModel = class("Rouge2_SceneModel", BaseSceneComp)

function Rouge2_SceneModel:onSceneStart(chapterId, layerId)
	Rouge2_MapLocalDataHelper.Init()
end

function Rouge2_SceneModel:onSceneClose()
	return
end

return Rouge2_SceneModel
