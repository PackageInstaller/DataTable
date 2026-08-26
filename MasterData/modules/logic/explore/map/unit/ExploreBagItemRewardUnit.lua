-- chunkname: @modules/logic/explore/map/unit/ExploreBagItemRewardUnit.lua

module("modules.logic.explore.map.unit.ExploreBagItemRewardUnit", package.seeall)

local ExploreBagItemRewardUnit = class("ExploreBagItemRewardUnit", ExploreBaseDisplayUnit)

function ExploreBagItemRewardUnit:needInteractAnim()
	return true
end

function ExploreBagItemRewardUnit:playAnim(animName)
	if animName == ExploreAnimEnum.AnimName.exit then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.checkHavePopup, self)
	else
		ExploreBagItemRewardUnit.super.playAnim(self, animName)
	end
end

function ExploreBagItemRewardUnit:checkHavePopup()
	if PopupController.instance:getPopupCount() > 0 or ViewMgr.instance:isOpen(ViewName.ExploreGetItemView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		return true
	else
		self:onPopupEnd()
	end
end

function ExploreBagItemRewardUnit:onPopupEnd()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.checkHavePopup, self)
	self.animComp:playAnim(ExploreAnimEnum.AnimName.exit)
end

function ExploreBagItemRewardUnit:onDestroy()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.checkHavePopup, self)
	ExploreBagItemRewardUnit.super.onDestroy(self)
end

return ExploreBagItemRewardUnit
