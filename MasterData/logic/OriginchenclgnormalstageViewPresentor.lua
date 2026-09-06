-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/view/OriginchenclgnormalstageViewPresentor.lua

module("logic.extensions.originchenclg.view.OriginchenclgnormalstageViewPresentor", package.seeall)

local OriginchenclgnormalstageViewPresentor = class("OriginchenclgnormalstageViewPresentor", ViewPresentor)

function OriginchenclgnormalstageViewPresentor:ctor()
	OriginchenclgnormalstageViewPresentor.super.ctor(self)
end

function OriginchenclgnormalstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginchenclgnormalstageViewPresentor:dependWhatResources()
	return {
		"ui/views/originchenclg/originchenclgnormalstageview.prefab"
	}
end

function OriginchenclgnormalstageViewPresentor:buildViews()
	return {
		OriginchenclgnormalstageView.New()
	}
end

return OriginchenclgnormalstageViewPresentor
