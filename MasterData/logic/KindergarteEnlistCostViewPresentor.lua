-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergarteEnlistCostViewPresentor.lua

module("logic.extensions.kindergarten.view.FlowerPopViewPresentor", package.seeall)

local FlowerPopViewPresentor = class("FlowerPopViewPresentor", ViewPresentor)

function FlowerPopViewPresentor:ctor()
	FlowerPopViewPresentor.super.ctor(self)
end

function FlowerPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FlowerPopViewPresentor:dependWhatResources()
	return {
		"ui/views/kindergarten/kindergarteenlistcostview.prefab"
	}
end

function FlowerPopViewPresentor:buildViews()
	return {
		KindergarteEnlistCostView.New()
	}
end

return FlowerPopViewPresentor
