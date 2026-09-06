-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamirecommenViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamirecommenViewPresentor", package.seeall)

local HoshigamirecommenViewPresentor = class("HoshigamirecommenViewPresentor", ViewPresentor)

function HoshigamirecommenViewPresentor:ctor()
	HoshigamirecommenViewPresentor.super.ctor(self)
end

function HoshigamirecommenViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HoshigamirecommenViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamirecommenview.prefab"
	}
end

function HoshigamirecommenViewPresentor:buildViews()
	return {
		HoshigamirecommenView.New()
	}
end

function HoshigamirecommenViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return HoshigamirecommenViewPresentor
