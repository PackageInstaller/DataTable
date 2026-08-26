-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchRightHeroItem.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchRightHeroItem", package.seeall)

local RoleStoryDispatchRightHeroItem = class("RoleStoryDispatchRightHeroItem", ListScrollCellExtend)

function RoleStoryDispatchRightHeroItem:onInitView()
	self.goAdd = gohelper.findChild(self.viewGO, "add")
	self.goHero = gohelper.findChild(self.viewGO, "#go_hero")
	self.simageHeroIcon = gohelper.findChildSingleImage(self.viewGO, "#go_hero/#simage_heroicon")
	self.imageCareer = gohelper.findChildImage(self.viewGO, "#go_hero/#image_career")
	self.btnClick = gohelper.findButtonWithAudio(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryDispatchRightHeroItem:addEvents()
	self.addClickCb(self, self.btnClick, self.onClickBtnClick, self)
end

function RoleStoryDispatchRightHeroItem:removeEvents()
	return
end

function RoleStoryDispatchRightHeroItem:refreshItem()
	if self.index > self.maxCount then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)
	gohelper.setActive(self.goAdd, not self.data)

	if not self.data then
		self:clear()
		gohelper.setActive(self.goHero, false)

		return
	end

	gohelper.setActive(self.goHero, true)

	local config = self.data.config

	self.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(config.id .. "01"))
	UISpriteSetMgr.instance:setCommonSprite(self.imageCareer, "lssx_" .. config.career)
end

function RoleStoryDispatchRightHeroItem:onUpdateMO(data, index, maxCount)
	self.data = data
	self.index = index
	self.maxCount = maxCount

	self:refreshItem()
end

function RoleStoryDispatchRightHeroItem:onClickBtnClick()
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ClickRightHero, self.data)
end

function RoleStoryDispatchRightHeroItem:_editableInitView()
	return
end

function RoleStoryDispatchRightHeroItem:clear()
	return
end

function RoleStoryDispatchRightHeroItem:onDestroyView()
	self:clear()

	if self.simageHeroIcon then
		self.simageHeroIcon:UnLoadImage()

		self.simageHeroIcon = nil
	end
end

return RoleStoryDispatchRightHeroItem
