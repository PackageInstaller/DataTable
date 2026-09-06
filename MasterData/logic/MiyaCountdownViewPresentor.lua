-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaCountdownViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaCountdownViewPresentor", package.seeall)

local MiyaCountdownViewPresentor = class("MiyaCountdownViewPresentor", ViewPresentor)

function MiyaCountdownViewPresentor:ctor()
	MiyaCountdownViewPresentor.super.ctor(self)
end

function MiyaCountdownViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiyaCountdownViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miyacountdownview.prefab"
	}
end

function MiyaCountdownViewPresentor:buildViews()
	return {
		MiyaCountdownView.New()
	}
end

return MiyaCountdownViewPresentor
