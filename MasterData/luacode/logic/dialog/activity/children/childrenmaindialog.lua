local TabFrame = require("framework.ui.frame.tab.tabframe")
local CClownCfg = BeanManager.GetTableByName("activity.cclowncfg")
local ChildrenMainDialog = class("ChildrenMainDialog", Dialog)
ChildrenMainDialog.AssetBundleName = "ui/layouts.activitychildrensday"
ChildrenMainDialog.AssetName = "ActivityChildrensDayMain"
local BtnType = {
  Task = 1,
  Conversion = 2,
  Shop = 3
}

function ChildrenMainDialog:Ctor(...)
  ChildrenMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._btnType = BtnType.Task
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChildrenActivityManagerID)
  self._shopId = DataCommon.ChildrenActivity.Shop.ShopID
  self._taskFinsh = false
end

function ChildrenMainDialog:OnCreate()
  self._takBtn = self:GetChild("Cutbtn1")
  self._takBtnRedDot = self:GetChild("Cutbtn1/Dot")
  self._conversionBtn = self:GetChild("Cutbtn2")
  self._conversionBtnRedDot = self:GetChild("Cutbtn2/Dot")
  self._shopBtn = self:GetChild("Cutbtn3")
  self._shopBtnRedDot = self:GetChild("Cutbtn3/Dot")
  self._backBtn = self:GetChild("BackBtn")
  self._talkText = self:GetChild("Talk1/Text")
  self._panel = self:GetChild("Frame")
  self._frame = TabFrame.Create(self._panel, self)
  self._takBtn:Subscribe_PointerClickEvent(self.OnTaskBtnClicked, self)
  self._conversionBtn:Subscribe_PointerClickEvent(self.OnConversionBtnClicked, self)
  self._shopBtn:Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_SRefreshChildrenInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshShopInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.OnOthersActivitysTimeOver, Common.n_OthersActivitysTimeOver, nil)
  self:Init()
  self:RefreshRedDot()
end

function ChildrenMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._frame then
    self._frame:Destroy()
  end
  DialogManager.DestroySingletonDialog("activity.children.childrentipsdialog")
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function ChildrenMainDialog:Init()
  self._taskFinsh = self._bm:GetTaskFinish()
  if self._bm:GetTaskFinish() then
    self:OnConversionBtnClicked()
  else
    self:OnTaskBtnClicked()
  end
end

function ChildrenMainDialog:Refresh()
  if not self._taskFinsh and self._bm:GetTaskFinish() then
    self:OnBackBtnClicked()
  end
  self:RefreshRedDot()
end

function ChildrenMainDialog:RefreshRedDot()
  self._takBtnRedDot:SetActive(self._bm:GetTaskRedDot())
  self._conversionBtnRedDot:SetActive(self._bm:GetItemShopRedDot())
  self._shopBtnRedDot:SetActive(self._bm:GetShopRedDot())
end

function ChildrenMainDialog:RefreshShopRedPoint(notification)
  if notification.userInfo.shopId == self._shopId then
    local allFreeSoldOut = false
    for _, good in ipairs(notification.userInfo.refresh) do
      if good.discountPrice == 0 then
        allFreeSoldOut = true
        if good.goodRemain ~= 0 then
          allFreeSoldOut = false
          break
        end
      end
    end
  end
end

function ChildrenMainDialog:OnTaskBtnClicked()
  if not self._bm:GetTaskFinish() then
    self._takBtn:SetSelected(true)
    self._conversionBtn:SetSelected(false)
    self._shopBtn:SetSelected(false)
    self._frame:ToPage(BtnType.Task)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100452)
  end
end

function ChildrenMainDialog:OnConversionBtnClicked()
  self._takBtn:SetSelected(false)
  self._conversionBtn:SetSelected(true)
  self._shopBtn:SetSelected(false)
  self._frame:ToPage(BtnType.Conversion)
end

function ChildrenMainDialog:OnShopBtnClicked()
  if not self._bm:GetTaskFinish() then
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
    protocol.shopId = self._shopId
    protocol:Send()
    self._takBtn:SetSelected(false)
    self._conversionBtn:SetSelected(false)
    self._shopBtn:SetSelected(true)
    self._frame:ToPage(BtnType.Shop)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100452)
  end
end

function ChildrenMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChildrenMainDialog:CellAtIndex(frame, index)
  if index == BtnType.Task then
    return "activity.children.taskpage"
  elseif index == BtnType.Conversion then
    return "activity.children.conversionpage"
  elseif index == BtnType.Shop then
    return "activity.children.shopmainpage"
  end
end

function ChildrenMainDialog:DidToPage(frame, index)
  if frame == self._frame then
    if index == BtnType.Task then
      self._frame:GetCellAtIndex(BtnType.Task):Refresh()
    elseif index == BtnType.Conversion then
      self._frame:GetCellAtIndex(BtnType.Conversion):Refresh()
    elseif index == BtnType.Shop then
      self._frame:GetCellAtIndex(BtnType.Shop):RefreshGoodsData()
    end
    self._btnType = index
  end
end

function ChildrenMainDialog:OnOthersActivitysTimeOver()
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.ChildrenDay) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100033)
    self:OnBackBtnClicked()
  end
end

return ChildrenMainDialog
