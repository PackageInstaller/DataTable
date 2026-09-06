-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emperorsubdue/view/EmperorSubdueMainViewPresentor.lua

module("logic.extensions.emperorsubdue.view.EmperorSubdueMainViewPresentor", package.seeall)

local EmperorSubdueMainViewPresentor = class("EmperorSubdueMainViewPresentor", ViewPresentor)

function EmperorSubdueMainViewPresentor:ctor()
	EmperorSubdueMainViewPresentor.super.ctor(self)
end

function EmperorSubdueMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EmperorSubdueMainViewPresentor:dependWhatResources()
	return {
		"ui/views/emperorsubdue/emperorsubduemainview.prefab"
	}
end

function EmperorSubdueMainViewPresentor:buildViews()
	return {
		EmperorSubdueMainView.New()
	}
end

return EmperorSubdueMainViewPresentor
