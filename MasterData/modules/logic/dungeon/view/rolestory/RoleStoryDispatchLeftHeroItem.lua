-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchLeftHeroItem.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchLeftHeroItem", package.seeall)

local RoleStoryDispatchLeftHeroItem = class("RoleStoryDispatchLeftHeroItem", ListScrollCellExtend)

function RoleStoryDispatchLeftHeroItem:onInitView()
	self.goHero = gohelper.findChild(self.viewGO, "#go_hero")
	self.simageHeroIcon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self.imageCareer = gohelper.findChildImage(self.viewGO, "#image_career")
	self.goDispatched = gohelper.findChild(self.viewGO, "#go_dispatched")
	self.goSelected = gohelper.findChild(self.viewGO, "#go_selected")
	self.txtIndex = gohelper.findChildTextMesh(self.viewGO, "#go_selected/#txt_index")
	self.goUp = gohelper.findChild(self.viewGO, "upicon")
	self.btnClick = gohelper.findButtonWithAudio(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryDispatchLeftHeroItem:addEvents()
	self.addClickCb(self, self.btnClick, self.onClickBtnClick, self)
end

function RoleStoryDispatchLeftHeroItem:removeEvents()
	return
end

function RoleStoryDispatchLeftHeroItem:refreshItem()
	self.config = self.mo.config

	self.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(self.config.id .. "01"))
	UISpriteSetMgr.instance:setCommonSprite(self.imageCareer, "lssx_" .. self.config.career)

	local dispatched = self.mo:isDispatched()
	local index = RoleStoryDispatchHeroListModel.instance:getSelectedIndex(self.mo.heroId)
	local selected = index ~= nil

	gohelper.setActive(self.goDispatched, dispatched)
	gohelper.setActive(self.goSelected, selected)

	if selected then
		self.txtIndex.text = index
	end

	gohelper.setActive(self.goUp, self.mo:isEffectHero())
end

function RoleStoryDispatchLeftHeroItem:onUpdateMO(mo)
	self.mo = mo

	self:refreshItem()
end

function RoleStoryDispatchLeftHeroItem:onClickBtnClick()
	RoleStoryDispatchHeroListModel.instance:clickHeroMo(self.mo)
end

function RoleStoryDispatchLeftHeroItem:_editableInitView()
	return
end

function RoleStoryDispatchLeftHeroItem:onDestroyView()
	if self.simageHeroIcon then
		self.simageHeroIcon:UnLoadImage()

		self.simageHeroIcon = nil
	end
end

return RoleStoryDispatchLeftHeroItem
