-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerrankViewPresentor.lua

module("logic.extensions.summontower.view.SummontowerrankViewPresentor", package.seeall)

local SummontowerrankViewPresentor = class("SummontowerrankViewPresentor", ViewPresentor)

function SummontowerrankViewPresentor:ctor()
	SummontowerrankViewPresentor.super.ctor(self)
end

function SummontowerrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummontowerrankViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/summontowerrankview.prefab"
	}
end

function SummontowerrankViewPresentor:buildViews()
	return {
		SummontowerrankView.New()
	}
end

return SummontowerrankViewPresentor
