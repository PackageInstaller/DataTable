-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdMatchTabViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdMatchTabViewPresentor", package.seeall)

local YouthArenaThirdMatchTabViewPresentor = class("YouthArenaThirdMatchTabViewPresentor", ViewPresentor)

function YouthArenaThirdMatchTabViewPresentor:ctor()
	YouthArenaThirdMatchTabViewPresentor.super.ctor(self)
end

function YouthArenaThirdMatchTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdMatchTabViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdmatchtabview.prefab"
	}
end

function YouthArenaThirdMatchTabViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function YouthArenaThirdMatchTabViewPresentor:buildViews()
	return {
		YouthArenaThirdMatchTabView.New()
	}
end

return YouthArenaThirdMatchTabViewPresentor
