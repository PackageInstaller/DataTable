-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryOptionsItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryOptionsItem", package.seeall)

local NecrologistStoryOptionsItem = class("NecrologistStoryOptionsItem", NecrologistStoryBaseItem)

function NecrologistStoryOptionsItem:onInit()
	self.goContent = gohelper.findChild(self.viewGO, "content")
	self.rectTrContent = self.goContent.transform
	self.goOption = gohelper.findChild(self.viewGO, "content/optionItem")

	gohelper.setActive(self.goOption, false)

	self.itemList = {}
end

function NecrologistStoryOptionsItem:onClickOption(item)
	if self:isDone() then
		return
	end

	self.selectSection = item.section

	self:refreshOptionList()

	local storyConfig = self:getStoryConfig()
	local optionId, optionIds = NecrologistStoryConfig.instance:getOptionIdByConfigAndIndex(storyConfig, item.index)

	if optionId then
		local mo = NecrologistStoryModel.instance:getCurStoryMO()

		if mo then
			mo:onSelectOption(optionId, optionIds)
		end
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnSelectSection, self.selectSection)
end

function NecrologistStoryOptionsItem:onPlayStory()
	self.selectSection = nil

	self:refreshOptionList()
end

function NecrologistStoryOptionsItem:refreshOptionList()
	local storyConfig = self:getStoryConfig()
	local sections = GameUtil.splitString2(storyConfig.param, true, "#", ",")
	local options = string.split(NecrologistStoryHelper.getDescByConfig(storyConfig), "#")

	for i = 1, math.max(#sections, #self.itemList) do
		local item = self:getOptionItem(i)

		self:updateOptionItem(item, sections[i], options[i])
	end

	ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)
end

function NecrologistStoryOptionsItem:updateOptionItem(item, data, optionDesc)
	local section = data and data[1]

	item.section = section

	if not section then
		gohelper.setActive(item.go, false)

		return
	end

	item.buttonType = data[2]

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
	item.btn.button.interactable = not hasSelect

	gohelper.setActive(item.goRaycast, not hasSelect)
	gohelper.setActive(item.goLoop, not hasSelect and item.buttonType == 1)
end

function NecrologistStoryOptionsItem:getOptionItem(index)
	local item = self.itemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index

		local go = gohelper.cloneInPlace(self.goOption, tostring(index))

		item.go = go
		item.goRaycast = gohelper.findChild(go, "raycast")
		item.goCanClick = gohelper.findChild(go, "canclick")
		item.goUnSelect = gohelper.findChild(go, "unselect")
		item.goSelect = gohelper.findChild(go, "select")
		item.txtContent = gohelper.findChildTextMesh(go, "#txt_choice")
		item.goLoop = gohelper.findChild(go, "loop")
		item.btn = gohelper.findButtonWithAudio(go)

		item.btn:AddClickListener(self.onClickOption, self, item)

		self.itemList[index] = item
	end

	return item
end

function NecrologistStoryOptionsItem:caleHeight()
	return (recthelper.getHeight(self.rectTrContent))
end

function NecrologistStoryOptionsItem:isDone()
	return self.selectSection ~= nil
end

function NecrologistStoryOptionsItem:onDestroy()
	if self.itemList then
		for i, v in ipairs(self.itemList) do
			v.btn:RemoveClickListener()
		end
	end
end

function NecrologistStoryOptionsItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/necrologiststoryoptionsitem.prefab"
end

return NecrologistStoryOptionsItem
