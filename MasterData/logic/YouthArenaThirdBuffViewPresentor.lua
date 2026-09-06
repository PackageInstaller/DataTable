-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdBuffViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdBuffViewPresentor", package.seeall)

local YouthArenaThirdBuffViewPresentor = class("YouthArenaThirdBuffViewPresentor", ViewPresentor)

function YouthArenaThirdBuffViewPresentor:ctor()
	YouthArenaThirdBuffViewPresentor.super.ctor(self)
end

function YouthArenaThirdBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdbuffview.prefab"
	}
end

function YouthArenaThirdBuffViewPresentor:buildViews()
	return {
		YouthArenaThirdBuffView.New()
	}
end

return YouthArenaThirdBuffViewPresentor
