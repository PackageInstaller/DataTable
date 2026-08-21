-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerBusinessCardView.lua

module("logic.extensions.playerinfo.view.info.PlayerBusinessCardView", package.seeall)

local M = class("PlayerBusinessCardView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._allPortraitList = false
	self._allCardList = false
	self._allFrameList = false
	self._curTabType = CommEnum.DisplayCardEnum.Mask
end

function M:buildUI()
	self._imgIconMask = self:getImage("1&business_card_item_851898229")
	self._imgIconCard = self:getImage("1&business_card_item_2047919685")
	self._imgIconFrame = self:getImage("1&business_card_item_1745534157")
	self._txtPlayerName = self:getText("1&business_card_item_819305407")
	self._txtSelectName = self:getText("1&business_card_item_-1271797095")
	self._txtTypeName = self:getText("1&business_card_item_89744765")
	self._txtDesc = self:getText("1&business_card_item_-376447416")
	self._btnGetWay = self:getBtnByPath("player_info_business_card/get_path_item")
	self._txtGetWay = self:getTextByPath("player_info_business_card/get_path_item/txtName")
	self._imgIconMaskRight = self:getImage("business_card_edit_view_-1134161084")
	self._imgIconCardRight = self:getImage("business_card_edit_view_2086733070")
	self._txtPlayerNameRight = self:getText("business_card_edit_view_-510375695")
	self._txtSelectNameRight = self:getText("business_card_edit_view_1562141136")
	self._tabContentGo = self:getGo("business_card_edit_view_-122661094")
	self._toggles = {}

	for i = 1, self._tabContentGo.transform.childCount - 1 do
		local toggleGo = self._tabContentGo.transform:GetChild(i).gameObject
		local toggleComp = toggleGo:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._toggles, toggleComp)
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_toggleClick(i, isOn)
			end
		end, nil)
	end

	self._scrollMaskGo = self:getGo("business_card_edit_view_1202640721")
	self._loopGridMask = LoopGridViewHelper.New(self._scrollMaskGo)

	self._loopGridMask:InitGridView(0, self._onCellUpdateMask, self)

	self._scrollCardGo = self:getGo("business_card_edit_view_1119070938")
	self._loopGridCard = LoopGridViewHelper.New(self._scrollCardGo)

	self._loopGridCard:InitGridView(0, self._onCellUpdateCard, self)

	self._scrollFrameGo = self:getGo("business_card_edit_view_444346741")
	self._loopGridFrame = LoopGridViewHelper.New(self._scrollFrameGo)

	self._loopGridFrame:InitGridView(0, self._onCellUpdateFrame, self)

	self._scrollPanelList = {
		self._scrollMaskGo,
		self._scrollCardGo,
		self._scrollFrameGo
	}
	self._btnSave = self:getBtn("55&btn_middle_-31477526")
	self._usingGo = self:getGo("business_card_edit_view_-1759850555")
	self._lockGo = self:getGo("business_card_edit_view_-1771469518")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnGetWay:AddClickListener(self._onClickGetWay, self)
	GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_PORTRAIT_SUC, self._onChangeSuc, self)
	GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_DISPLAYCARD_SUC, self._onChangeSuc, self)
end

function M:unbindEvents()
	self._btnSave:RemoveClickListener()
	self._btnGetWay:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_PORTRAIT_SUC, self._onChangeSuc, self)
	GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_DISPLAYCARD_SUC, self._onChangeSuc, self)
end

function M:onEnter()
	self._curTabType = CommEnum.DisplayCardEnum.Mask

	self:_setMaskData()
	self:_setCardData()
	self:_setFrameData()

	self._toggles[1].IsOn = false
	self._toggles[1].IsOn = true
end

function M:onExit()
	self._allPortraitList = false
	self._allCardList = false
	self._allFrameList = false
end

function M:_toggleClick(index, isOn)
	self._curTabType = index

	for i, v in ipairs(self._scrollPanelList) do
		goutil.setActive(v, i == index)
	end

	if index == CommEnum.DisplayCardEnum.Mask then
		self:_loadRightData(self._curSelectPortraitId, CommEnum.DisplayCardEnum.Mask)
	elseif index == CommEnum.DisplayCardEnum.Card then
		self:_loadRightData(self._curSelectCardId, CommEnum.DisplayCardEnum.Card)
	else
		self:_loadRightData(self._curSelectFrameId, CommEnum.DisplayCardEnum.Frame)
	end
end

function M:_initPortraitData()
	local allPortraitMap = BackpackConfig.instance:getItemsInfoByTS(GameEnum.ItemTypeEnum.Portrait, 1)

	for _, v in pairs(allPortraitMap) do
		table.insert(self._allPortraitList, {
			isUnlock = false,
			id = v.id,
			cfgdata = v
		})
	end

	local _curPortraitList = ItemModel.instance:getItemsByTS(GameEnum.ItemTypeEnum.Portrait, 1)

	if _curPortraitList then
		for i = 1, #_curPortraitList do
			for j = 1, #self._allPortraitList do
				if _curPortraitList[i]:getItemId() == self._allPortraitList[j].id then
					self._allPortraitList[j].isUnlock = true
				end
			end
		end
	end

	table.sort(self._allPortraitList, PlayerViewsUtil.sort)
end

function M:_setMaskData()
	self._playerInfo = PlayerModel.instance:getPlayerCardInfo()
	self._allPortraitList = {}
	self._curUsingMaskId = self._playerInfo.portrait
	self._curSelectPortraitId = self._playerInfo.portrait

	self:_initPortraitData()
	self:_loadRightData(self._curSelectPortraitId, CommEnum.DisplayCardEnum.Mask)
	self._loopGridMask:SetListItemCount(#self._allPortraitList, true)
	self._loopGridMask:RefreshAllShownItem()
end

function M:_onCellUpdateMask(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopGridMask:NewListViewItem("business_card_select_item")

	if self._allPortraitList then
		local itemData = self._allPortraitList[curIndex]

		if itemData then
			local shower = Astral.LuaComponentContainer.Add(item.gameObject, PlayerBusinessCardItem)
			local isLock = not self._allPortraitList[curIndex].isUnlock

			shower:setCellData(itemData, IconType.PlayerInfoMask, curIndex, self._curSelectPortraitId, isLock, IconType.PlayerInfoMask)
			shower:setClick(self._clickHeadIcon, self)
			shower:setUsing(self._curUsingMaskId == itemData.id)
		end
	end

	return item
end

function M:_clickHeadIcon(Id, index)
	self._index = index

	if self._curSelectPortraitId == Id or self._curSelectCardId == Id or self._curSelectFrameId == Id then
		return
	end

	self:_loadRightData(Id, self._curTabType)

	if self._curTabType == CommEnum.DisplayCardEnum.Mask then
		self._curSelectPortraitId = Id

		self._loopGridMask:RefreshAllShownItem()
	elseif self._curTabType == CommEnum.DisplayCardEnum.Card then
		self._curSelectCardId = Id

		self._loopGridCard:RefreshAllShownItem()
	else
		self._curSelectFrameId = Id

		self._loopGridFrame:RefreshAllShownItem()
	end

	self:_setStates()

	local co = BackpackConfig.instance:getItemInfoByItemId(Id)
	local moList = ItemModel.instance:getItemsByItemId(Id)

	if co and #moList > 0 and moList[1]:getRedPoint() == CommEnum.ItemRedPoint.New then
		BackpackAgent.instance:sendremoveRedPointRequest(co.type, {
			Id
		})
	end
end

function M:_initCardFrameData(subType)
	local allCfgMap = BackpackConfig.instance:getItemsInfoByTS(GameEnum.ItemTypeEnum.DisplayCard, subType)

	for _, v in pairs(allCfgMap) do
		if subType == 1 then
			table.insert(self._allCardList, {
				isUnlock = false,
				id = v.id,
				cfgdata = v
			})
		else
			table.insert(self._allFrameList, {
				isUnlock = false,
				id = v.id,
				cfgdata = v
			})
		end
	end

	local allDataList

	if subType == 1 then
		allDataList = self._allCardList
	else
		allDataList = self._allFrameList
	end

	local _curdataList = ItemModel.instance:getItemsByTS(GameEnum.ItemTypeEnum.DisplayCard, subType)

	if _curdataList then
		for i = 1, #_curdataList do
			for j = 1, #allDataList do
				if _curdataList[i]:getItemId() == allDataList[j].id then
					allDataList[j].isUnlock = true
				end
			end
		end
	end

	table.sort(allDataList, PlayerViewsUtil.sort)

	if subType == 1 then
		allDataList = self._allCardList
	else
		allDataList = self._allFrameList
	end
end

function M:_getCardOrFrameId(subType)
	self._playerInfo = PlayerModel.instance:getPlayerCardInfo()

	local allDataList

	if subType == 1 then
		allDataList = self._allCardList
	else
		allDataList = self._allFrameList
	end

	for i, v in ipairs(self._playerInfo.displayCard) do
		for m, n in ipairs(allDataList) do
			if v == n.id then
				return v
			end
		end
	end

	printWarn("=====no card or frame======", subType)

	return 0
end

function M:_setCardData()
	self._allCardList = {}

	self:_initCardFrameData(1)

	self._curUsingCardId = self:_getCardOrFrameId(1)
	self._curSelectCardId = self:_getCardOrFrameId(1)

	self:_loadRightData(self._curSelectCardId, CommEnum.DisplayCardEnum.Card)
	self._loopGridCard:SetListItemCount(#self._allCardList, true)
	self._loopGridCard:RefreshAllShownItem()
end

function M:_onCellUpdateCard(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopGridCard:NewListViewItem("business_card_select_item")
	local itemData = self._allCardList[curIndex]

	if itemData then
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, PlayerBusinessCardItem)
		local isLock = not self._allCardList[curIndex].isUnlock

		shower:setCellData(itemData, IconType.ItemIcon, curIndex, self._curSelectCardId, isLock, IconType.PlayerInfoCard)
		shower:setClick(self._clickHeadIcon, self)
		shower:setUsing(self._curUsingCardId == itemData.id)
	end

	return item
end

function M:_setFrameData()
	self._allFrameList = {}

	self:_initCardFrameData(2)

	self._curUsingFrameId = self:_getCardOrFrameId(2)
	self._curSelectFrameId = self:_getCardOrFrameId(2)

	self:_loadRightData(self._curSelectFrameId, CommEnum.DisplayCardEnum.Frame)
	self._loopGridFrame:SetListItemCount(#self._allFrameList, true)
	self._loopGridFrame:RefreshAllShownItem()
end

function M:_onCellUpdateFrame(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopGridFrame:NewListViewItem("business_card_select_item")
	local itemData = self._allFrameList[curIndex]

	if itemData then
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, PlayerBusinessCardItem)
		local isLock = not self._allFrameList[curIndex].isUnlock

		shower:setCellData(itemData, IconType.ItemIcon, curIndex, self._curSelectFrameId, isLock, IconType.PlayerInfoFrame)
		shower:setClick(self._clickHeadIcon, self)
		shower:setUsing(self._curUsingFrameId == itemData.id)
	end

	return item
end

function M:_setStates()
	if self._curTabType == CommEnum.DisplayCardEnum.Mask then
		self:_setBottomState(self._curSelectPortraitId, self._curUsingMaskId, self._allPortraitList)
	elseif self._curTabType == CommEnum.DisplayCardEnum.Card then
		self:_setBottomState(self._curSelectCardId, self._curUsingCardId, self._allCardList)
	else
		self:_setBottomState(self._curSelectFrameId, self._curUsingFrameId, self._allFrameList)
	end
end

function M:_setBottomState(selectId, usingId, allList)
	local curIndex = 1

	for i, v in ipairs(allList) do
		if selectId == v.id then
			curIndex = i

			break
		end
	end

	local itemData = allList[curIndex]
	local isUsing = usingId == itemData.id

	goutil.setActive(self._btnSave.gameObject, itemData.isUnlock and not isUsing)
	goutil.setActive(self._usingGo, itemData.isUnlock and isUsing)
	goutil.setActive(self._lockGo, not itemData.isUnlock)
end

function M:_loadRightData(Id, tabType)
	self._txtPlayerName.text = PlayerModel.instance:getNickName()
	self._txtPlayerNameRight.text = PlayerModel.instance:getNickName()

	local co

	if tabType == CommEnum.DisplayCardEnum.Mask then
		self._txtTypeName.text = lang("tip_player_display_static_mask")
		co = BackpackConfig.instance:getItemInfoByItemId(Id)

		if co then
			IconLoader.setSprite(self._imgIconMask, IconType.PlayerInfoMask, co.icon)
			IconLoader.setSprite(self._imgIconMaskRight, IconType.PlayerInfoMask, co.icon)
		end
	elseif tabType == CommEnum.DisplayCardEnum.Card then
		self._txtTypeName.text = lang("tip_player_display_static_card")
		co = BackpackConfig.instance:getItemInfoByItemId(Id)

		if co then
			IconLoader.setSprite(self._imgIconCard, IconType.PlayerInfoCard, co.icon2)
			IconLoader.setSprite(self._imgIconCardRight, IconType.PlayerInfoCard, co.icon3)
		end
	else
		self._txtTypeName.text = lang("tip_player_display_static_frame")
		co = BackpackConfig.instance:getItemInfoByItemId(Id)

		if co then
			IconLoader.setSprite(self._imgIconFrame, IconType.PlayerInfoFrame, co.icon2)
		end
	end

	if co then
		self._txtSelectName.text = co.name
		self._txtSelectNameRight.text = co.name
		self._txtDesc.text = co.desc
		self._txtGetWay.text = co.unlockdesc
	end

	self:_setStates()
end

function M:_onClickSave()
	if self._curTabType == CommEnum.DisplayCardEnum.Mask then
		if self._allPortraitList[self._index].isUnlock and self._curSelectPortraitId ~= self._curUsingMaskId then
			PlayerAgent.instance:sendChangePortraitRequest(self._curSelectPortraitId)
		end
	elseif self._curTabType == CommEnum.DisplayCardEnum.Card then
		if self._allCardList[self._index].isUnlock and self._curSelectCardId ~= self._curUsingCardId then
			PlayerAgent.instance:sendChangeDisplayCardRequest(self._curSelectCardId)
		end
	elseif self._allFrameList[self._index].isUnlock and self._curSelectFrameId ~= self._curUsingFrameId then
		PlayerAgent.instance:sendChangeDisplayCardRequest(self._curSelectFrameId)
	end
end

function M:_onClickGetWay()
	if self._curTabType == CommEnum.DisplayCardEnum.Mask then
		local portraitCO = BackpackConfig.instance:getItemInfoByItemId(self._curSelectPortraitId)

		if portraitCO then
			local jumpId = portraitCO.getWays

			printWarn("===mask===jumpId=====", jumpId)
			GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, tonumber(jumpId))
		end
	elseif self._curTabType == CommEnum.DisplayCardEnum.Card then
		local cardCO = BackpackConfig.instance:getItemInfoByItemId(self._curSelectCardId)

		if cardCO then
			local jumpId = cardCO.getWays

			printWarn("===card===jumpId=====", jumpId)
			GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, tonumber(jumpId))
		end
	else
		local frameCO = BackpackConfig.instance:getItemInfoByItemId(self._curSelectFrameId)

		if frameCO then
			local jumpId = frameCO.getWays

			printWarn("===frame===jumpId=====", jumpId)
			GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, tonumber(jumpId))
		end
	end
end

function M:_onChangeSuc(key, Id)
	if self._curTabType == CommEnum.DisplayCardEnum.Mask then
		self._curUsingMaskId = Id
		self._allPortraitList = {}

		self:_initPortraitData()
		self:_setStates()
		self._loopGridMask:RefreshAllShownItem()
	elseif self._curTabType == CommEnum.DisplayCardEnum.Card then
		self._curUsingCardId = Id
		self._allCardList = {}

		self:_initCardFrameData(1)
		self:_setStates()
		self._loopGridCard:RefreshAllShownItem()
	else
		self._curUsingFrameId = Id
		self._allFrameList = {}

		self:_initCardFrameData(2)
		self:_setStates()
		self._loopGridFrame:RefreshAllShownItem()
	end
end

return M
