-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerProtagonistHaloViewPresentor.lua

module("logic.extensions.summontower.view.SummontowerProtagonistHaloViewPresentor", package.seeall)

local SummontowerProtagonistHaloViewPresentor = class("SummontowerProtagonistHaloViewPresentor", ViewPresentor)

function SummontowerProtagonistHaloViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummontowerProtagonistHaloViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/sumtowprotagonisthaloview.prefab"
	}
end

function SummontowerProtagonistHaloViewPresentor:buildViews()
	return {
		SummontowerProtagonistHaloView.New()
	}
end

return SummontowerProtagonistHaloViewPresentor
