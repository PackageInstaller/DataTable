-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/festiveflower/view/FestiveflowergainViewPresentor.lua

module("logic.extensions.festiveflower.view.FestiveflowergainViewPresentor", package.seeall)

local FestiveflowergainViewPresentor = class("FestiveflowergainViewPresentor", ViewPresentor)

function FestiveflowergainViewPresentor:ctor()
	FestiveflowergainViewPresentor.super.ctor(self)
end

function FestiveflowergainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FestiveflowergainViewPresentor:dependWhatResources()
	return {
		"ui/views/festiveflower/festiveflowergainview.prefab"
	}
end

function FestiveflowergainViewPresentor:buildViews()
	return {
		FestiveFlowerGainView.New()
	}
end

return FestiveflowergainViewPresentor
