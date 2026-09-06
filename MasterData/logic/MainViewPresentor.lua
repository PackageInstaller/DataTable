-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainViewPresentor.lua

module("logic.extensions.mainui.view.MainViewPresentor", package.seeall)

local MainViewPresentor = class("MainViewPresentor", ViewWithGuidePresentor)

MainViewPresentor.Url_MainView = "ui/views/mainui/mainuiview.prefab"
MainViewPresentor.Url_MainBubbleView = "ui/views/mainui/mainbubbleview.prefab"
MainViewPresentor.AthenaBlessEx = "ui/views/athenabless/athenablessex.prefab"
MainViewPresentor.Url_MainBtnExpand = "ui/views/mainui/mainbtnexpandview.prefab"

function MainViewPresentor:ctor()
	MainViewPresentor.super.ctor(self)

	MainViewPresentor.instance = self
end

function MainViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function MainViewPresentor:dependWhatResources()
	return {
		MainViewPresentor.Url_MainView,
		MainViewPresentor.Url_MainBubbleView,
		MainViewPresentor.AthenaBlessEx
	}
end

function MainViewPresentor:buildViews()
	local views = {}
	local mainuiview = MainUIView.New()
	local maintaskview = MainTaskView.New()
	local mainchatview = MainChatView.New()
	local mainactivityview = MainActivityView.New()
	local customBtnsView = MainCustomBtnsView.New()
	local mainBubbleView = MainBubbleView.New()
	local mainextensionview = MainExtensionView.New()

	table.insert(views, mainuiview)
	table.insert(views, maintaskview)
	table.insert(views, mainchatview)
	table.insert(views, mainactivityview)
	table.insert(views, customBtnsView)
	table.insert(views, mainBubbleView)
	table.insert(views, mainextensionview)

	return views
end

function MainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MainViewPresentor
