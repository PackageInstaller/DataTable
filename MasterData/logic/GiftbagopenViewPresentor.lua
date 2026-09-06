-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/GiftbagopenViewPresentor.lua

module("logic.extensions.itembag.view.GiftbagopenViewPresentor", package.seeall)

local GiftbagopenViewPresentor = class("GiftbagopenViewPresentor", ViewPresentor)

function GiftbagopenViewPresentor:ctor()
	GiftbagopenViewPresentor.super.ctor(self)
end

function GiftbagopenViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GiftbagopenViewPresentor:dependWhatResources()
	return {
		"ui/views/itembag/giftbagopenview.prefab"
	}
end

function GiftbagopenViewPresentor:getTempResources()
	return {
		"effect/prefabs/ui/fx_ui_aohebaoxiang/fx_ui_aohebaoxiang_baokai.prefab"
	}
end

function GiftbagopenViewPresentor:buildViews()
	return {
		GiftbagopenView.New()
	}
end

return GiftbagopenViewPresentor
