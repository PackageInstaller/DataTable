-- chunkname: @IQIGame\\UI\\RoleDevelopment\\FavorabilityCell.lua

FavorabilityCell = {
	LongJump = 5,
	curExp = 0,
	ItemAddOrSubCount = 0,
	ItemCustomCount = 0,
	id_number = 0
}

function FavorabilityCell.New(go, mianView)
	local o = Clone(FavorabilityCell)

	o:Initialize(go, mianView)

	return o
end

function FavorabilityCell:DeleteFunction()
	function self.OnClick_ButtonUp(_self, go)
		self:OnClickButtonUp(go)
	end

	function self.OnClick_LongTimer()
		self:OnClickLongTimer()
	end

	function self.OnClick_LongAddOrSub()
		self:OnClickLongAddOrSub()
	end

	function self.OnClick_EndAdd()
		self:OnClickEndAdd()
	end

	function self.OnClick_UpAdd(go)
		self:OnClickUpAdd(go)
	end

	function self.OnClick_DownAdd(go)
		self:OnClickDownAdd(go)
	end
end

function FavorabilityCell:Initialize(go, mianView)
	LuaCodeInterface.BindOutlet(go, self)
	self:DeleteFunction()

	self.gameObject = go
	self.mianView = mianView
	self.BaseItemCell = ItemCell.New(self.ItemObj, true, true)
	self.curOwnText = self.Own:GetComponent("Text")
	self.usenumText = self.usenum:GetComponent("Text")
	self.usenumText.text = ""
	self.AddLongBtn = self.addBtn:GetComponent("LongButton")
	self.AddLongBtn.repeatCall = false

	self.AddLongBtn.onLongDownClick:AddListener(self.OnClick_LongAddOrSub)

	self.AddLongBtn.onLongDownEnd = self.OnClick_EndAdd
	self.AddLongBtn.OnPointerUpAction = self.OnClick_UpAdd

	self.AddLongBtn.onClick:AddListener(self.OnClick_ButtonUp)

	self.AddLongBtn.OnPointerDownAction = self.OnClick_DownAdd
	self.SubLongBtn = self.subBtn:GetComponent("LongButton")
	self.SubLongBtn.repeatCall = false

	self.SubLongBtn.onLongDownClick:AddListener(self.OnClick_LongAddOrSub)

	self.SubLongBtn.onLongDownEnd = self.OnClick_EndAdd
	self.SubLongBtn.OnPointerUpAction = self.OnClick_UpAdd
	self.SubLongBtn.OnPointerDownAction = self.OnClick_DownAdd

	self.SubLongBtn.onClick:AddListener(self.OnClick_ButtonUp)
end

function FavorabilityCell:RefreshItemCell(data)
	self.Data = data

	self.ExtendObj:SetActive(data.num > 0)

	self.curExp = self.Data:GetCfg().ActionParams[1]
	self.id_number = tonumber(self.Data.id)
	self.ItemCustomCount = self.Data.ItemCustomCount == nil and 0 or self.Data.ItemCustomCount

	self.BaseItemCell:SetItem(data)
	self.BaseItemCell:SetGray(data.num <= 0)

	self.curOwnText.text = data.num > 0 and data.num or ""
	self.CanItemCustomCount = data.num

	self.SubLongBtn.gameObject:SetActive(false)

	self.usenumText.text = ""
end

function FavorabilityCell:OnClickLongAddOrSub()
	self.islongAn = true

	self:TimerClose()

	self.timer = Timer.New(self.OnClick_LongTimer, 0.12, -1)

	self.timer:Start()
end

function FavorabilityCell:OnClickLongTimer()
	if self.AnButtonType == 1 then
		self:OnClickAdd()
	else
		self:OnClickSub()
	end
end

function FavorabilityCell:OnClickEndAdd()
	self.mianView.OnClick_SendBtn()
end

function FavorabilityCell:OnClickDownAdd(go)
	if go.name == "addBtn" then
		self.AnButtonType = 1
		RoleExtendModule.OperateData.isAdd = true
	else
		self.AnButtonType = 2
		RoleExtendModule.OperateData.isAdd = false
	end

	RoleExtendModule.OperateData.Data = self.Data
	self.ItemAddOrSubCount = 0
end

function FavorabilityCell:OnClickButtonUp(go)
	if RoleExtendModule.PreviewIsMax or WarlockModule.curWarlockData:GetFavorIsMax() then
		NoticeModule.ShowNotice(20005)

		return
	end

	if self.AnButtonType == 1 then
		self:OnClickAdd()
	else
		self:OnClickSub()
	end

	self.mianView.OnClick_SendBtn()
end

function FavorabilityCell:OnClickUpAdd(go)
	if self.islongAn == true then
		self.islongAn = false

		self:TimerClose()
	end
end

function FavorabilityCell:OnClickAdd(_self, go)
	if RoleExtendModule.PreviewIsMax or WarlockModule.curWarlockData:GetFavorIsMax() then
		if self.islongAn == true then
			self:TimerClose()
		end

		return
	end

	if self.ItemCustomCount == self.CanItemCustomCount then
		if self.islongAn == true then
			self:TimerClose()
		end

		return
	end

	if self.islongAn == true then
		local longPreviewCount = self.ItemCustomCount + self.LongJump

		if longPreviewCount > self.CanItemCustomCount then
			self.ItemCustomCount = self.CanItemCustomCount
			self.ItemAddOrSubCount = self.CanItemCustomCount - self.ItemCustomCount
		else
			self.ItemCustomCount = longPreviewCount
			self.ItemAddOrSubCount = self.LongJump
		end

		local AddOrSubExp = self.curExp * self.ItemAddOrSubCount
		local exp = AddOrSubExp + RoleExtendModule.PreviewAddExp

		if exp >= RoleExtendModule.MaxOwnExp then
			self.ItemCustomCount = self.ItemCustomCount - self.ItemAddOrSubCount

			self:OverflowExp()
			self:TimerClose()
		end
	else
		self.ItemCustomCount = self.ItemCustomCount + 1
		self.ItemAddOrSubCount = 1
	end

	self:ItemCountRefresh()
end

function FavorabilityCell:OverflowExp()
	local length = self.ItemAddOrSubCount

	self.ItemAddOrSubCount = 0

	for i = 1, length do
		local AddOrSubExp = self.curExp * i
		local exp = RoleExtendModule.PreviewAddExp + AddOrSubExp

		self.ItemCustomCount = self.ItemCustomCount + 1
		self.ItemAddOrSubCount = self.ItemAddOrSubCount + 1

		if exp >= RoleExtendModule.MaxOwnExp then
			break
		end
	end
end

function FavorabilityCell:OnClickSub(_self, go)
	if self.ItemCustomCount == 0 then
		if self.islongAn == true then
			self:TimerClose()
		end

		return
	end

	if self.islongAn == true then
		local longPreviewCount = self.ItemCustomCount - self.LongJump

		if longPreviewCount < 0 then
			self.ItemAddOrSubCount = self.ItemCustomCount
			self.ItemCustomCount = 0
		else
			self.ItemCustomCount = longPreviewCount
			self.ItemAddOrSubCount = self.LongJump
		end
	else
		self.ItemCustomCount = self.ItemCustomCount - 1
		self.ItemAddOrSubCount = 1
	end

	self:ItemCountRefresh()
end

function FavorabilityCell:ItemCountRefresh()
	if self.ItemCustomCount > 0 then
		RoleExtendModule.CustomItemDic[self.Data.cid] = self.ItemCustomCount
	end

	self.Data.ItemCustomCount = self.ItemCustomCount
	self.Data.ItemAddOrSubCount = self.ItemAddOrSubCount

	local diffnum = self.Data.num - self.ItemCustomCount

	self.curOwnText.text = diffnum > 0 and diffnum or ""

	self.mianView.DelegaPreviewClickCall()
end

function FavorabilityCell:TimerClose()
	if self.timer ~= nil then
		self.timer:Stop()
	end

	self.timer = nil
end

function FavorabilityCell:ResetAll()
	if self.ItemCustomCount == 0 then
		return
	end

	self.ItemCustomCount = 0
	self.usenumText.text = ""

	self.SubLongBtn.gameObject:SetActive(false)

	self.ItemAddOrSubCount = 0
end

function FavorabilityCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	self.AddLongBtn.onLongDownClick:RemoveListener(self.OnClick_LongAddOrSub)
	self.SubLongBtn.onLongDownClick:RemoveListener(self.OnClick_LongAddOrSub)
	self.AddLongBtn.onClick:RemoveListener(self.OnClick_ButtonUp)
	self.SubLongBtn.onClick:RemoveListener(self.OnClick_ButtonUp)
end

return FavorabilityCell
