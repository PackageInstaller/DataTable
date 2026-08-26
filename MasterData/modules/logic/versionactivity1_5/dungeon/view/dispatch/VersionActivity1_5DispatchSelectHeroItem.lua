-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/dispatch/VersionActivity1_5DispatchSelectHeroItem.lua

module("modules.logic.versionactivity1_5.dungeon.view.dispatch.VersionActivity1_5DispatchSelectHeroItem", package.seeall)

local VersionActivity1_5DispatchSelectHeroItem = class("VersionActivity1_5DispatchSelectHeroItem", UserDataDispose)

function VersionActivity1_5DispatchSelectHeroItem.createItem(go, index)
	local item = VersionActivity1_5DispatchSelectHeroItem.New()

	item:init(go, index)

	return item
end

function VersionActivity1_5DispatchSelectHeroItem:init(go, index)
	self:__onInit()

	self.index = index
	self.go = go
	self.goHero = gohelper.findChild(self.go, "#go_hero")
	self.simageHeroIcon = gohelper.findChildSingleImage(self.go, "#go_hero/#simage_heroicon")
	self.imageCareer = gohelper.findChildImage(self.go, "#go_hero/#image_career")
	self.click = gohelper.getClick(self.go)

	self.click:AddClickListener(self.onClickSelf, self)
	gohelper.setActive(self.goHero, false)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeSelectedHero, self.refreshUI, self)
end

function VersionActivity1_5DispatchSelectHeroItem:onClickSelf()
	if not VersionActivity1_5HeroListModel.instance:canChangeHeroMo() then
		return
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ChangeDispatchHeroContainerEvent, true)

	if self.mo == nil then
		return
	end

	VersionActivity1_5HeroListModel.instance:deselectMo(self.mo)
end

function VersionActivity1_5DispatchSelectHeroItem:isSelected()
	return self.mo ~= nil
end

function VersionActivity1_5DispatchSelectHeroItem:refreshUI()
	self.mo = VersionActivity1_5HeroListModel.instance:getSelectedMoByIndex(self.index)

	gohelper.setActive(self.goHero, self:isSelected())

	if self:isSelected() then
		self.heroCo = self.mo.config

		self.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(self.heroCo.id .. "01"))
		UISpriteSetMgr.instance:setCommonSprite(self.imageCareer, "lssx_" .. self.heroCo.career)
	end
end

function VersionActivity1_5DispatchSelectHeroItem:destroy()
	self.simageHeroIcon:UnLoadImage()
	self.click:RemoveClickListener()
	self:__onDispose()
end

return VersionActivity1_5DispatchSelectHeroItem
