-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamieprefabquiptipsViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamieprefabquiptipsViewPresentor", package.seeall)

local HoshigamieprefabquiptipsViewPresentor = class("HoshigamieprefabquiptipsViewPresentor", ViewPresentor)

function HoshigamieprefabquiptipsViewPresentor:ctor()
	HoshigamieprefabquiptipsViewPresentor.super.ctor(self)
end

function HoshigamieprefabquiptipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HoshigamieprefabquiptipsViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamiequiptips.prefab"
	}
end

function HoshigamieprefabquiptipsViewPresentor:buildViews()
	return {
		HoshigamieprefabquiptipsView.New()
	}
end

function HoshigamieprefabquiptipsViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return HoshigamieprefabquiptipsViewPresentor
