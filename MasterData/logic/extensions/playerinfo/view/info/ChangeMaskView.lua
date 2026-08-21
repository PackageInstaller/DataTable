-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/ChangeMaskView.lua

module("logic.extensions.playerinfo.view.info.ChangeMaskView", package.seeall)

local M = class("ChangeMaskView", ViewComponent)

function M:buildUI()
	self._btnClose = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "universal_second_tips_common_bg/content/btnClose"))
	self._btnUse = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "content/btnUse"), CommButton)
	self._txtName = self:getText("player_change_mask_tips_1218403609")
	self._txtContent = self:getText("player_change_mask_tips_-58199919")
	self._imgIcon = self:getImage("player_change_mask_tips_-762506412")
	self._maskScroll = goutil.findChild(self.mainGO, "content/maskScroll")
	self._headScroll = LoopGridViewHelper.New(self._maskScroll)

	self._headScroll:InitGridView(0, self._updateHeadData, self)
end

function M:destroyUI()
	self._headScroll:Dispose()

	self._headScroll = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnUse:AddClickListener(self._onClickUse, self)
	GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_PORTRAIT_SUC, self._onChangePortraitSuc, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_PORTRAIT_SUC, self._onChangePortraitSuc, self)
	self._btnClose:RemoveClickListener()
	self._btnUse:RemoveClickListener()
end

function M:onEnter()
	self._playerInfo = PlayerModel.instance:getPlayerCardInfo()
	self._allPortraitList = {}
	self._curSelectPortraitId = self._playerInfo.portrait

	self:_initPortraitData()
	self:_loadRightData(self._curSelectPortraitId)
	self._headScroll:SetListItemCount(#self._allPortraitList, true)
	self._headScroll:RefreshAllShownItem()
end

function M:onEnterFinished()
	self._headScroll:RefreshAllShownItem()
end

function M:onExit()
	self._headScroll:ClearCells()
end

function M:_onClickClose()
	self:close()
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

function M:_loadRightData(portrait)
	local portraitCO = BackpackConfig.instance:getItemInfoByItemId(portrait)

	if portraitCO then
		IconLoader.setSprite(self._imgIcon, IconType.PlayerInfoMask, portraitCO.icon)

		self._txtContent.text = portraitCO.desc
		self._txtName.text = portraitCO.name

		local isLock = false

		for i = 1, #self._allPortraitList do
			if self._allPortraitList[i].id == portrait then
				isLock = not self._allPortraitList[i].isUnlock

				if isLock then
					self._btnUse:setText("未获得")

					self._txtContent.text = portraitCO.unlockdesc

					self._btnUse:setActiveState(false)

					break
				end

				self._btnUse:setText("使用")
				self._btnUse:setActiveState(true)

				break
			end
		end

		local isUsing = self._playerInfo.portrait == portrait

		if isUsing then
			self._btnUse:setText("使用中")
		end
	end

	table.sort(self._allPortraitList, PlayerViewsUtil.sort)
end

function M:_updateHeadData(curIndex)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._headScroll:NewListViewItem("player_mask_item")

	if self._allPortraitList then
		local itemData = self._allPortraitList[curIndex]

		if itemData then
			local shower = Astral.LuaComponentContainer.Add(item.gameObject, MaskItemCell)
			local isLock = not self._allPortraitList[curIndex].isUnlock

			shower:setCellData(itemData, curIndex, self._playerInfo.portrait, self._curSelectPortraitId, isLock)
			shower:setClick(self._clickHeadIcon, self)
			shower:setUsing(self._playerInfo.portrait == itemData.id)
		end
	end

	return item
end

function M:_onClickUse()
	if self._allPortraitList[self._index].isUnlock and self._curSelectPortraitId ~= self._playerInfo.portrait then
		PlayerAgent.instance:sendChangePortraitRequest(self._curSelectPortraitId)
	end
end

function M:_clickHeadIcon(portraitId, index)
	self._index = index

	if self._curSelectPortraitId == portraitId then
		return
	end

	self._curSelectPortraitId = portraitId

	self:_loadRightData(self._curSelectPortraitId)
	self._headScroll:RefreshAllShownItem()

	local portraitCO = BackpackConfig.instance:getItemInfoByItemId(portraitId)
	local portraitMoList = ItemModel.instance:getItemsByItemId(portraitId)

	if portraitCO and #portraitMoList > 0 and portraitMoList[1]:getRedPoint() == CommEnum.ItemRedPoint.New then
		BackpackAgent.instance:sendremoveRedPointRequest(portraitCO.type, {
			portraitId
		})
	end
end

function M:_onChangePortraitSuc(key, portrait)
	self._playerInfo.portrait = portrait

	self:_loadRightData(portrait)

	if self._headScroll then
		self._headScroll:RefreshAllShownItem()
	end
end

return M
