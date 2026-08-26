-- chunkname: @modules/logic/versionactivity1_4/dungeon/view/VersionActivity1_4DungeonEpisodeViewContainer.lua

module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonEpisodeViewContainer", package.seeall)

local VersionActivity1_4DungeonEpisodeViewContainer = class("VersionActivity1_4DungeonEpisodeViewContainer", BaseViewContainer)

function VersionActivity1_4DungeonEpisodeViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity1_4DungeonEpisodeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_righttop"))

	return views
end

function VersionActivity1_4DungeonEpisodeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local currencyParam = {
			CurrencyEnum.CurrencyType.Power
		}

		self.currencyView = CurrencyView.New(currencyParam)

		return {
			self.currencyView
		}
	end
end

return VersionActivity1_4DungeonEpisodeViewContainer
