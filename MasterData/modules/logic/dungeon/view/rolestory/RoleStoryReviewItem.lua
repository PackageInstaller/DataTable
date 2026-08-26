-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryReviewItem.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryReviewItem", package.seeall)

local RoleStoryReviewItem = class("RoleStoryReviewItem", ListScrollCellExtend)

function RoleStoryReviewItem:onInitView()
	self.goSelect = gohelper.findChild(self.viewGO, "selectbg")
	self.txtSelectOrder = gohelper.findChildTextMesh(self.goSelect, "#txt_selectorder")
	self.goNormal = gohelper.findChild(self.viewGO, "normalbg")
	self.txtNormalOrder = gohelper.findChildTextMesh(self.goNormal, "#txt_normalorder")
	self.txtStoryName = gohelper.findChildTextMesh(self.viewGO, "#txt_storyname")
	self.btnClick = gohelper.findButtonWithAudio(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryReviewItem:addEvents()
	self.addClickCb(self, self.btnClick, self.onClickBtnClick, self)
end

function RoleStoryReviewItem:removeEvents()
	return
end

function RoleStoryReviewItem:onClickBtnClick()
	if not self.data then
		return
	end

	local selelcted = self.selectDispatchId == self.data.id

	if selelcted then
		return
	end

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ClickReviewItem, self.data.id)
end

function RoleStoryReviewItem:refreshItem()
	if not self.data then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	self.txtSelectOrder.text = string.format("%02d", self.index)
	self.txtNormalOrder.text = string.format("%02d", self.index)
	self.txtStoryName.text = self.data.name

	local selelcted = self.selectDispatchId == self.data.id

	gohelper.setActive(self.goSelect, selelcted)
	gohelper.setActive(self.goNormal, not selelcted)
end

function RoleStoryReviewItem:onUpdateMO(data, index)
	self.data = data
	self.index = index

	self:refreshItem()
end

function RoleStoryReviewItem:updateSelect(dispatchId)
	self.selectDispatchId = dispatchId

	self:refreshItem()
end

function RoleStoryReviewItem:_editableInitView()
	return
end

function RoleStoryReviewItem:onDestroyView()
	return
end

return RoleStoryReviewItem
