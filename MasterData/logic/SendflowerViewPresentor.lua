-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sendflower/view/SendflowerViewPresentor.lua

module("logic.extensions.sendflower.view.SendflowerViewPresentor", package.seeall)

local SendflowerViewPresentor = class("SendflowerViewPresentor", ViewPresentor)

function SendflowerViewPresentor:ctor()
	SendflowerViewPresentor.super.ctor(self)
end

function SendflowerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SendflowerViewPresentor:dependWhatResources()
	return {
		"ui/views/sendflower/sendflowerview.prefab"
	}
end

function SendflowerViewPresentor:buildViews()
	return {
		SendflowerView.New()
	}
end

return SendflowerViewPresentor
