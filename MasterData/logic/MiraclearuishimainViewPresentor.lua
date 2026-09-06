-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/copy/MiraclearuishimainViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.copy.MiraclearuishimainViewPresentor", package.seeall)

local MiraclearuishimainViewPresentor = class("MiraclearuishimainViewPresentor", ViewPresentor)

function MiraclearuishimainViewPresentor:ctor()
	MiraclearuishimainViewPresentor.super.ctor(self)
end

function MiraclearuishimainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiraclearuishimainViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/copy/miraclearuishimainview.prefab"
	}
end

function MiraclearuishimainViewPresentor:buildViews()
	return {
		MiraclearuishimainView.New()
	}
end

return MiraclearuishimainViewPresentor
