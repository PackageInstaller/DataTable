-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedakinosclg/view/DivineDakinosClgStageViewPresentor.lua

module("logic.extensions.divinedakinosclg.view.DivineDakinosClgStageViewPresentor", package.seeall)

local DivineDakinosClgStageViewPresentor = class("DivineDakinosClgStageViewPresentor", ViewPresentor)

function DivineDakinosClgStageViewPresentor:ctor()
	DivineDakinosClgStageViewPresentor.super.ctor(self)
end

function DivineDakinosClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineDakinosClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedakinosclg/divinedakinosclgstageview.prefab"
	}
end

function DivineDakinosClgStageViewPresentor:buildViews()
	return {
		DivineDakinosClgStageView.New()
	}
end

return DivineDakinosClgStageViewPresentor
