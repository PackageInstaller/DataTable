-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hexlineup/view/HexLineupSceneViewPresentor.lua

module("logic.extensions.hexlineup.view.HexLineupSceneViewPresentor", package.seeall)

local HexLineupSceneViewPresentor = class("HexLineupSceneViewPresentor", ViewPresentor)

function HexLineupSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HexLineupSceneViewPresentor:dependWhatResources()
	return {
		"ui/views/hexlineup/hexlineupsceneview.prefab"
	}
end

function HexLineupSceneViewPresentor:buildViews()
	return {
		HexLineupSceneView.New()
	}
end

return HexLineupSceneViewPresentor
