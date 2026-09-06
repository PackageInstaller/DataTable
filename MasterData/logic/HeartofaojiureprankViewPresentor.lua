-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiurep/view/HeartofaojiureprankViewPresentor.lua

module("logic.extensions.heartofaojiurep.view.HeartofaojiureprankViewPresentor", package.seeall)

local HeartofaojiureprankViewPresentor = class("HeartofaojiureprankViewPresentor", ViewPresentor)

function HeartofaojiureprankViewPresentor:ctor()
	HeartofaojiureprankViewPresentor.super.ctor(self)
end

function HeartofaojiureprankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartofaojiureprankViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofaojiurep/heartofaojiureprankview.prefab"
	}
end

function HeartofaojiureprankViewPresentor:buildViews()
	return {
		HeartofaojiureprankView.New()
	}
end

return HeartofaojiureprankViewPresentor
