-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryBranchSectionItem.lua

module("modules.logic.necrologiststory.view.NecrologistStoryBranchSectionItem", package.seeall)

local NecrologistStoryBranchSectionItem = class("NecrologistStoryBranchSectionItem", ListScrollCellExtend)
local MAX_OPTION_COUNT = 3

function NecrologistStoryBranchSectionItem:onInitView()
	self.transform = self.viewGO.transform
	self.goTips = gohelper.findChild(self.viewGO, "Tips")
	self.goUnLight = gohelper.findChild(self.viewGO, "Tips/unLight")
	self.goLight = gohelper.findChild(self.viewGO, "Tips/Light")
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "Title/#txt_title")
	self.txtTitleEn = gohelper.findChildTextMesh(self.viewGO, "Title/#txt_title/#txt_en")
	self.txtIndex = gohelper.findChildTextMesh(self.viewGO, "Title/#txt_title/#txt_num")
	self.goOptionItem = gohelper.findChild(self.viewGO, "Option/go_optionitem")

	gohelper.setActive(self.goOptionItem, false)

	self.goBranchItem = gohelper.findChild(self.viewGO, "Branch/go_branchItem")

	gohelper.setActive(self.goBranchItem, false)

	self.branchItemList = {}
	self.goEnding = gohelper.findChild(self.viewGO, "Branch/ending")
	self.endingList = {}

	for i = 1, MAX_OPTION_COUNT do
		self.endingList[i] = gohelper.findChild(self.goEnding, tostring(i))
	end

	self.goItemPos = gohelper.findChild(self.viewGO, "itemPos")
	self.transformPos = self.goItemPos.transform
	self.goOptionLayout = gohelper.findChild(self.viewGO, "Option/OptionLayout")

	gohelper.setActive(self.goOptionLayout, false)

	self.optionLayoutItemList = {}
	self.goEmpty = gohelper.findChild(self.viewGO, "empty")
	self.goEmptyFinish = gohelper.findChild(self.viewGO, "empty/go_line")
	self.animEmpty = gohelper.findComponentAnim(self.goEmptyFinish)
end

function NecrologistStoryBranchSectionItem:addEventListeners()
	return
end

function NecrologistStoryBranchSectionItem:removeEventListeners()
	return
end

function NecrologistStoryBranchSectionItem:setIndex(index, dataCount)
	self.index = index
	self.txtIndex.text = string.format("%02d", index)
	self.tabItem.txtSelectIndex.text = tostring(index)
	self.tabItem.txtUnSelectIndex.text = tostring(index)
	self.isEnding = index == dataCount
end

function NecrologistStoryBranchSectionItem:setTabItem(tabItem)
	self.tabItem = tabItem
end

function NecrologistStoryBranchSectionItem:onUpdateMO(data)
	self.data = data

	self:refreshView()
end

function NecrologistStoryBranchSectionItem:addOptionDataList(branchDataList)
	local data = {}

	data.storygroup = self.plotId
	data.optionsList = {}

	if self.optionDataList and #self.optionDataList > 0 then
		tabletool.addValues(data.optionsList, self.optionDataList)
	else
		table.insert(data.optionsList, {})
	end

	table.insert(branchDataList, data)
end

function NecrologistStoryBranchSectionItem:refreshView()
	local data = self.data

	gohelper.setActive(self.viewGO, data ~= nil)
	gohelper.setActive(self.tabItem.go, data ~= nil)

	self.optionDataList = nil

	if not data then
		return
	end

	self.plotId = data.storygroup

	local config = NecrologistStoryConfig.instance:getPlotGroupCo(data.storygroup)

	self.plotGroupConfig = config
	self.storyId = config.storyId
	self.storyMo = NecrologistStoryModel.instance:getGameMO(self.storyId)
	self.plotInfo = self.storyMo:getPlotInfo(self.plotId, true)
	self.isStoryFinish = self.storyMo:isStoryFinish(self.plotId)

	self:refreshTitle()
	self:refreshTips()
	self:refreshOptions()
end

function NecrologistStoryBranchSectionItem:refreshTitle()
	local config = self.plotGroupConfig

	self.txtTitle.text = config.storyName
	self.txtTitleEn.text = config.storyNameEn
end

function NecrologistStoryBranchSectionItem:refreshTips()
	local isShowTips = next(self.data.affectsEndingOptionIndexs) ~= nil

	gohelper.setActive(self.goTips, isShowTips)

	if isShowTips then
		local isFinish = true

		for optionId, _ in pairs(self.data.affectsEndingOptionIndexs) do
			if not self.plotInfo:isOptionUnlocked(optionId) then
				isFinish = false

				break
			end
		end

		gohelper.setActive(self.goUnLight, not isFinish)
		gohelper.setActive(self.goLight, isFinish)
		gohelper.setActive(self.tabItem.goLight, isFinish)
		gohelper.setActive(self.tabItem.goUnLight, not isFinish)
	else
		gohelper.setActive(self.tabItem.goLight, false)
		gohelper.setActive(self.tabItem.goUnLight, false)
	end
end

function NecrologistStoryBranchSectionItem:refreshOptions()
	local list = self.data.optionList
	local dataList = {}

	for index, options in ipairs(list) do
		table.insert(dataList, options)
	end

	if next(self.data.endingList) then
		table.insert(dataList, self.data.endingList)
	end

	self.optionDataList = dataList

	local dataCount = #dataList

	for index, options in ipairs(dataList) do
		local optionLayout = self:getOrCreateOptionLayout(index)

		self:refreshOptionLayout(optionLayout, options)
	end

	local emptyVisible = false

	if dataCount == 0 then
		gohelper.setActive(self.goEmpty, true)

		emptyVisible = self.isStoryFinish
	else
		gohelper.setActive(self.goEmpty, false)
	end

	local lastEmptyVisible = self._emptyVisible

	self._emptyVisible = emptyVisible

	if not emptyVisible then
		self.animEmpty:Play("idle1")
	else
		self.animEmpty:Play(lastEmptyVisible == false and "move" or "idle2")
	end

	local width = self:getSectionItemWidth(dataCount)

	recthelper.setWidth(self.transform, width)
end

function NecrologistStoryBranchSectionItem:getOrCreateOptionLayout(index)
	local item = self.optionLayoutItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index
		item.go = gohelper.cloneInPlace(self.goOptionLayout, tostring(index))
		item.transform = item.go.transform
		item.optionItemList = {}

		local startPosX = 192
		local spaceX = 772
		local x = startPosX + (index - 1) * spaceX

		recthelper.setAnchorX(item.transform, x)

		self.optionLayoutItemList[index] = item
	end

	return item
end

function NecrologistStoryBranchSectionItem:refreshOptionLayout(optionLayout, options)
	optionLayout.options = options

	gohelper.setActive(optionLayout.go, options ~= nil)

	if not options then
		return
	end

	local optionStrList = {}

	for order, optionData in ipairs(options) do
		local item = self:getOrCreateOptionItem(order, optionLayout)

		self:refreshOptionItem(item, optionData)
		table.insert(optionStrList, NecrologistStoryHelper.getOptionDesc(optionData, true))
	end
end

function NecrologistStoryBranchSectionItem:getOrCreateOptionItem(index, parentItem)
	local item = parentItem.optionItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index
		item.go = gohelper.clone(self.goOptionItem, parentItem.go, tostring(index))
		item.transform = item.go.transform
		item.goUnlock = gohelper.findChild(item.go, "unlock")
		item.txtUnlockDesc = gohelper.findChildTextMesh(item.go, "unlock/#txt_option")
		item.imgUnlockBg = gohelper.findChildImage(item.go, "unlock/#image_bg")
		item.goLock = gohelper.findChild(item.go, "lock")
		item.txtLockDesc = gohelper.findChildTextMesh(item.go, "lock/#txt_option")
		item.imgLockBg = gohelper.findChildImage(item.go, "lock/#image_bg")
		item.btnClick = gohelper.findChildButtonWithAudio(item.go, "btn_click")

		item.btnClick:AddClickListener(self.onClickOptionItem, self, item)

		item.anim = gohelper.findComponentAnim(item.go)
		parentItem.optionItemList[index] = item
	end

	return item
end

function NecrologistStoryBranchSectionItem:refreshOptionItem(item, data)
	item.data = data

	gohelper.setActive(item.go, data ~= nil)

	if data == nil then
		return
	end

	local optionData = data
	local isEnding = optionData.isEnding
	local isFinish = false
	local icon = "rolestory_new3_btn_1"

	if isEnding then
		isFinish = self.plotInfo:isEndingUnlocked(optionData.id)
		icon = isFinish and "rolestory_new3_btn_3" or "rolestory_new3_btn_4"
	else
		isFinish = self.plotInfo:isOptionUnlocked(optionData.id)

		if self.data.affectsEndingOptionIndexs[optionData.id] then
			icon = "rolestory_new3_btn_2"
		end
	end

	local lastIsFinish = item.isFinish

	item.isFinish = isFinish or false

	if not isFinish then
		item.anim:Play("lock_idle")
	elseif lastIsFinish == false then
		item.anim:Play("unlock")
	else
		item.anim:Play("unlock_idle")
	end

	gohelper.setActive(item.goUnlock, isFinish)
	gohelper.setActive(item.goLock, not isFinish)

	if isFinish then
		UISpriteSetMgr.instance:setRoleStorySprite(item.imgUnlockBg, icon)

		item.txtUnlockDesc.text = NecrologistStoryHelper.getOptionDesc(optionData, isFinish)
	else
		UISpriteSetMgr.instance:setRoleStorySprite(item.imgLockBg, icon)

		item.txtLockDesc.text = NecrologistStoryHelper.getOptionDesc(optionData, isFinish)
	end
end

function NecrologistStoryBranchSectionItem:onClickOptionItem(item)
	NecrologistStoryController.instance:openStoryView(self.plotId)
end

function NecrologistStoryBranchSectionItem:refreshBranchs(dataList, startIndex)
	local optionDataCount = #self.optionDataList
	local dataCount = optionDataCount

	if dataCount == 0 and not self.isEnding then
		dataCount = 1
	end

	if dataCount > 0 then
		for i = 1, math.max(dataCount, #self.branchItemList) do
			local item = self:getBranchItem(i)

			self:refreshBranchItem(item, dataList[i + startIndex])
		end
	end

	if self.isEnding then
		local lastData = self.optionDataList[optionDataCount]

		if lastData then
			local connectOptionCount = Mathf.Clamp(#lastData or 0, 1, MAX_OPTION_COUNT)
			local finishCount = 0

			for _, optionData in ipairs(lastData) do
				local plotInfo = self.storyMo:getPlotInfo(optionData.config.storygroup, true)

				if optionData.isEnding and plotInfo:isEndingUnlocked(optionData.id) then
					finishCount = finishCount + 1
				end
			end

			local isAllFinish = connectOptionCount <= finishCount

			gohelper.setActive(self.goEnding, isAllFinish)

			if isAllFinish then
				for i, v in ipairs(self.endingList) do
					gohelper.setActive(v, i == connectOptionCount)
				end

				local x = self:getBranchPos(dataCount)

				recthelper.setAnchorX(self.goEnding.transform, x)
			end
		end
	else
		gohelper.setActive(self.goEnding, false)
	end

	return dataCount
end

function NecrologistStoryBranchSectionItem:getBranchItem(index)
	local item = self.branchItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index
		item.go = gohelper.cloneInPlace(self.goBranchItem, tostring(index))
		item.transform = item.go.transform
		item.childList = {}

		for i = 1, 2 do
			local go = gohelper.findChild(item.go, i == 1 and "left" or "right")
			local childItem = self:createChildBranchItem(go)

			table.insert(item.childList, childItem)
		end

		self.branchItemList[index] = item
	end

	return item
end

function NecrologistStoryBranchSectionItem:createChildBranchItem(go)
	local item = self:getUserDataTb_()

	item.go = go
	item.itemList = {}

	for i = 1, MAX_OPTION_COUNT do
		local lineItem = self:getUserDataTb_()

		lineItem.index = i
		lineItem.go = gohelper.findChild(item.go, tostring(i))
		lineItem.lineList = {}

		for j = 1, i do
			local go = gohelper.findChild(lineItem.go, string.format("go_line%d", j))

			if go then
				local lineGOItem = self:getUserDataTb_()

				lineGOItem.go = go
				lineGOItem.anim = gohelper.findComponentAnim(lineGOItem.go)
				lineItem.lineList[j] = lineGOItem
			end
		end

		table.insert(item.itemList, lineItem)
	end

	return item
end

function NecrologistStoryBranchSectionItem:refreshChildBranchItem(item, optionDatas)
	if optionDatas then
		if not #optionDatas then
			local optionCount = 0

			gohelper.setActive(item.go, optionCount > 0)

			if optionCount == 0 then
				return
			end

			for i, v in ipairs(item.itemList) do
				if i == optionCount then
					gohelper.setActive(v.go, true)

					for j, optionData in ipairs(optionDatas) do
						self:refreshLineGOItem(v.lineList[j], optionData)
					end
				else
					gohelper.setActive(v.go, false)
				end
			end
		end
	end
end

function NecrologistStoryBranchSectionItem:refreshLineGOItem(item, optionData)
	if not item then
		return
	end

	local isVisible = false

	if optionData then
		local isEnding = optionData.isEnding
		local config = optionData.config
		local plotInfo = self.storyMo:getPlotInfo(config.storygroup, true)

		isVisible = isEnding and (plotInfo:isEndingSelected(optionData.id) or false) or plotInfo:isOptionSelected(optionData.id) or false
	else
		isVisible = true
	end

	local lastVisible = item.isVisible

	item.isVisible = isVisible

	if not isVisible then
		item.anim:Play("idle1")
	else
		item.anim:Play(lastVisible == false and "move" or "idle2")
	end
end

function NecrologistStoryBranchSectionItem:refreshBranchItem(item, data)
	item.data = data

	local isEmpty = data == nil or #data == 0

	gohelper.setActive(item.go, not isEmpty)

	if isEmpty then
		return
	end

	for i, childItem in ipairs(item.childList) do
		self:refreshChildBranchItem(childItem, data[i])
	end

	local x = self:getBranchPos(item.index)

	recthelper.setAnchorX(item.transform, x)
end

function NecrologistStoryBranchSectionItem:getBranchPos(index)
	local startX = 352
	local spaceX = 711

	return startX + (index - 1) * spaceX
end

function NecrologistStoryBranchSectionItem:getSectionItemWidth(indexCount)
	local startX = 780
	local spaceX = 714
	local x = startX + (indexCount - 1) * spaceX

	if self.isEnding then
		x = x + 420
	end

	return math.max(x, startX)
end

function NecrologistStoryBranchSectionItem:getTransformPos()
	return recthelper.getAnchorX(self.transform)
end

function NecrologistStoryBranchSectionItem:onDestroy()
	for _, v in ipairs(self.optionLayoutItemList) do
		for _, item in ipairs(v.optionItemList) do
			item.btnClick:RemoveClickListener()
		end
	end
end

return NecrologistStoryBranchSectionItem
