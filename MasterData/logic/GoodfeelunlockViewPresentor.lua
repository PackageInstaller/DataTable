-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelunlockViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelunlockViewPresentor", package.seeall)

local GoodfeelunlockViewPresentor = class("GoodfeelunlockViewPresentor", ViewPresentor)

function GoodfeelunlockViewPresentor:ctor()
	GoodfeelunlockViewPresentor.super.ctor(self)
end

function GoodfeelunlockViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoodfeelunlockViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelunlockview.prefab"
	}
end

function GoodfeelunlockViewPresentor:buildViews()
	return {
		GoodfeelunlockView.New()
	}
end

function GoodfeelunlockViewPresentor:onClickOutside()
	self:close()
end

return GoodfeelunlockViewPresentor
