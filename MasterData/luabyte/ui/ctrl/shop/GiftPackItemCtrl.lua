local GiftPackItemCtrl = BaseClass("GiftPackItemCtrl")
local M = GiftPackItemCtrl
local ShopBagType = RechargeConst.ShopBagType
local sfmt = string.format

function M:__init(view)
    self._view = view

    self._view.rectItem:onClick(Bind(self, self.OnItemClick))
    self.items = {}
    for i = 1, 3 do
        local item = require("UI.Ctrl.Common.CommonItemCtrl").New(self._view["item" .. i])
        table.insert(self.items, item)
    end
end

function M:UpdateItem(data, notClick)
    self._notClick = notClick

    if data == nil then
        return
    end

    self._data = data

    if not self._notClick then
        if self._data.type == ShopBagType.FreeLevelPack or
            self._data.type == ShopBagType.DailyPack then
            self._view.redpoint.gameObject:SetActive(true)
            self._view.redpoint:SetParam(0, self._data.shopConfId)
            self._view.redpoint:Check()
        else
            self._view.redpoint.gameObject:SetActive(false)
        end
    end
    self:Update()
end

function M:Update()
    local shopBagCfg = ConfigHelper.GetCfgByLua("shopBag", self._data.shopConfId)
    local itemId = shopBagCfg.itemId
    local item = ConfigHelper.GetCfgByLua("item", itemId)
    if item then
        self._view.labName:SetText(item.name)
        self._view.imgIcon:SetPic(item.icon)
    end
    if shopBagCfg.payId > 0 then
        local paycfg = ConfigHelper.GetCfgByLua("pay", shopBagCfg.payId)
        if paycfg then
            local rmbChar = ConfigHelper.GetLocalString(paycfg.monetaryUnit)
            local price = string.format("%d", paycfg.truePrice / 100)
            -- if string.sub(price, -1) == "0" then
            --     price = string.sub(price, 1, -2)
            -- end
            self._view.labCost:SetText(rmbChar .. price)
        else
            Logger.LogError("注意:shopBag.id=" .. shopBagCfg.id .. ".shopId=" .. shopBagCfg.payId .. " 无法在 pay表中找到")
        end

        self._view.imgCost.gameObject:SetActive(false)
    else
        if shopBagCfg.costItem > 0 then
            self._view.imgCost.gameObject:SetActive(true)
            self._view.imgCost:SetItemIcon(shopBagCfg.costItem)
        else
            self._view.imgCost.gameObject:SetActive(false)
        end

        if shopBagCfg.costItemNum > 0 then
            self._view.labCost:SetText(tostring(shopBagCfg.costItemNum))
        else
            self._view.labCost:SetText(5083)
        end
    end


    -- 等级礼包
    if self._data.type == ShopBagType.FreeLevelPack or self._data.type == ShopBagType.PaidLevelPack then
        local openCondition = ConfigHelper.GetCfgPropByLua("shopBag", self._data.shopConfId, "openCondition")
        local isOpen = GameHelper.CheckLockByOpenConditionIds(openCondition)

        if not isOpen then
            self._view.tfContentCannot.gameObject:SetActive(true)
            local tips = ConfigHelper.GetLocalString(5084)
            local openLevel = ConfigHelper.GetCfgPropByLua("openCondition", openCondition[1], "unlockParam1")
            tips = sfmt(tips, openLevel)
            self._view.labBuyLevel:SetText(tips)
        else
            self._view.tfContentCannot.gameObject:SetActive(false)
        end
    else
        self._view.tfContentCannot.gameObject:SetActive(false)
    end

    if self._data.allNum > 0 and self._data.allNum <= self._data.buyNum then
        -- 不能购买
        self._view.tfNotBuy.gameObject:SetActive(true)
    else
        self._view.tfNotBuy.gameObject:SetActive(false)
    end

    self._view.tfTime.gameObject:SetActive(false)

    if self._data.type == ShopBagType.WeeklyPack then
        -- 周期礼包
        self._view.tfTime.gameObject:SetActive(true)
        local nowTimer = TimeUtil.GetNowTimeStamp()
        local timer = shopBagCfg.endTime - nowTimer
        local dayNum = math.ceil(timer / 86400)
        self._view.labTime:SetText(tostring(dayNum))
    end

    if self._data.type == ShopBagType.MonthlyPack then
        self._view.tfTime.gameObject:SetActive(true)
        if self._data.nextResetTime > 0 then
            local nowTimer = TimeUtil.GetNowTimeStamp()
            local timer = self._data.nextResetTime - nowTimer
            local dayNum = math.ceil(timer / 86400)
            self._view.labTime:SetText(tostring(dayNum))
        else
            local dayNum = TimeUtil.GetRemainDays()
            self._view.labTime:SetText(tostring(dayNum))
        end
    end

    if self._data.type == ShopBagType.FixedPack then
        self._view.tfTime.gameObject:SetActive(true)
        local nowTimer = TimeUtil.GetNowTimeStamp()
        if self._data.nextResetTime > 0 then
            local timer = self._data.nextResetTime - nowTimer
            local dayNum = math.ceil(timer / 86400)
            self._view.labTime:SetText(tostring(dayNum))
        else
            local timer = (shopBagCfg.endTime - nowTimer) % (86400 * shopBagCfg.refreshTime)
            local dayNum = math.ceil(timer / 86400)
            self._view.labTime:SetText(tostring(dayNum))
        end
    end

    if self._data.allNum <= 0 then
        self._view.tfBuyNum:SetActive(false)
    else
        self._view.tfBuyNum:SetActive(true)
        local buyNum = ConfigHelper.GetLocalString(256)
        buyNum = buyNum .. (self._data.allNum - self._data.buyNum)
        self._view.labBuyNum:SetText(buyNum)
    end

    self._view.rectItem.gameObject:SetActive(true)

    if shopBagCfg.label > 0 then
        self._view.Sale:SetActive(true)
        self._view.SaleText:SetText(shopBagCfg.label .. "")
    else
        self._view.Sale:SetActive(false)
    end
    local tempProps = {}
    for _, v in pairs(shopBagCfg.itemGroup) do
        local itemGroup = ConfigHelper.GetCfg("itemGroup", v)
        for k, randomItem in pairs(itemGroup.items) do
            local data = {}
            data.id = randomItem
            data.num = itemGroup.cnts[k]
            table.insert(tempProps, data)
        end
    end
    for i = 1, 3 do
        if tempProps[i] then
            self.items[i]:SetActive(true)
            self.items[i]:SetInfo(tempProps[i].id, ItemNumberType.TOTLE, tempProps[i].num)
        else
            self.items[i]:SetActive(false)
        end
    end
end

function M:OnItemClick()
    if self._notClick then
        return
    end

    if self._data.allNum > 0 and self._data.allNum <= self._data.buyNum then
        return
    end

    UIContextMgr:GetInstance():Show(UIDefine.UIShopPack, self._data)
end

function M:_OnUpdateShop(data)
    if self._notClick then
        return
    end

    self:GetShopDataCallBack(data)
end

function M:Dispose()
    self._view.rectItem:onClick(nil)
    self:OnDispose()
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
    end

    self._view = nil
end

return GiftPackItemCtrl
