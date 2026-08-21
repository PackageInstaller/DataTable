local M = BaseClass("PassItemGroupCtrl")
local PassMgr = PassDataMgr:GetInstance()
local RewardType = PassConst.RewardType
local itemCtrl = require("UI.Ctrl.Pass.PassRewardGroupItemCtrl")

function M:__init(view)
    self._view = view
    self.m_passId = 0
    self.m_getCallback = nil
    self.m_rewardType = RewardType.None
    self.m_itemlist = { self._view.itemPfb }
end

function M:OnDispose()
    for _, item in ipairs(self.m_itemlist) do item:DoDispose() end
    if self._view then self._view:OnDispose() end
    self._view = nil
    self.m_passId = nil
    self.m_itemlist = nil
    self.m_rewardType = nil
    self.m_getCallback = nil
end

function M:UpdateItem(data)
    if data == nil then return end

    self.m_passId = data.id
    self._view.txt_passLv:SetText(tostring(data.passLevel))
    self:_SetItems(data)
end

function M:_SetItems(data)
    local level = data.passLevel
    local numType = ItemNumberType.TOTLE
    local handler = Bind(self, self.OnClickGetReward)
    local lockItem, idx = PassMgr:GetPassLevel() < level, 1

    --设置免费items
    local isGetFree = PassMgr:IsGetFreeReward(level)
    for _, value in ipairs(self:_GetItems(data.freeReward)) do
        local itemPfb = self:_GetItemPfb(idx)
        itemPfb:SetInfo(value.id, numType, value.num)
        itemPfb:Select(isGetFree)
        itemPfb:SetLock(lockItem)
        if isGetFree or lockItem then --已领取或是lockItem的items
            itemPfb:SetClickCallback(nil)
            itemPfb:SetRedPoint(0, -1)
            itemPfb:EnablePopItem(true)
        else --可领取items
            itemPfb:SetClickCallback(handler)
            itemPfb:EnablePopItem(false)
            itemPfb:SetRedPoint(0, level)
        end
        itemPfb:RedPointCheck()
        idx = idx + 1
    end

    --设置付费items
    local isPaid = PassMgr:IsPaid()
    local isLock = lockItem or not isPaid
    local isGetPaid = PassMgr:IsGetPaidReward(level)
    for _, value in ipairs(self:_GetItems(data.payReward)) do
        local itemPfb = self:_GetItemPfb(idx)
        itemPfb:SetInfo(value.id, numType, value.num)
        itemPfb:Select(isGetPaid)
        itemPfb:SetLock(isLock)
        if isGetPaid or isLock then --已领取或是lockItem的或是未开通付费的items
            itemPfb:SetClickCallback(nil)
            itemPfb:SetRedPoint(0, -1)
            itemPfb:EnablePopItem(true)
        else --可领取items
            itemPfb:SetClickCallback(handler)
            itemPfb:EnablePopItem(false)
            itemPfb:SetRedPoint(0, level)
        end
        itemPfb:RedPointCheck()
        idx = idx + 1
    end

    for i = idx, #self.m_itemlist, 1 do
        self.m_itemlist[i]:SetActive(false)
    end

    local isFreeType = not isGetFree and not lockItem
    local isPaidType = not isGetPaid and not isLock
    if isFreeType and isPaidType then
        self.m_rewardType = RewardType.All
    elseif isPaidType then
        self.m_rewardType = RewardType.Paid
    elseif isFreeType then
        self.m_rewardType = RewardType.Free
    else
        self.m_rewardType = RewardType.None
    end
end

function M:_GetItems(itemGroupId)
    local items = {}
    local itemGroupCfg = ConfigHelper.GetCfg("itemGroup", itemGroupId)
    if itemGroupCfg then
        for i, id in ipairs(itemGroupCfg.items) do
            local num = itemGroupCfg.cnts[i]
            local item = { id = id, num = num }
            table.insert(items, item)
        end
    else
        Logger.LogError("itemGroup is nil. id = " .. itemGroupId)
    end
    return items
end

function M:_GetItemPfb(idx)
    local item = self.m_itemlist[idx]
    if not item then
        -- item = self._view.itemPfb:Instantiate()
        item = itemCtrl.New(self._view.itemPfb:Instantiate())
        table.insert(self.m_itemlist, item)
    end
    item:SetActive(true)
    item:RefreshRedPoint()
    return item
end

function M:SetGetRewardCallback(callback)
    self.m_getCallback = callback
end

function M:OnClickGetReward(_)
    if self.m_rewardType == RewardType.None then return end
    local activityId = PassMgr:GetActivityId()
    ActivityDataMgr:GetInstance():SendCommonReward(
        activityId,
        { self.m_passId },
        self.m_getCallback,
        { self.m_rewardType }
    )
end

return M
