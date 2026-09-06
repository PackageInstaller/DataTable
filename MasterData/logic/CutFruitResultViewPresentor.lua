-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/view/cutfruit/CutFruitResultViewPresentor.lua

module("logic.extensions.godlongyan.view.cutfruit.CutFruitResultViewPresentor", package.seeall)

local CutFruitResultViewPresentor = class("CutFruitResultViewPresentor", ViewPresentor)

function CutFruitResultViewPresentor:ctor()
	CutFruitResultViewPresentor.super.ctor(self)
end

function CutFruitResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutFruitResultViewPresentor:dependWhatResources()
	return {
		"ui/views/godlongyan/cutfruit/cutfruitresultview.prefab"
	}
end

function CutFruitResultViewPresentor:buildViews()
	return {
		CutFruitResultView.New()
	}
end

return CutFruitResultViewPresentor
