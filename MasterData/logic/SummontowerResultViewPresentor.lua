-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerResultViewPresentor.lua

module("logic.extensions.summontower.view.SummontowerResultViewPresentor", package.seeall)

local SummontowerResultViewPresentor = class("SummontowerResultViewPresentor", ViewPresentor)

function SummontowerResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummontowerResultViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/summontowerpopview.prefab"
	}
end

function SummontowerResultViewPresentor:buildViews()
	return {
		SummontowerResultView.New()
	}
end

return SummontowerResultViewPresentor
