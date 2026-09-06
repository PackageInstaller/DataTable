-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/view/HeartofjieshenrankViewPresentor.lua

module("logic.extensions.heartofjieshen.view.HeartofjieshenrankViewPresentor", package.seeall)

local HeartofjieshenrankViewPresentor = class("HeartofjieshenrankViewPresentor", ViewPresentor)

function HeartofjieshenrankViewPresentor:ctor()
	HeartofjieshenrankViewPresentor.super.ctor(self)
end

function HeartofjieshenrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartofjieshenrankViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofjieshen/heartofjieshenrankview.prefab"
	}
end

function HeartofjieshenrankViewPresentor:buildViews()
	return {
		HeartofjieshenrankView.New()
	}
end

return HeartofjieshenrankViewPresentor
