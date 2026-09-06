-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/SenluowanxiangViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.SenluowanxiangViewPresentor", package.seeall)

local SenluowanxiangViewPresentor = class("SenluowanxiangViewPresentor", ViewPresentor)

function SenluowanxiangViewPresentor:ctor()
	SenluowanxiangViewPresentor.super.ctor(self)
end

function SenluowanxiangViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SenluowanxiangViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/tianmanking/senluowanxiangview.prefab"
	}
end

function SenluowanxiangViewPresentor:buildViews()
	return {
		SenluowanxiangView.New()
	}
end

return SenluowanxiangViewPresentor
