-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessPetsGameResultViewPresentor.lua

module("logic.extensions.guesspets.view.GuessPetsGameResultViewPresentor", package.seeall)

local GuessPetsGameResultViewPresentor = class("GuessPetsGameResultViewPresentor", ViewPresentor)

function GuessPetsGameResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GuessPetsGameResultViewPresentor:dependWhatResources()
	return {
		"ui/views/guesspets/guesspetsrankview.prefab"
	}
end

function GuessPetsGameResultViewPresentor:buildViews()
	return {
		GuessPetsGameResultView.New()
	}
end

return GuessPetsGameResultViewPresentor
