-- chunkname: @IQIGame\\UI\\Equip\\Skin\\EquipUISkinView.lua

local EquipUISkinCell = require("IQIGame.UI.Equip.Skin.EquipUISkinCell")
local m = {
	DescPage = 1,
	SkinCells = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickPrevPageBtn()
		self:OnClickPrevPageBtn()
	end

	function self.DelegateOnClickNextPageBtn()
		self:OnClickNextPageBtn()
	end

	function self.DelegateOnClickChangeSkinBtn()
		self:OnClickChangeSkinBtn()
	end

	function self.DelegateOnClickGoBuyBtn()
		self:OnClickGoBuyBtn()
	end

	function self.DelegateOnEquipSkinChanged(skinCid)
		self:OnEquipSkinChanged(skinCid)
	end

	local scrollAreaList = self.SkinCardGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectCell(cell)
	end

	UGUIUtil.SetText(self.OriginEquipNameLabel, EquipUIApi:GetString("SkinView_OriginEquipNameLabel"))
	UGUIUtil.SetTextInChildren(self.GoBuyBtn, EquipUIApi:GetString("SkinView_GoBuyBtnText"))
end

function m:AddListeners()
	self.PrevPageBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPrevPageBtn)
	self.NextPageBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNextPageBtn)
	self.ChangeSkinBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeSkinBtn)
	self.GoBuyBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGoBuyBtn)
	EventDispatcher.AddEventListener(EventID.EquipSkinChanged, self.DelegateOnEquipSkinChanged)
end

function m:RemoveListeners()
	self.PrevPageBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPrevPageBtn)
	self.NextPageBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNextPageBtn)
	self.ChangeSkinBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeSkinBtn)
	self.GoBuyBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGoBuyBtn)
	EventDispatcher.RemoveEventListener(EventID.EquipSkinChanged, self.DelegateOnEquipSkinChanged)
end

function m:Refresh(itemData)
	self.ItemData = itemData

	self:RemoveListeners()
	self:AddListeners()
	self.goCard.transform:SetParent(self.goCardPoint.transform, false)
	self:__Refresh(true)
end

function m:__Refresh(isOnShow)
	local cfgItemData = self.ItemData:GetCfg()

	UGUIUtil.SetText(self.OriginEquipNameText, cfgItemData.Name)

	self.SkinCids = EquipModule.GetEquipSkins(self.ItemData.cid)

	local scrollAreaList = self.SkinCardGrid:GetComponent("ScrollAreaList")

	if isOnShow then
		scrollAreaList.defaultSelectedToggle = 0

		scrollAreaList:Refresh(#self.SkinCids)
		self:ShowSkinInfo(self.SkinCids[1])
	else
		scrollAreaList:RenderCellsDynamic(#self.SkinCids)
		self:ShowSkinInfo(self.CurrentSkinCfgData.Id)
	end
end

function m:SetActive(value)
	if value == false then
		self:OnHide()
	end

	self.View:SetActive(value)
end

function m:OnHide()
	self:RemoveListeners()
end

function m:OnRenderCell(cell)
	local skinCell = self.SkinCells[cell.gameObject:GetInstanceID()]

	if skinCell == nil then
		skinCell = EquipUISkinCell.New(cell.gameObject)
		self.SkinCells[cell.gameObject:GetInstanceID()] = skinCell
	end

	skinCell:SetData(self.SkinCids[cell.index + 1])
end

function m:OnSelectCell(cell)
	local skinCell = self.SkinCells[cell.gameObject:GetInstanceID()]

	self:ShowSkinInfo(skinCell.SkinCid)
end

function m:ShowSkinInfo(skinCid)
	self.CurrentSkinCfgData = CfgSoulPaintingSkinTable[skinCid]

	UGUIUtil.SetText(self.SkinNameText, self.CurrentSkinCfgData.Name)

	self.DescPage = 1

	self:RefreshBtn()
	self:RefreshDescPage()
end

function m:RefreshBtn()
	local isUnlock = EquipModule.GetSkinState(self.CurrentSkinCfgData.Id) ~= nil

	self.ChangeSkinBtn:SetActive(isUnlock)

	local hasLockDesc = self.CurrentSkinCfgData.LockDesc ~= nil and self.CurrentSkinCfgData.LockDesc ~= ""

	self.LockBtnView:SetActive(not isUnlock and hasLockDesc)

	if hasLockDesc then
		UGUIUtil.SetTextInChildren(self.LockBtnView, self.CurrentSkinCfgData.LockDesc)
	end

	self.GoBuyBtn:SetActive(not isUnlock and not hasLockDesc and self.CurrentSkinCfgData.Mall ~= 0)

	local skinState = EquipModule.GetSkinState(self.CurrentSkinCfgData.Id)

	UGUIUtil.SetTextInChildren(self.ChangeSkinBtn, EquipUIApi:GetString("SkinView_ChangeSkinBtnText", skinState == 1))
end

function m:RefreshDescPage()
	local isUnlock = EquipModule.GetSkinState(self.CurrentSkinCfgData.Id) ~= nil
	local hiddenStoryIndex = self.DescPage - 1
	local isHiddenStoryUnlock = hiddenStoryIndex <= self.ItemData.equipData.star
	local showLockView = self.DescPage > 1 and (not isUnlock or not isHiddenStoryUnlock)

	self.DescLockView:SetActive(showLockView)
	self.DescNormalView:SetActive(not showLockView)

	if self.DescPage == 1 then
		UGUIUtil.SetTextInChildren(self.DescNormalView, self.CurrentSkinCfgData.Desc)
	elseif isUnlock and isHiddenStoryUnlock then
		UGUIUtil.SetTextInChildren(self.DescNormalView, self.CurrentSkinCfgData.HiddenStory[hiddenStoryIndex])
	else
		local text

		if isUnlock then
			text = EquipUIApi:GetString("goNormalStoryLockDesc", hiddenStoryIndex)
		else
			text = EquipUIApi:GetString("SkinView_LockedHiddenStoryText")
		end

		UGUIUtil.SetTextInChildren(self.DescLockView, text)
	end

	local maxPage = #self.CurrentSkinCfgData.HiddenStory + 1

	self.PrevPageBtn:SetActive(self.DescPage > 1)
	self.NextPageBtn:SetActive(maxPage > self.DescPage)
	UGUIUtil.SetText(self.PageText, EquipUIApi:GetString("SkinView_PageText", self.DescPage, maxPage))
end

function m:OnClickPrevPageBtn()
	self.DescPage = self.DescPage - 1

	if self.DescPage < 1 then
		self.DescPage = 1
	end

	self:RefreshDescPage()
end

function m:OnClickNextPageBtn()
	self.DescPage = self.DescPage + 1

	local maxPage = #self.CurrentSkinCfgData.HiddenStory + 1

	if maxPage < self.DescPage then
		self.DescPage = maxPage
	end

	self:RefreshDescPage()
end

function m:OnClickChangeSkinBtn()
	local state = EquipModule.GetSkinState(self.CurrentSkinCfgData.Id)

	if state == nil then
		return
	end

	local operation

	operation = state == 1 and 0 or 1

	EquipModule.SendChangeSkin(self.CurrentSkinCfgData.Id, operation)
end

function m:OnClickGoBuyBtn()
	JumpModule.Jump(self.CurrentSkinCfgData.Mall)
end

function m:OnEquipSkinChanged(skinCid)
	if skinCid == self.CurrentSkinCfgData.Id then
		self:__Refresh(false)
	end
end

function m:OnDestroy()
	for instanceId, cell in pairs(self.SkinCells) do
		cell:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
