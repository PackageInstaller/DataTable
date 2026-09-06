-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamchat/view/DreamchatViewPresentor.lua

module("logic.extensions.dreamchat.view.DreamchatViewPresentor", package.seeall)

local DreamchatViewPresentor = class("DreamchatViewPresentor", ViewPresentor)

function DreamchatViewPresentor:ctor()
	DreamchatViewPresentor.super.ctor(self)
end

function DreamchatViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamchatViewPresentor:dependWhatResources()
	return {
		"ui/views/activity/dreamchat/dreamgivebackview.prefab"
	}
end

function DreamchatViewPresentor:buildViews()
	return {
		DreamchatView.New()
	}
end

return DreamchatViewPresentor
