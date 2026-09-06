-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/SxGameResultViewPresentor.lua

module("logic.extensions.sxgame.view.SxGameResultViewPresentor", package.seeall)

local SxGameResultViewPresentor = class("SxGameResultViewPresentor", ViewPresentor)

function SxGameResultViewPresentor:ctor()
	SxGameResultViewPresentor.super.ctor(self)
end

function SxGameResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SxGameResultViewPresentor:dependWhatResources()
	return {
		"ui/views/sxgame/sxgameresultview.prefab"
	}
end

function SxGameResultViewPresentor:buildViews()
	return {
		SxGameResultView.New()
	}
end

return SxGameResultViewPresentor
