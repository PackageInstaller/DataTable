-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/view/DivinelongyanpowerstageViewPresentor.lua

module("logic.extensions.divinelongyan.view.DivinelongyanpowerstageViewPresentor", package.seeall)

local DivinelongyanpowerstageViewPresentor = class("DivinelongyanpowerstageViewPresentor", ViewPresentor)

function DivinelongyanpowerstageViewPresentor:ctor()
	DivinelongyanpowerstageViewPresentor.super.ctor(self)
end

function DivinelongyanpowerstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinelongyanpowerstageViewPresentor:dependWhatResources()
	return {
		"ui/views/divinelongyan/divinelongyanpowerstageview.prefab"
	}
end

function DivinelongyanpowerstageViewPresentor:buildViews()
	return {
		DivinelongyanpowerstageView.New()
	}
end

return DivinelongyanpowerstageViewPresentor
