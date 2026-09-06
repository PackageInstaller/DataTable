-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/view/OriginXiuErMainViewPresentor.lua

module("logic.extensions.originxiuer.view.OriginXiuErMainViewPresentor", package.seeall)

local OriginXiuErMainViewPresentor = class("OriginXiuErMainViewPresentor", ViewPresentor)

function OriginXiuErMainViewPresentor:ctor()
	OriginXiuErMainViewPresentor.super.ctor(self)
end

function OriginXiuErMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginXiuErMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originxiuer/originxiuermainview.prefab"
	}
end

function OriginXiuErMainViewPresentor:buildViews()
	return {
		OriginXiuErMainView.New()
	}
end

return OriginXiuErMainViewPresentor
