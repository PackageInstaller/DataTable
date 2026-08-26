-- chunkname: @modules/logic/mainuiswitch/view/MainUISwitchInfoBlurMaskViewContainer.lua

module("modules.logic.mainuiswitch.view.MainUISwitchInfoBlurMaskViewContainer", package.seeall)

local MainUISwitchInfoBlurMaskViewContainer = class("MainUISwitchInfoBlurMaskViewContainer", BaseViewContainer)

function MainUISwitchInfoBlurMaskViewContainer:buildViews()
	local views = {}

	if not self.viewParam or self.viewParam.isNotShowHero ~= true then
		table.insert(views, MainUISwitchInfoHeroView.New())
	end

	table.insert(views, MainUISwitchInfoBlurMaskView.New())

	return views
end

return MainUISwitchInfoBlurMaskViewContainer
