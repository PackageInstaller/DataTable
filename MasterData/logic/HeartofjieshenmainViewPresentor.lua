-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/view/HeartofjieshenmainViewPresentor.lua

module("logic.extensions.heartofjieshen.view.HeartofjieshenmainViewPresentor", package.seeall)

local HeartofjieshenmainViewPresentor = class("HeartofjieshenmainViewPresentor", ViewPresentor)

function HeartofjieshenmainViewPresentor:ctor()
	HeartofjieshenmainViewPresentor.super.ctor(self)
end

function HeartofjieshenmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartofjieshenmainViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofjieshen/heartofjieshenmainview.prefab"
	}
end

function HeartofjieshenmainViewPresentor:buildViews()
	return {
		HeartofjieshenmainView.New()
	}
end

return HeartofjieshenmainViewPresentor
