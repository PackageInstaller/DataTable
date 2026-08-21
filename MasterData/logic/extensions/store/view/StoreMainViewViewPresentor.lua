-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreMainViewViewPresentor.lua

module("logic.extensions.store.view.StoreMainViewViewPresentor", package.seeall)

local M = class("StoreMainViewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Store_store_main_view,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Store)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, StoreMainView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.DefaultHideType))

	local titleView = TitleView.New()

	titleView:setHideHomeBtn(true)
	table.insert(views, titleView)

	return views
end

return M
