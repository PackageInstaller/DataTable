-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/HonglianzhanfangViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.moyan.HonglianzhanfangViewPresentor", package.seeall)

local HonglianzhanfangViewPresentor = class("HonglianzhanfangViewPresentor", ViewPresentor)

function HonglianzhanfangViewPresentor:ctor()
	HonglianzhanfangViewPresentor.super.ctor(self)
end

function HonglianzhanfangViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HonglianzhanfangViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/moyan/honglianzhanfangview.prefab"
	}
end

function HonglianzhanfangViewPresentor:buildViews()
	return {
		HonglianzhanfangView.New()
	}
end

return HonglianzhanfangViewPresentor
