local M = BaseClass("BagItemCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))
local ONEDAYM = 86400

function M:Init()
    self.m_data = nil
    self.m_timer = nil
    self:SetRedPoint(true)
    self:SetClickCallback(Bind(self, self._ClickItem))
    self.m_timeHandler = Bind(self, self.OnTimerCallback)
end

function M:OnDispose()
    if self.m_timer then self.m_timer:Stop() end
    self.m_timer = nil
    self.m_data = nil
    M.super.OnDispose(self)
end

function M:_ClickItem(go)
    local itemData = self.m_data.data
    local keyName = "itemRedPoint" .. tostring(itemData.PackageId) .. tostring(itemData.Id)
    GameHelper.SetPlayerPrefsInt(keyName, itemData.Num)
    self:RedPointCheck()
    IRedPointMgr:ForceCheck(RedPointConst.BagItemTypeRedPointChecker)
    EventMgr:Broadcast(UIMessageNames.BAG_SELECT_ITEM, itemData)
end

function M:UpdateItem(data)
    if data == nil then
        if self.m_timer then self.m_timer:Stop() end
        self.m_timer = nil
        self.m_data = nil
        return
    end

    local itemData = data.data
    -- 数据不同 刷新
    if self.m_data ~= data then
        self.m_data = data

        if itemData.Num > 0 then
            self._view.node_alpha:SetAlpha(1)
        else
            self._view.node_alpha:SetAlpha(0.6)
        end

        self:SetInfo(itemData.Id, ItemNumberType.TOTLE, itemData.Num)
        self:_ShowExpireTime()

        self:SetRedPointParam(0, itemData.Id)
        self:RedPointCheck()
    end

    local itemCfg = itemData:GetItemCfg()
    local state = self.m_isDecompose()
    if state then
        -- 分解模式
        local decompose = itemCfg.decompose == 1
        self._view.node_mask:SetAlpha(0.6)
        self._view.node_mask:SetActive(not decompose)
    else
        self._view.node_mask:SetActive(false)
    end

    if self:IsEqualRedPointParam(0, -99) then
        self:SetRedPointParam(0, itemData.Id)
        self:RedPointCheck()
    end

    self:SetSelect(self.m_isSelect(itemData.Id, itemData.PackageId))
end

function M:_ShowExpireTime()
    if self.m_timer then self.m_timer:Stop() end
    self.m_timer = nil
    local itemData = self.m_data.data
    if itemData.ExpireTime > 0 then
        local curTime = TimeUtil.GetNowTimeStamp()
        local remainTime = itemData.ExpireTime - curTime
        local days = 0
        if remainTime > 0 then
            days = math.modf(remainTime / ONEDAYM)
            self.m_timer = TimerManager:GetInstance():GetTimer(remainTime, self.m_timeHandler, self, true, nil, true)
            self.m_timer:Start()
        end
        self._view.tfTimer1:SetActive(days > 0)
        self._view.tfTimer2:SetActive(days <= 0)
        self._view.tfTimer:SetActive(true)
    else
        self._view.tfTimer:SetActive(false)
    end
end

function M:GetItemData()
    if self.m_data then
        return self.m_data.data
    end
    return nil
end

function M:SetSelect(value)
    self.m_data.isSelect = value
    self:Select(self.m_data.isSelect)
end

function M:OnTimerCallback()
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
    ItemHelper.RefreshBag()
end

function M:SetCallBack(action, action2)
    self.m_isSelect = action
    self.m_isDecompose = action2
end

return M
