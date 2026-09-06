-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/specialviews/XiongMaoJumpViewPresentor.lua

module("logic.extensions.challenge.view.specialviews.XiongMaoJumpViewPresentor", package.seeall)

local XiongMaoJumpViewPresentor = class("XiongMaoJumpViewPresentor", ViewPresentor)

function XiongMaoJumpViewPresentor:ctor()
	XiongMaoJumpViewPresentor.super.ctor(self)
end

function XiongMaoJumpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiongMaoJumpViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/choose/spmissionview/xiongmaojumpview.prefab"
	}
end

function XiongMaoJumpViewPresentor:buildViews()
	return {
		XiongMaoJumpView.New()
	}
end

return XiongMaoJumpViewPresentor
