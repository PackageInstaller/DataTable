-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationDetailViewContainer.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationDetailViewContainer", package.seeall)

local VersionActivity2_3NewCultivationDetailViewContainer = class("VersionActivity2_3NewCultivationDetailViewContainer", CultivationDestinyViewBaseContainer)

function VersionActivity2_3NewCultivationDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_3NewCultivationDetailView.New())

	return views
end

return VersionActivity2_3NewCultivationDetailViewContainer
