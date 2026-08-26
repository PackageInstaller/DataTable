-- chunkname: @modules/logic/necrologiststory/view/item/V3A2NecrologistStoryOptionsItem.lua

module("modules.logic.necrologiststory.view.item.V3A2NecrologistStoryOptionsItem", package.seeall)

local V3A2NecrologistStoryOptionsItem = class("V3A2NecrologistStoryOptionsItem", NecrologistStoryOptionsItem)

function V3A2NecrologistStoryOptionsItem:refreshOptionList()
	local storyConfig = self:getStoryConfig()
	local sections = GameUtil.splitString2(storyConfig.param, true, "#", ",")
	local options = string.split(NecrologistStoryHelper.getDescByConfig(storyConfig), "#")

	for i = 1, math.max(#sections, #self.itemList) do
		local item = self:getOptionItem(i)

		self:updateOptionItem(item, sections[i], options[i])
	end

	ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)
end

function V3A2NecrologistStoryOptionsItem:getOptionItem(index)
	local item = self.itemList[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self.goOption, tostring(index))

		item.go = go
		item.goRaycast = gohelper.findChild(go, "raycast")
		item.goCanClick = gohelper.findChild(go, "canclick")
		item.goUnSelect = gohelper.findChild(go, "unselect")
		item.goSelect = gohelper.findChild(go, "select")
		item.txtContent = gohelper.findChildTextMesh(go, "#txt_choice")
		item.goArrow = gohelper.findChild(go, "#txt_choice/image_arrow")
		item.goLoop = gohelper.findChild(go, "loop")
		item.trsArrow = item.goArrow.transform
		item.btn = gohelper.findButtonWithAudio(go)

		item.btn:AddClickListener(self.onClickOption, self, item)

		self.itemList[index] = item
	end

	return item
end

function V3A2NecrologistStoryOptionsItem:updateOptionItem(item, data, optionDesc)
	local section = data and data[1]

	item.section = section

	if not section then
		gohelper.setActive(item.go, false)

		return
	end

	item.buttonType = data[2]

	local checkItem = data[3]

	item.checkItem = checkItem

	local hasCheckItem = checkItem ~= nil

	gohelper.setActive(item.go, true)

	local hasSelect = self.selectSection ~= nil

	if hasSelect then
		gohelper.setActive(item.goCanClick, false)

		local isSelect = self.selectSection == section

		gohelper.setActive(item.goSelect, isSelect)
		gohelper.setActive(item.goUnSelect, not isSelect)
	else
		gohelper.setActive(item.goCanClick, true)
		gohelper.setActive(item.goSelect, false)
		gohelper.setActive(item.goUnSelect, false)
	end

	item.txtContent.text = optionDesc

	local canClick = not hasSelect or hasCheckItem

	item.btn.button.interactable = canClick

	gohelper.setActive(item.goRaycast, canClick)
	gohelper.setActive(item.goArrow, hasCheckItem)
	gohelper.setActive(item.goLoop, not hasSelect and item.buttonType == 1)

	if hasSelect and item.useItemComp and not item.useItemComp:isDone() then
		item.useItemComp:setSelectItem(0)
		item.useItemComp:refreshItemList()
	end

	if hasCheckItem then
		local angle = item.isShowUseItem and 180 or 0

		transformhelper.setLocalRotation(item.trsArrow, 0, 0, angle)
	end
end

function V3A2NecrologistStoryOptionsItem:onClickOption(item)
	if item.checkItem then
		self:onClickItemOption(item)
	else
		V3A2NecrologistStoryOptionsItem.super.onClickOption(self, item)
	end
end

function V3A2NecrologistStoryOptionsItem:onClickItemOption(item)
	item.isShowUseItem = not item.isShowUseItem

	local angle = item.isShowUseItem and 180 or 0

	transformhelper.setLocalRotation(item.trsArrow, 0, 0, angle)

	if item.useItemComp then
		self:useItemShowOrHide(item)
		ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)
		self:refreshHeight()

		return
	end

	if self.useItemLoader then
		local useItemGO = self.useItemLoader:getInstGO()

		if not gohelper.isNil(useItemGO) then
			self:refreshOptionUseItemList()
		end

		return
	end

	self.useItemLoader = PrefabInstantiate.Create(self.goContent)

	self.useItemLoader:startLoad(V3A2NecrologistStoryUseItem.getResPath(), self.onUseItemLoaded, self)
end

function V3A2NecrologistStoryOptionsItem:onUseItemLoaded(loader)
	local useItemGO = loader:getInstGO()

	gohelper.setActive(useItemGO, false)
	self:refreshOptionUseItemList()
end

function V3A2NecrologistStoryOptionsItem:refreshOptionUseItemList()
	for _, item in ipairs(self.itemList) do
		self:refreshOptionUseItem(item)
	end

	ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)
	self:refreshHeight()
end

function V3A2NecrologistStoryOptionsItem:refreshOptionUseItem(item)
	if not item.section or not item.checkItem then
		return
	end

	if not item.useItemComp then
		local useItemGO = self.useItemLoader:getInstGO()
		local go = gohelper.cloneInPlace(useItemGO, "useitem")
		local index = gohelper.getSibling(item.go)

		gohelper.setSibling(go, index + 1)

		item.useItemComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3A2NecrologistStoryUseItem)

		item.useItemComp:setParent(self.storyView:getScrollViewGO())
		item.useItemComp:setClickCallback(self.onClickUseItem, self, item)
	end

	item.useItemComp:setCheckItem(item.checkItem)
	self:useItemShowOrHide(item)
end

function V3A2NecrologistStoryOptionsItem:useItemShowOrHide(optionItem)
	local isShow = optionItem.isShowUseItem

	if not optionItem.useItemComp then
		return
	end

	TaskDispatcher.runRepeat(self.frameUpdateHight, self, 0.02)

	if isShow then
		optionItem.useItemComp:show(self.onShowOrCloseFinish, self)
	else
		optionItem.useItemComp:hide(self.onShowOrCloseFinish, self)
	end
end

function V3A2NecrologistStoryOptionsItem:onClickUseItem(optionItem, useItem)
	local mo = NecrologistStoryModel.instance:getCurStoryMO()

	if mo then
		mo:markSpecial(self:getStoryId())
	end

	V3A2NecrologistStoryOptionsItem.super.onClickOption(self, optionItem)
end

function V3A2NecrologistStoryOptionsItem:onShowOrCloseFinish()
	TaskDispatcher.cancelTask(self.frameUpdateHight, self)
end

function V3A2NecrologistStoryOptionsItem:frameUpdateHight()
	ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)
	self:refreshHeight()
end

function V3A2NecrologistStoryOptionsItem:onDestroy()
	TaskDispatcher.cancelTask(self.frameUpdateHight, self)
	V3A2NecrologistStoryOptionsItem.super.onDestroy(self)
end

return V3A2NecrologistStoryOptionsItem
