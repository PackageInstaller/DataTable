-- chunkname: @modules/logic/versionactivity1_7/lantern/view/LanternFestivalQuestionTipViewContainer.lua

module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalQuestionTipViewContainer", package.seeall)

local LanternFestivalQuestionTipViewContainer = class("LanternFestivalQuestionTipViewContainer", BaseViewContainer)

function LanternFestivalQuestionTipViewContainer:buildViews()
	return {
		LanternFestivalQuestionTipView.New()
	}
end

return LanternFestivalQuestionTipViewContainer
