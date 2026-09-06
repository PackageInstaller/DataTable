-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/growup/view/HeartgrowupViewPresentor.lua

module("logic.extensions.growup.view.HeartgrowupViewPresentor", package.seeall)

local HeartgrowupViewPresentor = class("HeartgrowupViewPresentor", ViewPresentor)

function HeartgrowupViewPresentor:ctor()
	HeartgrowupViewPresentor.super.ctor(self)
end

function HeartgrowupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartgrowupViewPresentor:dependWhatResources()
	return {
		"ui/views/growup/heartgrowupview.prefab"
	}
end

function HeartgrowupViewPresentor:buildViews()
	return {
		HeartGrowUpView.New()
	}
end

return HeartgrowupViewPresentor
