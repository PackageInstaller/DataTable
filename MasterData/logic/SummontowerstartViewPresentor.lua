-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerstartViewPresentor.lua

module("logic.extensions.summontower.view.SummontowerstartViewPresentor", package.seeall)

local SummontowerstartViewPresentor = class("SummontowerstartViewPresentor", ViewPresentor)

function SummontowerstartViewPresentor:ctor()
	SummontowerstartViewPresentor.super.ctor(self)
end

function SummontowerstartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummontowerstartViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/summontowerstartview.prefab"
	}
end

function SummontowerstartViewPresentor:buildViews()
	return {
		SummontowerStartView.New()
	}
end

return SummontowerstartViewPresentor
