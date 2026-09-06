-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampdefense/view/TraincampdefenselistViewPresentor.lua

module("logic.extensions.traincampdefense.view.TraincampdefenselistViewPresentor", package.seeall)

local TraincampdefenselistViewPresentor = class("TraincampdefenselistViewPresentor", ViewPresentor)

function TraincampdefenselistViewPresentor:ctor()
	TraincampdefenselistViewPresentor.super.ctor(self)
end

function TraincampdefenselistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TraincampdefenselistViewPresentor:dependWhatResources()
	return {
		"ui/views/traincampdefense/traincampdefenselistview.prefab"
	}
end

function TraincampdefenselistViewPresentor:buildViews()
	return {
		TraincampdefenselistView.New()
	}
end

function TraincampdefenselistViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return TraincampdefenselistViewPresentor
