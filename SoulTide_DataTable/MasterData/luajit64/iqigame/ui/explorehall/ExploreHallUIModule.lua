-- chunkname: @IQIGame\\UI\\ExploreHall\\ExploreHallUIModule.lua

local m = {
	__TabIndexModuleMap = {
		[3] = RpgMazeModule,
		[4] = DreamlandModule,
		[5] = PlotChallengeModule,
		[6] = DualTeamExploreModule,
		[7] = MagicTowerModule,
		[8] = MonsterAcademyModule,
		[9] = EndlessPlusMazeModule,
		[10] = FlightChallengeModule,
		[11] = RestaurantOperationModule,
		[12] = PlaceGameModule,
		[13] = AmusementParkModule,
		[14] = SurvivalModule,
		[15] = HorizontalRPGModule,
		[16] = FishingActivityModule
	},
	ExploreHallViewController = {
		[3] = require("IQIGame.UI.ExploreHall.ActivityRpgPanelController"),
		[4] = require("IQIGame.UI.ExploreHall.Dreamland.ExploreDreamlandController"),
		[5] = require("IQIGame.UI.ExploreHall.PlotChallenge.PlotChallengePanelController"),
		[6] = require("IQIGame.UI.ExploreHall.DualTeamExplore.ExploreDualTeamExploreController"),
		[7] = require("IQIGame.UI.ExploreHall.MagicTower.ExploreMagicTowerController"),
		[8] = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyController"),
		[9] = require("IQIGame.UI.ExploreHall.EndlessPlus.ExploreEndlessPlusController"),
		[10] = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightChallengeController"),
		[11] = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationController"),
		[12] = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameController"),
		[13] = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkController"),
		[14] = require("IQIGame.UI.ExploreHall.Survival.SurvivalController"),
		[15] = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGController"),
		[16] = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityController")
	}
}

function m.GetDailyDupViewAsset(tabIndex)
	local module = m.GetDailyDupModule(tabIndex)

	if module == nil then
		return nil
	end

	if module.GetExploreUIAsset == nil then
		logError("模块必须包含GetExploreUIAsset方法")

		return nil
	end

	local path = module.GetExploreUIAsset()

	if path ~= nil then
		path = UIGlobalApi.GetDailyDupExploreHallBGPrefab(path)
	end

	return path
end

function m.GetDailyDupModule(tabIndex)
	local module = m.__TabIndexModuleMap[tabIndex]

	if module == nil then
		logError("没有配置 tabIndex：" .. tostring(tabIndex) .. " 对应的Module")

		return nil
	end

	if module.IsShow == nil then
		logError("模块必须包含IsShow方法")

		return nil
	end

	if not module.IsShow() then
		return nil
	end

	return module
end

function m.GetDailyDupViewAssets()
	local paths = {}

	for index, module in pairs(m.__TabIndexModuleMap) do
		local path = m.GetDailyDupViewAsset(index)

		if path ~= nil then
			table.insert(paths, path)
		end
	end

	return paths
end

return m
