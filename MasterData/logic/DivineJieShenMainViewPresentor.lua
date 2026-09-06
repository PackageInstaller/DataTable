-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/view/DivineJieShenMainViewPresentor.lua

module("logic.extensions.divinejieshen.view.DivineJieShenMainViewPresentor", package.seeall)

local DivineJieShenMainViewPresentor = class("DivineJieShenMainViewPresentor", ViewPresentor)

function DivineJieShenMainViewPresentor:ctor()
	DivineJieShenMainViewPresentor.super.ctor(self)
end

function DivineJieShenMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineJieShenMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinejieshen/divinejieshenmainview.prefab"
	}
end

function DivineJieShenMainViewPresentor:buildViews()
	return {
		DivineJieShenMainView.New()
	}
end

return DivineJieShenMainViewPresentor
