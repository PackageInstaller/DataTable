-- chunkname: @IQIGame\\UI\\MainPhoneUI\\MainPhoneUI_RightView_TopBanner.lua

local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local BannerItem = {
	skipCid = 0
}

function BannerItem.New(view)
	local obj = Clone(BannerItem)

	obj:__Init(view)

	return obj
end

function BannerItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnJumpBtnClick()
		self:__OnJumpBtnClick()
	end

	self.jumpBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnJumpBtnClick)
end

function BannerItem:Show(cfg)
	self.gameObject:SetActive(true)

	self.cfgCid = cfg.Id
	self.skipCid = cfg.Skip

	local path = UIGlobalApi.GetImagePath(cfg.Path)

	AssetUtil.LoadImage(self, path, self.Img:GetComponent("Image"))
end

function BannerItem:Hide()
	self.gameObject:SetActive(false)
end

function BannerItem:Dispose()
	self.jumpBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnJumpBtnClick)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function BannerItem:__OnJumpBtnClick()
	UIModule.Open(Constant.UIControllerName.NoticeBannerUI, Constant.UILayer.UI, {
		cid = self.cfgCid
	})
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

function BannerToggleItem:Show()
	self.gameObject:SetActive(true)
	self:SetIsOn(false)
end

function BannerToggleItem:SetIsOn(isOn)
	self.onGo.gameObject:SetActive(isOn)
end

function BannerToggleItem:Release()
	self.gameObject:SetActive(false)
end

function BannerToggleItem:IsFree()
	return not self.gameObject.activeSelf
end

function BannerToggleItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local BannerView = {}

function BannerView.New(view)
	local obj = Clone(BannerView)

	obj:__Init(view)

	return obj
end

function BannerView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.bannerItemList = {}

	self:__InitBannerScrollView()
	self:__InitBannerToggle()
end

function BannerView:Show()
	self.gameObject:SetActive(true)
	self:__RefreshShow()

	if not EventUtil.HasEventListener(self, EventID.UnlockFunction) then
		EventUtil.AddEventListener(self, EventID.UnlockFunction, self.__RefreshShow)
	end
end

function BannerView:Hide()
	EventUtil.RemoveEventListener(self, EventID.UnlockFunction)
	self.gameObject:SetActive(false)
end

function BannerView:Dispose()
	EventUtil.ClearEventListener(self)
	self:__StopAnimTimer()

	self.bannerItemList = nil
	self.bannerAreaList.onRenderCell = nil
	self.bannerAreaList.onPageReachedMainPos = nil
	self.bannerAreaList = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function BannerView:__InitBannerScrollView()
	self.bannerAreaList = self.bannerScrollView:GetComponent("ScrollAreaListPage")

	function self.bannerAreaList.onRenderCell(cell)
		self:__OnRenderBannerListItem(cell)
	end

	function self.bannerAreaList.onPageReachedMainPos(page)
		self:__OnPageReachedMainPos(page)
	end
end

function BannerView:__RefreshShow()
	self:__StopAnimTimer()

	self.bannerItemDataList = GameNoticeModule.GetPayActiveNoticeList()

	if #self.bannerItemDataList == 0 then
		self.contentRoot.gameObject:SetActive(false)

		return
	end

	self.contentRoot.gameObject:SetActive(true)

	self.animForward = true

	local totalCount = #self.bannerItemDataList

	self:__ResetToggleShow(totalCount)

	self.bannerAreaList.startIndex = 0

	self.bannerAreaList:Refresh(totalCount)
end

function BannerView:__OnRenderBannerListItem(itemCell)
	local insID = itemCell.gameObject:GetInstanceID()
	local bannerItem = self.bannerItemList[insID]

	if bannerItem == nil then
		bannerItem = BannerItem.New(itemCell.gameObject)
		self.bannerItemList[insID] = bannerItem
	end

	local itemCfg = self.bannerItemDataList[itemCell.index + 1]

	bannerItem:Show(itemCfg)
end

function BannerView:__OnPageReachedMainPos(page)
	self.pageIndex = page.index + 1

	self:__RefreshToggleState(self.pageIndex)
	self:__StartAnimTimer()
end

function BannerView:__InitBannerToggle()
	self.toggleItem.gameObject:SetActive(false)

	self.bannerToggleItemPool = UIViewObjectPool.New(self.toggleItem, nil, function(_view)
		return BannerToggleItem.New(_view)
	end)
end

function BannerView:__ResetToggleShow(totalCount)
	self.bannerToggleItemPool:ForItems(function(_item)
		_item:Release()
	end)

	for _ = 1, totalCount do
		local item = self.bannerToggleItemPool:GetFree(function(_item)
			return _item:IsFree()
		end)

		item:Show()
	end
end

function BannerView:__RefreshToggleState(selectIndex)
	local _index = 1

	self.bannerToggleItemPool:ForItems(function(_item)
		if _item:IsFree() then
			return
		end

		local isOn = _index == selectIndex

		_item:SetIsOn(isOn)

		_index = _index + 1
	end)
end

function BannerView:__StartAnimTimer()
	self:__StopAnimTimer()

	if #self.bannerItemDataList == 1 then
		return
	end

	self.animTimer = Timer.New(function()
		self:__OnNextPage()
	end, 5, -1)

	self.animTimer:Start()
end

function BannerView:__StopAnimTimer()
	if self.animTimer == nil then
		return
	end

	self.animTimer:Stop()

	self.animTimer = nil
end

function BannerView:__OnNextPage()
	if self.pageIndex == #self.bannerItemDataList then
		self.animForward = false
	elseif self.pageIndex == 1 then
		self.animForward = true
	end

	if self.animForward then
		self.bannerAreaList:TurnToForward()
	else
		self.bannerAreaList:TurnToBackward()
	end
end

return BannerView
