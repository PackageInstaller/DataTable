-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/view/OriginFightCollectViewPresentor.lua

module("logic.extensions.originfight.view.OriginFightCollectViewPresentor", package.seeall)

local OriginFightCollectViewPresentor = class("OriginFightCollectViewPresentor", ViewPresentor)

function OriginFightCollectViewPresentor:ctor()
	OriginFightCollectViewPresentor.super.ctor(self)
end

function OriginFightCollectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginFightCollectViewPresentor:dependWhatResources()
	return {
		"ui/views/originfight/originfightcollectview.prefab"
	}
end

function OriginFightCollectViewPresentor:buildViews()
	return {
		OriginFightCollectView.New()
	}
end

return OriginFightCollectViewPresentor
