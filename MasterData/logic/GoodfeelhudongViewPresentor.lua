-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelhudongViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelhudongViewPresentor", package.seeall)

local GoodfeelhudongViewPresentor = class("GoodfeelhudongViewPresentor", ViewPresentor)

function GoodfeelhudongViewPresentor:ctor()
	GoodfeelhudongViewPresentor.super.ctor(self)
end

function GoodfeelhudongViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoodfeelhudongViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelhudongview.prefab"
	}
end

function GoodfeelhudongViewPresentor:buildViews()
	return {
		GoodfeelhudongView.New()
	}
end

function GoodfeelhudongViewPresentor:onClickOutside()
	self:close()
end

return GoodfeelhudongViewPresentor
