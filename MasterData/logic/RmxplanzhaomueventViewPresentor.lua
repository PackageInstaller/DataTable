-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanzhaomueventViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanzhaomueventViewPresentor", package.seeall)

local RmxplanzhaomueventViewPresentor = class("RmxplanzhaomueventViewPresentor", ViewPresentor)

function RmxplanzhaomueventViewPresentor:ctor()
	RmxplanzhaomueventViewPresentor.super.ctor(self)
end

function RmxplanzhaomueventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplanzhaomueventViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanzhaomueventview.prefab"
	}
end

function RmxplanzhaomueventViewPresentor:buildViews()
	return {
		RmxplanzhaomueventView.New()
	}
end

return RmxplanzhaomueventViewPresentor
