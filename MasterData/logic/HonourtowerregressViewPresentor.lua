-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/honourtower/view/HonourtowerregressViewPresentor.lua

module("logic.extensions.honourtower.view.HonourtowerregressViewPresentor", package.seeall)

local HonourtowerregressViewPresentor = class("HonourtowerregressViewPresentor", ViewPresentor)

function HonourtowerregressViewPresentor:ctor()
	HonourtowerregressViewPresentor.super.ctor(self)
end

function HonourtowerregressViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HonourtowerregressViewPresentor:dependWhatResources()
	return {
		"ui/views/honourtower/honourtowerregressview.prefab"
	}
end

function HonourtowerregressViewPresentor:buildViews()
	return {
		HonourtowerregressView.New()
	}
end

function HonourtowerregressViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(ViewName.HonourtowerregressView)
end

return HonourtowerregressViewPresentor
