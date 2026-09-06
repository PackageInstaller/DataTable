-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/view/DivineAoJiuExtStageViewPresentor.lua

module("logic.extensions.divineaojiu.view.DivineAoJiuExtStageViewPresentor", package.seeall)

local DivineAoJiuExtStageViewPresentor = class("DivineAoJiuExtStageViewPresentor", ViewPresentor)

function DivineAoJiuExtStageViewPresentor:ctor()
	DivineAoJiuExtStageViewPresentor.super.ctor(self)
end

function DivineAoJiuExtStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineAoJiuExtStageViewPresentor:dependWhatResources()
	return {
		"ui/views/divineaojiu/divineaojiuextstageview.prefab"
	}
end

function DivineAoJiuExtStageViewPresentor:buildViews()
	return {
		DivineAoJiuExtStageView.New()
	}
end

return DivineAoJiuExtStageViewPresentor
