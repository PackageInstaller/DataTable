-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooupleveltipViewPresentor.lua

module("logic.extensions.zoo.view.ZooupleveltipViewPresentor", package.seeall)

local ZooupleveltipViewPresentor = class("ZooupleveltipViewPresentor", ViewPresentor)

function ZooupleveltipViewPresentor:ctor()
	ZooupleveltipViewPresentor.super.ctor(self)
end

function ZooupleveltipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooupleveltipViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zooupleveltipview.prefab"
	}
end

function ZooupleveltipViewPresentor:buildViews()
	return {
		ZooupleveltipView.New()
	}
end

return ZooupleveltipViewPresentor
