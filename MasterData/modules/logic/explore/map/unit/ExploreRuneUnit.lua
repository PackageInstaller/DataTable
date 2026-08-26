-- chunkname: @modules/logic/explore/map/unit/ExploreRuneUnit.lua

module("modules.logic.explore.map.unit.ExploreRuneUnit", package.seeall)

local ExploreRuneUnit = class("ExploreRuneUnit", ExploreBaseDisplayUnit)

function ExploreRuneUnit:onInit()
	return
end

function ExploreRuneUnit:tryTrigger()
	self._triggerType = ExploreEnum.RuneTriggerType.None

	local useItemUid = ExploreModel.instance:getUseItemUid()
	local itemMo = ExploreBackpackModel.instance:getById(useItemUid)

	if itemMo and itemMo.itemEffect == ExploreEnum.ItemEffect.Active then
		local isActiveState = self.mo:isInteractActiveState()
		local itemStatus = itemMo.status

		if ExploreEnum.RuneStatus.Inactive == itemStatus and not isActiveState or ExploreEnum.RuneStatus.Active == itemStatus and isActiveState then
			-- block empty
		elseif ExploreEnum.RuneStatus.Inactive == itemStatus and isActiveState then
			self._triggerType = ExploreEnum.RuneTriggerType.ItemActive

			ExploreRuneUnit.super.tryTrigger(self)
		elseif ExploreEnum.RuneStatus.Active == itemStatus and isActiveState == false then
			self._triggerType = ExploreEnum.RuneTriggerType.RuneActive

			ExploreRuneUnit.super.tryTrigger(self)
		end
	end
end

function ExploreRuneUnit:canTrigger()
	local canTrigger = ExploreRuneUnit.super.canTrigger(self)

	if not canTrigger then
		return false
	end

	if ExploreModel.instance:getStepPause() then
		return false
	end

	local useItemUid = ExploreModel.instance:getUseItemUid()
	local itemMo = ExploreBackpackModel.instance:getById(useItemUid)

	if itemMo and itemMo.itemEffect == ExploreEnum.ItemEffect.Active then
		local isActiveState = self.mo:isInteractActiveState()
		local itemStatus = itemMo.status

		if ExploreEnum.RuneStatus.Inactive == itemStatus and not isActiveState or ExploreEnum.RuneStatus.Active == itemStatus and isActiveState then
			return false
		elseif ExploreEnum.RuneStatus.Inactive == itemStatus and isActiveState then
			return true
		elseif ExploreEnum.RuneStatus.Active == itemStatus and isActiveState == false then
			return true
		end
	end

	return false
end

function ExploreRuneUnit:needInteractAnim()
	return true
end

function ExploreRuneUnit:onTriggerDone()
	if self._triggerType == ExploreEnum.RuneTriggerType.ItemActive and self._displayTr then
		local whirl = ExploreController.instance:getMapWhirl():getWhirl(ExploreEnum.WhirlType.Rune)

		if whirl then
			ExploreModel.instance:setStepPause(true)
			ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Rune)
			whirl:flyToPos(true, self._whirlFlyBack, self)

			return
		end
	end

	local hero = ExploreController.instance:getMap():getHero()

	hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Interact, true, false)

	self._triggerType = nil
end

function ExploreRuneUnit:playAnim(animName)
	if animName == ExploreAnimEnum.AnimName.nToA and self._displayTr then
		local whirl = ExploreController.instance:getMapWhirl():getWhirl(ExploreEnum.WhirlType.Rune)

		if whirl then
			ExploreModel.instance:setStepPause(true)
			ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Rune)
			whirl:flyToPos(false, self._realPlayNToA, self)

			return
		end
	end

	ExploreRuneUnit.super.playAnim(self, animName)
end

function ExploreRuneUnit:getHeroDir()
	return ExploreController.instance:getMap():getHero().dir
end

function ExploreRuneUnit:onAnimEnd(preAnim, nowAnim)
	if preAnim == ExploreAnimEnum.AnimName.nToA or preAnim == ExploreAnimEnum.AnimName.aToN then
		self.mo:checkActiveCount()
	end
end

function ExploreRuneUnit:_whirlFlyBack()
	local whirl = ExploreController.instance:getMapWhirl():getWhirl(ExploreEnum.WhirlType.Rune)

	if whirl then
		whirl:flyBack()
	end
end

function ExploreRuneUnit:_realPlayNToA()
	ExploreRuneUnit.super.playAnim(self, ExploreAnimEnum.AnimName.nToA)
end

return ExploreRuneUnit
