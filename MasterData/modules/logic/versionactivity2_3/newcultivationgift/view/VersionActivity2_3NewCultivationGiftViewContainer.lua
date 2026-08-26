-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationGiftViewContainer.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftViewContainer", package.seeall)

local VersionActivity2_3NewCultivationGiftViewContainer = class("VersionActivity2_3NewCultivationGiftViewContainer", CultivationDestinyViewBaseContainer)

function VersionActivity2_3NewCultivationGiftViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_3NewCultivationGiftView.New())

	return views
end

return VersionActivity2_3NewCultivationGiftViewContainer
