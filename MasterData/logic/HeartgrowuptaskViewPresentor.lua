-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/growup/view/HeartgrowuptaskViewPresentor.lua

module("logic.extensions.growup.view.HeartgrowuptaskViewPresentor", package.seeall)

local HeartgrowuptaskViewPresentor = class("HeartgrowuptaskViewPresentor", ViewPresentor)

function HeartgrowuptaskViewPresentor:ctor()
	HeartgrowuptaskViewPresentor.super.ctor(self)
end

function HeartgrowuptaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartgrowuptaskViewPresentor:dependWhatResources()
	return {
		"ui/views/growup/heartgrowuptaskview.prefab"
	}
end

function HeartgrowuptaskViewPresentor:buildViews()
	return {
		HeartGrowUpTaskView.New()
	}
end

return HeartgrowuptaskViewPresentor
