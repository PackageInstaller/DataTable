-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseSelfTaskHeroTypeTipViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseSelfTaskHeroTypeTipViewContainer", package.seeall)

local CruiseSelfTaskHeroTypeTipViewContainer = class("CruiseSelfTaskHeroTypeTipViewContainer", BaseViewContainer)

function CruiseSelfTaskHeroTypeTipViewContainer:buildViews()
	local views = {}

	table.insert(views, CruiseSelfTaskHeroTypeTipView.New())

	return views
end

return CruiseSelfTaskHeroTypeTipViewContainer
