-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerGetSolicitsViewPresentor.lua

module("logic.extensions.summontower.view.SummontowerGetSolicitsViewPresentor", package.seeall)

local SummontowerGetSolicitsViewPresentor = class("SummontowerGetSolicitsViewPresentor", ViewPresentor)

function SummontowerGetSolicitsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummontowerGetSolicitsViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/sumtowgetsolicitsview.prefab"
	}
end

function SummontowerGetSolicitsViewPresentor:buildViews()
	return {
		SummontowerGetSolicitsView.New()
	}
end

return SummontowerGetSolicitsViewPresentor
