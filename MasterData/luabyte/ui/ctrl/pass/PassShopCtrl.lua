local M = BaseClass("PassShopCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local ShopPackType = PassConst.ShopPackType

function M:Init()
    self.m_fmtStr = ConfigHelper.GetLocalString(5780)
    local handler = Bind(self, self.OnUpdatePassPackInfo)
    self.m_onChangedHandler = EventMgr:AddListener(UIMessageNames.PASS_INFO_CHANGED, handler)
    -- self.tabItemPfbViews = { self._view.ItemPfbView }
end

function M:SetPanelState(value)
    self:SetActive(value)
    if value then self:OnUpdatePassPackInfo() end
end

function M:OnUpdatePassPackInfo()
    local INST = PassDataMgr:GetInstance()
    if not INST:IsPlayShop() then self._view.shopAnim:Play("PassShop", 0, 0) end
    local lastPassShopId = INST:GetLastPassShopId()
    local isPaid = INST:IsPaid()                                   -- 本次是否购买
    local lastPaid = self:_UpGrade(isPaid, lastPassShopId)         -- 本期未购买，上次是否购买
    local upgradesPaid = self:_UpgradePaid(isPaid, lastPassShopId) -- 能否升级
    local normalShop, higherShop
    -- 本期已经购买
    if isPaid then
        local reduced = self:_isReduced(isPaid, lastPassShopId) --是否是折扣礼包(本期已经购买，是否是折扣礼包)
        if upgradesPaid then                                    -- 能升级
            if reduced then
                normalShop = INST:GetShopPackByType(ShopPackType.NormalReduced)
                higherShop = INST:GetShopPackByType(ShopPackType.UpHigher)
            else
                normalShop = INST:GetShopPackByType(ShopPackType.Normal)
                higherShop = INST:GetShopPackByType(ShopPackType.UpNormal)
            end
            normalShop.state = 2 -- 已经购买
            higherShop.state = 1 -- 可购买
        else                     -- 不能升级
            if reduced then
                normalShop = INST:GetShopPackByType(ShopPackType.NormalReduced)
                higherShop = INST:GetShopPackByType(ShopPackType.HigherReduced)
            else
                normalShop = INST:GetShopPackByType(ShopPackType.Normal)
                higherShop = INST:GetShopPackByType(ShopPackType.Higher)
            end
            normalShop.state = 3 -- 已经购买另一个
            higherShop.state = 2 -- 已经购买
        end
    else                         -- 本期未购买
        -- 上期已经购买
        if lastPaid then
            normalShop = INST:GetShopPackByType(ShopPackType.NormalReduced)
            higherShop = INST:GetShopPackByType(ShopPackType.HigherReduced)
        else
            normalShop = INST:GetShopPackByType(ShopPackType.Normal)
            higherShop = INST:GetShopPackByType(ShopPackType.Higher)
        end
        normalShop.state = 1 -- 可购买
        higherShop.state = 1 -- 可购买
    end
    self._view.UIPassShopItemCtrl1:SetShopPackInfo(normalShop)
    self._view.UIPassShopItemCtrl2:SetShopPackInfo(higherShop)
    INST:SetPlayShop(true)

    -- local activityId = INST:GetShopActivityId()
    -- if activityId <= 0 then return end
    -- local passShops = ConfigHelper.GetCfgsByLua("passShop", { activityId = activityId })
    -- if #passShops <= 0 then return end
    -- local itemGroupId = passShops[1].showGetItems
    -- local itemGroup = ConfigHelper.GetCfg("itemGroup", itemGroupId)
    -- if itemGroup then
    --     for i = 1, #itemGroup.items do
    --         local id = itemGroup.items[i]
    --         local ItemPfbView = self.tabItemPfbViews[i]
    --         if not ItemPfbView then
    --             ItemPfbView = self._view.ItemPfbView:Instantiate()
    --             self.tabItemPfbViews[i] = ItemPfbView
    --         end
    --         ItemPfbView:EnablePopItem(true)
    --         ItemPfbView:SetInfo(id, ItemNumberType.TOTLE, itemGroup.cnts[i])
    --         ItemPfbView:SetActive(true)
    --     end
    --     for i = #itemGroup.items + 1, #self.tabItemPfbViews do
    --         self.tabItemPfbViews[i]:SetActive(false)
    --     end
    -- else
    --     Logger.LogError("itemGroup is nil, @熊伟看看, id = " .. itemGroupId)
    -- end
end

-- 上期是否购买
function M:_UpGrade(isPaid, lastPassShopId)
    if isPaid or (lastPassShopId <= 0) then return end

    local order = ConfigHelper.GetCfgPropByLua("passShop", lastPassShopId, "order")
    return order == PassDataMgr:GetInstance():GetCurOrder() - 1
end

-- 能否升级
function M:_UpgradePaid(isPaid, lastPassShopId)
    if not isPaid or (lastPassShopId <= 0) then return end

    local passBagType = ConfigHelper.GetCfgPropByLua("passShop", lastPassShopId, "passBagType")
    return passBagType == ShopPackType.Normal or passBagType == ShopPackType.NormalReduced
end

-- 本期已经购买是否是折扣礼包
function M:_isReduced(isPaid, lastPassShopId)
    if not isPaid or (lastPassShopId <= 0) then return end

    local passBagType = ConfigHelper.GetCfgPropByLua("passShop", lastPassShopId, "passBagType")
    return passBagType == ShopPackType.NormalReduced or passBagType == ShopPackType.HigherReduced or
        passBagType == ShopPackType.UpHigher
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.PASS_INFO_CHANGED, self.m_onChangedHandler)
    -- for _, value in pairs(self.tabItemPfbViews) do value:DoDispose() end
    self.m_onChangedHandler = nil
    -- self.tabItemPfbViews = nil
    M.super.OnDispose(self)
end

return M
