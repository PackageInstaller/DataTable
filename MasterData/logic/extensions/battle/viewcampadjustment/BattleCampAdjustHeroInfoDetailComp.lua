-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustHeroInfoDetailComp.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustHeroInfoDetailComp", package.seeall)

local M = class("BattleCampAdjustHeroInfoDetailComp", BattleHeroInfoDetailCompBase)
local kColorGrey = "#9F9F9F"
local kColorWhite = "#FFFFFF"

function M:buildUI(gameObject)
	self._bgGo = goutil.findChild(gameObject, "imgroleInfoDi")

	self.super.buildUI(self, goutil.findChild(gameObject, "roleInfo"))

	self._txtBloodOfNormal = goutil.findChildTextComponent(self.mainGO, "progress/txtBlood_unit")
	self._txtBloodOfWeak = goutil.findChildTextComponent(self.mainGO, "progress/txtBlood_boss")
	self._goBtnGroup = goutil.findChild(self.mainGO, "btnGroup")
	self._btnPreset = Astral.ButtonAdapter.Get(goutil.findChild(self._goBtnGroup, "btnPreset"))
	self._btnUpgrade = Astral.ButtonAdapter.Get(goutil.findChild(self._goBtnGroup, "btnUpgrade"))
end

function M:bindEvents()
	self.super.bindEvents(self)
	self._btnPreset:AddClickListener(self._onClickPreset, self)
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
end

function M:unbindEvents()
	self.super.unbindEvents(self)
	self._btnPreset:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
end

function M:_setEvent(add)
	self.super._setEvent(self, add)

	if add then
		GlobalDispatcher:addEventListener(EventType.HERO_INFO_CHANGE, self._onHeroInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.ON_BATTLE_UNIT_PROPERTY_MODIFY, self._onUnitPropertyModify, self)
		GlobalDispatcher:addEventListener(EventType.ON_BATTLE_UNIT_SKILL_MODIFY, self._onUnitSkillModify, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._onHeroDataChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HERO_INFO_CHANGE, self._onHeroInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.ON_BATTLE_UNIT_PROPERTY_MODIFY, self._onUnitPropertyModify, self)
		GlobalDispatcher:removeEventListener(EventType.ON_BATTLE_UNIT_SKILL_MODIFY, self._onUnitSkillModify, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._onHeroDataChange, self)
	end
end

function M:destroyUI()
	self.super.destroyUI(self)

	self._btnPreset = nil
	self._btnUpgrade = nil
end

function M:_updateViewById()
	self.super._updateViewById(self)

	local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._selectedHeroId)

	self:_updateButtonGroup(heroMO, nil)
end

function M:_updateViewInfoOfType2()
	self.super._updateViewInfoOfType2(self)
	self:_updateButtonGroup(nil, self._unit)
end

function M:_updateHp(curHp, maxHp, showWeakPoint)
	self:_setActive(self._txtBloodOfNormal.gameObject, not showWeakPoint)
	self:_setActive(self._txtBloodOfWeak.gameObject, showWeakPoint)

	if showWeakPoint then
		self._txtBloodOfWeak.text = string.format("%d<size=22>/%d</size>", curHp, maxHp)
	else
		self._txtBloodOfNormal.text = string.format("%d/<size=22>%d</size>", curHp, maxHp)
	end
end

function M:_updateButtonGroup(heroMO, unit)
	local heroId

	if heroMO then
		heroId = self._selectedHeroId
	elseif unit then
		heroId = unit.property:getEntityCode()
		heroId = ItemUtil.isCharacterById(heroId) and heroId or nil
	end

	if heroId then
		-- block empty
	end

	self:_setActive(self._goBtnGroup, heroId ~= nil and HeroDepotModel.instance:hasHero(heroId) and BattleCampAdjustmentModel.instance:isAdjusting())
end

function M:_onClickPreset()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.HeroPreset, true) then
		return
	end

	local heroId = self:_getCurHeroId()

	ViewMgr.instance:open(ViewName.CharacterPreinstallView, heroId, 2)
end

function M:_onClickUpgrade()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleUpgrade, true) then
		return
	end

	local upgradable = CharacterUtil.isHeroCanUpgrade(self:_getCurHeroId(), true)

	if upgradable then
		local heroId = self:_getCurHeroId()

		ViewMgr.instance:open(ViewName.CharacterUpgrade, {
			heroId = heroId
		})
	end
end

function M:_onHeroInfoChange()
	if self._selectedHeroId and not self._unit then
		self:_updateViewById()
	end
end

function M:_onUnitPropertyModify(_, entityCode)
	if self._unit and self._unit.property:getEntityCode() == entityCode then
		self:_updateViewInfoOfType2()
	end
end

function M:_onUnitSkillModify(_, entityCode)
	if self._unit and self._unit.property:getEntityCode() == entityCode then
		self:_updateViewInfoOfType2()
	end
end

function M:_onHeroDataChange(_, heroData)
	if self._unit and heroData:getId() == self._unit.property:getEntityCode() then
		self:_updateViewInfoOfType2()
	elseif self._selectedHeroId and heroData:getId() == self._selectedHeroId then
		self:_updateViewById()
	end
end

function M:_getCurHeroId()
	if self._unit then
		return self._unit.property:getEntityCode()
	else
		return self._selectedHeroId
	end
end

return M
