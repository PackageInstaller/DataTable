-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/view/DivineAoJiuExtResultViewPresentor.lua

module("logic.extensions.divineaojiu.view.DivineAoJiuExtResultViewPresentor", package.seeall)

local DivineAoJiuExtResultViewPresentor = class("DivineAoJiuExtResultViewPresentor", ViewPresentor)

function DivineAoJiuExtResultViewPresentor:ctor()
	DivineAoJiuExtResultViewPresentor.super.ctor(self)
end

function DivineAoJiuExtResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineAoJiuExtResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divineaojiu/divineaojiuextresultview.prefab"
	}
end

function DivineAoJiuExtResultViewPresentor:buildViews()
	return {
		DivineAoJiuExtResultView.New()
	}
end

return DivineAoJiuExtResultViewPresentor
