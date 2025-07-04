---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/12 21:12
---

---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/12 21:12
---

---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/12 21:12
---

local UIGeneralShopModel = BaseClass("UIGeneralShopModel",UIBaseModel)
local base = UIBaseModel
local this = UIGeneralShopModel

function this.OnCreate(self)
    base.OnCreate(self)
end

function this.OnEnable(self,data)
    base.OnEnable(self)
    self.data = data
    if data then
        self.modeType = data.type
    else
        self.modeType = nil
    end
    self:OnRefresh(data)
end

function this.OnRefresh(self,data)

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

function this.OnAddListener(self)
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_PLAYER_INFO_CHG,OnPlayerInfoChg)
    self:AddDataListener(DataMessageNames.ON_DAY_PURCHASE_INFO_CHG,OnDayPurchaseInfoChg)
    self:AddDataListener(DataMessageNames.ON_WEEK_PURCHASE_INFO_CHG,OnWeekPurchaseInfoChg)
    self:AddDataListener(DataMessageNames.ON_MONTH_PURCHASE_INFO_CHG,OnMonthPurchaseInfoChg)
    self:AddDataListener(DataMessageNames.ON_ITEM_INFO_CHG, OnItemInfoChg)
    self:AddDataListener(DataMessageNames.ON_EQUIP_INFO_CHG,OnEquipInfoChg)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_PLAYER_INFO_CHG)
    self:RemoveDataListener(DataMessageNames.ON_DAY_PURCHASE_INFO_CHG)
    self:RemoveDataListener(DataMessageNames.ON_WEEK_PURCHASE_INFO_CHG)
    self:RemoveDataListener(DataMessageNames.ON_MONTH_PURCHASE_INFO_CHG)
    self:RemoveDataListener(DataMessageNames.ON_ITEM_INFO_CHG)
    self:RemoveDataListener(DataMessageNames.ON_EQUIP_INFO_CHG)
end

function this.OnDisable(self)
    self.paid_num = nil
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end

return this

