-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerWishTriggerViewPresentor.lua

module("logic.extensions.summontower.view.SummontowerWishTriggerViewPresentor", package.seeall)

local SummontowerWishTriggerViewPresentor = class("SummontowerWishTriggerViewPresentor", ViewPresentor)

SummontowerWishTriggerViewPresentor.effPath = "20211028/zhaohuanmiyu/fx_ui_zhaohuanmiyu_jiqilongzhu.prefab"

function SummontowerWishTriggerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummontowerWishTriggerViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/sumtowtriggerview.prefab"
	}
end

function SummontowerWishTriggerViewPresentor:buildViews()
	return {
		SummontowerWishTriggerView.New()
	}
end

function SummontowerWishTriggerViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(SummontowerWishTriggerViewPresentor.effPath)
	}
end

return SummontowerWishTriggerViewPresentor
