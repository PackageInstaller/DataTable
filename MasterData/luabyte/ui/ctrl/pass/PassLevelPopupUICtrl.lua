local M = BaseClass("PassLevelPopupUICtrl", BaseUICtrl)

function M:Init()
    self.m_itemNum     = 0
    self.m_curBuyLevel = 1
    self.m_buyParams   = GameHelper.GetParamters(241)
    self.m_fmtStr      = ConfigHelper.GetLocalString(5074)
    self.m_maxLevel    = PassDataMgr:GetInstance():GetMaxLevel()
    self.m_curLevel    = PassDataMgr:GetInstance():GetPassLevel()
    self.m_isMaxLevel  = self.m_curLevel >= self.m_maxLevel
    self.m_costItemId  = self.m_buyParams[0]
    self.m_costItemNum = self.m_buyParams[1]
    local itemCtrl     = require("UI.Ctrl.Pass.PassItemCtrl")
    local itemView     = require("UI.View.Pass.PassItemView")

    self._view.itemloop:Init(itemCtrl, itemView)
    self._view.btm_mask:onClick(Bind(self, self.Close))
    self._view.btn_cancel:onClick(Bind(self, self.Close))
    self._view.btn_buy:onClick(Bind(self, self.OnClickBuyLevel))
    self._view.numSlider:SetChangedCallback(Bind(self, self.OnNumChanged))
end

function M:OnDispose()
    self.m_fmtStr      = nil
    self.m_itemNum     = nil
    self.m_curLevel    = nil
    self.m_maxLevel    = nil
    self.m_buyParams   = nil
    self.m_isMaxLevel  = nil
    self.m_costItemId  = nil
    self.m_costItemNum = nil
    self.m_curBuyLevel = nil

    M.super.OnDispose(self)
end

function M:OnEnter()
    self._view.btn_buy:SetActive(not self.m_isMaxLevel)
    local maxBuyLevel = math.max(0, self.m_maxLevel - self.m_curLevel)
    self._view.numSlider:SetSliderInfo(self.m_curBuyLevel, maxBuyLevel)
    self.m_itemNum = ItemDataMgr:GetInstance():GetItemNumById(self.m_costItemId)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true 
end

function M:OnNumChanged(num)
    self.m_curBuyLevel = num
    local costNum = self.m_costItemNum * num
    local level = math.floor(num + self.m_curLevel)
    local groupIds = PassDataMgr:GetInstance():GetRewardGroupsByLevel(level)
    self._view.itemloop:SetDataList(self:_GetItems(groupIds))
    self._view.comItem:SetItemById(self.m_costItemId, costNum)
    self:_SetBuyLevelDesc(level)
end

function M:_SetBuyLevelDesc(level)
    local desc
    if self.m_isMaxLevel then
        desc = ConfigHelper.GetLocalString(5075)
    else
        desc = string.format(self.m_fmtStr, level)
    end
    self._view.txt_desc:SetText(desc)
end

function M:OnClickBuyLevel()
    if self.m_isMaxLevel then return end

    if (self.m_costItemNum * self.m_curBuyLevel) > self.m_itemNum then
        GameHelper.TipsById(5077)
    else
        PassDataMgr:GetInstance():SendBuyPassExp(self.m_curBuyLevel, function()
            GameHelper.TipsById(5803) -- 购买成功
            self:Close()
        end)
    end
end

function M:_GetItems(groupIds)
    local items, keyVel = {}, {}
    for _, groupId in ipairs(groupIds or {}) do
        local itemGroup = ConfigHelper.GetCfg("itemGroup", groupId)
        if itemGroup then
            local cnts = itemGroup.cnts
            for i, id in ipairs(itemGroup.items) do
                local num = keyVel[id] or 0
                keyVel[id] = num + cnts[i]
            end
        else
            Logger.LogError("itemGroup is nil. id = " .. groupId)
        end
    end
    for itemId, num in pairs(keyVel) do
        table.insert(items, { id = itemId, cnt = num })
    end
    return items
end

return M
