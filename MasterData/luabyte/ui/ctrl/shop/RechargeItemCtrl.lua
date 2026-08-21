local RechargeItemCtrl = BaseClass("RechargeItemCtrl")
local M = RechargeItemCtrl

function M:__init(view)
    self._view = view

    self._view.rectItem:onClick(Bind(self, self.OnItemClick))
end

function M:Dispose()
    self._view.rectItem:onClick(nil)
    self:OnDispose()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

function M:UpdateItem(data)
    if data == nil then
        return
    end
    self.data = data
    self:_UpdateData(data.cfg)
end

function M:OnItemClick()
    if self.data.cfg.payId > 0 then
        SDKHelper.Pay(self.data.cfg.payId, function(isOk)
            if not isOk then
                GameHelper.TipsById(5789) -- 充值失败
            end
        end)
    end
end

function M:_UpdateData(data)
    self._view.txtExtra:SetText(tostring(data.reward))
    self:_SetPrice(data)

    local index = tonumber(self._view.rectItem.gameObject.name) + 1
    local isFirst = RechargeDataMgr:GetInstance():IsFirstRecharge(index)
    self._view.rectDouble:SetActive(isFirst)
    self:_SetExtraDesc(data, isFirst)
    self._view.bg:SetPic(data.itemPicture)
    if data.stage == 6 then
        self._view.UIState:SetState(2)
    else
        self._view.UIState:SetState(1)
    end
end

function M:_SetPrice(data)
    local paycfg = ConfigHelper.GetCfgByLua("pay", data.payId)
    local currency = ConfigHelper.GetLocalString(paycfg.monetaryUnit)
    local price = string.format("%d", paycfg.truePrice / 100)
    -- if string.sub(price, -1) == "0" then
    --     price = string.sub(price, 1, -2)
    -- end
    self._view.txtPrice:SetText("<size=45>" .. currency .. "</size>" .. price)
end

function M:_SetExtraDesc(data, isFirst)
    local itemNum = 0
    if isFirst then
        itemNum = data.firstRecharge
    else
        itemNum = data.nextRecharge
    end
    self._view.txtDesc:SetText(542)
    self._view.txtGift:SetText(tostring(itemNum))
end

return RechargeItemCtrl
