-- chunkname: @modules/logic/tips/view/PackageRewardDetailViewContainer.lua

module("modules.logic.tips.view.PackageRewardDetailViewContainer", package.seeall)

local PackageRewardDetailViewContainer = class("PackageRewardDetailViewContainer", CultivationDestinyViewBaseContainer)

function PackageRewardDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, PackageRewardDetailView.New())

	return views
end

return PackageRewardDetailViewContainer
