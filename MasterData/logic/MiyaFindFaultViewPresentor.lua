-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaFindFaultViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaFindFaultViewPresentor", package.seeall)

local MiyaFindFaultViewPresentor = class("MiyaFindFaultViewPresentor", ViewPresentor)

function MiyaFindFaultViewPresentor:ctor()
	MiyaFindFaultViewPresentor.super.ctor(self)
end

function MiyaFindFaultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiyaFindFaultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miyafindfaultview.prefab"
	}
end

function MiyaFindFaultViewPresentor:buildViews()
	return {
		MiyaFindFaultView.New()
	}
end

return MiyaFindFaultViewPresentor
