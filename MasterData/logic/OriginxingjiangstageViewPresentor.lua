-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/view/OriginxingjiangstageViewPresentor.lua

module("logic.extensions.orixingjiang.view.OriginxingjiangstageViewPresentor", package.seeall)

local OriginxingjiangstageViewPresentor = class("OriginxingjiangstageViewPresentor", ViewPresentor)

function OriginxingjiangstageViewPresentor:ctor()
	OriginxingjiangstageViewPresentor.super.ctor(self)
end

function OriginxingjiangstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginxingjiangstageViewPresentor:dependWhatResources()
	return {
		"ui/views/orixingjiang/originxingjiangstageview.prefab"
	}
end

function OriginxingjiangstageViewPresentor:buildViews()
	return {
		OriginxingjiangstageView.New()
	}
end

return OriginxingjiangstageViewPresentor
