-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/doubleeleven/sheet2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CElevenItemCfg = (BeanManager.GetTableByName)("activity.celevenitemcfg")
local Sheet2 = class("Sheet2", Dialog)
local ColumnNum = 3
Sheet2.AssetBundleName = "ui/layouts.activityeleven"
Sheet2.AssetName = "ActivityElevenTicket"
Sheet2.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Sheet2
  ((Sheet2.super).Ctor)(self, ...)
  self._cardData = {}
  self._cardCanClick = false
  self._gainItemInfo = nil
end

Sheet2.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, ColumnNum, _ENV
  self._activeTime = self:GetChild("ActiveTime")
  self._cardPanel = self:GetChild("FrameCard")
  self._tipsBtn = self:GetChild("Tips")
  self._poolRestar = self:GetChild("PoolRestar")
  self._poolRuler1 = self:GetChild("PoolRuler1")
  self._poolRuler2 = self:GetChild("PoolRuler2")
  self._poolRulerNum = self:GetChild("PoolRulerNum")
  self._currencyIcon = self:GetChild("Item")
  self._currencyNum = self:GetChild("NowNum")
  self._cardFrame = (GridFrame.Create)(self._cardPanel, self, true, ColumnNum, false)
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function(_, notification)
    -- function num : 0_1_0 , upvalues : self
    self:RefreshCardData(true, notification)
  end
, Common.n_OnSOpenDoubleElevenCard, nil)
  self:SetStaticRes()
end

Sheet2.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : CElevenItemCfg, _ENV, CStringRes, Item
  self._needOnceCurrencyNum = (CElevenItemCfg:GetRecorder(1)).itemNum
  ;
  (self._activeTime):SetText((TextManager.GetText)((CStringRes:GetRecorder(1641)).msgTextID))
  ;
  (self._poolRestar):SetText((TextManager.GetText)((CStringRes:GetRecorder(1648)).msgTextID))
  ;
  (self._poolRuler1):SetText((TextManager.GetText)((CStringRes:GetRecorder(1646)).msgTextID))
  ;
  (self._poolRuler2):SetText((TextManager.GetText)((CStringRes:GetRecorder(1647)).msgTextID))
  ;
  (self._poolRulerNum):SetText(self._needOnceCurrencyNum)
  self._currencyItem = (Item.Create)(DataCommon.CrystalBall)
  ;
  (self._currencyIcon):SetSprite(((self._currencyItem):GetIcon()).assetBundle, ((self._currencyItem):GetIcon()).assetName)
end

Sheet2.OnDestroy = function(self)
  -- function num : 0_3
  if self._cardFrame then
    (self._cardFrame):Destroy()
  end
end

Sheet2.SetData = function(self, data)
  -- function num : 0_4 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.DoubleElevenActivityID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DoubleElevenActivityID)
  self:RefreshCurrencyData()
  self:RefreshCardData(false)
end

Sheet2.RefreshCurrencyData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local haveCurrencyNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.CrystalBall)
  ;
  (self._currencyNum):SetText((NumberManager.GetShowNumber)(haveCurrencyNum))
end

Sheet2.RefreshCardData = function(self, refresh, notification)
  -- function num : 0_6 , upvalues : _ENV, Item
  if not refresh then
    for key,_ in pairs(self._cardData) do
      -- DECOMPILER ERROR at PC7: Confused about usage of register: R8 in 'UnsetPending'

      (self._cardData)[key] = nil
    end
    local remoteCardData = (self._bm):GetOpenCards()
    for i = 1, 9 do
      if remoteCardData[i] then
        local item = (Item.Create)((remoteCardData[i]).itemId)
        item:SetCount((remoteCardData[i]).itemNum)
        -- DECOMPILER ERROR at PC33: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self._cardData)[i] = {item = item, state = "ToFace", index = i}
      else
        do
          do
            -- DECOMPILER ERROR at PC39: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (self._cardData)[i] = {state = "ToBack", index = i}
            -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    ;
    (self._cardFrame):ReloadAllCell()
  else
    do
      local isGoldCard = (self._bm):GetCardIsGoldCard((notification.userInfo).cardType)
      local cardIndex = (notification.userInfo).position
      local cardItemInfo = (notification.userInfo).itemInfo
      self._gainItemInfo = cardItemInfo
      do
        local item = (Item.Create)(cardItemInfo.id)
        item:SetCount(cardItemInfo.number)
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((self._cardData)[cardIndex]).item = item
        -- DECOMPILER ERROR at PC68: Confused about usage of register: R7 in 'UnsetPending'

        if isGoldCard then
          ((self._cardData)[cardIndex]).state = "HaveGoldCard"
        else
          -- DECOMPILER ERROR at PC72: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self._cardData)[cardIndex]).state = "HaveNormalCard"
        end
        ;
        (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
        ;
        (self._cardFrame):FireEvent("RefreshOneCell", {index = cardIndex, data = self._cardData})
        self._cardCanClick = true
      end
    end
  end
end

Sheet2.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "activity.doubleeleven.cardcell"
end

Sheet2.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
  return #self._cardData
end

Sheet2.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._cardData)[index]
end

Sheet2.OnOneCardClicked = function(self, index)
  -- function num : 0_10 , upvalues : _ENV
  if self._cardCanClick == false then
    return 
  end
  local haveCurrencyNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.CrystalBall)
  if haveCurrencyNum < self._needOnceCurrencyNum then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100411)
    return 
  else
    self._cardCanClick = false
    ;
    (self._bm):SendOpenOneCardProtocol(index)
  end
end

Sheet2.OnOneGoldCardToFace = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (self._bm):ClearCardsData()
  ;
  (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
  ;
  (self._cardFrame):FireEvent("ClearAllCard")
end

Sheet2.OnOpenCardAnimationEnd = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  if self._gainItemInfo then
    local data = {
items = {self._gainItemInfo}
}
    ;
    ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).ItemAccount, data = data})
    self._gainItemInfo = nil
  end
end

Sheet2.OnClearCardAnimationEnd = function(self)
  -- function num : 0_13 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
end

Sheet2.OnTipsBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV, CStringRes
  local dialogName = "activity.doubleeleven.tipsdialog"
  local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  if dialog then
    dialog:SetData((CStringRes:GetRecorder(1649)).msgTextID, (CStringRes:GetRecorder(1650)).msgTextID)
  end
end

return Sheet2

