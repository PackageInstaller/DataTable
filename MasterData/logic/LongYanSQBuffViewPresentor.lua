-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/view/LongYanSQBuffViewPresentor.lua

module("logic.extensions.godlongyan.view.LongYanSQBuffViewPresentor", package.seeall)

local LongYanSQBuffViewPresentor = class("LongYanSQBuffViewPresentor", ViewPresentor)

LongYanSQBuffViewPresentor.Effect = "20220429/zengyitiaozhan/fx_ui_zengyiguangxiao.prefab"

function LongYanSQBuffViewPresentor:ctor()
	LongYanSQBuffViewPresentor.super.ctor(self)
end

function LongYanSQBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LongYanSQBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/godlongyan/longyansqbuffview.prefab"
	}
end

function LongYanSQBuffViewPresentor:buildViews()
	return {
		LongYanSQBuffView.New()
	}
end

function LongYanSQBuffViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(LongYanSQBuffViewPresentor.Effect)
	}
end

return LongYanSQBuffViewPresentor
