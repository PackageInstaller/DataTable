-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/view/MusicGameSceneViewPresentor.lua

module("logic.extensions.musicgame.view.MusicGameSceneViewPresentor", package.seeall)

local MusicGameSceneViewPresentor = class("MusicGameSceneViewPresentor", ViewPresentor)

MusicGameSceneViewPresentor.PathPre = "ui/views/%s.prefab"

function MusicGameSceneViewPresentor:ctor()
	MusicGameSceneViewPresentor.super.ctor(self)
end

function MusicGameSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MusicGameSceneViewPresentor:dependWhatResources()
	local resPathList = {}
	local params = self:getOpenParam() or {}

	if not params[1] then
		local mgViewParam = MusicGameViewParam.New()
		local stageId = mgViewParam:getStageId()
		local stageData = MusicGameConfig.instance:getStageData(stageId)

		table.insert(resPathList, "ui/views/musicgame/musicgamesceneview.prefab")
		table.insert(resPathList, string.format(MusicGameSceneViewPresentor.PathPre, stageData.symbolPrefabName))

		return resPathList
	end
end

function MusicGameSceneViewPresentor:buildViews()
	return {
		MusicGameSceneView.New()
	}
end

return MusicGameSceneViewPresentor
