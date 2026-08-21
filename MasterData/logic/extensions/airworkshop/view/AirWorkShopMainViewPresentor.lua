-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/AirWorkShopMainViewPresentor.lua

module("logic.extensions.airworkshop.view.AirWorkShopMainViewPresentor", package.seeall)

local M = class("AirWorkShopMainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_main_view,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_AirWorkShop)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopMainView.New())
	table.insert(views, TitleView.New(CommEnum.GuideID.AirWorkShop))
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.AirStudioChallengeShowType))

	return views
end

return M
