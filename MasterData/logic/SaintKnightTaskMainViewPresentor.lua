-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabframework/view/saintknighttask/SaintKnightTaskMainViewPresentor.lua

module("logic.extensions.tabframework.view.saintknighttask.SaintKnightTaskMainViewPresentor", package.seeall)

local SaintKnightTaskMainViewPresentor = class("SaintKnightTaskMainViewPresentor", ViewPresentor)

function SaintKnightTaskMainViewPresentor:ctor()
	SaintKnightTaskMainViewPresentor.super.ctor(self)
end

function SaintKnightTaskMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintKnightTaskMainViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttask/saintknighttaskmainview.prefab"
	}
end

function SaintKnightTaskMainViewPresentor:buildViews()
	return {
		SaintKnightTaskMainView.New()
	}
end

return SaintKnightTaskMainViewPresentor
