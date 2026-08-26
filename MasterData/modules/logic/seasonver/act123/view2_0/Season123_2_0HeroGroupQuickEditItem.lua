-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0HeroGroupQuickEditItem.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0HeroGroupQuickEditItem", package.seeall)

local Season123_2_0HeroGroupQuickEditItem = class("Season123_2_0HeroGroupQuickEditItem", Season123_2_0HeroGroupEditItem)

function Season123_2_0HeroGroupQuickEditItem:init(go)
	Season123_2_0HeroGroupQuickEditItem.super.init(self, go)

	self._imageorder = gohelper.findChildImage(go, "#go_orderbg/#image_order")
	self._goorderbg = gohelper.findChild(go, "#go_orderbg")
	self._gohp = gohelper.findChild(go, "#go_hp")
	self._sliderhp = gohelper.findChildSlider(go, "#go_hp/#slider_hp")
	self._imagehp = gohelper.findChildImage(go, "#go_hp/#slider_hp/Fill Area/Fill")
	self._godead = gohelper.findChild(go, "#go_dead")

	self:enableDeselect(false)
	self._heroItem:setNewShow(false)
	gohelper.setActive(self._goorderbg, false)
end

function Season123_2_0HeroGroupQuickEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self._heroItem:setNewShow(false)
	self:updateLimitStatus()

	local index = Season123HeroGroupQuickEditModel.instance:getHeroTeamPos(self._mo.uid)

	self._team_pos_index = index

	if index ~= 0 then
		if not self._open_ani_finish then
			TaskDispatcher.runDelay(self._show_goorderbg, self, 0.3)
		else
			self:_show_goorderbg()
		end
	else
		gohelper.setActive(self._goorderbg, false)
	end

	self._open_ani_finish = true

	self:refreshHp()
	self:refreshDead()
end

function Season123_2_0HeroGroupQuickEditItem:_show_goorderbg()
	gohelper.setActive(self._goorderbg, true)
	UISpriteSetMgr.instance:setHeroGroupSprite(self._imageorder, "biandui_shuzi_" .. self._team_pos_index)
end

function Season123_2_0HeroGroupQuickEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self:checkRestrict(self._mo.uid) or self:checkHpZero(self._mo.uid) then
		return
	end

	if self._mo then
		local result = Season123HeroGroupQuickEditModel.instance:selectHero(self._mo.uid)

		if not result then
			return
		end
	end

	if self._isSelect and self._enableDeselect then
		self._view:selectCell(self._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		self._view:selectCell(self._index, true)
	end
end

function Season123_2_0HeroGroupQuickEditItem:onSelect(select)
	self._isSelect = select

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function Season123_2_0HeroGroupQuickEditItem:onDestroy()
	TaskDispatcher.cancelTask(self._show_goorderbg, self)
	Season123_2_0HeroGroupQuickEditItem.super.onDestroy(self)
end

return Season123_2_0HeroGroupQuickEditItem
