-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/dispatch/VersionActivity1_8DispatchSelectHeroItem.lua

module("modules.logic.versionactivity1_8.dungeon.view.dispatch.VersionActivity1_8DispatchSelectHeroItem", package.seeall)

local VersionActivity1_8DispatchSelectHeroItem = class("VersionActivity1_8DispatchSelectHeroItem", LuaCompBase)

function VersionActivity1_8DispatchSelectHeroItem:ctor(index)
	self.index = index
end

function VersionActivity1_8DispatchSelectHeroItem:init(go)
	self.go = go
	self.goHero = gohelper.findChild(self.go, "#go_hero")
	self.simageHeroIcon = gohelper.findChildSingleImage(self.go, "#go_hero/#simage_heroicon")
	self.imageCareer = gohelper.findChildImage(self.go, "#go_hero/#image_career")
	self.click = gohelper.getClick(self.go)

	gohelper.setActive(self.goHero, false)
end

function VersionActivity1_8DispatchSelectHeroItem:addEventListeners()
	self.click:AddClickListener(self.onClickSelf, self)
	self.addEventCb(self, DispatchController.instance, DispatchEvent.ChangeSelectedHero, self.refreshUI, self)
end

function VersionActivity1_8DispatchSelectHeroItem:removeEventListeners()
	self.click:RemoveClickListener()
	self.removeEventCb(self, DispatchController.instance, DispatchEvent.ChangeSelectedHero, self.refreshUI, self)
end

function VersionActivity1_8DispatchSelectHeroItem:onClickSelf()
	local isCanChangeHero = DispatchHeroListModel.instance:canChangeHeroMo()

	if not isCanChangeHero then
		return
	end

	if self.mo then
		DispatchHeroListModel.instance:deselectMo(self.mo)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end

	DispatchController.instance:dispatchEvent(DispatchEvent.ChangeDispatchHeroContainerEvent, true)
end

function VersionActivity1_8DispatchSelectHeroItem:refreshUI()
	self.mo = DispatchHeroListModel.instance:getSelectedMoByIndex(self.index)

	local isSelected = self:isSelected()

	gohelper.setActive(self.goHero, isSelected)

	if isSelected then
		self.heroCo = self.mo.config

		local headIconPath = ResUrl.getRoomHeadIcon(self.heroCo.id .. "01")

		self.simageHeroIcon:LoadImage(headIconPath)
		UISpriteSetMgr.instance:setCommonSprite(self.imageCareer, "lssx_" .. self.heroCo.career)
	end
end

function VersionActivity1_8DispatchSelectHeroItem:isSelected()
	return self.mo ~= nil
end

function VersionActivity1_8DispatchSelectHeroItem:destroy()
	self.simageHeroIcon:UnLoadImage()
end

return VersionActivity1_8DispatchSelectHeroItem
