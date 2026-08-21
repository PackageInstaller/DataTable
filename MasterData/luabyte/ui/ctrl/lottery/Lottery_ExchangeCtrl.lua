local M = BaseClass("Lottery_ExchangeCtrl", BaseUICtrl)

function M:Init()
    self._view.enterBtn:SetOnClick(self, self.ClickEnter)
    self._view.cancelBtn:SetOnClick(self, self.ClickCancel)
    self._view.bg:SetOnClick(self, self.ClickCancel)
end

function M:OnEnter(mtipstr, items,cfg, callback)
    --策划需求 倒序展示
    local temItem = {}
    local length = #items
    for i = 1, length do
        temItem[i] = items[length - i + 1]
    end
    self.callback = callback
    for i = 1, 3 do
        local item = self._view["Item" .. i]
        if i <= #temItem then
            item:SetData(temItem[i])
        else
            item:SetData(nil)
        end
    end
    local hasNumber = ItemDataMgr:GetInstance():GetItemNumById(6) --*4石
    self._view.goldNum:SetText(tostring(hasNumber))

    --底部提示
    local language = mtipstr
    --拼接提示需要的货币的字符串
    local tipstr = " "
    for i = 1, #temItem do
        local itemcfg = ConfigHelper.GetCfg("item", temItem[i].Id)
        local itemName = ConfigHelper.GetLocalString(itemcfg.name)
        if i > 1 then
            tipstr = tipstr .. "、"
        end
        tipstr = tipstr .. itemName .. " x " .. temItem[i].Cnt .. " "
    end
    tipstr = string.replace(language, "{0}", tipstr)
    self._view.tipStr:SetText(tostring(tipstr))

    --刷新顶部
    local itemIds = self:GetLotterNeedItemId(cfg)
    for i=1 , 4 do
        if i > #itemIds then
        self._view["topCurrency"..i].gameObject:SetActive(false)
        else
        self._view["topCurrency"..i].gameObject:SetActive(true)
        self._view["topCurrency"..i]:Action(itemIds[i],-1)
        end
    end
    
end

--点击设置退出键【关闭带顶栏的popup窗口】
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:ClickEnter(go)
    if self.callback ~= nil then
        self.callback(true)
    end
    self:Close()
end

function M:ClickCancel(go)
    if self.callback ~= nil then
        self.callback(false)
    end
    self:Close()
end

function M:GetLotterNeedItemId(cfg)
    local allItemIds = {}
    local onceItem = LotteryHelper.GetCostItems(cfg.id,true)
    local tenItem = LotteryHelper.GetCostItems(cfg.id,false)
    for _,v in pairs(onceItem) do
        if not table.indexof(allItemIds,v.id) then
            table.insert(allItemIds,v.id)
        end
    end

    for _,v in pairs(tenItem) do
        if not table.indexof(allItemIds,v.id) then
            table.insert(allItemIds,v.id)
        end
    end

    return allItemIds
end

return M
