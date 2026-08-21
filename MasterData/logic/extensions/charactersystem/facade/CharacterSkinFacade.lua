-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/facade/CharacterSkinFacade.lua

module("logic.extensions.charactersystem.facade.CharacterSkinFacade", package.seeall)

local CharacterSkinFacade = class("CharacterSkinFacade", BaseFacade)

function CharacterSkinFacade:showSingleSkin(skinId)
	local skinMO = HeroSkinModel.instance:getMoById(skinId)

	if skinMO == nil then
		return
	end

	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_enter, nil, nil, nil)
	ViewMgr.instance:open(ViewName.CharacterSkinView, {
		heroId = skinMO:getHeroId(),
		skinId = skinId,
		showType = HeroSkinEnum.ShowType.SingleSkin
	})
end

function CharacterSkinFacade:showAllSkin(heroId, skinId, jumpFrom)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_enter, nil, nil, nil)
	ViewMgr.instance:open(ViewName.CharacterSkinView, {
		heroId = heroId,
		skinId = skinId,
		showType = HeroSkinEnum.ShowType.AllSkin,
		jumpFromView = jumpFrom
	})
end

CharacterSkinFacade.instance = CharacterSkinFacade.New()

return CharacterSkinFacade
