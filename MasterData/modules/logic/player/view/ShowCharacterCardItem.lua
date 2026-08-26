-- chunkname: @modules/logic/player/view/ShowCharacterCardItem.lua

module("modules.logic.player.view.ShowCharacterCardItem", package.seeall)

local ShowCharacterCardItem = class("ShowCharacterCardItem", ListScrollCell)

function ShowCharacterCardItem:init(go)
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)
	self._heroItem:setStyle_CharacterBackpack()

	self._mask = gohelper.findChild(self._gocharactercarditem, "nummask")
	self._masknum = gohelper.findChildText(self._gocharactercarditem, "nummask/num")
	self._shownum = 0

	self:_initObj()
end

function ShowCharacterCardItem:_initObj()
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
end

function ShowCharacterCardItem:addEventListeners()
	return
end

function ShowCharacterCardItem:removeEventListeners()
	return
end

function ShowCharacterCardItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self._heroItem:setNewShow(false)
	self:_initShowHeroList()
end

function ShowCharacterCardItem:_initShowHeroList()
	local heros = PlayerModel.instance:getShowHeros()

	self:_initnum((self:_clecknum(heros)))
end

function ShowCharacterCardItem:_onItemClick()
	local heros = PlayerModel.instance:getShowHeros()

	if self._shownum ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
		self._heroItem:setChoose(nil)
		PlayerModel.instance:setShowHero(self._shownum, 0)

		self._shownum = 0
	else
		self:_addHeroShow(heros)

		if self._shownum ~= 0 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
		end

		PlayerModel.instance:setShowHero(self._shownum, self._mo.heroId)
	end
end

function ShowCharacterCardItem:_addHeroShow(heros)
	for i = 1, #heros do
		if heros[i] == 0 then
			self:_initnum(i)

			return
		end
	end
end

function ShowCharacterCardItem:_clecknum(heros)
	local num = 0

	for i = 1, #heros do
		if heros[i] ~= 0 and self._mo.heroId == heros[i].heroId then
			num = i
		end
	end

	return num
end

function ShowCharacterCardItem:_initnum(num)
	if num == 0 then
		self._heroItem:setChoose(nil)
	else
		self._heroItem:setChoose(num)
	end

	self._shownum = num
end

function ShowCharacterCardItem:getAnimator()
	return self._animator
end

function ShowCharacterCardItem:onDestroy()
	return
end

return ShowCharacterCardItem
