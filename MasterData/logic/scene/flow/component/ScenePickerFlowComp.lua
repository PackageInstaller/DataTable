-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/flow/component/ScenePickerFlowComp.lua

module("logic.scene.flow.component.ScenePickerFlowComp", package.seeall)

local M = class("ScenePickerFlowComp", ISceneFlowComp)

function M:onEnterDone()
	ScenePickerViewFacade.instance:open()
end

function M:onExit()
	ScenePickerViewFacade.instance:close()
end

return M
