-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/dragonboatfestival/sheet1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Sheet1 = class("Sheet1", Dialog)
Sheet1.AssetBundleName = "ui/layouts.activityspringouting"
Sheet1.AssetName = "ActivitySpringOutingWish"
Sheet1.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Sheet1
  ((Sheet1.super).Ctor)(self, ...)
end

Sheet1.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._activityTime = self:GetChild("ActiveTime")
  self._tipsBtn = self:GetChild("Tips")
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._wishBtn = self:GetChild("WishBtn")
  self._wishBtnTxt = self:GetChild("WishBtn/Text")
  ;
  (self._wishBtnTxt):Subscribe_PointerClickEvent(self.OnWishBtnClicked, self)
  self._checkBtn = self:GetChild("CheckBtn")
  self._checkBtnTxt = self:GetChild("CheckBtn/Text")
  ;
  (self._checkBtn):Subscribe_PointerClickEvent(self.OnCheckBtnClicked, self)
  self._currencyBack = self:GetChild("ItemBack")
  self._currencyIcon = self:GetChild("ItemBack/Item")
  self._currencyNum = self:GetChild("ItemBack/NowNum")
  ;
  (self._currencyBack):Subscribe_PointerClickEvent(self.OnCurrencyBackClicked, self)
  self._wishObject = self:GetChild("Spring")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSDragonBoatFestivalInfo, Common.n_SDragonBoatFestivalInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSDragonBoatFestivalWish, Common.n_SDragonBoatFestivalWish, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self:SetStaticRes()
end

Sheet1.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes, Item
  (self._activityTime):SetText((TextManager.GetText)((CStringRes:GetRecorder(1812)).msgTextID))
  ;
  (self._checkBtnTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1824)).msgTextID))
  self._currencyItem = (Item.Create)(DataCommon.LuckyCopperCoin)
  ;
  (self._currencyIcon):SetSprite(((self._currencyItem):GetIcon()).assetBundle, ((self._currencyItem):GetIcon()).assetName)
end

Sheet1.OnDestroy = function(self)
  -- function num : 0_3
end

Sheet1.SetData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self:RefreshCurrencyData()
  self:RefreshWishBtnTxt()
end

Sheet1.RefreshCurrencyData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local haveCurrencyNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.LuckyCopperCoin)
  ;
  (self._currencyNum):SetText((NumberManager.GetShowNumber)(haveCurrencyNum))
end

Sheet1.RefreshWishBtnTxt = function(self)
  -- function num : 0_6 , upvalues : _ENV, CStringRes
  if (self._bm):GetWishIsOpen() then
    (self._wishBtnTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1822)).msgTextID))
  else
    ;
    (self._wishBtnTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1823)).msgTextID))
  end
end

Sheet1.OnCurrencyBackClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local width, height = (self._currencyIcon):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._currencyItem})
    tipsDialog:SetTipsPosition(width, height, (self._currencyIcon):GetLocalPointInUiRootPanel())
  end
end

Sheet1.OnTipsBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV, CStringRes
  local dialogName = "activity.dragonboatfestival.tipsdialog"
  local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  if dialog then
    dialog:SetData((CStringRes:GetRecorder(1810)).msgTextID, (CStringRes:GetRecorder(1811)).msgTextID)
  end
end

Sheet1.OnWishBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (self._bm):GetWishIsOpen() then
    local dialogName = "activity.dragonboatfestival.exchangedialog"
    local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
    if dialog then
      dialog:SetData()
    end
  else
    do
      if (self._bm):GetIsOpen() then
        local currencyNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.LuckyCopperCoin)
        local recyleNum = currencyNum * (self._bm):GetExchangeRecycleRate()
        ;
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(137, {currencyNum, recyleNum}, function()
    -- function num : 0_9_0 , upvalues : self
    (self._bm):SendCActivityExchangeRecycle()
  end
, {}, nil, {})
      else
        do
          ;
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100228)
          do return  end
        end
      end
    end
  end
end

Sheet1.OnCheckBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialogName = "activity.dragonboatfestival.rewardpooldialog"
  local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  if dialog then
    dialog:SetData()
  end
end

Sheet1.OnSDragonBoatFestivalInfo = function(self)
  -- function num : 0_11
end

Sheet1.OnSDragonBoatFestivalWish = function(self)
  -- function num : 0_12
  self:RefreshWishBtnTxt()
end

return Sheet1

