-- chunkname: @modules/logic/scene/main/comp/MainSceneViewComp.lua

module("modules.logic.scene.main.comp.MainSceneViewComp", package.seeall)

local MainSceneViewComp = class("MainSceneViewComp", BaseSceneComp)

function MainSceneViewComp:onScenePrepared(sceneId, levelId)
	if DungeonController.instance:needShowDungeonViewByAdvPlay() then
		local viewName = DungeonController.instance:showDungeonViewByAdvPlay()

		if viewName then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, viewName)
		end
	elseif DungeonController.instance:needShowDungeonView() then
		local viewName = DungeonController.instance:showDungeonView()

		if viewName then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, viewName)
		end
	elseif GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DontOpenMain) then
		-- block empty
	else
		local teachingNeedOpenView = TeachingModel.instance:getNeedOpenView()

		if teachingNeedOpenView ~= nil then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, teachingNeedOpenView)
			ViewMgr.instance:openView(ViewName.MainView)
			TeachingController.instance:openCacheTeachingView()

			return
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.MainView)
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

function MainSceneViewComp:onSceneClose()
	ViewMgr.instance:closeView(ViewName.MainView)
end

return MainSceneViewComp
