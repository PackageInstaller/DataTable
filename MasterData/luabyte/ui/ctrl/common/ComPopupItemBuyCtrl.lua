local M = BaseClass("ComPopupItemBuyCtrl", BaseUICtrl)

function M:Init()
    self.m_data = nil
    self.m_useNum = 0
    self.m_itemCfg = nil
    self.m_changeNum = 1
    self.m_maxUseNum = 0
    self.m_isClick = false
    self._view.btn_tips:onClick(Bind(self, self.OnClickTips))
    self._view.btn_plus:onClick(Bind(self, self.OnClickPlus))
    self._view.btn_mask:onClick(Bind(self, self.OnClickCancle))
    self._view.btn_minus:onClick(Bind(self, self.OnClickMinus))
    self._view.btn_cancle:onClick(Bind(self, self.OnClickCancle))
    self._view.btn_confirm:onClick(Bind(self, self.OnClickConfirm))
    self._view.btn_plus:onLongPress(Bind(self, self.OnLongPressPlus))
    self._view.btn_minus:onLongPress(Bind(self, self.OnLongPressMinus))
    self._view.node_slider:OnSliderChanged(Bind(self, self.OnSliderValueChanged))
    self.alreadyBuy = false
end

function M:OnEnter(data, isEnough)
    self.m_data = data
    self.isEnough = isEnough
    local haveConst = ItemDataMgr:GetInstance():GetItemNumById(self.m_data.shopItemConfig.finalItem) or 0
    self.m_itemCfg = ConfigHelper.GetCfgByLua("item", self.m_data.shopItemConfig.itemId)
    self.finalNum = self.m_data.shopItemConfig.finalNum
    self._view.img_icon:SetItemIcon(self.m_itemCfg.id)
    self._view.txt_name:SetText(ConfigHelper.GetLocalString(self.m_itemCfg.name) .. "*" .. self.m_data.shopItemConfig
    .num)
    self._view.img_cost:SetItemIcon(self.m_data.shopItemConfig.finalItem)
    self._view.img_huobi:SetItemIcon(self.m_data.shopItemConfig.finalItem)
    self._view.txt_des:SetText(self.m_itemCfg.desc)
    local string = ConfigHelper.GetLocalString(30222)
    self._view.txt_remain:SetText(string .. tostring(self.m_data.shopItemConfig.buyCount - self.m_data.Num))
    self._view.PropertyBar:Action(self.m_data.shopItemConfig.finalItem)
    if self.isEnough == false then
        local finalItemCfg = ConfigHelper.GetCfgByLua("item", self.m_data.shopItemConfig.finalItem)
        local str = string.format(ConfigHelper.GetLocalString(158), ConfigHelper.GetLocalString(finalItemCfg.name))
        self._view.txt_not:SetText(str)
        self._view.UIState:SetState(2)
        self._view.txt_cost:SetText(tostring(self.finalNum))
    else
        local canBuyNum = 0
        if self.m_data.shopItemConfig.finalNum == 0 then
            canBuyNum = self.m_data.shopItemConfig.buyCount - self.m_data.Num
        else
            canBuyNum = math.modf(haveConst / self.m_data.shopItemConfig.finalNum)
        end
        local buyMax = self.m_data.shopItemConfig.buyCount - self.m_data.Num
        buyMax = buyMax < canBuyNum and buyMax or canBuyNum
        self.haveNum = ItemDataMgr:GetInstance():GetItemNumById(self.m_data.shopItemConfig.itemId)
        self.shopItemId = self.m_data.shopItemConfig.id
        self.shopId = self.m_data.shopId

        self.m_maxUseNum = buyMax

        local paramat = GameHelper.GetParamters(242)
        self.m_changeNum = paramat[0]
        self._view.btn_plus:SetLongPressTimes(paramat[1])
        self._view.btn_minus:SetLongPressTimes(paramat[1])
        self:_SetUseNum(self.m_maxUseNum == 0 and 0 or 1)
        self._view.txt_minNum:SetText(tostring(self.m_useNum))
        self._view.txt_maxNum:SetText(tostring(self.m_maxUseNum))

        self._view.UIState:SetState(1)
    end
end

function M:OnClose()
    self._view.node_slider:RemoveSliderAllListeners()
end

function M:OnClickTips(go)
    local shopItem = self.m_data.shopItemConfig
    GameHelper.PopItem(shopItem.itemId, shopItem.num, self._view)
end

function M:OnClickPlus(go)
    if self.m_useNum < self.m_maxUseNum then
        self:_SetUseNum(1)
    end
end

function M:OnClickMinus(go)
    if self.m_useNum > 1 then
        self:_SetUseNum( -1)
    end
end

function M:OnClickCancle(go)
    if self.alreadyBuy == true then return end
    self:Close()
end

function M:OnClickConfirm(go)
    if self.alreadyBuy == true then return end

    if not self.m_itemCfg then return end

    if self.isEnough == false then
        return
    end

    if self.m_maxUseNum <= 0 then
        local tips = ConfigHelper.GetLocalString(5164)
        local name = ConfigHelper.GetLocalString(self.m_itemCfg.name)
        GameHelper.Tips(string.format(tips, tostring(self.m_batch), name))
        return
    end
    self.alreadyBuy = true
    
    if self.m_data.bLimitShop then
        LimitDataMgr:GetInstance():RequestBuyExtremeBattleShop(self.m_data:GetId(),self.m_useNum,Bind(self, self.BuyCallback))
    else
        ShopDataMgr:RequestBuyItem(self.shopId, self.shopItemId, self.m_useNum, Bind(self, self.BuyCallback))
    end
end

function M:BuyCallback()
    self.alreadyBuy = false
    self:Close()
end

function M:OnLongPressPlus(go)
    local sum = self.m_useNum + self.m_changeNum
    if sum <= self.m_maxUseNum then
        self:_SetUseNum(self.m_changeNum)
    else
        local num = sum - self.m_maxUseNum
        if num > 0 and num < self.m_changeNum then
            self:_SetUseNum(self.m_changeNum - num)
        end
    end
end

function M:OnLongPressMinus(go)
    local diff = self.m_useNum - self.m_changeNum - 1
    if diff >= 0 then
        self:_SetUseNum( -self.m_changeNum)
    else
        local num = self.m_changeNum + diff
        if num > 0 then
            self:_SetUseNum( -num)
        end
    end
end

function M:_SetUseNum(num)
    self.m_isClick = true
    self.m_useNum = self.m_useNum + num
    self:_SetSliderValue()
    self._view.txt_cost:SetText(tostring(self.finalNum * self.m_useNum))
end

function M:OnSliderValueChanged(value)
    if self.m_isClick then
        self.m_isClick = false
        return
    end

    self.m_isClick = true
    if self.m_maxUseNum == 0 then
        self.m_useNum = 0
    else
        local num = math.floor(value * self.m_maxUseNum)
        self.m_useNum = num <= 0 and 1 or num
    end
    self:_SetSliderValue()
end

function M:_SetSliderValue()
    local value = 1
    if self.m_maxUseNum ~= 0 then
        value = self.m_useNum / self.m_maxUseNum
    end
    self._view.node_slider:SetValue(value)
    self._view.txt_useNum:SetText(tostring(self.m_useNum))
    if self.m_useNum == self.m_maxUseNum then
        self._view.BtnAdd:SetState(2)
    end

    if self.m_useNum == 1 then
        self._view.BtnReduce:SetState(2)
    end

    if self.m_useNum > 1 and self.m_useNum < self.m_maxUseNum then
        self._view.BtnReduce:SetState(1)
        self._view.BtnAdd:SetState(1)
    end
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

return M
