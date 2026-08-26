-- chunkname: @modules/logic/seasonver/act166/view/Season166TalentInfoViewContainer.lua

module("modules.logic.seasonver.act166.view.Season166TalentInfoViewContainer", package.seeall)

local Season166TalentInfoViewContainer = class("Season166TalentInfoViewContainer", BaseViewContainer)

function Season166TalentInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166TalentInfoView.New())

	return views
end

return Season166TalentInfoViewContainer
