-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipIntensifyAndDetailViewPresentor.lua

module("logic.extensions.charactersystem.view.equip.EquipIntensifyAndDetailViewPresentor", package.seeall)

local M = class("EquipIntensifyAndDetailViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Equipsystem_equip_function_view,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Backpack)
	}
end

function M:buildViews()
	self._filterView = EquipIntensifyFilterView.New()

	local views = {}

	table.insert(views, EquipIntensifyAndDetailView.New())
	table.insert(views, EquipDetailView.New())
	table.insert(views, EquipIntensifyView.New())
	table.insert(views, self._filterView)
	table.insert(views, EquipMoneyView.New(CommEnum.MoneyShowType.EquipIntensify))
	table.insert(views, TitleView.New())

	return views
end

function M:getSortMo()
	return self._filterView:getSortMo()
end

return M
