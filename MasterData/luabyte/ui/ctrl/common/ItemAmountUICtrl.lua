local M = BaseClass("ItemAmountUICtrl")

function M:__init(view)
    self._view = view
    self.m_itemId = 0
    self.m_itemTag = 0
    self.m_targetNum = 0
    self.m_itemHandler = Bind(self, self.OnItemChanged)
    self.m_onMarkDone = EventMgr:AddListener(UIMessageNames.JUMP_ITEM_DONE, Bind(self, self.OnMarkDone))
end

function M:OnDispose()
    self:_CloseTimer()
    EventMgr:RemoveListener(UIMessageNames.JUMP_ITEM_DONE, self.m_onMarkDone)
    ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_itemTag)
    self.m_itemId = nil
    self.m_itemTag = nil
    self.m_targetNum = nil
    self.m_onMarkDone = nil
    self.m_itemHandler = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

-- 左边：自有数量， 右边： 目标数量
function M:SetItemInfo(itemId, targetNum)
    self.m_itemId = itemId
    self.m_targetNum = targetNum
    self._view.txt_right:SetText(GameHelper.TransNumClip(self.m_targetNum))
    self._view.itemPfb:SetInfo(self.m_itemId, ItemNumberType.NONE)
    ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_itemTag)
    self:_SetCurItemNum(ItemDataMgr:GetInstance():GetItemNumById(self.m_itemId))
    self.m_itemTag = ItemDataMgr:GetInstance():AddItemChange(self.m_itemId, self.m_itemHandler)
end

-- 目标达成，关闭UI
function M:OnMarkDone()
    ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_itemTag)
    self._view:SetActive(false)
    self.m_targetNum = 0
    self.m_itemTag = 0
    self.m_itemId = 0
end

function M:SetActive(value)
    self._view:SetActive(value)
end

function M:OnItemChanged(_, _, newNum)
    self:_CloseTimer()
    -- 仲谋要求延迟变化
    self.m_timer = TimerManager:GetInstance():GetTimer(1, function()
        self:_SetCurItemNum(newNum)
    end, nil, true)
    self.m_timer:Start()
end

function M:_SetCurItemNum(num)
    self._view.txt_left:SetText(GameHelper.TransNumClip(num))
    -- 1:满足   2:不满足
    self._view.uiState:SetState((num >= self.m_targetNum) and 1 or 2)
end

function M:_CloseTimer()
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
end

return M
