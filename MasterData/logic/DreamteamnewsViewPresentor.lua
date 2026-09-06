-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamchat/view/DreamteamnewsViewPresentor.lua

module("logic.extensions.dreamchat.view.DreamteamnewsViewPresentor", package.seeall)

local DreamteamnewsViewPresentor = class("DreamteamnewsViewPresentor", ViewPresentor)

function DreamteamnewsViewPresentor:ctor()
	DreamteamnewsViewPresentor.super.ctor(self)
end

function DreamteamnewsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DreamteamnewsViewPresentor:dependWhatResources()
	return {
		"ui/views/activity/dreamchat/dreamteamnewsview.prefab"
	}
end

function DreamteamnewsViewPresentor:buildViews()
	return {
		DreamteamnewsView.New()
	}
end

return DreamteamnewsViewPresentor
