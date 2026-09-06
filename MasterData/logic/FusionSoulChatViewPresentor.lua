-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulChatViewPresentor.lua

module("logic.extensions.fusionsoul.view.FusionSoulChatViewPresentor", package.seeall)

local FusionSoulChatViewPresentor = class("FusionSoulChatViewPresentor", ViewPresentor)

function FusionSoulChatViewPresentor:ctor()
	FusionSoulChatViewPresentor.super.ctor(self)
end

function FusionSoulChatViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FusionSoulChatViewPresentor:dependWhatResources()
	return {
		"ui/views/fusionsoul/fusionsoulchatview.prefab"
	}
end

function FusionSoulChatViewPresentor:buildViews()
	return {
		FusionSoulChatView.New()
	}
end

return FusionSoulChatViewPresentor
