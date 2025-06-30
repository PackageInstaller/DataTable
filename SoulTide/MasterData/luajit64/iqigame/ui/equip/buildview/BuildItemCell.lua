-- chunkname: @IQIGame\\UI\\Equip\\BuildView\\BuildItemCell.lua

local BuildItemCell = {
	selectedNum = 0
}

function BuildItemCell.New(go)
	local o = Clone(BuildItemCell)

	o:Initialize(go)

	return o
end

function BuildItemCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfItemExp = self.goItemExp:GetComponent("Text")
	self.tfSelectedNum = self.goSelectedNum:GetComponent("Text")
	self.btnReduce = self.goBtnReduce:GetComponent("Button")
	self.btnAdd = self.goBtnAdd:GetComponent("Button")

	function self.onClickBtnReduceDelegate()
		self:OnClickBtnReduce()
	end

	function self.onClickBtnAddDelegate()
		self:OnClickBtnAdd()
	end

	self:AddListeners()
end

function BuildItemCell:Refresh(index, dataArr, mainView)
	self.index = index
	self.mainView = mainView
	self.cfgItemData = CfgItemTable[dataArr[1]]
	self.exp = dataArr[2]
	self.coin = dataArr[3]
	self.realOwnNum = WarehouseModule.GetItemNumByCfgID(self.cfgItemData.Id)
	self.ownNum = self.realOwnNum
	self.selectedNum = 0

	self.goBtnReduce:SetActive(false)
	self:RefreshMisc()
	self:RefreshCell()
end

function BuildItemCell:OnDestroy()
	self.mainView = nil

	self:RemoveListeners()

	if self.itemCell ~= nil then
		self.itemCell:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BuildItemCell:AddListeners()
	self.btnReduce.onClick:AddListener(self.onClickBtnReduceDelegate)
	self.btnAdd.onClick:AddListener(self.onClickBtnAddDelegate)
end

function BuildItemCell:RemoveListeners()
	self.btnReduce.onClick:RemoveListener(self.onClickBtnReduceDelegate)
	self.btnAdd.onClick:RemoveListener(self.onClickBtnAddDelegate)
end

function BuildItemCell:OnClickBtnReduce()
	self.goBtnReduce:SetActive(false)
	self:RefreshOnReduce()
	self.mainView:OnClickItemCell(self, false)
	self:RefreshSignSelectedNumState()
end

function BuildItemCell:OnClickBtnAdd()
	if self.mainView.canUpLv >= self.mainView.curMaxLv then
		if EquipModule.CheckReachedMaxLv(self.mainView.canUpLv, self.mainView.cfgSoulPaintingData.Quality) then
			NoticeModule.ShowNoticeNoCallback(21053006)
		else
			NoticeModule.ShowNoticeNoCallback(21041042)
		end

		return
	end

	return self:DoClickBtnAdd()
end

function BuildItemCell:RefreshMisc()
	UGUIUtil.SetText(self.goName, EquipUIApi:GetString("costItemName", self.cfgItemData.Name))

	self.tfItemExp.text = EquipUIApi:GetString("goExp", self.exp)
	self.tfSelectedNum.text = EquipUIApi:GetString("goSelectedNum", self.selectedNum)

	if self.itemCell ~= nil then
		self.itemCell:SetNum(self.ownNum, true)
	end
end

function BuildItemCell:RefreshOnReduce()
	self.ownNum = self.realOwnNum
	self.selectedNum = 0

	self:RefreshMisc()
end

function BuildItemCell:RefreshCell()
	if self.itemCell == nil then
		self.itemCell = ItemCell.PackageOrReuseView(self, self.goSlot.transform:GetChild(0).gameObject)
	end

	self.itemCell:SetItemByCID(self.cfgItemData.Id, self.ownNum)
	self:RefreshSignSelectedNumState()
end

function BuildItemCell:RefreshSignSelectedNumState()
	self.goSignSelectedNum:SetActive(self.selectedNum ~= 0)
end

function BuildItemCell:DoClickBtnAdd()
	if self.ownNum == 0 then
		return false
	end

	self.goBtnReduce:SetActive(true)

	self.selectedNum = self.mainView:GetReachNextLvCostItemCount(self.exp) + self.selectedNum

	if self.selectedNum > self.realOwnNum then
		self.selectedNum = self.realOwnNum
	end

	if self.selectedNum == 0 then
		return false
	end

	self.ownNum = self.realOwnNum - self.selectedNum

	if self.ownNum < 0 then
		self.ownNum = 0
	end

	self:RefreshMisc()
	self.mainView:OnClickItemCell(self, true)
	self:RefreshSignSelectedNumState()

	return true
end

return BuildItemCell
