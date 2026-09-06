-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/ChangeraceselectpopViewPresentor.lua

module("logic.extensions.formation.view.ChangeraceselectpopViewPresentor", package.seeall)

local ChangeraceselectpopViewPresentor = class("ChangeraceselectpopViewPresentor", ViewPresentor)

function ChangeraceselectpopViewPresentor:ctor()
	ChangeraceselectpopViewPresentor.super.ctor(self)
end

function ChangeraceselectpopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChangeraceselectpopViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/changeraceselectpopview.prefab"
	}
end

function ChangeraceselectpopViewPresentor:buildViews()
	return {
		ChangeraceselectpopView.New()
	}
end

return ChangeraceselectpopViewPresentor
