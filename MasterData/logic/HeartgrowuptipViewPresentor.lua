-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/growup/view/HeartgrowuptipViewPresentor.lua

module("logic.extensions.growup.view.HeartgrowuptipViewPresentor", package.seeall)

local HeartgrowuptipViewPresentor = class("HeartgrowuptipViewPresentor", ViewPresentor)

function HeartgrowuptipViewPresentor:ctor()
	HeartgrowuptipViewPresentor.super.ctor(self)
end

function HeartgrowuptipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HeartgrowuptipViewPresentor:dependWhatResources()
	return {
		"ui/views/growup/heartgrowuptipview.prefab"
	}
end

function HeartgrowuptipViewPresentor:buildViews()
	return {
		HeartGrowUpTipView.New()
	}
end

return HeartgrowuptipViewPresentor
