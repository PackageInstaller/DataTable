-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/dispatch/VersionActivity1_8DispatchHeroItem.lua

module("modules.logic.versionactivity1_8.dungeon.view.dispatch.VersionActivity1_8DispatchHeroItem", package.seeall)

local VersionActivity1_8DispatchHeroItem = class("VersionActivity1_8DispatchHeroItem", ListScrollCell)

function VersionActivity1_8DispatchHeroItem:init(go)
	self._go = go
	self._simageicon = gohelper.findChildSingleImage(self._go, "#simage_icon")
	self._imagecareer = gohelper.findChildImage(self._go, "#image_career")
	self._godispatched = gohelper.findChild(self._go, "#go_dispatched")
	self._goselected = gohelper.findChild(self._go, "#go_selected")

	gohelper.setActive(self._goselected, false)

	self._txtindex = gohelper.findChildText(self._go, "#go_selected/#txt_index")
	self.click = gohelper.getClick(self._go)
	self.isSelected = false
	self.dispatched = false
end

function VersionActivity1_8DispatchHeroItem:addEventListeners()
	self.click:AddClickListener(self.onClickSelf, self)
	self.addEventCb(self, DispatchController.instance, DispatchEvent.ChangeSelectedHero, self.updateSelect, self)
end

function VersionActivity1_8DispatchHeroItem:removeEventListeners()
	self.click:RemoveClickListener()
	self.removeEventCb(self, DispatchController.instance, DispatchEvent.ChangeSelectedHero, self.updateSelect, self)
end

function VersionActivity1_8DispatchHeroItem:onClickSelf()
	local isCanChangeHero = DispatchHeroListModel.instance:canChangeHeroMo()

	if not isCanChangeHero then
		return
	end

	local isDispatched = self.mo:isDispatched()

	if isDispatched then
		return
	end

	if self.isSelected then
		DispatchHeroListModel.instance:deselectMo(self.mo)
	else
		local isCanAddMo = DispatchHeroListModel.instance:canAddMo()

		if isCanAddMo then
			DispatchHeroListModel.instance:selectMo(self.mo)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function VersionActivity1_8DispatchHeroItem:updateSelect()
	local index = DispatchHeroListModel.instance:getSelectedIndex(self.mo)

	self.isSelected = index ~= nil

	gohelper.setActive(self._goselected, self.isSelected)

	if self.isSelected then
		self._txtindex.text = index
	end
end

function VersionActivity1_8DispatchHeroItem:onUpdateMO(mo)
	self.mo = mo
	self.config = mo.config

	local headIconPath = ResUrl.getRoomHeadIcon(self.config.id .. "01")

	self._simageicon:LoadImage(headIconPath)
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. self.config.career)

	self.dispatched = self.mo:isDispatched()

	if self.dispatched then
		self.isSelected = false
	else
		local index = DispatchHeroListModel.instance:getSelectedIndex(self.mo)

		self.isSelected = index ~= nil
	end

	gohelper.setActive(self._godispatched, self.dispatched)
	self:updateSelect()
end

function VersionActivity1_8DispatchHeroItem:onDestroy()
	self._simageicon:UnLoadImage()
end

return VersionActivity1_8DispatchHeroItem
