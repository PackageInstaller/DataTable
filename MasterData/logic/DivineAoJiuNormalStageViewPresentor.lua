-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/view/DivineAoJiuNormalStageViewPresentor.lua

module("logic.extensions.divineaojiu.view.DivineAoJiuNormalStageViewPresentor", package.seeall)

local DivineAoJiuNormalStageViewPresentor = class("DivineAoJiuNormalStageViewPresentor", ViewPresentor)

function DivineAoJiuNormalStageViewPresentor:ctor()
	DivineAoJiuNormalStageViewPresentor.super.ctor(self)
end

function DivineAoJiuNormalStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineAoJiuNormalStageViewPresentor:dependWhatResources()
	return {
		"ui/views/divineaojiu/divineaojiunormalstageview.prefab"
	}
end

function DivineAoJiuNormalStageViewPresentor:buildViews()
	return {
		DivineAoJiuNormalStageView.New()
	}
end

return DivineAoJiuNormalStageViewPresentor
