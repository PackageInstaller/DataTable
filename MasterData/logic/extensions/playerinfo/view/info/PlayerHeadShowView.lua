-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerHeadShowView.lua

module("logic.extensions.playerinfo.view.info.PlayerHeadShowView", package.seeall)

local M = class("PlayerHeadShowView", DynamicFragmentView)

function M:buildUI()
	self._headScroll = LoopGridViewHelper.New(self:getGo("player_head_show_panel_215445046"))

	self._headScroll:InitGridView(0, self._updateHeadData, self)

	self._imgHeadIcon = self:getImage("1&0&head_item_1770823988")
	self._txtName = self:getText("1&player_info_preview_tips_1879998473")
	self._txtDesc = self:getText("1&player_info_preview_tips_1818738736")
	self._txtUnlockDesc = self:getText("1&player_info_preview_tips_1221177753")
	self._txtHeadIconName = self:getText("1&player_info_preview_tips_181164354")
	self._lockObj = self:getGo("1&0&head_item_-765526646")
	self._imgCard = self:getImage("1&player_info_preview_tips_1101775695")
	self._guiAnimation = goutil.addComponentOnce(self._registry:getMainGO(), typeof(Astral.GUITimelineAniLua))

	goutil.setActive(self._lockObj, false)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:destroyUI()
	self._headScroll:Dispose()

	self._headScroll = nil
	self._imgHeadIcon = nil
	self._txtName = nil
	self._txtDesc = nil
	self._txtUnlockDesc = nil
	self._txtHeadIconName = nil
	self._imgCard = nil
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_PORTRAIT_SUC, self._onChangePortraitSuc, self)
	GlobalDispatcher:addEventListener(EventType.UPDATE_ROLE_NAME_SUC, self._updateName, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_PORTRAIT_SUC, self._onChangePortraitSuc, self)
	GlobalDispatcher:removeEventListener(EventType.UPDATE_ROLE_NAME_SUC, self._updateName, self)
end

function M:_updateName()
	local playerInfo = PlayerModel.instance:getPlayerCardInfo()

	self._txtName.text = PlayerModel.instance:getNickName()
	self._playerInfo = playerInfo
end

function M:playDynamicPageTimeLineAni(animName)
	if self.mainGO.activeSelf and self._guiAnimation then
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName(animName)
	end

	GlobalDispatcher:dispatchEvent(EventType.PLAYER_MAINVIEW_ANI, "close-head")
end

function M:onEnter()
	local playerInfo = PlayerModel.instance:getPlayerCardInfo()

	self._txtName.text = PlayerModel.instance:getNickName()
	self._playerInfo = playerInfo
	self._allPortraitList = {}
	self._curSelectPortraitId = playerInfo.portrait
	self._portraitId = ConstConfig.instance:getNumValuesByKey("DefaultPortrait")
	self._itemCO = BackpackConfig.instance:getItemInfoByItemId(playerInfo.displayCard)

	if self._itemCO then
		IconLoader.setSprite(self._imgCard, IconType.PlayerCardMedium, self._itemCO.icon)
	end

	self:_initPortraitData()
	self:_loadRightData(self._curSelectPortraitId)
	self._headScroll:SetListItemCount(#self._allPortraitList - 1, true)
end

function M:onExit()
	GlobalDispatcher:dispatchEvent(EventType.PLAYER_MAINVIEW_ANI, "head-open")
	self._headScroll:ClearCells()
	table.clear(self._allPortraitList)
end

function M:_initPortraitData()
	local allPortraitMap = BackpackConfig.instance:getItemsInfoByTS(GameEnum.ItemTypeEnum.Portrait, 1)

	for _, v in pairs(allPortraitMap) do
		if v.id == self:_getPortraitByImage(CommEnum.ImageEnum.Girl) then
			self._tempPortrait = {
				isUnlock = true,
				id = v.id,
				cfgdata = v
			}
		else
			table.insert(self._allPortraitList, {
				isUnlock = false,
				id = v.id,
				cfgdata = v
			})
		end
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
		IconLoader.setSprite(self._imgHeadIcon, IconType.HeadIcon, portraitCO.icon)
		IconLoader.setSprite(self._imgCard, IconType.PlayerCardMedium, self._itemCO.icon)

		self._txtDesc.text = portraitCO.desc
		self._txtUnlockDesc.text = portraitCO.unlockdesc

		local isUsing = self._playerInfo.portrait == portrait
		local isLock = false

		for i = 1, #self._allPortraitList do
			if self._allPortraitList[i].id == portrait then
				isLock = not self._allPortraitList[i].isUnlock

				break
			end
		end

		self._txtHeadIconName.text = portraitCO.name
	end

	table.sort(self._allPortraitList, PlayerViewsUtil.sort)
end

function M:_getPortraitByImage(image)
	local res = image == CommEnum.ImageEnum.Boy and 2 or 1

	return self._portraitId[res]
end

function M:_updateHeadData(curIndex)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._headScroll:NewListViewItem("head_item")

	if self._allPortraitList then
		local itemData = self._allPortraitList[curIndex]

		if itemData then
			if itemData.id == self:_getPortraitByImage(CommEnum.ImageEnum.Boy) and self._playerInfo.image == CommEnum.ImageEnum.Girl then
				itemData = self._tempPortrait
			end

			local shower = Astral.LuaComponentContainer.Add(item.gameObject, PlayerPortraitItem)

			shower:setCellData(itemData, curIndex, self._playerInfo.portrait, self._curSelectPortraitId)
			shower:setClick(self._clickHeadIcon, self)
		end
	end

	return item
end

function M:_onClickUse()
	if self._curSelectPortraitId ~= self._playerInfo.portrait then
		PlayerAgent.instance:sendChangePortraitRequest(self._curSelectPortraitId)
	end
end

function M:_clickHeadIcon(portraitId)
	if self._curSelectPortraitId == portraitId then
		return
	end

	self._curSelectPortraitId = portraitId

	self:_loadRightData(self._curSelectPortraitId)
	self._headScroll:RefreshAllShownItem()
	self:_onClickUse()
end

function M:_onChangePortraitSuc(key, portrait)
	self._playerInfo.portrait = portrait

	self:_loadRightData(portrait)

	if self._headScroll then
		self._headScroll:RefreshAllShownItem()
	end
end

return M
