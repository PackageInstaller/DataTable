-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/view/OriginXiuErFmtViewPresentor.lua

module("logic.extensions.originxiuer.view.OriginXiuErFmtViewPresentor", package.seeall)

local OriginXiuErFmtViewPresentor = class("OriginXiuErFmtViewPresentor", ViewPresentor)

function OriginXiuErFmtViewPresentor:ctor()
	OriginXiuErFmtViewPresentor.super.ctor(self)
end

function OriginXiuErFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginXiuErFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/originxiuer/originxiuerfmtview.prefab"
	}
end

function OriginXiuErFmtViewPresentor:buildViews()
	return {
		OriginXiuErFmtView.New()
	}
end

return OriginXiuErFmtViewPresentor
