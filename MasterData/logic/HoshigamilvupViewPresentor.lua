-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamilvupViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamilvupViewPresentor", package.seeall)

local HoshigamilvupViewPresentor = class("HoshigamilvupViewPresentor", ViewPresentor)

function HoshigamilvupViewPresentor:ctor()
	HoshigamilvupViewPresentor.super.ctor(self)
end

function HoshigamilvupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HoshigamilvupViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamilvupview.prefab"
	}
end

function HoshigamilvupViewPresentor:buildViews()
	return {
		HoshigamilvupView.New()
	}
end

function HoshigamilvupViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return HoshigamilvupViewPresentor
