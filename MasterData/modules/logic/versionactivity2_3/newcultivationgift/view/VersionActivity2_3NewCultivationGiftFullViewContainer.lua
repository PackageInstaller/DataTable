-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationGiftFullViewContainer.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftFullViewContainer", package.seeall)

local VersionActivity2_3NewCultivationGiftFullViewContainer = class("VersionActivity2_3NewCultivationGiftFullViewContainer", CultivationDestinyViewBaseContainer)

function VersionActivity2_3NewCultivationGiftFullViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_3NewCultivationGiftFullView.New())

	return views
end

return VersionActivity2_3NewCultivationGiftFullViewContainer
