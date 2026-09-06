-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstannualwelfare/view/SkinTryTakeViewPresentor.lua

module("logic.extensions.firstannualwelfare.view.SkinTryTakeViewPresentor", package.seeall)

local SkinTryTakeViewPresentor = class("SkinTryTakeViewPresentor", ViewPresentor)

function SkinTryTakeViewPresentor:ctor()
	SkinTryTakeViewPresentor.super.ctor(self)
end

function SkinTryTakeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkinTryTakeViewPresentor:dependWhatResources()
	return {
		"ui/views/firstannualwelfare/annualmain/skintrytakeview.prefab"
	}
end

function SkinTryTakeViewPresentor:buildViews()
	return {
		SkinTryTakeView.New()
	}
end

return SkinTryTakeViewPresentor
