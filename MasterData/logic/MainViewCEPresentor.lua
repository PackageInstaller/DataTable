-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainViewCEPresentor.lua

module("logic.extensions.mainui.view.MainViewCEPresentor", package.seeall)

local MainViewCEPresentor = class("MainViewCEPresentor", ViewWithGuidePresentor)

MainViewCEPresentor.Url_MainView = "ui/views/mainui/mainuiview_ce.prefab"

function MainViewCEPresentor:ctor()
	MainViewCEPresentor.super.ctor(self)

	MainViewCEPresentor.instance = self
end

function MainViewCEPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function MainViewCEPresentor:dependWhatResources()
	return {
		MainViewCEPresentor.Url_MainView,
		ItemChatMain.ResPath
	}
end

function MainViewCEPresentor:buildViews()
	local views = {}
	local mainuiview = MainUIView.New()
	local maintaskview = MainTaskView.New()
	local mainchatview = MainChatView.New()
	local mainactivityview = MainActivityView.New()

	table.insert(views, mainuiview)
	table.insert(views, maintaskview)
	table.insert(views, mainchatview)
	table.insert(views, mainactivityview)

	return views
end

function MainViewCEPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MainViewCEPresentor
