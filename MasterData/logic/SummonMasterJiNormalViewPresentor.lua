-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/view/SummonMasterJiNormalViewPresentor.lua

module("logic.extensions.summonmasterji.view.SummonMasterJiNormalViewPresentor", package.seeall)

local SummonMasterJiNormalViewPresentor = class("SummonMasterJiNormalViewPresentor", ViewPresentor)

SummonMasterJiNormalViewPresentor.EffectPath1 = "20240403/zhaohuanshiji/fx_ui_zhsj_tiaozhan.prefab"

function SummonMasterJiNormalViewPresentor:ctor()
	SummonMasterJiNormalViewPresentor.super.ctor(self)
end

function SummonMasterJiNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummonMasterJiNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/summonmasterji/summonmasterjinormalview.prefab"
	}
end

function SummonMasterJiNormalViewPresentor:buildViews()
	return {
		SummonMasterJiNormalView.New()
	}
end

function SummonMasterJiNormalViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(SummonMasterJiNormalViewPresentor.EffectPath1)
	}
end

return SummonMasterJiNormalViewPresentor
