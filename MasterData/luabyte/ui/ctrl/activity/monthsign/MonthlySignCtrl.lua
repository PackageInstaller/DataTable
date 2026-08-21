local MonthlySignCtrl = BaseClass("MonthlySignCtrl", BaseUICtrl)
local M = MonthlySignCtrl
local sfmt = string.format

local SignItemCtrl = require("UI.Ctrl.Activity.MonthSign.SignItemCtrl")
local SignItemView = require("UI.View.Activity.MonthSign.SignItemView")

function M:Init()
    self._view.btnShop:onClick(Bind(self, self.OnGoShopClick))
    self.tabItemPfbViews = {self._view.ItemPfbView}
    self.grid = self._view.grid
    self.grid:Init(SignItemCtrl, SignItemView)
end

function M:OnEnter(datas)
    self.datas = datas
    self.m_CurSignNum = self:GetContext():GetCurSignNum()
    self.isSign = self:GetContext():IsSign()
    self.monthCard = RechargeDataMgr:GetInstance():GetRemainingDays() > 0
    self:RefMonthCardItem(self.datas[self.m_CurSignNum].dailyBonus)
    self.grid:SetDataList(datas)
    GameHelper.DoPlayerAction(PlayerAction.OpenMonthSign)
    if not self.isSign then
        UIContextMgr:GetInstance():GetContext(UIDefine.UIActivity):SetCanRecharge(false)
        self:GetContext():RequestMonthSign()
    end
end

function M:RefMonthCardItem(dailyBonus)
    self._view.labMonth:SetText(sfmt("%02d", dailyBonus.month))
    self._view.labDay:SetText(tostring(self.isSign and self.m_CurSignNum or self.m_CurSignNum - 1))
    self._view.btnShop:SetActive(not self.monthCard)

    local itemGroupId = dailyBonus.monthlyCard
    local itemGroup = ConfigHelper.GetCfg("itemGroup", itemGroupId)
    for i, id in pairs(itemGroup.items) do
        local ItemPfbView = self.tabItemPfbViews[i]
        if not ItemPfbView then
            ItemPfbView = self._view.ItemPfbView:Instantiate()
            self.tabItemPfbViews[i] = ItemPfbView
        end
        ItemPfbView.item:EnablePopItem(true)
        ItemPfbView.item:SetInfo(id, ItemNumberType.TOTLE, itemGroup.cnts[i])
        ItemPfbView.item:SetActive(true)
        ItemPfbView.item:SetFinish(self.isSign and self.monthCard)
    end
    for i = #itemGroup.items + 1, #self.tabItemPfbViews do
        self.tabMonthItems[i]:SetActive(false)
    end
end

function M:OnGoShopClick()
    GameHelper.Jump(57)
end

-- 签到成功刷新界面
function M:RefSignSucces(rewards, isSign)
    self.isSign = isSign
    local SignItemCtrls = self.grid:GetItems()
    for _, SignItemCtrl in pairs(SignItemCtrls) do
        if SignItemCtrl:GetId() == self.m_CurSignNum then
            SignItemCtrl:PlayAnimator(Bind(self, self.ShowRewards, rewards))
            break
        end
    end
end

function M:ShowRewards(rewards)
    GameHelper.ShowGetItemsByItems(rewards, Bind(self, self.CloseShowRewards))
    self:RefMonthCardItem(self.datas[self.m_CurSignNum].dailyBonus)
end

function M:CloseShowRewards()
    UIContextMgr:GetInstance():GetContext(UIDefine.UIActivity):SetCanRecharge(true)
end

function M:OnDispose()
    M.super.OnDispose(self)
    for _, value in pairs(self.tabItemPfbViews) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDispose()
    end
    self.tabItemPfbViews = nil
end
-- 点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

return M
