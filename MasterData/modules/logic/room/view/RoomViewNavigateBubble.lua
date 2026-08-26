-- chunkname: @modules/logic/room/view/RoomViewNavigateBubble.lua

module("modules.logic.room.view.RoomViewNavigateBubble", package.seeall)

local RoomViewNavigateBubble = class("RoomViewNavigateBubble", BaseView)

function RoomViewNavigateBubble:onInitView()
	self._gopanel = gohelper.findChild(self.viewGO, "go_normalroot/go_navigatebubble")
	self._gocontainer = gohelper.findChild(self.viewGO, "go_normalroot/go_navigatebubble/go_layout")
	self._gocategoryitem = gohelper.findChild(self.viewGO, "go_normalroot/go_navigatebubble/go_layout/roomnavigatebubbleitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewNavigateBubble:addEvents()
	return
end

function RoomViewNavigateBubble:removeEvents()
	return
end

function RoomViewNavigateBubble:_editableInitView()
	self._nodeUIs = {}
	self._processedNodes = {}
end

function RoomViewNavigateBubble:onDestroyView()
	for index, categoryItem in ipairs(self._nodeUIs) do
		categoryItem.btnself:RemoveClickListener()

		for _, bubbleItem in pairs(categoryItem.childrenNodes) do
			bubbleItem.btnself:RemoveClickListener()
		end
	end

	self._processedNodes = nil
end

function RoomViewNavigateBubble:onOpen()
	RoomNavigateBubbleController.instance:init()
	self.addEventCb(self, RoomNavigateBubbleController.instance, RoomEvent.NavigateBubbleUpdate, self.refreshUI, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, self.refreshUI, self)
	self:refreshUI()
end

function RoomViewNavigateBubble:onClose()
	self.removeEventCb(self, RoomNavigateBubbleController.instance, RoomEvent.NavigateBubbleUpdate, self.refreshUI, self)
	self.removeEventCb(self, RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, self.refreshUI, self)
	RoomNavigateBubbleController.instance:clear()
end

function RoomViewNavigateBubble:refreshUI()
	local isInDialogInteraction = RoomCharacterHelper.isInDialogInteraction()

	if isInDialogInteraction then
		gohelper.setActive(self._gopanel, false)

		return
	end

	local map = RoomNavigateBubbleModel.instance:getCategoryMap()

	if map and tabletool.len(map) > 0 then
		for index, categoryMO in pairs(map) do
			self:refreshCategoryItem(categoryMO, index)
		end

		gohelper.setActive(self._gopanel, true)
	else
		gohelper.setActive(self._gopanel, false)
	end

	self:hideNoProcessNodes()
end

function RoomViewNavigateBubble:refreshCategoryItem(categoryMO, index)
	local itemObj = self:getOrCreateCategoryItem(index)

	self._processedNodes[itemObj] = 1

	local expandStr = itemObj.expand and "1" or "0"

	UISpriteSetMgr.instance:setRoomSprite(itemObj.imagebg, string.format("xw_bubblebg_%s", expandStr))
	SLFramework.UGUI.GuiHelper.SetColor(itemObj.imageType, tonumber(expandStr) == 1 and "#ffffff" or "#262a27")
	SLFramework.UGUI.GuiHelper.SetColor(itemObj.txtcategory, tonumber(expandStr) == 1 and "#f8f8f8" or "#262a27")

	local totalBubblesCount = categoryMO:getBubblesCount()

	itemObj.txtcategory.text = tostring(totalBubblesCount)

	local bubbles = categoryMO:getBubbles()

	if tabletool.len(bubbles) > 0 and totalBubblesCount > 0 then
		for _, bubbleMO in ipairs(bubbles) do
			local bubbleType = bubbleMO:getShowType()
			local bubbleObj = self:getOrCreateBubbleItem(itemObj, bubbleType)
			local count = bubbleMO:getBubbleCount()

			if count > 0 then
				bubbleObj.txtbubble.text = tostring(count)

				gohelper.setActive(bubbleObj.go, itemObj.expand)

				self._processedNodes[bubbleObj] = 1

				gohelper.setActive(bubbleObj.gobubbleeffect, itemObj.expand and bubbleType == RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade)
			else
				gohelper.setActive(bubbleObj.go, false)
			end
		end

		gohelper.setActive(itemObj.go, true)
	else
		gohelper.setActive(itemObj.go, false)
	end
end

function RoomViewNavigateBubble.onClickCategory(args)
	local self = args.self
	local index = args.index
	local categoryObj = self:getOrCreateCategoryItem(index)
	local map = RoomNavigateBubbleModel.instance:getCategoryMap()

	if not map then
		return
	end

	local categoryMO = map[index]

	categoryObj.expand = not categoryObj.expand

	self:refreshCategoryItem(categoryMO, index)
	ZProj.UGUIHelper.RebuildLayout(self._gocontainer.transform)
end

function RoomViewNavigateBubble.onClickBubble(args)
	local self = args.self
	local bubbleType = args.bubbleType
	local categoryIndex = args.categoryIndex
	local categoryObj = self:getOrCreateCategoryItem(categoryIndex)
	local map = RoomNavigateBubbleModel.instance:getCategoryMap()

	if not map then
		return
	end

	self:getOrCreateBubbleItem(categoryObj, bubbleType)

	local categoryMO = map[categoryIndex]
	local bubbleMO = categoryMO:getBubbleByType(bubbleType)

	RoomNavigateBubbleController.instance:onClickCall(bubbleMO)
end

function RoomViewNavigateBubble:hideNoProcessNodes()
	for _, node in pairs(self._nodeUIs) do
		if not self._processedNodes[node] then
			gohelper.setActive(node.go, false)
		else
			for _, child in pairs(node.childrenNodes) do
				if not self._processedNodes[child] then
					gohelper.setActive(child.go, false)
				end
			end
		end
	end

	for k, _ in pairs(self._processedNodes) do
		self._processedNodes[k] = nil
	end
end

function RoomViewNavigateBubble:getOrCreateCategoryItem(index)
	local item = self._nodeUIs[index]

	if not item then
		item = self:getUserDataTb_()

		local path = self.viewContainer:getSetting().otherRes[5]
		local itemGo = self:getResInst(path, self._gocontainer, "category_item_" .. tostring(index))

		item.go = itemGo
		item.imagebg = gohelper.findChildImage(itemGo, "bubblecategory/image_bg")
		item.imageType = gohelper.findChildImage(itemGo, "bubblecategory/image_type")
		item.txtcategory = gohelper.findChildText(itemGo, "bubblecategory/txt_num")
		item.gobubbleitem = gohelper.findChild(itemGo, "childitemContent/roomnavigatebubblechilditem")
		item.btnself = gohelper.findChildButtonWithAudio(itemGo, "bubblecategory/btn_categoryclick")

		item.btnself:AddClickListener(self.onClickCategory, {
			self = self,
			index = index
		})
		gohelper.addUIClickAudio(item.btnself.gameObject, AudioEnum.UI.play_ui_callfor_open)

		item.index = index
		item.expand = true

		gohelper.setActive(item.go, false)

		item.childrenNodes = {}
		self._nodeUIs[index] = item
	end

	return item
end

function RoomViewNavigateBubble:getOrCreateBubbleItem(categoryItem, bubbleType)
	local item = categoryItem.childrenNodes[bubbleType]

	if not item then
		item = self:getUserDataTb_()

		local itemGo = gohelper.clone(categoryItem.gobubbleitem, categoryItem.go, "bubble_item_" .. tostring(bubbleType))

		item.go = itemGo
		item.imagebubblechild = gohelper.findChildImage(itemGo, "imagebubblechild")
		item.gobg = gohelper.findChild(itemGo, "txtbg")
		item.txtbubble = gohelper.findChildText(itemGo, "txtbg/txt_bubblechildnum")
		item.gobubbleeffect = gohelper.findChild(itemGo, "#xw_bubbleicon_up")
		item.btnself = gohelper.findChildButtonWithAudio(itemGo, "btn_bubbleclick")

		item.btnself:AddClickListener(self.onClickBubble, {
			self = self,
			bubbleType = bubbleType,
			categoryIndex = categoryItem.index
		})
		gohelper.setActive(item.go, true)

		categoryItem.childrenNodes[bubbleType] = item

		local showNum = not RoomNavigateBubbleEnum.BubbleHideNum[bubbleType]

		gohelper.setActive(item.gobg, showNum)

		local resPath = RoomNavigateBubbleEnum.Bubble2ResPath[bubbleType]

		if not string.nilorempty(resPath) then
			UISpriteSetMgr.instance:setRoomSprite(item.imagebubblechild, resPath, true)
		end

		self:_addUIClickAudio(item.btnself.gameObject, bubbleType)
	end

	return item
end

function RoomViewNavigateBubble:_addUIClickAudio(go, bubbleType)
	if bubbleType == RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade then
		gohelper.addUIClickAudio(go, AudioEnum.UI.play_ui_admission_open)
	elseif bubbleType == RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward then
		gohelper.addUIClickAudio(go, AudioEnum.Room.ui_home_board_upgrade)
	elseif bubbleType == RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull then
		gohelper.addUIClickAudio(go, AudioEnum.Room.ui_home_board_upgrade)
	end
end

return RoomViewNavigateBubble
