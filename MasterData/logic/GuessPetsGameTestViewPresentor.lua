-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessPetsGameTestViewPresentor.lua

module("logic.extensions.guesspets.view.GuessPetsGameTestViewPresentor", package.seeall)

local GuessPetsGameTestViewPresentor = class("GuessPetsGameTestViewPresentor", ViewPresentor)

function GuessPetsGameTestViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessPetsGameTestViewPresentor:dependWhatResources()
	return {
		"ui/views/guesspets/guesspetsgametestview.prefab"
	}
end

function GuessPetsGameTestViewPresentor:buildViews()
	return {
		GuessPetsGameTestView.New()
	}
end

return GuessPetsGameTestViewPresentor
