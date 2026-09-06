-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/view/DivinelongyanlevelupViewPresentor.lua

module("logic.extensions.divinelongyan.view.DivinelongyanlevelupViewPresentor", package.seeall)

local DivinelongyanlevelupViewPresentor = class("DivinelongyanlevelupViewPresentor", ViewPresentor)

function DivinelongyanlevelupViewPresentor:ctor()
	DivinelongyanlevelupViewPresentor.super.ctor(self)
end

function DivinelongyanlevelupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinelongyanlevelupViewPresentor:dependWhatResources()
	return {
		"ui/views/divinelongyan/divinelongyanlevelupview.prefab"
	}
end

function DivinelongyanlevelupViewPresentor:buildViews()
	return {
		DivinelongyanlevelupView.New()
	}
end

function DivinelongyanlevelupViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DivinelongyanlevelupViewPresentor
