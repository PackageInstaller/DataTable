-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedChangeHeroItem.lua

module("modules.logic.character.view.recommed.CharacterRecommedChangeHeroItem", package.seeall)

local CharacterRecommedChangeHeroItem = class("CharacterRecommedChangeHeroItem", CharacterRecommedHeroIcon)

function CharacterRecommedChangeHeroItem:_btnclickOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local heroId = self._mo.heroId

	self._view.viewParam.heroId = heroId

	CharacterRecommedController.instance:dispatchEvent(CharacterRecommedEvent.OnChangeHero, heroId)
end

return CharacterRecommedChangeHeroItem
