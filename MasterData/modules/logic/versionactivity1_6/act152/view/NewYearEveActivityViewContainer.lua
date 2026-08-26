-- chunkname: @modules/logic/versionactivity1_6/act152/view/NewYearEveActivityViewContainer.lua

module("modules.logic.versionactivity1_6.act152.view.NewYearEveActivityViewContainer", package.seeall)

local NewYearEveActivityViewContainer = class("NewYearEveActivityViewContainer", BaseViewContainer)

function NewYearEveActivityViewContainer:buildViews()
	return {
		NewYearEveActivityView.New()
	}
end

return NewYearEveActivityViewContainer
