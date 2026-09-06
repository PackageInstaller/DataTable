-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/view/OriginxingjiangmainViewPresentor.lua

module("logic.extensions.orixingjiang.view.OriginxingjiangmainViewPresentor", package.seeall)

local OriginxingjiangmainViewPresentor = class("OriginxingjiangmainViewPresentor", ViewPresentor)

function OriginxingjiangmainViewPresentor:ctor()
	OriginxingjiangmainViewPresentor.super.ctor(self)
end

function OriginxingjiangmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginxingjiangmainViewPresentor:dependWhatResources()
	return {
		"ui/views/orixingjiang/originxingjiangmainview.prefab"
	}
end

function OriginxingjiangmainViewPresentor:buildViews()
	return {
		OriginxingjiangmainView.New()
	}
end

return OriginxingjiangmainViewPresentor
