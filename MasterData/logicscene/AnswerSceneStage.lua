-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/stage/AnswerSceneStage.lua

module("logicscene.scene.component.stage.AnswerSceneStage", package.seeall)

local AnswerSceneStage = class("AnswerSceneStage", TilingSceneStage)

function AnswerSceneStage:_preloadSceneResources(camSizeH, camSizeW, camDetSizeW, camDetSizeH)
	self:_prepareTerrainResources()
	self:_prepareElementsResources()

	local helpCo = AnswerSceneConfig.instance:getHelpCo(AnswerSceneMO.HelpType_ExceptError)

	self:_addNeedLoadResource(helpCo.effPath .. ".prefab")
end

function AnswerSceneStage:_getCameraSizeScale()
	return 100
end

function AnswerSceneStage:_startJumperUIRes()
	self:_onlyLoadDeaultUIRes()
end

return AnswerSceneStage
