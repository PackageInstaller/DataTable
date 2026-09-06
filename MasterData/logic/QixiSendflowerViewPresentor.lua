-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/romanticgifts/view/QixiSendflowerViewPresentor.lua

module("logic.extensions.romanticgifts.view.QixiSendflowerViewPresentor", package.seeall)

local QixiSendflowerViewPresentor = class("QixiSendflowerViewPresentor", ViewPresentor)

function QixiSendflowerViewPresentor:ctor()
	QixiSendflowerViewPresentor.super.ctor(self)
end

function QixiSendflowerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QixiSendflowerViewPresentor:dependWhatResources()
	return {
		"ui/views/romanticgifts/qixisendflowerview.prefab"
	}
end

function QixiSendflowerViewPresentor:buildViews()
	return {
		QixiSendflowerView.New()
	}
end

return QixiSendflowerViewPresentor
