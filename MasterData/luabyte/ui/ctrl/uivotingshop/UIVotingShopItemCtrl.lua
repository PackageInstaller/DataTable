local UIVotingShopItemCtrl = BaseClass("UIVotingShopItemCtrl")
local M = UIVotingShopItemCtrl
local sfmt = string.format

function M:__init(view)
    self._view = view
    self._view.btnBuy:SetOnClick(self, self.OnBtnBuyClick)
    self._view.imageIcom:SetOnClick(self, self.OnBtnIconClick)
end

function M:UpdateItem(data)
    self.data = data
    self:UpdateCurNum()
    self:InitItem(data.itemId, data.ConstItemId)
    self:InitState(data)
end

function M:OnBtnBuyClick()
    local buyMax = self.data.canNum
    local havaConst = ItemDataMgr:GetInstance():GetItemNumById(self.data.ConstItemId) or 0
    local maxBuy = math.modf(havaConst / self.data.ConstItemNum)
    buyMax = maxBuy < buyMax and maxBuy or buyMax

    if buyMax <= 0 then
        local constName = ConfigHelper.GetCfgPropByLua("item", self.data.ConstItemId, "name")
        GameHelper.Tips(sfmt(ConfigHelper.GetLocalString(10913), ConfigHelper.GetLocalString(constName)))
        return
    end
    if self.buyCallBack then
        self.buyCallBack(self.data)
    end
end

function M:OnBtnIconClick()
    GameHelper.PopItem(self.data.itemId, 0, self._view)
end

function M:InitItem(id, costIcon)
    self._view.imageCost:SetItemIcon(costIcon)
    self._view.ItemPfbMid:SetItemNameActive(true)
    local rewardNum = ConfigHelper.GetCfgPropByLua("activityExchange", self.data.id, "rewardNum")
    self._view.ItemPfbMid:SetInfo(id, ItemNumberType.TOTLE, rewardNum)
end

function M:InitState(data)
    self._view.tfNormal.gameObject:SetActive(not data.buyOver)
    self._view.tfSellout.gameObject:SetActive(data.buyOver)
    self._view.textCanBuy:SetText(sfmt(ConfigHelper.GetLocalString(690), data.canNum))
end

function M:UpdateCurNum()
    self._view.textCostNum:SetText(tostring(self.data.ConstItemNum))
end

function  M:SetBuyCallBack(callBack)
    self.buyCallBack = callBack
end

function M:OnDispose()
    self._view.btnBuy:RemoveOnClick()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return UIVotingShopItemCtrl
