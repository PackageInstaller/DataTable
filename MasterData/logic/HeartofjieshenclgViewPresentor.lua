-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/view/HeartofjieshenclgViewPresentor.lua

module("logic.extensions.heartofjieshen.view.HeartofjieshenclgViewPresentor", package.seeall)

local HeartofjieshenclgViewPresentor = class("HeartofjieshenclgViewPresentor", ViewPresentor)

function HeartofjieshenclgViewPresentor:ctor()
	HeartofjieshenclgViewPresentor.super.ctor(self)
end

function HeartofjieshenclgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartofjieshenclgViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofjieshen/heartofjieshenclgview.prefab"
	}
end

function HeartofjieshenclgViewPresentor:buildViews()
	return {
		HeartofjieshenclgView.New()
	}
end

return HeartofjieshenclgViewPresentor
