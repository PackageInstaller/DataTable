local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Sheet1 = class("Sheet1", Dialog)
Sheet1.AssetBundleName = "ui/layouts.activityspringouting"
Sheet1.AssetName = "ActivitySpringOutingWish"

function Sheet1:Ctor(...)
  Sheet1.super.Ctor(self, ...)
end

function Sheet1:OnCreate()
  self._activityTime = self:GetChild("ActiveTime")
  self._tipsBtn = self:GetChild("Tips")
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._wishBtn = self:GetChild("WishBtn")
  self._wishBtnTxt = self:GetChild("WishBtn/Text")
  self._wishBtnTxt:Subscribe_PointerClickEvent(self.OnWishBtnClicked, self)
  self._checkBtn = self:GetChild("CheckBtn")
  self._checkBtnTxt = self:GetChild("CheckBtn/Text")
  self._checkBtn:Subscribe_PointerClickEvent(self.OnCheckBtnClicked, self)
  self._currencyBack = self:GetChild("ItemBack")
  self._currencyIcon = self:GetChild("ItemBack/Item")
  self._currencyNum = self:GetChild("ItemBack/NowNum")
  self._currencyBack:Subscribe_PointerClickEvent(self.OnCurrencyBackClicked, self)
  self._wishObject = self:GetChild("Spring")
  LuaNotificationCenter.AddObserver(self, self.OnSDragonBoatFestivalInfo, Common.n_SDragonBoatFestivalInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSDragonBoatFestivalWish, Common.n_SDragonBoatFestivalWish, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self:SetStaticRes()
end

function Sheet1:SetStaticRes()
  self._activityTime:SetText(TextManager.GetText(CStringRes:GetRecorder(1812).msgTextID))
  self._checkBtnTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1824).msgTextID))
  self._currencyItem = Item.Create(DataCommon.LuckyCopperCoin)
  self._currencyIcon:SetSprite(self._currencyItem:GetIcon().assetBundle, self._currencyItem:GetIcon().assetName)
end

function Sheet1:OnDestroy()
end

function Sheet1:SetData()
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self:RefreshCurrencyData()
  self:RefreshWishBtnTxt()
end

function Sheet1:RefreshCurrencyData()
  local haveCurrencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.LuckyCopperCoin)
  self._currencyNum:SetText(NumberManager.GetShowNumber(haveCurrencyNum))
end

function Sheet1:RefreshWishBtnTxt()
  if self._bm:GetWishIsOpen() then
    self._wishBtnTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1822).msgTextID))
  else
    self._wishBtnTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1823).msgTextID))
  end
end

function Sheet1:OnCurrencyBackClicked()
  local width, height = self._currencyIcon:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._currencyItem
    })
    tipsDialog:SetTipsPosition(width, height, self._currencyIcon:GetLocalPointInUiRootPanel())
  end
end

function Sheet1:OnTipsBtnClicked()
  local dialogName = "activity.dragonboatfestival.tipsdialog"
  local dialog = DialogManager.CreateSingletonDialog(dialogName)
  if dialog then
    dialog:SetData(CStringRes:GetRecorder(1810).msgTextID, CStringRes:GetRecorder(1811).msgTextID)
  end
end

function Sheet1:OnWishBtnClicked()
  if self._bm:GetWishIsOpen() then
    local dialogName = "activity.dragonboatfestival.exchangedialog"
    local dialog = DialogManager.CreateSingletonDialog(dialogName)
    if dialog then
      dialog:SetData()
    end
  elseif self._bm:GetIsOpen() then
    local currencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.LuckyCopperCoin)
    local recyleNum = currencyNum * self._bm:GetExchangeRecycleRate()
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(137, {currencyNum, recyleNum}, function()
      self._bm:SendCActivityExchangeRecycle()
    end, {}, nil, {})
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100228)
    return
  end
end

function Sheet1:OnCheckBtnClicked()
  local dialogName = "activity.dragonboatfestival.rewardpooldialog"
  local dialog = DialogManager.CreateSingletonDialog(dialogName)
  if dialog then
    dialog:SetData()
  end
end

function Sheet1:OnSDragonBoatFestivalInfo()
end

function Sheet1:OnSDragonBoatFestivalWish()
  self:RefreshWishBtnTxt()
end

return Sheet1
