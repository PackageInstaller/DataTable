local M = BaseClass("PassRewardUICtrl", require("UI.Ctrl.Common.BaseSubCtrl"))

function M:Init()
    local ctrl = require("UI.Ctrl.Pass.PassItemGroupCtrl")
    local view = require("UI.View.Pass.PassItemGroupView")
    self.m_maxIndex = 0
    self.m_isPaid = true -- 是否购买礼包
    self.m_callback = nil
    self.m_passGroups = nil
    self.m_hasReward = false -- 是否可以一键领取
    self._view.looplist:Init(ctrl, view)
    self.m_getHandler = Bind(self, self.OnGetRewardCallback)
    self.m_curIndex = PassDataMgr:GetInstance():FirstUnGetPassLevel()
    self._view.btn_quickGet:onClick(Bind(self, self.OnClickQuickGet))
    self._view.btn_quickShop:onClick(Bind(self, self.OnClickQuickShop))
    self._view.btn_quickShop:onClick(Bind(self, self.OnClickQuickShop))
    self._view.looplist:SetDragCallback(Bind(self, self.OnRewardDrag))
    self._view.looplist:ScrollCallback(Bind(self, self._UpdateRewardStage))
    self._view.looplist:SetCreateItemCallback(Bind(self, self.OnCreateItem))
end

function M:OnDispose()
    self.m_isPaid = nil
    self.m_maxIndex = nil
    self.m_curIndex = nil
    self.m_callback = nil
    self.m_hasReward = nil
    self.m_getHandler = nil
    self.m_passGroups = nil
    M.super.OnDispose(self)
end

function M:OnCreateItem(ctrl)
    ctrl:SetGetRewardCallback(self.m_getHandler)
end

-- 一键领取
function M:OnClickQuickGet(go)
    if not self.m_hasReward then return end

    PassDataMgr:GetInstance():QuickGetPassLevelRewards(self.m_getHandler)
end

function M:OnGetRewardCallback(item)
    self:_UpdateLevelItems()
    self:_UpdateRewardStage()
    self:_UpdateQuickGetReward()
    GameHelper.ShowGetItems(item)
    IRedPointMgr:ForceCheck(RedPointConst.PassCardRewardRedPointChecker)
end

-- 快速跳转通行证商店
function M:OnClickQuickShop(go)
    if self.m_isPaid then return end
    if self.m_callback then self.m_callback() end
end

function M:OnRewardDrag(index)
    if index == self.m_curIndex then return end

    self.m_curIndex = index
    -- self:_UpdateRewardStage()
end

function M:SetPanelState(value)
    self:SetActive(value)
    if value then
        self:_UpdatePaidState()
        self:_UpdateLevelItems()
        self:_UpdateRewardStage()
        self:_UpdateQuickGetReward()
    end
end

function M:SetQuickShopCallback(callback)
    self.m_callback = callback
end

function M:_UpdateRewardStage()
    local curIndex = self._view.looplist:GetCurItemIndex("PassItemGroup", 1)
    local data = PassDataMgr:GetInstance():GetShowRewardByLevel(curIndex)
    if data then self._view.stageReward:UpdateItem(data) end
end

function M:_UpdateLevelItems()
    if not self.m_passGroups then
        self.m_passGroups = PassDataMgr:GetInstance():GetPassGroups()
        self.m_maxIndex = #self.m_passGroups - PassConst.RewardShowNum
        self._view.looplist:SetDataList(self.m_passGroups)
        self:_MovePanelToItemIndex()
    else
        self._view.looplist:UpdateList(self.m_passGroups)
    end
end

function M:_UpdatePaidState()
    self.m_isPaid = PassDataMgr:GetInstance():IsPaid()
    self._view.quickShopLock:SetActive(not self.m_isPaid)
end

function M:_UpdateQuickGetReward()
    self.m_hasReward = PassDataMgr:GetInstance():IsPassLevelReward()
    self._view.quickGetLock:SetActive(not self.m_hasReward)
end

function M:_MovePanelToItemIndex()
    if self.m_curIndex > self.m_maxIndex then
        self._view.looplist:MovePanelToItemIndex(self.m_maxIndex - 1)
    else
        self._view.looplist:MovePanelToItemIndex(self.m_curIndex - 1)
    end
end

return M
