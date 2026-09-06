-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/view/SaintKnightTianMainViewPresentor.lua

module("logic.extensions.saintknighttian.view.SaintKnightTianMainViewPresentor", package.seeall)

local SaintKnightTianMainViewPresentor = class("SaintKnightTianMainViewPresentor", ViewPresentor)

function SaintKnightTianMainViewPresentor:ctor()
	SaintKnightTianMainViewPresentor.super.ctor(self)
end

function SaintKnightTianMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintKnightTianMainViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttian/saintknighttianmainview.prefab"
	}
end

function SaintKnightTianMainViewPresentor:buildViews()
	return {
		SaintKnightTianMainView.New()
	}
end

return SaintKnightTianMainViewPresentor
