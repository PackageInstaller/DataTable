-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoRewardTipsPresentor.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoRewardTipsPresentor", package.seeall)

local M = class("AirWorkShopRodeoRewardTipsPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_sports_reward_tips,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_AirWorkShop)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopRodeoRewardTips.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
