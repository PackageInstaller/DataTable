-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/view/OriginFightGetRewardViewPresentor.lua

module("logic.extensions.originfight.view.OriginFightGetRewardViewPresentor", package.seeall)

local OriginFightGetRewardViewPresentor = class("OriginFightGetRewardViewPresentor", ViewPresentor)

function OriginFightGetRewardViewPresentor:ctor()
	OriginFightGetRewardViewPresentor.super.ctor(self)
end

function OriginFightGetRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginFightGetRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/originfight/originfightgetrewardview.prefab"
	}
end

function OriginFightGetRewardViewPresentor:buildViews()
	return {
		OriginFightGetRewardView.New()
	}
end

return OriginFightGetRewardViewPresentor
