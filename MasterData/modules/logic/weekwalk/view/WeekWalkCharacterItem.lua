-- chunkname: @modules/logic/weekwalk/view/WeekWalkCharacterItem.lua

module("modules.logic.weekwalk.view.WeekWalkCharacterItem", package.seeall)

local WeekWalkCharacterItem = class("WeekWalkCharacterItem", ListScrollCell)

function WeekWalkCharacterItem:init(go)
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)
	self._heroItem:setStyle_CharacterBackpack()

	self._goAnim = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	self._hpbg = gohelper.findChild(go, "hpbg")

	gohelper.setActive(self._hpbg, false)

	self._hptextwhite = gohelper.findChildText(go, "hpbg/hptextwhite")
	self._hptextred = gohelper.findChildText(go, "hpbg/hptextred")
	self._hpimage = gohelper.findChildImage(go, "hpbg/hp")

	self:_initObj()
end

function WeekWalkCharacterItem:_initObj()
	return
end

function WeekWalkCharacterItem:addEventListeners()
	return
end

function WeekWalkCharacterItem:removeEventListeners()
	return
end

function WeekWalkCharacterItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)

	local hpPercent = 1
	local info = WeekWalkModel.instance:getInfo()

	if info then
		local hp = info:getHeroHp(self._mo.config.id)

		if hp then
			hpPercent = hp / self._mo.baseAttr.hp
		end
	end

	hpPercent = math.min(hpPercent, 1)

	self._heroItem:setInjury(hpPercent <= 0)

	local buff = info:getHeroBuff(self._mo.heroId)

	self._heroItem:setAdventureBuff(buff)
end

function WeekWalkCharacterItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local o = {}

	o = self._mo

	CharacterController.instance:openCharacterView(self._mo)
end

function WeekWalkCharacterItem:getAnimator()
	return self._goAnim
end

function WeekWalkCharacterItem:onDestroy()
	return
end

return WeekWalkCharacterItem
