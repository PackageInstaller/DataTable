-- chunkname: @modules/logic/versionactivity1_6/act152/view/NewYearEveGiftViewContainer.lua

module("modules.logic.versionactivity1_6.act152.view.NewYearEveGiftViewContainer", package.seeall)

local NewYearEveGiftViewContainer = class("NewYearEveGiftViewContainer", BaseViewContainer)

function NewYearEveGiftViewContainer:buildViews()
	return {
		NewYearEveGiftView.New()
	}
end

return NewYearEveGiftViewContainer
