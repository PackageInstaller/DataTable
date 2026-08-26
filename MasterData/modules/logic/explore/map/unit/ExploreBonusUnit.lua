-- chunkname: @modules/logic/explore/map/unit/ExploreBonusUnit.lua

module("modules.logic.explore.map.unit.ExploreBonusUnit", package.seeall)

local ExploreBonusUnit = class("ExploreBonusUnit", ExploreBaseMoveUnit)

function ExploreBonusUnit:canTrigger()
	if self.mo:isInteractActiveState() then
		return false
	end

	return ExploreBonusUnit.super.canTrigger(self)
end

function ExploreBonusUnit:playAnim(animName)
	ExploreBonusUnit.super.playAnim(self, animName)

	if animName == ExploreAnimEnum.AnimName.nToA then
		PopupController.instance:setPause("ExploreBonusUnit_EXIT", true)

		local hero = ExploreController.instance:getMap():getHero()

		hero:onCheckDir(hero.nodePos, self.nodePos)
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.OpenChest, true, true)
		self.animComp:setShowEffect(false)
	end
end

function ExploreBonusUnit:onAnimEnd(preAnim, nowAnim)
	if preAnim == ExploreAnimEnum.AnimName.nToA then
		AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_cordage02)
		PopupController.instance:setPause("ExploreBonusUnit_EXIT", false)

		if self:checkHavePopup() then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.checkHavePopup, self)
		end
	end

	ExploreBonusUnit.super.onAnimEnd(self, preAnim, nowAnim)
end

function ExploreBonusUnit:checkHavePopup()
	if PopupController.instance:getPopupCount() > 0 or ViewMgr.instance:isOpen(ViewName.ExploreGetItemView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		return true
	else
		self:onPopupEnd()
	end
end

function ExploreBonusUnit:onPopupEnd()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.checkHavePopup, self)
	self.animComp:setShowEffect(true)
	self.animComp:_setCurAnimName(ExploreAnimEnum.AnimName.active)
end

function ExploreBonusUnit:onDestroy(...)
	PopupController.instance:setPause("ExploreBonusUnit_EXIT", false)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.checkHavePopup, self)
	ExploreBonusUnit.super.onDestroy(self, ...)
end

return ExploreBonusUnit
