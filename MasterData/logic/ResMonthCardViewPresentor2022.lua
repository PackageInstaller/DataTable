-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/ResMonthCardViewPresentor2022.lua

module("logic.extensions.monthcard.view.ResMonthCardViewPresentor20222022", package.seeall)

local ResMonthCardViewPresentor2022 = class("ResMonthCardViewPresentor2022", ViewPresentor)

function ResMonthCardViewPresentor2022:ctor()
	ResMonthCardViewPresentor2022.super.ctor(self)
end

function ResMonthCardViewPresentor2022:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ResMonthCardViewPresentor2022:dependWhatResources()
	return {
		"ui/views/monthcard/resmonthcardview2022.prefab"
	}
end

function ResMonthCardViewPresentor2022:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_mibaoshangcheng/fx_ui_yueka_mibaoshangcheng.prefab")
	}
end

function ResMonthCardViewPresentor2022:buildViews()
	return {
		ResMonthCardView2022.New()
	}
end

function ResMonthCardViewPresentor2022:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ResMonthCardViewPresentor2022
