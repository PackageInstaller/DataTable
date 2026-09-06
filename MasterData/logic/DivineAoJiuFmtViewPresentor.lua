-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/view/DivineAoJiuFmtViewPresentor.lua

module("logic.extensions.divineaojiu.view.DivineAoJiuFmtViewPresentor", package.seeall)

local DivineAoJiuFmtViewPresentor = class("DivineAoJiuFmtViewPresentor", ViewPresentor)

function DivineAoJiuFmtViewPresentor:ctor()
	DivineAoJiuFmtViewPresentor.super.ctor(self)
end

function DivineAoJiuFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineAoJiuFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/divineaojiu/divineaojiufmtview.prefab"
	}
end

function DivineAoJiuFmtViewPresentor:buildViews()
	return {
		DivineAoJiuFmtView.New()
	}
end

return DivineAoJiuFmtViewPresentor
