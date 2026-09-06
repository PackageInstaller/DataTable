-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamiequiptipsViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamiequiptipsViewPresentor", package.seeall)

local HoshigamiequiptipsViewPresentor = class("HoshigamiequiptipsViewPresentor", ViewPresentor)

function HoshigamiequiptipsViewPresentor:ctor()
	HoshigamiequiptipsViewPresentor.super.ctor(self)
end

function HoshigamiequiptipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HoshigamiequiptipsViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamiequiptips.prefab"
	}
end

function HoshigamiequiptipsViewPresentor:buildViews()
	return {
		HoshigamiequiptipsView.New()
	}
end

function HoshigamiequiptipsViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return HoshigamiequiptipsViewPresentor
