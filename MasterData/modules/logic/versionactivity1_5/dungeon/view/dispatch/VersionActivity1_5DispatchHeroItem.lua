-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/dispatch/VersionActivity1_5DispatchHeroItem.lua

module("modules.logic.versionactivity1_5.dungeon.view.dispatch.VersionActivity1_5DispatchHeroItem", package.seeall)

local VersionActivity1_5DispatchHeroItem = class("VersionActivity1_5DispatchHeroItem", ListScrollCell)

function VersionActivity1_5DispatchHeroItem:init(go)
	self._go = go
	self._simageicon = gohelper.findChildSingleImage(self._go, "#simage_icon")
	self._imagecareer = gohelper.findChildImage(self._go, "#image_career")
	self._godispatched = gohelper.findChild(self._go, "#go_dispatched")
	self._goselected = gohelper.findChild(self._go, "#go_selected")
	self._txtindex = gohelper.findChildText(self._go, "#go_selected/#txt_index")

	gohelper.setActive(self._goselected, false)

	self.click = gohelper.getClick(self._go)
	self.isSelected = false
	self.dispatched = false
end

function VersionActivity1_5DispatchHeroItem:addEventListeners()
	self.click:AddClickListener(self.onClickSelf, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeSelectedHero, self.updateSelect, self)
end

function VersionActivity1_5DispatchHeroItem:removeEventListeners()
	self.click:RemoveClickListener()
	self.removeEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeSelectedHero, self.updateSelect, self)
end

function VersionActivity1_5DispatchHeroItem:updateSelect()
	local index = VersionActivity1_5HeroListModel.instance:getSelectedIndex(self.mo)

	self.isSelected = index ~= nil

	gohelper.setActive(self._goselected, self.isSelected)

	if self.isSelected then
		self._txtindex.text = index
	end
end

function VersionActivity1_5DispatchHeroItem:onClickSelf()
	if not VersionActivity1_5HeroListModel.instance:canChangeHeroMo() then
		return
	end

	if self.mo:isDispatched() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)

	if self.isSelected then
		VersionActivity1_5HeroListModel.instance:deselectMo(self.mo)

		return
	end

	if VersionActivity1_5HeroListModel.instance:canAddMo() then
		VersionActivity1_5HeroListModel.instance:selectMo(self.mo)
	end
end

function VersionActivity1_5DispatchHeroItem:onUpdateMO(mo)
	self.mo = mo
	self.config = mo.config

	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(self.config.id .. "01"))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. self.config.career)

	self.dispatched = self.mo:isDispatched()

	if self.dispatched then
		self.isSelected = false
	else
		local index = VersionActivity1_5HeroListModel.instance:getSelectedIndex(self.mo)

		self.isSelected = index ~= nil
	end

	gohelper.setActive(self._godispatched, self.dispatched)
	self:updateSelect()
end

function VersionActivity1_5DispatchHeroItem:onDestroy()
	self._simageicon:UnLoadImage()
end

return VersionActivity1_5DispatchHeroItem
