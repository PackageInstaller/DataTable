-- chunkname: @IQIGame\\UI\\HomeLandThemeUI.lua

local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local HomeRoomItem = {
	roomCid = 0
}

function HomeRoomItem.New(view)
	local obj = Clone(HomeRoomItem)

	obj:__Init(view)

	return obj
end

function HomeRoomItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function HomeRoomItem:Show(roomCid)
	self.gameObject:SetActive(true)

	self.roomCid = roomCid

	local roomCfg = CfgHomeRoomTable[self.roomCid]

	self.roomName:GetComponent("Text").text = roomCfg.Name
end

function HomeRoomItem:UpdateSelectState(isSelect)
	self.selectRoot.gameObject:SetActive(isSelect)
end

function HomeRoomItem:Hide()
	self.gameObject:SetActive(false)
end

function HomeRoomItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local RoomSkinItem = {
	skinCid = 0,
	roomCid = 0
}

function RoomSkinItem.New(view)
	local obj = Clone(RoomSkinItem)

	obj:__Init(view)

	return obj
end

function RoomSkinItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function RoomSkinItem:Show(roomCid, skinCid)
	self.gameObject:SetActive(true)

	self.skinCid = skinCid
	self.roomCid = roomCid

	local sceneCfg = CfgHomeSceneTable[self.skinCid]

	if not LuaUtility.StrIsNullOrEmpty(sceneCfg.PreviewImage) then
		AssetUtil.LoadImage(self, sceneCfg.PreviewImage, self.sceneIcon:GetComponent("Image"))
	end

	self.sceneName:GetComponent("Text").text = sceneCfg.Name
end

function RoomSkinItem:ChangeSelect()
	return
end

function RoomSkinItem:Hide()
	self.gameObject:SetActive(false)
end

function RoomSkinItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local BannerToggleItem = {}

function BannerToggleItem.New(view)
	local obj = Clone(BannerToggleItem)

	obj:__Init(view)

	return obj
end

function BannerToggleItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function BannerToggleItem:Show(isOn)
	self.gameObject:SetActive(true)
	self:SetIsOn(isOn)
end

function BannerToggleItem:SetIsOn(isOn)
	self.onRoot.gameObject:SetActive(isOn)
	self.offRoot.gameObject:SetActive(not isOn)
end

function BannerToggleItem:IsFree()
	return not self.gameObject.activeSelf
end

function BannerToggleItem:Hide()
	self.gameObject:SetActive(false)
end

function BannerToggleItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local HomeLandThemeUI = {
	selectSkinCid = 0,
	selectRoomCid = 0,
	roomAreaList = {},
	roomItemList = {},
	roomCidList = {},
	skinAreaList = {},
	skinItemList = {},
	roomSkinList = {}
}

HomeLandThemeUI = Base:Extend("HomeLandThemeUI", "IQIGame.Onigao.UI.HomeLandThemeUI", HomeLandThemeUI)

function HomeLandThemeUI:OnInit()
	self:__OnInitEventDelegateFunc()

	self.commonReturnBtn = CommonReturnBtn.New(self.commonReturnBtnRoot, self)

	self:__InitRoomList()
	self:__InitSkinList()
	self:__InitBannerToggle()
end

function HomeLandThemeUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandThemeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandThemeUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandThemeUI:GetBGM(userData)
	return nil
end

function HomeLandThemeUI:OnOpen(userData)
	self.selectRoomCid = 0
	self.roomCidList = {}

	ForPairs(CfgHomeRoomTable, function(_roomCid, _)
		self.roomSkinList[_roomCid] = {}

		if not HomeModule.IsRoomOpen(_roomCid) then
			return
		end

		table.insert(self.roomCidList, _roomCid)
	end)
	ForPairs(CfgHomeSceneTable, function(_sceneCid, _sceneCfg)
		if self.roomSkinList[_sceneCfg.RoomId] == nil then
			self.roomSkinList[_sceneCfg.RoomId] = {}

			logError("CfgHomeSceneTable 场景皮肤 {0} 出现错误的房间ID： {0}", _sceneCid, _sceneCfg.RoomId)
		end

		table.insert(self.roomSkinList[_sceneCfg.RoomId], _sceneCid)
	end)
	self:__RefreshRoomListShow()
end

function HomeLandThemeUI:OnClose(userData)
	return
end

function HomeLandThemeUI:__OnInitEventDelegateFunc()
	function self.__delegateOnChangeSkin()
		self.__OnChangeSkin()
	end

	function self.__delegateOnPreviousPage()
		self.skinAreaList:TurnToBackward()
	end

	function self.__delegateOnNextPage()
		self.skinAreaList:TurnToForward()
	end
end

function HomeLandThemeUI:OnAddListeners()
	self.useButton:GetComponent("Button").onClick:AddListener(self.__delegateOnChangeSkin)
	self.leftBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnPreviousPage)
	self.rightBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnNextPage)
end

function HomeLandThemeUI:OnRemoveListeners()
	self.useButton:GetComponent("Button").onClick:RemoveListener(self.__delegateOnChangeSkin)
	self.leftBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnPreviousPage)
	self.rightBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnNextPage)
end

function HomeLandThemeUI:OnPause()
	return
end

function HomeLandThemeUI:OnResume()
	return
end

function HomeLandThemeUI:OnCover()
	return
end

function HomeLandThemeUI:OnReveal()
	return
end

function HomeLandThemeUI:OnRefocus(userData)
	return
end

function HomeLandThemeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandThemeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandThemeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandThemeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandThemeUI:OnDestroy()
	self.skinItemList = nil
	self.skinAreaList.onRenderCell = nil
	self.skinAreaList.onPageReachedMainPos = nil
	self.skinAreaList = nil

	self.commonReturnBtn:Dispose()
end

function HomeLandThemeUI:__InitRoomList()
	self.roomAreaList = self.roomScrollView:GetComponent("ScrollAreaList")

	function self.roomAreaList.onRenderCell(cell)
		self:__OnRenderRoomListItem(cell)
	end

	function self.roomAreaList.onSelectedCell(cell)
		self:__OnRoomListItemSelect(cell)
	end
end

function HomeLandThemeUI:__RefreshRoomListShow()
	self.roomAreaList:Refresh(#self.roomCidList)
end

function HomeLandThemeUI:__OnRenderRoomListItem(itemCell)
	local insID = itemCell.gameObject:GetInstanceID()
	local roomItem = self.roomItemList[insID]

	if roomItem == nil then
		roomItem = HomeRoomItem.New(itemCell.gameObject)
		self.roomItemList[insID] = roomItem
	end

	local roomCid = self.roomCidList[itemCell.index + 1]

	if self.selectRoomCid == 0 then
		self.selectRoomCid = roomCid
	end

	roomItem:Show(roomCid)

	local isSelect = self.selectRoomCid == roomCid

	roomItem:UpdateSelectState(isSelect)

	if isSelect then
		self:__RefreshSelectRoomShow()
	end
end

function HomeLandThemeUI:__OnRoomListItemSelect(itemCell)
	local insID = itemCell.gameObject:GetInstanceID()
	local roomItem = self.roomItemList[insID]

	if roomItem == nil then
		return
	end

	self.selectRoomCid = roomItem.roomCid

	ForPairs(self.roomItemList, function(_insID, _item)
		_item:UpdateSelectState(_item.roomCid == self.selectRoomCid)
	end)
	self:__RefreshSelectRoomShow()
end

function HomeLandThemeUI:__InitSkinList()
	self.skinAreaList = self.rightScrollView:GetComponent("ScrollAreaListPage")

	function self.skinAreaList.onRenderCell(cell)
		self:__OnRenderSkinListItem(cell)
	end

	function self.skinAreaList.onPageReachedMainPos(page)
		self:__OnPageReachedMainPos(page)
	end
end

function HomeLandThemeUI:__OnRenderSkinListItem(page)
	local insID = page.gameObject:GetInstanceID()
	local skinItem = self.skinItemList[insID]

	if skinItem == nil then
		skinItem = RoomSkinItem.New(page.gameObject)
		self.skinItemList[insID] = skinItem
	end

	local skinCid = self.roomSkinList[self.selectRoomCid][page.index + 1]

	skinItem:Show(self.selectRoomCid, skinCid)
end

function HomeLandThemeUI:__OnPageReachedMainPos(page)
	self:__ChangeBannerToggleSelect(page.index + 1)
end

function HomeLandThemeUI:__RefreshSelectRoomShow()
	local skinCidList = self.roomSkinList[self.selectRoomCid]
	local totalCount = #skinCidList

	self:__RefreshBannerToggleShow(totalCount)

	self.skinAreaList.startIndex = 0

	self.skinAreaList:Refresh(totalCount)
end

function HomeLandThemeUI:__InitBannerToggle()
	self.togglePrefab.gameObject:SetActive(false)

	self.bannerToggleItemPool = UIViewObjectPool.New(self.togglePrefab, nil, function(_view)
		return BannerToggleItem.New(_view)
	end)
end

function HomeLandThemeUI:__RefreshBannerToggleShow(totalCount)
	self.bannerToggleItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, totalCount do
		local item = self.bannerToggleItemPool:GetFree(function(_item)
			return _item:IsFree()
		end)

		item:Show(false)
	end
end

function HomeLandThemeUI:__ChangeBannerToggleSelect(selectIndex)
	local index = 1

	self.bannerToggleItemPool:ForItems(function(_item)
		local isOn = selectIndex == index

		_item:SetIsOn(isOn)

		index = index + 1
	end)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bannerToggleRoot:GetComponent("RectTransform"))

	self.selectSkinCid = self.roomSkinList[self.selectRoomCid][selectIndex]

	local roomInfo = HomeModule.GetRoomData(self.selectRoomCid)
	local isUsing = self.selectSkinCid == roomInfo.homeRoomSkin.skinCid

	self.useButton.gameObject:SetActive(not isUsing)
	self.usingTag.gameObject:SetActive(isUsing)

	local totalCount = #self.roomSkinList[self.selectRoomCid]

	if selectIndex == 1 then
		self.leftBtn.gameObject:SetActive(false)

		if selectIndex == totalCount then
			self.rightBtn.gameObject:SetActive(false)
		else
			self.rightBtn.gameObject:SetActive(true)
		end
	elseif selectIndex == totalCount then
		self.rightBtn.gameObject:SetActive(false)

		if totalCount > 1 then
			self.leftBtn.gameObject:SetActive(true)
		else
			self.leftBtn.gameObject:SetActive(false)
		end
	else
		self.leftBtn.gameObject:SetActive(true)
		self.rightBtn.gameObject:SetActive(true)
	end
end

function HomeLandThemeUI:__OnChangeSkin()
	HomeModule.ChangeRoomSkin(self.selectRoomCid, self.selectSkinCid)
end

return HomeLandThemeUI
