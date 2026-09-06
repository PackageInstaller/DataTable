-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signindaily/view/SignindailyViewPresentor.lua

module("logic.extensions.signindaily.view.SignindailyViewPresentor", package.seeall)

local SignindailyViewPresentor = class("SignindailyViewPresentor", ViewPresentor)

function SignindailyViewPresentor:ctor()
	SignindailyViewPresentor.super.ctor(self)
end

function SignindailyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SignindailyViewPresentor:dependWhatResources()
	return {
		"ui/views/signindaily/signindailyview.prefab"
	}
end

function SignindailyViewPresentor:buildViews()
	return {
		SignindailyView.New()
	}
end

return SignindailyViewPresentor
