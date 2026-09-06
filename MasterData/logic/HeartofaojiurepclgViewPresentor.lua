-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiurep/view/HeartofaojiurepclgViewPresentor.lua

module("logic.extensions.heartofaojiurep.view.HeartofaojiurepclgViewPresentor", package.seeall)

local HeartofaojiurepclgViewPresentor = class("HeartofaojiurepclgViewPresentor", ViewPresentor)

function HeartofaojiurepclgViewPresentor:ctor()
	HeartofaojiurepclgViewPresentor.super.ctor(self)
end

function HeartofaojiurepclgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartofaojiurepclgViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofaojiurep/heartofaojiurepclgview.prefab"
	}
end

function HeartofaojiurepclgViewPresentor:buildViews()
	return {
		HeartofaojiurepclgView.New()
	}
end

return HeartofaojiurepclgViewPresentor
