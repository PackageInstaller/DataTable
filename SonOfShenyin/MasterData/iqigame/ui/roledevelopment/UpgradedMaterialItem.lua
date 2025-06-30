-- chunkname: @IQIGame\\UI\\RoleDevelopment\\UpgradedMaterialItem.lua

local m = {
	ItemNum = 0,
	IsNewTips = true
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateAddMatericalBtn()
		self:AddBtnClick()
	end

	function self.DelegateAddLongBtn(time)
		self:AddLongBtnClick(time)
	end

	function self.DelegateMaxBtn()
		self:MaxBtnClick()
	end

	function self.DelegateReduceBtn()
		self:ReduceBtnClick()
	end

	function self.DelegateReduceLongBtn()
		self:ReduceLongBtnClick()
	end

	function self.DelegateOnQuickAddEndEvent()
		self:OnQuickAddEndEvent()
	end

	self.ItemCell = ItemCell.New(self.CommonSlot, false, false)

	self:AddListeners()
end

function m:AddListeners()
	self.MaxBtn:GetComponent("Button").onClick:AddListener(self.DelegateMaxBtn)
	self.View:GetComponent("LongButton").onClick:AddListener(self.DelegateAddMatericalBtn)
	self.View:GetComponent("LongButton").onLongDownClick:AddListener(self.DelegateAddLongBtn)
	self.ReduceBtn:GetComponent("LongButton").onClick:AddListener(self.DelegateReduceBtn)
	self.ReduceBtn:GetComponent("LongButton").onLongDownClick:AddListener(self.DelegateReduceLongBtn)
	EventDispatcher.AddEventListener(EventID.OnQuickAddEndEvenet, self.DelegateOnQuickAddEndEvent)
end

function m:RemoveListeners()
	self.MaxBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateMaxBtn)
	self.View:GetComponent("LongButton").onClick:RemoveListener(self.DelegateAddMatericalBtn)
	self.View:GetComponent("LongButton").onLongDownClick:RemoveListener(self.DelegateAddLongBtn)
	self.ReduceBtn:GetComponent("LongButton").onClick:RemoveListener(self.DelegateReduceBtn)
	self.ReduceBtn:GetComponent("LongButton").onLongDownClick:RemoveListener(self.DelegateReduceLongBtn)
	EventDispatcher.RemoveEventListener(EventID.OnQuickAddEndEvenet, self.DelegateOnQuickAddEndEvent)
end

function m:SetData(itemCid)
	self.itemCid = itemCid

	UGUIUtil.SetText(self.SelectCountText, "0")
	UGUIUtil.SetText(self.MaterialCountText, "0")

	self.ItemData = WarehouseModule.FindItemForCid(self.itemCid)

	local num = 0

	if self.ItemData == nil then
		self.ItemData = ItemData.CreateByCIDAndNumber(self.itemCid, 0)
		num = self.ItemData.num
	else
		num = WarehouseModule.GetItemNumByCfgID(self.itemCid)
	end

	self.ItemNum = num

	local colorNum

	colorNum = string.format(ColorCfg.RoleUpdate.normalNum, num)

	UGUIUtil.SetText(self.MaterialCountText, colorNum)
	UGUIUtil.SetText(self.MaterialName, self.ItemData:GetCfg().Name)

	self.ItemExp = self.ItemData:GetCfg().ActionParams[1]

	self.ItemCell:SetItem(self.ItemData)
	self.ItemCell:SetItemNumShow(0, false)

	self.SelectCount = 0

	self.SelectParent:SetActive(false)
end

function m:AddBtnClick()
	if self.SelectCount == self.ItemData.num then
		if self.ItemData.num == 0 then
			ItemModule.OpenItemTipsByItemData(self.ItemData)
		elseif self.IsNewTips then
			NoticeModule.ShowNotice(20003)

			self.IsNewTips = false
		end

		return
	end

	if RoleDevelopmentModule.IsCanUpgradeHero then
		NoticeModule.ShowNotice(20005)

		return
	end

	self.SelectParent:SetActive(true)

	self.SelectCount = self.SelectCount + 1

	UGUIUtil.SetText(self.SelectCountText, self.SelectCount)
	self:ShowSelectInfo()
end

function m:AddLongBtnClick()
	for i = 1, 2 do
		if not RoleDevelopmentModule.IsCanUpgradeHero then
			self:AddBtnClick()
		end
	end
end

function m:InitSelect()
	self.SelectCount = 0

	LuaUtility.SetGameObjectShow(self.SelectParent, false)
end

function m:MaxSingleAddClick()
	self.SelectCount = self.SelectCount + 1
end

function m:ReduceBtnClick()
	self.SelectCount = self.SelectCount - 1
	self.IsNewTips = true

	if self.SelectCount < 0 then
		self.SelectCount = 0

		return
	end

	if self.SelectCount <= 0 then
		self.SelectParent:SetActive(false)
	end

	UGUIUtil.SetText(self.SelectCountText, self.SelectCount)
	self:ShowSelectInfo()
end

function m:ReduceLongBtnClick()
	for i = 1, 2 do
		self:ReduceBtnClick()
	end
end

function m:MaxBtnClick()
	if RoleDevelopmentModule.IsCanUpgradeHero then
		NoticeModule.ShowNotice(20005)

		return
	end

	local count = RoleDevelopmentModule.GetSelectMaterialMaxCount(self.ItemExp)

	if count <= 0 then
		return
	end

	if self.SelectCount >= self.ItemNum then
		return
	end

	if count <= self.ItemNum then
		self.SelectCount = self.SelectCount + count
	else
		self.SelectCount = self.SelectCount + self.ItemNum

		if self.SelectCount >= self.ItemNum then
			self.SelectCount = self.ItemNum
		end
	end

	self:ShowSelectInfo()
	self.SelectParent:SetActive(true)
	UGUIUtil.SetText(self.SelectCountText, self.SelectCount)
end

function m:OnQuickAddEndEvent()
	if self.SelectCount == 0 then
		return
	end

	self.SelectParent:SetActive(true)
	UGUIUtil.SetText(self.SelectCountText, self.SelectCount)
	self:ShowSelectInfo()
end

function m:IsMaxSelect()
	return self.SelectCount >= self.ItemNum
end

function m:ClearSelect()
	if self.SelectCount <= 0 then
		return
	end

	self.SelectCount = 0

	if self.SelectCount <= 0 then
		self.SelectParent:SetActive(false)
	end

	UGUIUtil.SetText(self.SelectCountText, self.SelectCount)
	self:ShowSelectInfo()
end

function m:ShowSelectInfo()
	EventDispatcher.Dispatch(EventID.SelectRoleUpgradMaterial, {
		[self.ItemData.cid] = {
			self.SelectCount,
			self.SelectCount * self.ItemExp
		}
	})
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
