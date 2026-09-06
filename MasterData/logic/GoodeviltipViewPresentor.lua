-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/GoodeviltipViewPresentor.lua

module("logic.extensions.zoo.view.GoodeviltipViewPresentor", package.seeall)

local GoodeviltipViewPresentor = class("GoodeviltipViewPresentor", ViewPresentor)

function GoodeviltipViewPresentor:ctor()
	GoodeviltipViewPresentor.super.ctor(self)
end

function GoodeviltipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoodeviltipViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/goodeviltipview.prefab"
	}
end

function GoodeviltipViewPresentor:buildViews()
	return {
		GoodeviltipView.New()
	}
end

return GoodeviltipViewPresentor
