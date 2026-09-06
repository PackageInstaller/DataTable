-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/iceqibugame/view/IceQiBuGameResultViewPresentor.lua

module("logic.extensions.iceqibugame.view.IceQiBuGameResultViewPresentor", package.seeall)

local IceQiBuGameResultViewPresentor = class("IceQiBuGameResultViewPresentor", ViewPresentor)

function IceQiBuGameResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function IceQiBuGameResultViewPresentor:dependWhatResources()
	return {
		"ui/views/iceqibugame/iceqibugameresultview.prefab"
	}
end

function IceQiBuGameResultViewPresentor:buildViews()
	return {
		IceQiBuGameResultView.New()
	}
end

return IceQiBuGameResultViewPresentor
