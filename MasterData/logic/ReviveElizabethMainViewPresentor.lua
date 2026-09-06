-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/view/ReviveElizabethMainViewPresentor.lua

module("logic.extensions.reviveelizabeth.view.ReviveElizabethMainViewPresentor", package.seeall)

local ReviveElizabethMainViewPresentor = class("ReviveElizabethMainViewPresentor", ViewPresentor)

function ReviveElizabethMainViewPresentor:ctor()
	ReviveElizabethMainViewPresentor.super.ctor(self)
end

function ReviveElizabethMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ReviveElizabethMainViewPresentor:dependWhatResources()
	return {
		"ui/views/reviveelizabeth/reviveelizabethmainview.prefab"
	}
end

function ReviveElizabethMainViewPresentor:buildViews()
	return {
		ReviveElizabethMainView.New()
	}
end

function ReviveElizabethMainViewPresentor:getTempResources()
	return {
		"ui/bigbg/story/story_bg/gal_y_41_1.png",
		"ui/bigbg/story/story_bg/gal_y_41_2.png"
	}
end

return ReviveElizabethMainViewPresentor
