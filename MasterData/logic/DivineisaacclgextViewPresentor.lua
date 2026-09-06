-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgextViewPresentor.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgextViewPresentor", package.seeall)

local DivineisaacclgextViewPresentor = class("DivineisaacclgextViewPresentor", ViewPresentor)

function DivineisaacclgextViewPresentor:ctor()
	DivineisaacclgextViewPresentor.super.ctor(self)
end

function DivineisaacclgextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineisaacclgextViewPresentor:dependWhatResources()
	return {
		"ui/views/divineisaacclg/divineisaacclgextview.prefab"
	}
end

function DivineisaacclgextViewPresentor:buildViews()
	return {
		DivineisaacclgextView.New()
	}
end

return DivineisaacclgextViewPresentor
