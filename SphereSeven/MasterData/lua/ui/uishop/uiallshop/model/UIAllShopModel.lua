---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/12 21:12
---

local UIAllShopModel = BaseClass("UIAllShopModel",UIBaseModel)
local base = UIBaseModel
local this = UIAllShopModel

function this.OnCreate(self)
    base.OnCreate(self)
    self.shop_data = nil
    self.packageIsNeedUpdate = true
end

function this.OnEnable(self, JumpInfo)
    base.OnEnable(self)
    self.JumpInfo = JumpInfo
    self:OnRefresh()
end

function this.OnRefresh(self)
    --self.shop_data = Z_StarStoneStore
end

local function OnPlayerInfoChg(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_PLAYER_INFO_CHG)
end

local function OnDayPurchaseInfoChg(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_DAY_PURCHASE_INFO_CHG)
end

local function OnWeekPurchaseInfoChg(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_WEEK_PURCHASE_INFO_CHG)
end

local function OnMonthPurchaseInfoChg(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_MONTH_PURCHASE_INFO_CHG)
end

local function OnItemInfoChg(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_ITEM_INFO_CHG)
end
local function OnEquipInfoChg(self)
    self:UIBroadcast(UIMessageNames.ON_EQUIP_INFO_CHG)
end

local function OnCardInfoChg(self, info)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_CARD_INFO_CHG, info)
end

local function OnMonthCardInfoChg(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_MONTH_CARD_INFO_CHG)
end

function this.OnAddListener(self)
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_PLAYER_INFO_CHG,OnPlayerInfoChg)
    self:AddDataListener(DataMessageNames.ON_DAY_PURCHASE_INFO_CHG,OnDayPurchaseInfoChg)
    self:AddDataListener(DataMessageNames.ON_WEEK_PURCHASE_INFO_CHG,OnWeekPurchaseInfoChg)
    self:AddDataListener(DataMessageNames.ON_MONTH_PURCHASE_INFO_CHG,OnMonthPurchaseInfoChg)
    self:AddDataListener(DataMessageNames.ON_ITEM_INFO_CHG, OnItemInfoChg)
    self:AddDataListener(DataMessageNames.ON_EQUIP_INFO_CHG,OnEquipInfoChg)
    self:AddDataListener(DataMessageNames.ON_CARD_INFO_CHG,OnCardInfoChg)
    self:AddDataListener(DataMessageNames.ON_MONTH_CARD_INFO_CHG,OnMonthCardInfoChg)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_PLAYER_INFO_CHG)
    self:RemoveDataListener(DataMessageNames.ON_DAY_PURCHASE_INFO_CHG)
    self:RemoveDataListener(DataMessageNames.ON_WEEK_PURCHASE_INFO_CHG)
    self:RemoveDataListener(DataMessageNames.ON_MONTH_PURCHASE_INFO_CHG)
    self:RemoveDataListener(DataMessageNames.ON_ITEM_INFO_CHG)
    self:RemoveDataListener(DataMessageNames.ON_EQUIP_INFO_CHG)
    self:RemoveDataListener(DataMessageNames.ON_MONTH_CARD_INFO_CHG)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    self.shop_data = nil
    base.OnDestroy(self)
end

return this