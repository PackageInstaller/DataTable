-- chunkname: @IQIGame\\UI\\Home\\UIActorController\\UIMainCityBannerController.lua

local ActorController = require("IQIGame/Scene/Home/Controller/ActorController")
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
	if self.skipCid == 0 or self.skipCid == nil then
		return
	end

	JumpModule.Jump(self.skipCid)
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

local Controller = Clone(ActorController)

function Controller:__OnInit()
	self.view = {}

	LuaCodeInterface.BindOutlet(self.actor.gameObject, self.view)

	self.bannerItemList = {}

	self:__InitBannerScrollView()
	self:__InitBannerToggle()
	self:__RefreshShow()
	self:__OnControllerReady()
end

function Controller:__OnInitEventDelegate()
	function self.__delegateOnUnlockFunction()
		self:__RefreshShow()
	end
end

function Controller:__OnAddListeners()
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.__delegateOnUnlockFunction)
end

function Controller:__OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.__delegateOnUnlockFunction)
end

function Controller:__RefreshShow()
	self:__StopAnimTimer()

	self.bannerItemDataList = {}

	ForPairs(CfgPayActivityTable, function(_cid, _cfg)
		if not self:__CheckBannerItem(_cfg) then
			return
		end

		table.insert(self.bannerItemDataList, _cfg)
	end)

	if #self.bannerItemDataList == 0 then
		self.view.contentRoot.gameObject:SetActive(false)

		return
	end

	self.view.contentRoot.gameObject:SetActive(true)

	self.animForward = true

	local totalCount = #self.bannerItemDataList

	self:__ResetToggleShow(totalCount)

	self.bannerAreaList.startIndex = 0

	self.bannerAreaList:Refresh(totalCount)
end

function Controller:__CheckBannerItem(itemConfig)
	if itemConfig.Type ~= 3 then
		return false
	end

	if itemConfig.Skip == 0 then
		return true
	end

	local cfgData = CfgFunctionTable[itemConfig.Skip]

	if cfgData == nil then
		return false
	end

	if cfgData.FuncSwitchOpen ~= 0 and not UnlockFunctionModule.IsUnlock(cfgData.FuncSwitchOpen) then
		return false
	end

	local _showConditionCid = TryToNumber(itemConfig.ShowCondition, 0)

	if not ConditionModule.Check(_showConditionCid) then
		return false
	end

	if not LuaUtility.StrIsNullOrEmpty(itemConfig.OpenTime) then
		local openTime = cfgDateTimeToTimeStamp(itemConfig.OpenTime)
		local closeTime = cfgDateTimeToTimeStamp(itemConfig.OpenTime) + itemConfig.Duration[1]
		local serverTime = PlayerModule.GetServerTime()

		if not (openTime < serverTime) or not (serverTime < closeTime) then
			return false
		end
	end

	return true
end

function Controller:__OnDispose()
	self:__StopAnimTimer()

	self.bannerItemList = nil
	self.bannerAreaList.onRenderCell = nil
	self.bannerAreaList.onPageReachedMainPos = nil
	self.bannerAreaList = nil

	LuaCodeInterface.ClearOutlet(self.actor.gameObject, self.view)
end

function Controller:__InitBannerScrollView()
	self.bannerAreaList = self.view.bannerScrollView:GetComponent("ScrollAreaListPage")

	function self.bannerAreaList.onRenderCell(cell)
		self:__OnRenderBannerListItem(cell)
	end

	function self.bannerAreaList.onPageReachedMainPos(page)
		self:__OnPageReachedMainPos(page)
	end
end

function Controller:__OnRenderBannerListItem(itemCell)
	local insID = itemCell.gameObject:GetInstanceID()
	local bannerItem = self.bannerItemList[insID]

	if bannerItem == nil then
		bannerItem = BannerItem.New(itemCell.gameObject)
		self.bannerItemList[insID] = bannerItem
	end

	local itemCid = self.bannerItemDataList[itemCell.index + 1]

	bannerItem:Show(itemCid)
end

function Controller:__OnPageReachedMainPos(page)
	self.pageIndex = page.index + 1

	self:__RefreshToggleState(self.pageIndex)
	self:__StartAnimTimer()
end

function Controller:__InitBannerToggle()
	self.view.toggleItem.gameObject:SetActive(false)

	self.bannerToggleItemPool = UIViewObjectPool.New(self.view.toggleItem, nil, function(_view)
		return BannerToggleItem.New(_view)
	end)
end

function Controller:__ResetToggleShow(totalCount)
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

function Controller:__RefreshToggleState(selectIndex)
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

function Controller:__StartAnimTimer()
	self:__StopAnimTimer()

	if #self.bannerItemDataList == 1 then
		return
	end

	self.animTimer = Timer.New(function()
		self:__OnNextPage()
	end, 5, -1)

	self.animTimer:Start()
end

function Controller:__StopAnimTimer()
	if self.animTimer == nil then
		return
	end

	self.animTimer:Stop()

	self.animTimer = nil
end

function Controller:__OnNextPage()
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

return Controller
