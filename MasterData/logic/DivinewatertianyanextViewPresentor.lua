-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/view/DivinewatertianyanextViewPresentor.lua

module("logic.extensions.divinewatertianyan.view.DivinewatertianyanextViewPresentor", package.seeall)

local DivinewatertianyanextViewPresentor = class("DivinewatertianyanextViewPresentor", ViewPresentor)

function DivinewatertianyanextViewPresentor:ctor()
	DivinewatertianyanextViewPresentor.super.ctor(self)
end

function DivinewatertianyanextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinewatertianyanextViewPresentor:dependWhatResources()
	return {
		"ui/views/divinewatertianyan/divinewatertianyanextview.prefab"
	}
end

function DivinewatertianyanextViewPresentor:buildViews()
	return {
		DivinewatertianyanextView.New()
	}
end

function DivinewatertianyanextViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DivinewatertianyanextViewPresentor
