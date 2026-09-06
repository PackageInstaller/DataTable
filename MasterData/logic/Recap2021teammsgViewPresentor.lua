-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021teammsgViewPresentor.lua

module("logic.extensions.recap2021.view.Recap2021teammsgViewPresentor", package.seeall)

local Recap2021teammsgViewPresentor = class("Recap2021teammsgViewPresentor", ViewPresentor)

Recap2021teammsgViewPresentor.EffectPath = UIEffectManager.instance:getEffectPath("20220401/xinfeng/xinfeng/xinfeng-ui_p.prefab")

function Recap2021teammsgViewPresentor:ctor()
	Recap2021teammsgViewPresentor.super.ctor(self)
end

function Recap2021teammsgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Recap2021teammsgViewPresentor:dependWhatResources()
	return {
		"ui/views/recap2021/recap2021teammsgview.prefab",
		Recap2021teammsgViewPresentor.EffectPath
	}
end

function Recap2021teammsgViewPresentor:buildViews()
	return {
		Recap2021teammsgView.New()
	}
end

return Recap2021teammsgViewPresentor
