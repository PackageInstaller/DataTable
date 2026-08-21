-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/authority/new/CharacterAuthorityNodeUnlockViewPresentor.lua

module("logic.extensions.charactersystem.view.authority.new.CharacterAuthorityNodeUnlockViewPresentor", package.seeall)

local M = class("CharacterAuthorityNodeUnlockViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.CharacterSystem_Authority_Skill_Unlock,
		ResName.CharacterSystem_Authority_Node,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Authority)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterAuthorityNodeUnlockView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
