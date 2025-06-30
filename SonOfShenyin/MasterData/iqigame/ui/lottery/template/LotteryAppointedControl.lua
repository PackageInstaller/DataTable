-- chunkname: @IQIGame\\UI\\Lottery\\Template\\LotteryAppointedControl.lua

local ItemCell = {}

function ItemCell.New(view)
	local obj = Clone(ItemCell)

	obj:__Init(view)

	return obj
end

function ItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function ItemCell:Show(cardCid, roleCid)
	self.gameObject:SetActive(true)

	self.cardCid = cardCid
	self.roleCid = roleCid

	local path = SkinModule.GetHeroDefaultSkinImgPath(roleCid, Constant.SkinImageType.HeroResourcesShowImg)

	AssetUtil.LoadImage(self, path, self.RoleImage:GetComponent("Image"))
end

function ItemCell:UpdateSelectShow(isSelect)
	self.SelectRoot.gameObject:SetActive(isSelect)
end

function ItemCell:Hide()
	self.gameObject:SetActive(false)
end

function ItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local LotteryAppointedControl = {
	displayItemCellList = {},
	displaySkinList = {},
	displayCardList = {}
}

function LotteryAppointedControl.New(view)
	local obj = Clone(LotteryAppointedControl)

	obj:__Init(view)

	return obj
end

function LotteryAppointedControl:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.scrollAreaList = self.ScrollAreaListRoot:GetComponent("ScrollAreaList")

	function self.scrollAreaList.onRenderCell(_cell)
		self:__OnDisplayCellRender(_cell)
	end

	function self.scrollAreaList.onSelectedCell(_cell)
		self:__OnDisplayCellSelected(_cell)
	end

	UIEventUtil.AddClickEventListener_Button(self, "ConfirmBtn", self.__OnConfirmBtnClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "CloseBtn", self.__OnCloseBtnClickHandler)
end

function LotteryAppointedControl:__OnConfirmBtnClickHandler()
	LotteryModule.SendChooseShowGroupData(self.cardGroupCid, self.cardJackpotID)
	EventDispatcher.Dispatch(EventID.SetLotteryAppointedViewActive, false)
end

function LotteryAppointedControl:__OnCloseBtnClickHandler()
	EventDispatcher.Dispatch(EventID.SetLotteryAppointedViewActive, false)
end

function LotteryAppointedControl:__OnDisplayCellRender(cell)
	local dataIndex = cell.index + 1
	local instanceID = cell.gameObject:GetInstanceID()
	local displayItemCell = self.displayItemCellList[instanceID]

	if displayItemCell == nil then
		displayItemCell = ItemCell.New(cell.gameObject)
		self.displayItemCellList[instanceID] = displayItemCell
	end

	local heroCid = self.displaySkinList[dataIndex]
	local cardJackpotID = self.displayCardList[dataIndex]

	displayItemCell:Show(cardJackpotID, heroCid)
	displayItemCell:UpdateSelectShow(heroCid == self.selectHeroCid)
end

function LotteryAppointedControl:__OnDisplayCellSelected(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local displayItemCell = self.displayItemCellList[instanceID]

	self.selectHeroCid = displayItemCell.roleCid
	self.cardJackpotID = displayItemCell.cardCid

	ForPairs(self.displayItemCellList, function(k, _cell)
		local isSelect = _cell.roleCid == self.selectHeroCid

		_cell:UpdateSelectShow(isSelect)
	end)
end

function LotteryAppointedControl:Show(showGroupCid, heroCid)
	self.gameObject:SetActive(true)

	self.cardGroupCid = showGroupCid
	self.cardJackpotID = 0
	self.selectHeroCid = heroCid

	local showGroupCfg = CfgCardGroupTable[self.cardGroupCid]

	ForArray(showGroupCfg.ShowCard, function(_index, _heroCid)
		if _heroCid == self.selectHeroCid then
			self.cardJackpotID = showGroupCfg.CardJackpotID[_index]
		end
	end)
	self:ShowSwitchView()
end

function LotteryAppointedControl:ShowSwitchView()
	local showGroupCfg = CfgCardGroupTable[self.cardGroupCid]

	self.displaySkinList = showGroupCfg.ShowCard
	self.displayCardList = showGroupCfg.CardJackpotID

	self.scrollAreaList:Refresh(#self.displaySkinList)
end

function LotteryAppointedControl:Hide()
	self.gameObject:SetActive(false)
end

function LotteryAppointedControl:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return LotteryAppointedControl
