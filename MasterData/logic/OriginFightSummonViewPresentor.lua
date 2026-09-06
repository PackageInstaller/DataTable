-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/view/OriginFightSummonViewPresentor.lua

module("logic.extensions.originfight.view.OriginFightSummonViewPresentor", package.seeall)

local OriginFightSummonViewPresentor = class("OriginFightSummonViewPresentor", ViewPresentor)

function OriginFightSummonViewPresentor:ctor()
	OriginFightSummonViewPresentor.super.ctor(self)
end

function OriginFightSummonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginFightSummonViewPresentor:dependWhatResources()
	return {
		"ui/views/originfight/originfightsummonview.prefab"
	}
end

function OriginFightSummonViewPresentor:buildViews()
	return {
		OriginFightSummonView.New()
	}
end

return OriginFightSummonViewPresentor
