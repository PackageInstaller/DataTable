-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/new/ChangeEquipViewNewPresentor.lua

module("logic.extensions.charactersystem.view.equip.new.ChangeEquipViewNewPresentor", package.seeall)

local ChangeEquipTitle = class("IntensiTyTitleView", TitleView)

function ChangeEquipTitle:back()
	EquipController.instance:setEnteredChangeView()
	ChangeEquipTitle.super.back(self)
end

local M = class("ChangeEquipViewNewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Equipsystem_new_equip_properties_overview_view_copy,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Backpack)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ChangeEquipViewNew.New())
	table.insert(views, ChangeEquipTitle.New(CommEnum.GuideID.EquipMain))

	return views
end

return M
