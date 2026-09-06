-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/festiveflower/view/FestiveflowermainViewPresentor.lua

module("logic.extensions.festiveflower.view.FestiveflowermainViewPresentor", package.seeall)

local FestiveflowermainViewPresentor = class("FestiveflowermainViewPresentor", ViewPresentor)

function FestiveflowermainViewPresentor:ctor()
	FestiveflowermainViewPresentor.super.ctor(self)
end

function FestiveflowermainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FestiveflowermainViewPresentor:dependWhatResources()
	return {
		"ui/views/festiveflower/festiveflowermainview.prefab"
	}
end

function FestiveflowermainViewPresentor:buildViews()
	return {
		FestiveFlowerMainView.New()
	}
end

return FestiveflowermainViewPresentor
