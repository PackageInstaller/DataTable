-- baoruichang
-- Masquerade_ShopConfirm
local UIDanceShopConfirmCtrl = BaseClass("UIDanceShopConfirmCtrl", BaseUICtrl)
local M = UIDanceShopConfirmCtrl
local mMin = math.min
local sfmt = string.format
local mModf = math.modf -- 向下取整

function M:Init()
    self._view.btn:onClick(Bind(self, self._onBtnOKClick))
    self._view.btnMask:onClick(Bind(self, self.Close))
    self._view.imgCost1:onClick(Bind(self, self._onClickCost))
    self._view.btnMin:onClick(Bind(self, self._onBtnMimMaxClick, false))
    self._view.btnSub:onClick(Bind(self, self._onBtnSubAddClick, false))
    self._view.btnAdd:onClick(Bind(self, self._onBtnSubAddClick, true))
    self._view.btnMax:onClick(Bind(self, self._onBtnMimMaxClick, true))
end

-- 进入UI，可传参数
function M:OnEnter(data, buyClick)
    self._data = data
    self._buyClick = buyClick
    local shopItemId = data.shopItemId
    self._view.imgIcon:SetItemIcon(shopItemId)
    self._view.labName1:SetItemName(shopItemId)
    self._view.labName2:SetItemName(shopItemId)
    local desc = ConfigHelper.GetCfgPropByLua("item", shopItemId, "desc")
    self._view.labDesc:SetText(desc)
    self._view.labNum:SetText("x" .. data.itemNum)
    
    local haveConstNum = ItemDataMgr:GetInstance():GetItemNumById(data.costItemId)
    local canBuyNum = mModf(haveConstNum / data.costItemNum)
    self._maxNum = mMin(canBuyNum, data.canBuyNum)
    self.selectNum = self._maxNum > 0 and 1 or 0
    self._view.labPrice:SetText(tostring(data.costItemNum))
    self._view.labHave:SetText(tostring(haveConstNum))
    self._view.imgCost1:SetItemIcon(data.costItemId)
    self._view.imgCost2:SetItemIcon(data.costItemId)
    local canBuyuyNum = ConfigHelper.GetLocalString(5798)
    canBuyuyNum = sfmt(canBuyuyNum, data.canBuyNum)
    self._view.labCanBuyNum:SetText(canBuyuyNum)
    self:UpdateAllCost()
end

function M:_onBtnOKClick()
    if self._data.canBuyNum <= 0 then
        return
    end
    if self._maxNum <= 0 then
        GameHelper.TipsById(27000308)
        return
    end
    if self._buyClick then
        self._buyClick(self.selectNum)
        self:Close()
    end
end

function M:_onBtnMimMaxClick(isMax)
    if self._maxNum <= 0 then
        return
    end
    self.selectNum = isMax and self._maxNum or 1
    self:UpdateAllCost()
end

function M:_onBtnSubAddClick(isAdd)
    if self._maxNum <= 0 then
        return
    end
    self.selectNum = isAdd and self.selectNum + 1 or self.selectNum - 1
    self.selectNum = self.selectNum <= 0 and 1 or self.selectNum
    self.selectNum = self.selectNum > self._maxNum and self._maxNum or self.selectNum
    self:UpdateAllCost()
end

function M:UpdateAllCost()
    self._view.labSelectNum:SetText(tostring(self.selectNum))
    self._view.labAllCost:SetText(tostring(self.selectNum * self._data.costItemNum))
end

function M:_onClickCost()
    GameHelper.PopItem(self._data.costItemId, 0, self._view)
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return UIDanceShopConfirmCtrl
