-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentViewPresentor.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentViewPresentor", package.seeall)

local BattleCampAdjustmentViewPresentor = class("BattleCampAdjustmentViewPresentor", ViewPresentor)

BattleCampAdjustmentViewPresentor.MainUrl = BattleResourceName.UICampAdjustment

function BattleCampAdjustmentViewPresentor:dependWhatResources()
	return {
		BattleCampAdjustmentViewPresentor.MainUrl,
		ViewlibResPath.BattleForbiddenCareerItem,
		ViewlibResPath.BattleCampAdjustmentHeroItem,
		ViewlibResPath.BattleCampAdjustmentMaterialItem,
		EffectUtil.getEffectUrl(BattleConst.PLACE_ENTITY),
		EffectUtil.getEffectUrl(BattleConst.PLACE_ENTITY2x2)
	}
end

function BattleCampAdjustmentViewPresentor:attachToWhichRoot()
	return ViewRootType.Hud
end

function BattleCampAdjustmentViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleCampAdjustmentView.New())
	table.insert(views, BattleCampAdjustmentStartView.New())
	table.insert(views, BattleCampAdjustmentMiddleTopView.New())
	table.insert(views, BattleCampAdjustmentLeftUpView.New())
	table.insert(views, BattleCampAdjustmentHeroInfoView.New())
	table.insert(views, BattleCampAdjustmentLvLimitView.New())

	return views
end

return BattleCampAdjustmentViewPresentor
