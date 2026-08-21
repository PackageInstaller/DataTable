local CurrencyExchangeUICtrl = BaseClass("CurrencyExchangeUICtrl", BaseUICtrl)
local M = CurrencyExchangeUICtrl

function M:Init()
    self._view.rectExchange:onClick(Bind(self, self.OnExchangeClick))
    self._view.rectCancel:onClick(Bind(self, self.Close))
    --self._view.rectAdd:onClick(Bind(self, self.OnAddClick))
    -- self._view.rectMinus:onClick(Bind(self, self.OnMinusClick))
    -- self._view.rectMax:onClick(Bind(self, self.OnMaxClick))
    -- self._view.rectMin:onClick(Bind(self, self.OnMinClick))
    self._view.rectClose:onClick(Bind(self, self.Close))
    --self._view.rectAdd:onLongPress(Bind(self, self.OnAddLongClick))
    --self._view.rectAdd:SetLongPressTimes(0.4)
    -- self._view.rectMinus:onLongPress(Bind(self, self.OnMinusLongClick))
    -- self._view.rectMinus:SetLongPressTimes(0.4)
    
    self._num = 1
    self._maxNum = ItemDataMgr:GetInstance():GetItemNumById(6)
    self._isLocked = self._maxNum < 1
    self._isLongClicking = false
    self._view.numSlider:SetChangedCallback(Bind(self,self._OnSelectValueChange))
end

function M:_OnSelectValueChange(curNum)
    self._num = curNum 
end

function M:OnEnter()
    local starStoneCfg = ConfigHelper.GetCfg("item", 6)
    self._view.imgStarStone:SetPic(starStoneCfg.icon, false)
    local creditPointCfg = ConfigHelper.GetCfg("item", 5)
    self._view.imgCreditPoint:SetPic(creditPointCfg.icon, false)
    self._view.txtDes:SetText(5130)

    local numStr = tostring(1)
    -- self._view.txtNum:SetText(numStr)
    self._view.txtCreditPoint:SetText(numStr)
    self._view.txtCreditPoint:SetText(numStr)

    if self._isLocked then
        self:_SetLockActive(true)
    else
        self:_SetLockActive(false)
    end

    self._view.numSlider:SetSliderInfo(self._num,self._maxNum,1)
end

-- --点击设置退出键
-- function M:OnDeviceBack()
--     self:Close()
--     return true
-- end

function M:OnExchangeClick()
    if not self._isLocked then
        ItemHelper.UseItem(6, self._num, false, nil, function()
            local format = ConfigHelper.GetLocalString(5238)
            local content = string.format(format, self._num, self._num)
            GameHelper.Tips(content)
            local dataValues = {6, self._num}
            IBuriedPointDataMgr:SubmitData(BuriedPointConst.Item6Use, dataValues)
            self:Close()
        end, true)
    end
end

-- function M:OnAddClick()
--     if self._isLongClicking == false then
--         if self._num >= self._maxNum or self._isLocked then
--             return
--         end
--         self._num = self._num + 1
--         self:_SetExchangeNum()
--     else
--         self._isLongClicking = false
--     end
-- end

-- function M:OnMinusClick()
--     if self._isLongClicking == false then
--         if self._num <= 1 or self._isLocked then
--             return
--         end
--         self._num = self._num - 1
--         self:_SetExchangeNum()
--     else
--         self._isLongClicking = false
--     end
-- end

-- function M:OnAddLongClick()
--     self._isLongClicking = true
--     if self._num >= self._maxNum or self._isLocked then
--         return
--     end
--     self._num = self._num + 10
--     self._num = self._num >= self._maxNum and self._maxNum or self._num
--     self:_SetExchangeNum()
-- end

-- function M:OnMinusLongClick()
--     self._isLongClicking = true
--     if self._num <= 1 or self._isLocked then
--         return
--     end
--     self._num = self._num - 10
--     self._num = self._num <= 1 and 1 or self._num
--     self:_SetExchangeNum()
-- end

-- function M:OnMaxClick()
--     if self._num == self._maxNum or self._isLocked then
--         return
--     end
--     self._num = ItemDataMgr:GetInstance():GetItemNumById(6)
--     self:_SetExchangeNum()
-- end

-- function M:OnMinClick()
--     if self._num == 1 or self._isLocked then
--         return
--     end
--     self._num = 1
--     self:_SetExchangeNum()
-- end

function M:_SetExchangeNum()
    local numStr = tostring(self._num)
    -- self._view.txtNum:SetText(numStr)
    self._view.txtCreditPoint:SetText(numStr)
    self._view.txtStarStone:SetText(numStr)
end

function M:_SetLockActive(active)
    self._view.rectExchangeLock:SetActive(active)
    -- self._view.rectAddLock:SetActive(active)
    -- self._view.rectMinusLock:SetActive(active)
    -- self._view.rectMaxLock:SetActive(active)
    -- self._view.rectMinLock:SetActive(active)
end

function M:OnClose()
end

function M:OnDispose()
    self._num = nil
    self._maxNum = nil
    self._isLocked = nil
    self._isLongClicking = nil
    M.super.OnDispose(self)
end

return CurrencyExchangeUICtrl