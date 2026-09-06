-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/iceqibugame/view/IceQiBuGameSceneViewPresentor.lua

module("logic.extensions.iceqibugame.view.IceQiBuGameSceneViewPresentor", package.seeall)

local IceQiBuGameSceneViewPresentor = class("IceQiBuGameSceneViewPresentor", ViewPresentor)

function IceQiBuGameSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IceQiBuGameSceneViewPresentor:dependWhatResources()
	return {
		"ui/views/iceqibugame/iceqibugamesceneview.prefab"
	}
end

function IceQiBuGameSceneViewPresentor:buildViews()
	return {
		IceQiBuGameSceneView.New()
	}
end

return IceQiBuGameSceneViewPresentor
