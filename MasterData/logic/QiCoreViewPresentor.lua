-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aocore/QiCoreViewPresentor.lua

module("logic.extensions.aocore.QiCoreViewPresentor", package.seeall)

local QiCoreViewPresentor = class("QiCoreViewPresentor", ViewWithGuidePresentor)

function QiCoreViewPresentor:ctor()
	QiCoreViewPresentor.super.ctor(self)
end

function QiCoreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QiCoreViewPresentor:dependWhatResources()
	return {
		"ui/views/aocore/qicoreview.prefab"
	}
end

function QiCoreViewPresentor:buildViews()
	return {
		QiCoreView.New()
	}
end

function QiCoreViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return QiCoreViewPresentor
