-- chunkname: @modules/logic/survival/view/map/comp/SurvivalInitHeroSelectEditItem.lua

module("modules.logic.survival.view.map.comp.SurvivalInitHeroSelectEditItem", package.seeall)

local SurvivalInitHeroSelectEditItem = class("SurvivalInitHeroSelectEditItem", ListScrollCell)

function SurvivalInitHeroSelectEditItem:init(go)
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)
	self._heroItem:setKeepAnim()
	self._heroItem:setSelectFrameSize(245, 583, 0, -12)

	self._hptextwhite = gohelper.findChildText(go, "hpbg/hptextwhite")
	self._hptextred = gohelper.findChildText(go, "hpbg/hptextred")
	self._hpimage = gohelper.findChildImage(go, "hpbg/hp")
	self._gohp = gohelper.findChild(go, "hpbg")
	self._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalHeroHealthPart)

	self:_initObj(go)
end

function SurvivalInitHeroSelectEditItem:_initObj(go)
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	self._isSelect = false
	self._enableDeselect = true

	transformhelper.setLocalScale(go.transform, 0.8, 0.8, 1)
	self._heroItem:setStyle_SurvivalHeroGroupEdit()
end

function SurvivalInitHeroSelectEditItem:addEventListeners()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._onSkinChanged, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self.updateTrialRepeat, self)
end

function SurvivalInitHeroSelectEditItem:removeEventListeners()
	return
end

function SurvivalInitHeroSelectEditItem:_onSkinChanged()
	self._heroItem:updateHero()
end

function SurvivalInitHeroSelectEditItem:setAdventureBuff(buffId)
	self._heroItem:setAdventureBuff(buffId)
end

function SurvivalInitHeroSelectEditItem:updateLimitStatus()
	gohelper.setActive(self._gohp, false)
	self._heroItem:setRestrict(false)
end

function SurvivalInitHeroSelectEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)

	if not mo:isTrial() then
		local lv = SurvivalBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateLimitStatus()
	self:updateTrialTag()
	self:updateTrialRepeat()

	local index = self:getGroupModel():getMoIndex(mo)

	self._heroItem:setNewShow(false)
	self._heroItem:setInteam(index > 0 and 1)
	self._healthPart:setHeroId(mo.heroId)
end

function SurvivalInitHeroSelectEditItem:updateTrialTag()
	local txt

	self._heroItem:setTrialTxt((self._mo:isTrial() or nil) and luaLang("herogroup_trial_tag0"))
end

function SurvivalInitHeroSelectEditItem:updateTrialRepeat()
	self._heroItem:setTrialRepeat(false)
end

function SurvivalInitHeroSelectEditItem:onSelect(select)
	self._isSelect = select

	self._heroItem:setSelect(select)

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function SurvivalInitHeroSelectEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._isSelect then
		self._view:selectCell(self._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo:getHeroMo(self._mo.heroId).health == 0 then
			return
		end

		self._view:selectCell(self._index, true)
	end
end

function SurvivalInitHeroSelectEditItem:enableDeselect(enable)
	self._enableDeselect = enable
end

function SurvivalInitHeroSelectEditItem:onDestroy()
	return
end

function SurvivalInitHeroSelectEditItem:getAnimator()
	return self._animator
end

function SurvivalInitHeroSelectEditItem:getGroupModel()
	return SurvivalMapModel.instance:getInitGroup()
end

return SurvivalInitHeroSelectEditItem
