local DormPuzzleShopCtrl = BaseClass("DormPuzzleShopCtrl", BaseUICtrl)
local M = DormPuzzleShopCtrl
local DormPuzzleShopItemCtrl = require("UI.Ctrl.Dorm.DormPuzzleShopItemCtrl")
local DormPuzzleShopItemView = require("UI.View.Dorm.DormPuzzleShopItemView")

function M:Init()
    self._view.btnBack:onClick(Bind(self, self.Close))
    self.grid = self._view.grid
    self.grid:Init(DormPuzzleShopItemCtrl, DormPuzzleShopItemView)
    self.grid:SetCreateItemCallback(Bind(self, self._OnCreateItem))
end

-- 进入UI，可传参数
function M:OnEnter(shopData)
    self.shopData = shopData
    self.grid:SetDataList(shopData)
    self._view.propertyBar:Action(self:GetContext():GetConstId())
end

function M:_OnCreateItem(DormPuzzleShopItemCtrl)
    DormPuzzleShopItemCtrl:SetClickCallback(Bind(self, self._OnSelect))
end

function M:_OnSelect(data)
    self._selectSubActivityId = data.activityShop.id
    local tempData = {}
    tempData.shopItemId = data.activityShop.shopItem
    tempData.costItemId = data.activityShop.costItem
    tempData.costItemNum = data.activityShop.costNum
    tempData.canBuyNum = data.canBuyNum
    UIManager:GetInstance():Show(UIDefine.UIShopConfirm, tempData, Bind(self, self._OnBuyClick))
end


function M:_OnBuyClick(num)
    local activityId = self:GetContext():GetActivityId()
    ActivityDataMgr:GetInstance():SendCommonReward(activityId, {self._selectSubActivityId}, Bind(self, self._OnRewardCallBack), {num})
end

function M:_OnRewardCallBack(awardData)
    DormPuzzleActivityDataMgr:GetInstance():UpdateData()
    GameHelper.ShowGetItems(awardData)
    self:GetContext():RefData()
end

function M:RefreshShopItem(shopData)
    self.shopData = shopData
    self.grid:SetDataList(shopData)
end

function M:OnClose()
    self:GetContext().closeCallback()
end 

function M:OnDispose()
    M.super.OnDispose(self)
end

return DormPuzzleShopCtrl
