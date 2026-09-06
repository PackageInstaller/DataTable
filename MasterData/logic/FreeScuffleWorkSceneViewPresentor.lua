-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleWorkSceneViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleWorkSceneViewPresentor", package.seeall)

local FreeScuffleWorkSceneViewPresentor = class("FreeScuffleWorkSceneViewPresentor", ViewPresentor)

function FreeScuffleWorkSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FreeScuffleWorkSceneViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescuffleworksceneview.prefab"
	}
end

function FreeScuffleWorkSceneViewPresentor:buildViews()
	return {
		FreeScuffleWorkSceneView.New()
	}
end

return FreeScuffleWorkSceneViewPresentor
