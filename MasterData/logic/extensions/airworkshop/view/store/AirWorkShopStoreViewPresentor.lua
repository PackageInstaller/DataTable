-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/store/AirWorkShopStoreViewPresentor.lua

module("logic.extensions.airworkshop.view.store.AirWorkShopStoreViewPresentor", package.seeall)

local M = class("AirWorkShopStoreViewPresentor", ViewPresentor)

M.MONEY_SHOW_TYPE = {
	[200000] = CommEnum.MoneyShowType.AirStudioStoreShowType,
	[200001] = CommEnum.MoneyShowType.AirStudioStoreShowType
}

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_store_view,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Store)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopStoreView.New())
	table.insert(views, TitleView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.AirStudioStoreShowType))

	return views
end

return M
