-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryView_Item.lua

module("modules.logic.necrologiststory.view.NecrologistStoryView_Item", package.seeall)

local NecrologistStoryView_Item = class("NecrologistStoryView_Item", BaseView)

function NecrologistStoryView_Item:onInitView()
	self.storyItemList = {}
	self.itemCount = 0
end

function NecrologistStoryView_Item:onClose()
	self:clearStoryItem()
end

function NecrologistStoryView_Item:getStoryView()
	return self.viewContainer:getStoryView()
end

function NecrologistStoryView_Item:createStoryItemAsync(cls, storyConfig, isSkip, parentGO)
	local storyView = self:getStoryView()
	local resPath = cls.getResPath()

	isSkip = isSkip or false

	if string.nilorempty(resPath) then
		self:_createStoryItemGo(nil, nil, cls, storyConfig, isSkip, parentGO)

		return
	end

	local resPathList = {
		resPath
	}
	local otherResPathList = cls.getOtherResPath()

	if otherResPathList then
		tabletool.addValues(resPathList, otherResPathList)
	end

	if storyView.loaderComp then
		storyView._isLoadingAsync = true

		storyView.loaderComp:startLoad(resPathList, self.onStoryItemLoaded, self, cls, storyConfig, isSkip, parentGO)
	else
		self:createStoryItem(cls, storyConfig, isSkip)
	end
end

function NecrologistStoryView_Item:_createStoryItemGo(go, resList, cls, storyConfig, isSkip, parentGO)
	local storyView = self:getStoryView()
	local storyId = storyConfig.id
	local actualParentGO = parentGO or storyView.goContent

	go = go or gohelper.create2d(actualParentGO, tostring(storyId))

	local isContentItem = parentGO == nil
	local itemParam = {
		storyView = storyView,
		isContentItem = isContentItem,
		resList = resList
	}
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, cls, itemParam)

	self:addItem(item)

	if isContentItem then
		item:playStory(storyConfig, isSkip, storyView.onItemPlayFinish, storyView, storyView.refreshContentSize, storyView)
		storyView:tryAddLine()
	else
		item:playStory(storyConfig, isSkip, storyView.onItemPlayFinish, storyView)
	end

	local flag = storyView:_canContinueSkip()

	if flag then
		storyView:_continueSkip()
	end
end

function NecrologistStoryView_Item:onStoryItemLoaded(mainRes, resList, cls, storyConfig, isSkip, parentGO)
	local storyView = self:getStoryView()

	storyView._isLoadingAsync = false

	if not mainRes then
		self:_createStoryItemGo(nil, resList, cls, storyConfig, isSkip, parentGO)

		return
	end

	local go = gohelper.clone(mainRes, parentGO or storyView.goContent, tostring(storyConfig.id))

	self:_createStoryItemGo(go, resList, cls, storyConfig, isSkip, parentGO)
end

function NecrologistStoryView_Item:addItem(item)
	self.itemCount = self.itemCount + 1
	item.index = self.itemCount
	self.storyItemList[self.itemCount] = item
end

function NecrologistStoryView_Item:delItem(item)
	if not item then
		return
	end

	local index = item.index

	table.remove(self.storyItemList, index)

	self.itemCount = self.itemCount - 1

	for i, v in ipairs(self.storyItemList) do
		v.index = i
	end

	item:destory()

	local storyView = self:getStoryView()

	storyView:runNextStep()
end

function NecrologistStoryView_Item:getItemCount()
	return self.itemCount
end

function NecrologistStoryView_Item:getItemByIndex(index)
	return self.storyItemList[index]
end

function NecrologistStoryView_Item:getLastItem()
	return self.storyItemList[self.itemCount]
end

function NecrologistStoryView_Item:getLastContentItem()
	for i = self.itemCount, 1, -1 do
		local item = self.storyItemList[i]

		if item:getIsContentItem() then
			return item
		end
	end

	return nil
end

function NecrologistStoryView_Item:clearStoryItem()
	for _, item in ipairs(self.storyItemList) do
		item:destory()
	end

	self.storyItemList = {}
	self.itemCount = 0
end

function NecrologistStoryView_Item:onDestroyView()
	self:clearStoryItem()
end

return NecrologistStoryView_Item
