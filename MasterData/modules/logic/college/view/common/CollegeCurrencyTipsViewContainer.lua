-- chunkname: @modules/logic/college/view/common/CollegeCurrencyTipsViewContainer.lua

module("modules.logic.college.view.common.CollegeCurrencyTipsViewContainer", package.seeall)

local CollegeCurrencyTipsViewContainer = class("CollegeCurrencyTipsViewContainer", BaseViewContainer)

function CollegeCurrencyTipsViewContainer:buildViews()
	return {
		CollegeCurrencyTipsView.New(),
		CollegeVisibleBaseView.New()
	}
end

return CollegeCurrencyTipsViewContainer
