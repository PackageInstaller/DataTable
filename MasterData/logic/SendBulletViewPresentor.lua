-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bulletscreen/view/SendBulletViewPresentor.lua

module("logic.extensions.bulletscreen.view.SendBulletViewPresentor", package.seeall)

local SendBulletViewPresentor = class("SendBulletViewPresentor", ViewPresentor)

function SendBulletViewPresentor:ctor()
	SendBulletViewPresentor.super.ctor(self)
end

function SendBulletViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function SendBulletViewPresentor:dependWhatResources()
	return {
		"ui/views/bulletscreen/sendbulletview.prefab"
	}
end

function SendBulletViewPresentor:buildViews()
	return {
		SendBulletView.New()
	}
end

return SendBulletViewPresentor
