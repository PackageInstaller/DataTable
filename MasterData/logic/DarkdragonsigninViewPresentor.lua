-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/DarkdragonsigninViewPresentor.lua

module("logic.extensions.operationsignin.view.DarkdragonsigninViewPresentor", package.seeall)

local DarkdragonsigninViewPresentor = class("DarkdragonsigninViewPresentor", ViewPresentor)

function DarkdragonsigninViewPresentor:ctor()
	DarkdragonsigninViewPresentor.super.ctor(self)
end

function DarkdragonsigninViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarkdragonsigninViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsignin/darkdragonsigninview.prefab"
	}
end

function DarkdragonsigninViewPresentor:buildViews()
	return {
		DarkdragonsigninView.New()
	}
end

return DarkdragonsigninViewPresentor
