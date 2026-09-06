-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HTVerifytipViewPresentor.lua

module("logic.extensions.herotrial.view.HtverifytipViewPresentor", package.seeall)

local HtverifytipViewPresentor = class("HtverifytipViewPresentor", ViewPresentor)

function HtverifytipViewPresentor:ctor()
	HtverifytipViewPresentor.super.ctor(self)
end

function HtverifytipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HtverifytipViewPresentor:dependWhatResources()
	return {
		"ui/views/herotrial/htverifytipview.prefab"
	}
end

function HtverifytipViewPresentor:buildViews()
	return {
		HTVerifytipView.New()
	}
end

return HtverifytipViewPresentor
