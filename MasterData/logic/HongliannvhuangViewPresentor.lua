-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/HongliannvhuangViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.moyan.HongliannvhuangViewPresentor", package.seeall)

local HongliannvhuangViewPresentor = class("HongliannvhuangViewPresentor", ViewPresentor)

function HongliannvhuangViewPresentor:ctor()
	HongliannvhuangViewPresentor.super.ctor(self)
end

function HongliannvhuangViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HongliannvhuangViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/moyan/hongliannvhuangview.prefab"
	}
end

function HongliannvhuangViewPresentor:buildViews()
	return {
		HongliannvhuangView.New()
	}
end

return HongliannvhuangViewPresentor
