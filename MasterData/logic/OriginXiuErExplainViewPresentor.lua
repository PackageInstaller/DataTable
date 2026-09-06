-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/view/OriginXiuErExplainViewPresentor.lua

module("logic.extensions.originxiuer.view.OriginXiuErExplainViewPresentor", package.seeall)

local OriginXiuErExplainViewPresentor = class("OriginXiuErExplainViewPresentor", ViewPresentor)

function OriginXiuErExplainViewPresentor:ctor()
	OriginXiuErExplainViewPresentor.super.ctor(self)
end

function OriginXiuErExplainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginXiuErExplainViewPresentor:dependWhatResources()
	return {
		"ui/views/originxiuer/originxiuerexplainview.prefab"
	}
end

function OriginXiuErExplainViewPresentor:buildViews()
	return {
		OriginXiuErExplainView.New()
	}
end

return OriginXiuErExplainViewPresentor
