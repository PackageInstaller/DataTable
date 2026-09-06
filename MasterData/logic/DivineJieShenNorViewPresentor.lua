-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/view/DivineJieShenNorViewPresentor.lua

module("logic.extensions.divinejieshen.view.DivineJieShenNorViewPresentor", package.seeall)

local DivineJieShenNorViewPresentor = class("DivineJieShenNorViewPresentor", ViewPresentor)

function DivineJieShenNorViewPresentor:ctor()
	DivineJieShenNorViewPresentor.super.ctor(self)
end

function DivineJieShenNorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineJieShenNorViewPresentor:dependWhatResources()
	return {
		"ui/views/divinejieshen/divinejieshennorview.prefab"
	}
end

function DivineJieShenNorViewPresentor:buildViews()
	return {
		DivineJieShenNorView.New()
	}
end

return DivineJieShenNorViewPresentor
