-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/view/DivineJieShenDrawViewPresentor.lua

module("logic.extensions.divinejieshen.view.DivineJieShenDrawViewPresentor", package.seeall)

local DivineJieShenDrawViewPresentor = class("DivineJieShenDrawViewPresentor", ViewPresentor)

function DivineJieShenDrawViewPresentor:ctor()
	DivineJieShenDrawViewPresentor.super.ctor(self)
end

function DivineJieShenDrawViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineJieShenDrawViewPresentor:dependWhatResources()
	return {
		"ui/views/divinejieshen/divinejieshendrawview.prefab"
	}
end

function DivineJieShenDrawViewPresentor:buildViews()
	return {
		DivineJieShenDrawView.New()
	}
end

return DivineJieShenDrawViewPresentor
