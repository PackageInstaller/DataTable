-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoogeteggViewPresentor.lua

module("logic.extensions.zoo.view.ZoogeteggViewPresentor", package.seeall)

local ZoogeteggViewPresentor = class("ZoogeteggViewPresentor", ViewPresentor)

function ZoogeteggViewPresentor:ctor()
	ZoogeteggViewPresentor.super.ctor(self)
end

function ZoogeteggViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZoogeteggViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoogeteggview.prefab"
	}
end

function ZoogeteggViewPresentor:buildViews()
	return {
		ZoogeteggView.New()
	}
end

return ZoogeteggViewPresentor
