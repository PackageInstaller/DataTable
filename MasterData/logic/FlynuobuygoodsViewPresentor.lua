-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuobuygoodsViewPresentor.lua

module("logic.extensions.flyingnuo.view.FlynuobuygoodsViewPresentor", package.seeall)

local FlynuobuygoodsViewPresentor = class("FlynuobuygoodsViewPresentor", ViewPresentor)

function FlynuobuygoodsViewPresentor:ctor()
	FlynuobuygoodsViewPresentor.super.ctor(self)
end

function FlynuobuygoodsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FlynuobuygoodsViewPresentor:dependWhatResources()
	return {
		"ui/views/flyingnuo/flynuobuygoodsview.prefab"
	}
end

function FlynuobuygoodsViewPresentor:buildViews()
	return {
		FlynuobuygoodsView.New()
	}
end

return FlynuobuygoodsViewPresentor
