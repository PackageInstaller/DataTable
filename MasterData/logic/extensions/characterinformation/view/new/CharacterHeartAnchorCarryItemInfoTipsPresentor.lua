-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterHeartAnchorCarryItemInfoTipsPresentor.lua

module("logic.extensions.characterinformation.view.new.CharacterHeartAnchorCarryItemInfoTipsPresentor", package.seeall)

local M = class("CharacterHeartAnchorCarryItemInfoTipsPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.CharacterSystem_heart_anchor_carryitem_info_tips,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterHeartAnchorCarryItemInfoTips.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
