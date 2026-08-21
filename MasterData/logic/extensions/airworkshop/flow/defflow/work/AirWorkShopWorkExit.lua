-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/work/AirWorkShopWorkExit.lua

module("logic.extensions.airworkshop.flow.defflow.work.AirWorkShopWorkExit", package.seeall)

local M = class("AirWorkShopWorkExit", WorkBase)

function M:onEnter(context)
	if context.model:isJumpToAnotherScene() then
		local removeSceneInStack = true
		local removeAll = true

		SceneFace.instance:exitScene(removeSceneInStack, removeAll)
	else
		SceneFace.instance:backScene()
	end

	self:onDone(WorkResult.Succeed)
end

function M:_enterLastScene()
	local backSceneInfo = SceneFace.instance:getCurrBackInfo()
	local backSceneTyp = backSceneInfo and backSceneInfo.sceneType or SceneType.Room

	if backSceneTyp == SceneType.Room then
		local mainSceneLoading
		local notOpenMainUI = true
		local isBackScene = true

		SceneFace.instance:enterRoomScene(mainSceneLoading, notOpenMainUI, isBackScene)
	end
end

function M:onExit(isInterrupt)
	return
end

return M
