-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/EchoUpgradeShowViewPresentor.lua

module("logic.extensions.charactersystem.view.carrier.EchoUpgradeShowViewPresentor", package.seeall)

local M = class("EchoUpgradeShowViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Carryitem_echo_upgrade_show_panel,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BlurBgView.New())
	table.insert(views, EchoUpgradeShowView.New())

	return views
end

return M
