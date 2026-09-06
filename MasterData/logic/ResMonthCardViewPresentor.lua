-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/ResMonthCardViewPresentor.lua

module("logic.extensions.monthcard.view.ResMonthCardViewPresentor", package.seeall)

local ResMonthCardViewPresentor = class("ResMonthCardViewPresentor", ViewPresentor)

function ResMonthCardViewPresentor:ctor()
	ResMonthCardViewPresentor.super.ctor(self)
end

function ResMonthCardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ResMonthCardViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/resmonthcardview.prefab"
	}
end

function ResMonthCardViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_mibaoshangcheng/fx_ui_yueka_mibaoshangcheng.prefab")
	}
end

function ResMonthCardViewPresentor:buildViews()
	return {
		ResMonthCardView.New()
	}
end

function ResMonthCardViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ResMonthCardViewPresentor
