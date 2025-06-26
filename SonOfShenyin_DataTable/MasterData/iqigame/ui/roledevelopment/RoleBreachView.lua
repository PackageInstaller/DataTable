-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleBreachView.lua

local m = {
	CurNeedMoney = 0,
	CurNeedBreachItem = {},
	heroData = {},
	AttrsTable = {},
	AttrItemCellList = {},
	materialItems = {}
}
local roleBreachAttrItem = require("IQIGame.UI.RoleDevelopment.RoleBreachAttrItem")
local RoleBreachMaterialsItem = require("IQIGame.UI.RoleDevelopment.RoleBreachMaterialsItem")

function m.New(view, fatherView)
	local obj = Clone(m)

	obj:Init(view, fatherView)

	return obj
end

function m:Init(view, fatherView)
	self.View = view
	self.fatherView = fatherView

	LuaCodeInterface.BindOutlet(self.View, self)
	LuaCodeInterface.BindOutlet(self.BreachInfoView, self)

	function self.DelegateBreachBtnClick()
		self:BreachBtnClick()
	end

	function self.DelegateBreachSucessCallback()
		self:RoleBreachSucessCallBack()
	end

	function self.DelegateUpdateItem()
		self:UpdateItem()
	end

	self.consumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)

	self.consumeGoldCell:InitIconImg(Constant.ItemCid.GOLD)

	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)

	self.moneyCell:RefreshItem(Constant.TopMoneyType.RoleBreachUI)
	UGUIUtil.SetTextInChildren(self.BreachBtn, RoleDevelopmentApi:GetBreachBtnTitle())
	self:AddListeners()
end

function m:AddListeners()
	self.BreachBtn:GetComponent("Button").onClick:AddListener(self.DelegateBreachBtnClick)
	EventDispatcher.AddEventListener(EventID.RoleBreakThroughSucess, self.DelegateBreachSucessCallback)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function m:RemoveListeners()
	self.BreachBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBreachBtnClick)
	EventDispatcher.RemoveEventListener(EventID.RoleBreakThroughSucess, self.DelegateBreachSucessCallback)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function m:SetData(heroCid, isPreview)
	self.heroCid = heroCid
	self.isPreview = isPreview
	self.CurNeedMoney = 0

	self.consumeGoldCell:SetData(self.CurNeedMoney)
	self:SetRoleInfo()
	self:ShowRoleBreachItems()
	self:SetRoleBreachState()
	self:ShowRoleAttr()
end

function m:Show()
	self.BreachBtn:GetComponent("Button").interactable = true

	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:OnRenderItemRowItem(cell)
	local ItemData = self.CurNeedBreachItem[cell.index + 1]
	local item = RoleBreachMaterialsItem.New(cell.gameObject)

	item:SetData(ItemData)
end

function m:SetRoleInfo()
	self.heroData = WarlockModule.WarlockDataDic[self.heroCid]
	self.MaxHeroLv = self.heroData:GetCurMaxLv()
	self.CacheHeroData = Clone(self.heroData)

	local conditionId = self.heroData:GetCurHeroBreachCfg(self.heroData.breakLv).Condition

	self.checkResult = ConditionModule.Check(conditionId)

	if self.checkResult then
		LuaUtility.SetGameObjectShow(self.conditionRoot, false)
	else
		UGUIUtil.SetText(self.conditionText, CfgConditionTable[conditionId].Name)
		LuaUtility.SetGameObjectShow(self.conditionRoot, true)
	end

	self:IsPreview(self.isPreview)
end

function m:SetRoleBreachState()
	self:LoadImage(RoleDevelopmentApi:GetBreachStateImg(self.heroData.breakLv), self.CurBreachImg:GetComponent("Image"))
	self:LoadImage(RoleDevelopmentApi:GetBreachFontImg(self.heroData.breakLv), self.CurBreachFont:GetComponent("Image"))

	if self.heroData:IsMaxBreachLv() then
		self.NextBreachParent:SetActive(false)
		self.NextArrow:SetActive(false)
		self.ScrollViewGroup.gameObject:SetActive(false)
		self:IsPreview(true)

		return
	else
		self.ScrollViewGroup.gameObject:SetActive(true)
	end

	self:LoadImage(RoleDevelopmentApi:GetNextBreachStateImg(self.heroData.breakLv + 1), self.NextBreachImg:GetComponent("Image"))
	self:LoadImage(RoleDevelopmentApi:GetNextBreachFontImg(self.heroData.breakLv + 1), self.NextBreachFont:GetComponent("Image"))
end

function m:LoadImage(path, imgobj)
	AssetUtil.LoadImage(self, path, imgobj, self.LoadImageSucess, nil, imgobj)
end

function m:LoadImageSucess(assetName, asset, duration, userData)
	userData:SetNativeSize()
end

function m:ShowRoleBreachItems()
	if self.heroData:IsMaxBreachLv() then
		return
	end

	local items = self.heroData:QueryHeroBreachCfg().Cost

	self.CurNeedBreachItem = {}

	for i = 1, #items, 2 do
		if items[i] == Constant.ItemCid.GOLD then
			self.CurNeedMoney = items[i + 1]
		else
			table.insert(self.CurNeedBreachItem, {
				ID = items[i],
				Num = items[i + 1]
			})
		end
	end

	self:RefreshNeedMaterials()
	self.consumeGoldCell:SetData(self.CurNeedMoney)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Com_ConsumeGold.transform)
end

function m:RefreshNeedMaterials()
	local items = self.CurNeedBreachItem

	for i = 1, #items do
		local ItemObj = self:CreateItems(i)

		ItemObj:SetData(self.CurNeedBreachItem[i])
	end

	for i = 1, #self.materialItems do
		if i <= #items then
			self.materialItems[i]:Show()
		else
			self.materialItems[i]:Hide()
		end
	end
end

function m:IsEnough()
	for i = 1, #self.CurNeedBreachItem do
		local needMaterialData = self.CurNeedBreachItem[i]

		if WarehouseModule.GetItemNumByCfgID(needMaterialData.ID) < needMaterialData.Num then
			return false
		end
	end

	return true
end

function m:CreateItems(index)
	local ItemMaterial = self.materialItems[index]

	if ItemMaterial == nil then
		local ItemObj = UnityEngine.GameObject.Instantiate(self.MaterialItem)

		ItemObj.transform:SetParent(self.ItemsGrid.transform, false)

		local materialLuaTable = RoleBreachMaterialsItem.New(ItemObj)

		self.materialItems[index] = materialLuaTable
		ItemMaterial = self.materialItems[index]
	end

	return ItemMaterial
end

function m:IsPreview(type)
	self.BreachBtn:SetActive(not type)
	self.Com_ConsumeGold.gameObject:SetActive(not type)
end

function m:BreachBtnClick()
	if not self.checkResult then
		NoticeModule.ShowNotice(12029)

		return
	end

	if self.CurNeedMoney > WarehouseModule.GetPlayerGoldNum() then
		NoticeModule.ShowCurrencyNotEnoughTips(Constant.ItemCid.GOLD)

		return
	end

	if not self.heroData:IsCanBreach() then
		NoticeModule.ShowNotice(11014)

		return
	end

	if not self:IsEnough() then
		NoticeModule.ShowNotice(20003)

		return
	end

	self.BreachBtn:GetComponent("Button").interactable = false

	local hreoid = self.heroData.warlockCid

	RoleDevelopmentModule.RoleBreach(hreoid)
end

function m:RoleBreachSucessCallBack()
	UIModule.Open(Constant.UIControllerName.RoleBreachSucessUI, Constant.UILayer.UI, self.CacheHeroData)

	self.BreachBtn:GetComponent("Button").interactable = true
	self.timer = Timer.New(function()
		self.fatherView:OpenUpgradeView()

		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end
	end, 2, 1)

	self.timer:Start()
end

function m:ShowRoleAttr()
	self.curAttrData = self.heroData:QueryHeroBreachCfg(self.heroData.breakLv)
	self.nextAttrData = self.heroData:QueryHeroBreachCfg(self.heroData.breakLv + 1)

	UGUIUtil.SetText(self.CurLvText, self.heroData.lv .. "/")
	UGUIUtil.SetText(self.NextLvText, self.heroData.lv .. "/")
	UGUIUtil.SetText(self.CurLvAttrText, self.curAttrData.MaxHeroLv)

	if not self.heroData:IsMaxBreachLv() then
		UGUIUtil.SetText(self.NextLvAttrText, self.nextAttrData.MaxHeroLv)
	end

	self:RefreshAttr()
end

function m:RefreshAttr()
	local lastAttrData

	lastAttrData = (self.heroData.breakLv ~= 0 or nil) and self.heroData:QueryHeroBreachCfg(self.heroData.breakLv - 1)

	local attrLength = 0

	for i = 1, #self.nextAttrData.AttrType do
		if self.nextAttrData.AttrType[i] ~= 0 and CfgAttributeTable[self.nextAttrData.AttrType[i]] ~= nil and CfgAttributeTable[self.nextAttrData.AttrType[i]].Show and RoleDevelopmentModule.PreviewHeroData.attr[i] ~= 0 then
			attrLength = attrLength + 1

			if self.AttrItemCellList[attrLength] == nil then
				local attrItem = UnityEngine.Object.Instantiate(self.AttributeItem)

				attrItem.transform:SetParent(self.AttributeGrid.transform, false)

				self.AttrItemCellList[attrLength] = roleBreachAttrItem.New(attrItem)
			end

			self.AttrItemCellList[attrLength]:SetData(self.heroData, self.curAttrData, self.nextAttrData, i, lastAttrData)
		end
	end

	for i = 1, #self.AttrItemCellList do
		if attrLength < i then
			self.AttrItemCellList[i]:Hide()
		else
			self.AttrItemCellList[i]:Show()
		end
	end
end

function m:UpdateItem()
	self:RefreshNeedMaterials()
end

function m:Dispose()
	self:RemoveListeners()

	for i = 1, #self.AttrItemCellList do
		self.AttrItemCellList[i]:Dispose()
	end

	for i = 1, #self.materialItems do
		self.materialItems[i]:Dispose()
	end

	self.consumeGoldCell:Dispose()

	self.consumeGoldCell = nil

	self.moneyCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.BreachInfoView, self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
