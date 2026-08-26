-- chunkname: @modules/logic/survival/view/shelter/ShelterHeroWareHouseItem.lua

module("modules.logic.survival.view.shelter.ShelterHeroWareHouseItem", package.seeall)

local ShelterHeroWareHouseItem = class("ShelterHeroWareHouseItem", HeroGroupEditItem)

function ShelterHeroWareHouseItem:init(go)
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)
	self._heroItem:setSelectFrameSize(245, 583, 0, -12)

	self._gohp = gohelper.findChild(go, "hpbg")

	self:_initObj(go)

	self._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalHeroHealthPart)
	self._goRepreat = gohelper.findChild(go, "#go_repeat")
	self._goRound = gohelper.findChild(go, "#go_round")
end

function ShelterHeroWareHouseItem:_initObj(go)
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
end

function ShelterHeroWareHouseItem:addEventListeners()
	return
end

function ShelterHeroWareHouseItem:removeEventListeners()
	return
end

function ShelterHeroWareHouseItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self._heroItem:setNewShow(false)
	self._healthPart:setHeroId(self._mo.heroId)
	self._healthPart:setTxtHealthWhite()
	gohelper.setActive(self._goRepreat, false)
	gohelper.setActive(self._goRound, false)
end

function ShelterHeroWareHouseItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	CharacterController.instance:openCharacterView(self._mo)
end

function ShelterHeroWareHouseItem:onDestroy()
	return
end

function ShelterHeroWareHouseItem:getAnimator()
	return self._animator
end

return ShelterHeroWareHouseItem
