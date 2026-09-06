-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/view/OriginZhengliStageViewPresentor.lua

module("logic.extensions.originzhengli.view.OriginZhengliStageViewPresentor", package.seeall)

local OriginZhengliStageViewPresentor = class("OriginZhengliStageViewPresentor", ViewPresentor)

function OriginZhengliStageViewPresentor:ctor()
	OriginZhengliStageViewPresentor.super.ctor(self)
end

function OriginZhengliStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginZhengliStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originzhengli/originzhenglistageview.prefab"
	}
end

function OriginZhengliStageViewPresentor:buildViews()
	return {
		OriginZhengliStageView.New()
	}
end

return OriginZhengliStageViewPresentor
