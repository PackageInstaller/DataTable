-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5CardDescViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5CardDescViewContainer", package.seeall)

local Season123_3_5CardDescViewContainer = class("Season123_3_5CardDescViewContainer", BaseViewContainer)

function Season123_3_5CardDescViewContainer:buildViews()
	local views = {}

	table.insert(views, Season123_3_5CardDescView.New())

	local touchView = Season123_3_5EquipFloatTouch.New()

	touchView:init("#go_target/#go_ctrl", "#go_target/#go_touch")
	table.insert(views, touchView)

	return views
end

return Season123_3_5CardDescViewContainer
