-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qixilinkgame/view/QiXiLinkGameMainViewPresentor.lua

module("logic.extensions.qixilinkgame.view.QiXiLinkGameMainViewPresentor", package.seeall)

local QiXiLinkGameMainViewPresentor = class("QiXiLinkGameMainViewPresentor", ViewPresentor)

function QiXiLinkGameMainViewPresentor:ctor()
	QiXiLinkGameMainViewPresentor.super.ctor(self)
end

function QiXiLinkGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QiXiLinkGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/qixilinkgame/qixilinkgamemainview.prefab"
	}
end

function QiXiLinkGameMainViewPresentor:buildViews()
	return {
		QiXiLinkGameMainView.New()
	}
end

return QiXiLinkGameMainViewPresentor
