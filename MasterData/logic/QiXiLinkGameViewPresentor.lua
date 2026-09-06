-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qixilinkgame/view/QiXiLinkGameViewPresentor.lua

module("logic.extensions.qixilinkgame.view.QiXiLinkGameViewPresentor", package.seeall)

local QiXiLinkGameViewPresentor = class("QiXiLinkGameViewPresentor", ViewPresentor)

function QiXiLinkGameViewPresentor:ctor()
	QiXiLinkGameViewPresentor.super.ctor(self)
end

function QiXiLinkGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QiXiLinkGameViewPresentor:dependWhatResources()
	return {
		"ui/views/qixilinkgame/qixilinkgameview.prefab"
	}
end

function QiXiLinkGameViewPresentor:buildViews()
	return {
		QiXiLinkGameView.New()
	}
end

return QiXiLinkGameViewPresentor
