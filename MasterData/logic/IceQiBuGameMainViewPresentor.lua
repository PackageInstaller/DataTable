-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/iceqibugame/view/IceQiBuGameMainViewPresentor.lua

module("logic.extensions.iceqibugame.view.IceQiBuGameMainViewPresentor", package.seeall)

local IceQiBuGameMainViewPresentor = class("IceQiBuGameMainViewPresentor", ViewPresentor)

function IceQiBuGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IceQiBuGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/iceqibugame/iceqibugamemainview.prefab"
	}
end

function IceQiBuGameMainViewPresentor:buildViews()
	return {
		IceQiBuGameMainView.New()
	}
end

return IceQiBuGameMainViewPresentor
