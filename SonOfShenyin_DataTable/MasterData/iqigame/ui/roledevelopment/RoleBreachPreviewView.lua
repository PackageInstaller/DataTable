-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleBreachPreviewView.lua

local BreachItem = {
	BreakLv = 0
}

function BreachItem.New(view, selectCallback)
	local obj = Clone(BreachItem)

	obj:Init(view, selectCallback)

	return obj
end

function BreachItem:Init(view, selectCallback)
	self.View = view
	self.SelectCallback = selectCallback

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnSelectClick()
		self:OnClickSelectBtn()
	end

	function self.DelegateGetBreakRewardSuccessEvent()
		self:OnGetBreakRewardSuccessEvent()
	end

	self:AddListeners()
end

function BreachItem:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnSelectClick)
	EventDispatcher.AddEventListener(EventID.GetBreakRewardSuccessEvent, self.DelegateGetBreakRewardSuccessEvent)
end

function BreachItem:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnSelectClick)
	EventDispatcher.RemoveEventListener(EventID.GetBreakRewardSuccessEvent, self.DelegateGetBreakRewardSuccessEvent)
end

function BreachItem:SetData(heroCid, breakLv, isBreach)
	self.BreakLv = breakLv
	self.HeroCid = heroCid

	AssetUtil.LoadImage(self, RoleDevelopmentApi:GetPreviewBreachStateImg(self.BreakLv), self.Breached:GetComponent("Image"))
	AssetUtil.LoadImage(self, RoleDevelopmentApi:GetNoPreviewBreachStateImg(self.BreakLv), self.NoBreached:GetComponent("Image"))
	LuaUtility.SetGameObjectShow(self.Breached, isBreach)
	LuaUtility.SetGameObjectShow(self.NoBreached, not isBreach)
	self:RefreshRedDot()
end

function BreachItem:OnClickSelectBtn()
	if self.SelectCallback ~= nil then
		self.SelectCallback(self.BreakLv)
	end
end

function BreachItem:OnGetBreakRewardSuccessEvent()
	self:RefreshRedDot()
end

function BreachItem:RefreshRedDot()
	LuaUtility.SetGameObjectShow(self.View.transform:Find("RedDot").gameObject, RedDotModule.CanShowRedDot_Warlock_BreachRewardByBreachLv(self.HeroCid, self.BreakLv))
end

function BreachItem:Select()
	LuaUtility.SetGameObjectShow(self.SelectImage, true)
end

function BreachItem:UnSelect()
	LuaUtility.SetGameObjectShow(self.SelectImage, false)
end

function BreachItem:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function BreachItem:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function BreachItem:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local RoleBreachMaterialsItem = require("IQIGame.UI.RoleDevelopment.RoleBreachMaterialsItem")
local m = {
	CurNeedMoney = 0,
	CurBreakLv = 0,
	BreachItemList = {},
	materialItems = {}
}

m.BreachItemView = BreachItem

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickLeftBtn()
		self:OnClickLeftBtn()
	end

	function self.DelegateOnClickRightBtn()
		self:OnClickRightBtn()
	end

	function self.DelegateOnClickGetRewardBtn()
		self:OnClickGetRewardBtn()
	end

	function self.DelegateGetBreakRewardSuccessEvent()
		self:OnGetBreakRewardSuccessEvent()
	end

	for i = 1, 6 do
		table.insert(self.BreachItemList, self.BreachItemView.New(self["BreachItem" .. i], function(breakLv)
			self:SelectBreachItemCallback(breakLv)
		end))
	end

	self.consumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)

	self.consumeGoldCell:InitIconImg(Constant.ItemCid.GOLD)

	self.BreachRewardItem = ItemCell.New(self.BreachRewardItem, true, true)
	self.LeftBtnCom = self.LeftBtn:GetComponent("Button")
	self.RightBtnCom = self.RightBtn:GetComponent("Button")
	self.MiddleBreachItemView = {}

	LuaCodeInterface.BindOutlet(self.SelectBreachItem, self.MiddleBreachItemView)
	self:AddListeners()
end

function m:AddListeners()
	self.LeftBtnCom.onClick:AddListener(self.DelegateOnClickLeftBtn)
	self.RightBtnCom.onClick:AddListener(self.DelegateOnClickRightBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.GetRewardButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGetRewardBtn)
	EventDispatcher.AddEventListener(EventID.GetBreakRewardSuccessEvent, self.DelegateGetBreakRewardSuccessEvent)
end

function m:RemoveListeners()
	self.LeftBtnCom.onClick:RemoveListener(self.DelegateOnClickLeftBtn)
	self.RightBtnCom.onClick:RemoveListener(self.DelegateOnClickRightBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.GetRewardButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGetRewardBtn)
	EventDispatcher.RemoveEventListener(EventID.GetBreakRewardSuccessEvent, self.DelegateGetBreakRewardSuccessEvent)
end

function m:SetData(heroId)
	self.HeroData = WarlockModule.WarlockDataDic[heroId]

	for i = 1, #self.BreachItemList do
		if i > self.HeroData:GetCfg().MaxBreakLv then
			self.BreachItemList[i]:Hide()
		else
			self.BreachItemList[i]:Show()
			self.BreachItemList[i]:SetData(self.HeroData.cid, i, i <= self.HeroData.breakLv)
		end
	end

	local normalBreakLv = self.HeroData.breakLv > self.HeroData:GetCfg().MaxBreakLv and self.HeroData:GetCfg().MaxBreakLv or self.HeroData.breakLv

	if normalBreakLv == 0 then
		normalBreakLv = 1
	end

	self:SelectBreachItemCallback(normalBreakLv)
end

function m:SelectBreachItemCallback(breakLv)
	self.CurBreakLv = breakLv

	for k, v in pairs(self.BreachItemList) do
		if k ~= breakLv then
			v:UnSelect()
		else
			v:Select()
		end
	end

	self:RefreshCurBreachInfo(breakLv)
	self:UpdateLeftAndRightBtnState()
end

function m:RefreshCurBreachInfo(breakLv)
	AssetUtil.LoadImage(self, RoleDevelopmentApi:GetBreachStateImg(breakLv), self.MiddleBreachItemView.BreachImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, RoleDevelopmentApi:GetBreachFontImg(breakLv), self.MiddleBreachItemView.BreachImageFont:GetComponent("Image"))
	LuaUtility.SetGameObjectShow(self.MiddleBreachItemView.Breached, breakLv <= self.HeroData.breakLv)
	LuaUtility.SetGameObjectShow(self.MiddleBreachItemView.NoBreached, not (breakLv <= self.HeroData.breakLv))

	self.HeroBreakCfg = self.HeroData:QueryHeroBreachCfg(breakLv - 1 < 0 and 0 or breakLv - 1)

	local items = self.HeroBreakCfg.Cost

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

	self.hasReward = false

	local heroCurBreakCfg = self.HeroData:QueryHeroBreachCfg(breakLv)

	if table.len(heroCurBreakCfg.BreakAward) <= 0 then
		LuaUtility.SetGameObjectShow(self.RewardParent, false)
	else
		LuaUtility.SetGameObjectShow(self.RewardParent, true)

		self.hasReward = true

		self.BreachRewardItem:SetItemByCid(heroCurBreakCfg.BreakAward[1], heroCurBreakCfg.BreakAward[2])
		self.BreachRewardItem:SetNum(heroCurBreakCfg.BreakAward[2])
	end

	self:UpdateGetRewardState()
	UGUIUtil.SetText(self.BreachLvText, heroCurBreakCfg.MaxHeroLv)
	LuaUtility.SetGameObjectShow(self.Breached, breakLv <= self.HeroData.breakLv)
	LuaUtility.SetGameObjectShow(self.NoBreach, not (breakLv <= self.HeroData.breakLv))
end

function m:UpdateGetRewardState()
	LuaUtility.SetGameObjectShow(self.GetRewardButton, not self.HeroData:GetBreakRewardIsReceived(self.CurBreakLv) and self.HeroData.breakLv >= self.CurBreakLv and self.hasReward == true)
	LuaUtility.SetGameObjectShow(self.ReceivedParent, self.HeroData:GetBreakRewardIsReceived(self.CurBreakLv))
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

function m:OnClickLeftBtn()
	if self.CurBreakLv <= 1 then
		return
	end

	self.CurBreakLv = self.CurBreakLv - 1

	self:SelectBreachItemCallback(self.CurBreakLv)
end

function m:OnClickRightBtn()
	if self.CurBreakLv >= self.HeroData:GetCfg().MaxBreakLv then
		return
	end

	self.CurBreakLv = self.CurBreakLv + 1

	self:SelectBreachItemCallback(self.CurBreakLv)
end

function m:UpdateLeftAndRightBtnState()
	self.LeftBtnCom.interactable = self.CurBreakLv > 1
	self.RightBtnCom.interactable = self.CurBreakLv < self.HeroData:GetCfg().MaxBreakLv
end

function m:OnClickGetRewardBtn()
	RoleDevelopmentModule.GetBreakReward(self.HeroData.cid, self.CurBreakLv)
end

function m:OnGetBreakRewardSuccessEvent()
	self:UpdateGetRewardState()
end

function m:OnClickCloseBtn()
	self:Hide()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.consumeGoldCell:Dispose()

	for k, v in pairs(self.BreachItemList) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.SelectBreachItem, self.MiddleBreachItemView)

	self.MiddleBreachItemView = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
