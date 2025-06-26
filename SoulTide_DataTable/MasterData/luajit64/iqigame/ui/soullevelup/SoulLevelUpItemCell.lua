-- chunkname: @IQIGame\\UI\\SoulLevelUp\\SoulLevelUpItemCell.lua

local SoulLevelUpItemCell = {
	selectedNum = 0
}

function SoulLevelUpItemCell.New(go)
	local o = Clone(SoulLevelUpItemCell)

	o:Initialize(go)

	return o
end

function SoulLevelUpItemCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfSelectedNum = self.goSelectedNum:GetComponent("Text")
	self.tfOwnNum = self.goOwnNum:GetComponent("Text")
	self.btnReduce = self.goBtnReduce:GetComponent("Button")
	self.btnAdd = self.goBtnAdd:GetComponent("Button")
	self.btnInfo = self.goBtnInfo:GetComponent("Button")

	function self.onClickBtnInfoDelegate()
		self:OnClickBtnInfo()
	end

	function self.onClickBtnReduceDelegate()
		self:OnClickBtnReduce()
	end

	function self.onClickBtnAddDelegate()
		self:OnClickBtnAdd()
	end

	self:AddListeners()
end

function SoulLevelUpItemCell:Refresh(index, mainView)
	self.index = index
	self.mainView = mainView

	local startIndex = index + (index - 1)
	local cfgData = CfgDiscreteDataTable[6506030]

	self.cfgItemData = CfgItemTable[cfgData.Data[startIndex]]
	self.exp = cfgData.Data[startIndex + 1]
	self.realOwnNum = WarehouseModule.GetItemNumByCfgID(self.cfgItemData.Id)
	self.ownNum = self.realOwnNum
	self.selectedNum = 0

	self.goBtnReduce:SetActive(false)
	self:RefreshMisc()
end

function SoulLevelUpItemCell:RefreshOnReduce()
	self.ownNum = self.realOwnNum
	self.selectedNum = 0

	self:RefreshMisc()
end

function SoulLevelUpItemCell:OnHide()
	return
end

function SoulLevelUpItemCell:OnDestroy()
	self.mainView = nil

	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SoulLevelUpItemCell:AddListeners()
	self.btnReduce.onClick:AddListener(self.onClickBtnReduceDelegate)
	self.btnAdd.onClick:AddListener(self.onClickBtnAddDelegate)
	self.btnInfo.onClick:AddListener(self.onClickBtnInfoDelegate)
end

function SoulLevelUpItemCell:RemoveListeners()
	self.btnReduce.onClick:RemoveListener(self.onClickBtnReduceDelegate)
	self.btnAdd.onClick:RemoveListener(self.onClickBtnAddDelegate)
	self.btnInfo.onClick:RemoveListener(self.onClickBtnInfoDelegate)
end

function SoulLevelUpItemCell:OnClickBtnInfo()
	ItemModule.OpenTipByData(self.cfgItemData, true)
end

function SoulLevelUpItemCell:OnClickBtnReduce(notCall)
	self:PlayAnimReduce(false)
	self:RefreshOnReduce()

	if not notCall then
		self.mainView:OnSelectItemChange(self)
	end
end

function SoulLevelUpItemCell:OnClickBtnAdd()
	if self.mainView.canUpLv >= self.mainView.maxSoulLv then
		NoticeModule.ShowNoticeNoCallback(21041039)

		return
	end

	local cfgData = CfgSoulLevelTable[self.mainView.canUpLv]

	if PlayerModule.PlayerInfo.baseInfo.pLv < cfgData.NeedPlayerLv then
		NoticeModule.ShowNoticeNoCallback(21041040)

		return
	end

	self:DoClickBtnAdd()
end

function SoulLevelUpItemCell:DoClickBtnAdd(notCall)
	if self.ownNum == 0 then
		return false
	end

	self:PlayAnimReduce(true)

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

	self:RefreshSelectInfo()

	if not notCall then
		self.mainView:OnSelectItemChange(self)
	end

	return true
end

function SoulLevelUpItemCell:RefreshMisc()
	self:RefreshSelectInfo()

	self.tfName.text = SoulLevelUpUIApi:GetString("goExpItemName", self.cfgItemData.Name)

	local icon = self.goSlot.transform:Find("Image_Icon"):GetComponent("Image")

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.cfgItemData.Icon), icon)

	local qualityIcon = self.goSlot.transform:Find("Image_Color"):GetComponent("Image")

	AssetUtil.LoadImage(self, SoulUIApi:GetString("UpViewItemQualityBg", self.cfgItemData.Quality), qualityIcon)
end

function SoulLevelUpItemCell:RefreshSelectInfo()
	self.tfSelectedNum.text = SoulLevelUpUIApi:GetString("goSelectedNum", self.selectedNum)
	self.tfOwnNum.text = SoulLevelUpUIApi:GetString("goOwnNum", self.realOwnNum)
end

function SoulLevelUpItemCell:PlayAnimReduce(playForward)
	self.goBtnReduce:SetActive(playForward)
end

return SoulLevelUpItemCell
