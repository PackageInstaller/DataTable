-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiCutHeroViewContainer.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiCutHeroViewContainer", package.seeall)

local V3a6YaMiCutHeroViewContainer = class("V3a6YaMiCutHeroViewContainer", BaseViewContainer)

function V3a6YaMiCutHeroViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a6YaMiCutHeroView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_panel"))

	return views
end

function V3a6YaMiCutHeroViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.detailView = V3a6YaMiHeroDetailView.New()

		return {
			self.detailView
		}
	end
end

function V3a6YaMiCutHeroViewContainer:getDetailView()
	return self.detailView
end

return V3a6YaMiCutHeroViewContainer
