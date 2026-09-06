-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/flipgame/SunWuKongFlipGameMainViewPresentor.lua

module("logic.extensions.sunwukongchallenge.view.flipgame.SunWuKongFlipGameMainViewPresentor", package.seeall)

local SunWuKongFlipGameMainViewPresentor = class("SunWuKongFlipGameMainViewPresentor", ViewPresentor)

function SunWuKongFlipGameMainViewPresentor:ctor()
	SunWuKongFlipGameMainViewPresentor.super.ctor(self)
end

function SunWuKongFlipGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SunWuKongFlipGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/sunwukongchallenge/sunwukongflipgamemainview.prefab"
	}
end

function SunWuKongFlipGameMainViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_dianliangmengzhidui/fx_ui_xiaochu_mzd.prefab")
	}
end

function SunWuKongFlipGameMainViewPresentor:buildViews()
	return {
		SunWuKongFlipGameMainView.New()
	}
end

return SunWuKongFlipGameMainViewPresentor
