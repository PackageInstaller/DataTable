-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/FlipGameMainViewPresentor.lua

module("logic.extensions.dreamteam.view.FlipGameMainViewPresentor", package.seeall)

local FlipGameMainViewPresentor = class("FlipGameMainViewPresentor", ViewPresentor)

function FlipGameMainViewPresentor:ctor()
	FlipGameMainViewPresentor.super.ctor(self)
end

function FlipGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FlipGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteam/smallgame/flipgamemainview.prefab"
	}
end

function FlipGameMainViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_dianliangmengzhidui/fx_ui_xiaochu_mzd.prefab")
	}
end

function FlipGameMainViewPresentor:buildViews()
	return {
		FlipGameMainView.New()
	}
end

return FlipGameMainViewPresentor
