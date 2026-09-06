-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/view/DivineAoJiuSelectViewPresentor.lua

module("logic.extensions.divineaojiu.view.DivineAoJiuSelectViewPresentor", package.seeall)

local DivineAoJiuSelectViewPresentor = class("DivineAoJiuSelectViewPresentor", ViewPresentor)

function DivineAoJiuSelectViewPresentor:ctor()
	DivineAoJiuSelectViewPresentor.super.ctor(self)
end

function DivineAoJiuSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineAoJiuSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/divineaojiu/divineaojiuselectview.prefab"
	}
end

function DivineAoJiuSelectViewPresentor:buildViews()
	return {
		DivineAoJiuSelectView.New()
	}
end

function DivineAoJiuSelectViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DivineAoJiuSelectViewPresentor
