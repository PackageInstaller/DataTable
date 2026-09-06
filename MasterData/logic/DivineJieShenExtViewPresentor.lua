-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/view/DivineJieShenExtViewPresentor.lua

module("logic.extensions.divinejieshen.view.DivineJieShenExtViewPresentor", package.seeall)

local DivineJieShenExtViewPresentor = class("DivineJieShenExtViewPresentor", ViewPresentor)

function DivineJieShenExtViewPresentor:ctor()
	DivineJieShenExtViewPresentor.super.ctor(self)
end

function DivineJieShenExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineJieShenExtViewPresentor:dependWhatResources()
	return {
		"ui/views/divinejieshen/divinejieshenextview.prefab"
	}
end

function DivineJieShenExtViewPresentor:buildViews()
	return {
		DivineJieShenExtView.New()
	}
end

return DivineJieShenExtViewPresentor
