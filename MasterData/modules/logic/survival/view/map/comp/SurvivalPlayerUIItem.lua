-- chunkname: @modules/logic/survival/view/map/comp/SurvivalPlayerUIItem.lua

module("modules.logic.survival.view.map.comp.SurvivalPlayerUIItem", package.seeall)

local SurvivalPlayerUIItem = class("SurvivalPlayerUIItem", SurvivalUnitUIItem)

function SurvivalPlayerUIItem:init(go)
	self._gohero = gohelper.findChild(go, "hero")
	self._imageprogress = gohelper.findChildImage(go, "hero/#image_progress")
	self._imageprogressbg = gohelper.findChildImage(go, "hero/image_progressbg")
	self._simage_hero = gohelper.findChildImage(go, "hero/#simage_hero")

	SurvivalPlayerUIItem.super.init(self, go)
	self:setIconEnable()
end

function SurvivalPlayerUIItem:addEventListeners()
	SurvivalPlayerUIItem.super.addEventListeners(self)
	SurvivalController.instance:registerCallback(SurvivalEvent.ShowSurvivalHeroTick, self._showHeroTick, self)
end

function SurvivalPlayerUIItem:removeEventListeners()
	SurvivalPlayerUIItem.super.removeEventListeners(self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.ShowSurvivalHeroTick, self._showHeroTick, self)
end

function SurvivalPlayerUIItem:refreshInfo()
	gohelper.setActive(self._golevel, false)
	gohelper.setActive(self._imageicon, false)
	gohelper.setActive(self._imagebubble, false)
	gohelper.setActive(self._imageprogressbg, false)
	gohelper.setActive(self._imageprogress, false)

	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	local path = lua_survival_role.configDict[survivalShelterRoleMo.roleId].moveHead

	UISpriteSetMgr.instance:setSurvivalSprite2(self._simage_hero, path)
end

function SurvivalPlayerUIItem:_showHeroTick(curVal, totalVal)
	self:setIconEnable(true)
	gohelper.setActive(self._imageprogressbg, true)
	gohelper.setActive(self._imageprogress, true)

	self._curVal = curVal
	self._totalVal = totalVal
	self._imageprogress.fillAmount = (curVal - 1) / totalVal
	self._tweenId = ZProj.TweenHelper.DOFillAmount(self._imageprogress, curVal / totalVal, SurvivalConst.PlayerMoveSpeed, self._onTweenEnd, self, nil, EaseType.Linear)
end

function SurvivalPlayerUIItem:_onTweenEnd()
	if self._curVal == self._totalVal then
		gohelper.setActive(self._imageprogressbg, false)
		gohelper.setActive(self._imageprogress, false)

		local entity = SurvivalMapHelper.instance:getEntity(0)

		if entity then
			self:setIconEnable(not entity.isShow)
		end
	end

	self._tweenId = nil
end

function SurvivalPlayerUIItem:setIconEnable(isEnabled)
	self._isIconEnabled = isEnabled

	self:updateIconShow()
end

function SurvivalPlayerUIItem:_onArrowChange(show)
	SurvivalPlayerUIItem.super._onArrowChange(self, show)
	gohelper.setActive(self._imagebubble, false)
	self:updateIconShow()
end

function SurvivalPlayerUIItem:updateIconShow()
	gohelper.setActive(self._gohero, self._isIconEnabled or self._isArrowShow)
end

function SurvivalPlayerUIItem:checkEnabled()
	return
end

function SurvivalPlayerUIItem:onDestroy()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return SurvivalPlayerUIItem
