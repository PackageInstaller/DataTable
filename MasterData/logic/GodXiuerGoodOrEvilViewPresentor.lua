-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godxiuerchallenge/view/GodXiuerGoodOrEvilViewPresentor.lua

module("logic.extensions.godxiuerchallenge.view.GodXiuerGoodOrEvilViewPresentor", package.seeall)

local GodXiuerGoodOrEvilViewPresentor = class("GodXiuerGoodOrEvilViewPresentor", ViewPresentor)

GodXiuerGoodOrEvilViewPresentor.Effect1 = "20221223/shenqixiuer/fx_ui_xiuer_fw_zhujiemian02.prefab"

function GodXiuerGoodOrEvilViewPresentor:ctor()
	GodXiuerGoodOrEvilViewPresentor.super.ctor(self)
end

function GodXiuerGoodOrEvilViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodXiuerGoodOrEvilViewPresentor:dependWhatResources()
	return {
		"ui/views/godxiuerchallenge/godxiuergoodorevilview.prefab"
	}
end

function GodXiuerGoodOrEvilViewPresentor:buildViews()
	return {
		GodXiuerGoodOrEvilView.New()
	}
end

function GodXiuerGoodOrEvilViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(GodXiuerGoodOrEvilViewPresentor.Effect1)
	}
end

return GodXiuerGoodOrEvilViewPresentor
