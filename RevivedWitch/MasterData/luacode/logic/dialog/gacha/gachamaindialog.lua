-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gachamaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CDrawCardDef = (LuaNetManager.GetProtocolDef)("protocol.card.cdrawcard")
local CardPool = (BeanManager.GetTableByName)("item.ccardpool")
local TableFrame = require("framework.ui.frame.table.tableframe")
local LoopTableFrame = require("framework.ui.frame.looptable.looptableframe")
local Item = require("logic.manager.experimental.types.item")
local CSoulExchangeRecord = ((BeanManager.GetTableByName)("item.csoulexchange")):GetRecorder(1)
local tenDrawGuidePoolId = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(44)).Value)
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local GachaType = {Money = 1, Item = 2, MoneyAndItem = 3, Wrong = 4}
local GachaMainDialog = class("GachaMainDialog", Dialog)
GachaMainDialog.AssetBundleName = "ui/layouts.gacha"
GachaMainDialog.AssetName = "GachaMain"
local HandleGuideStatusChanged = function(self, notification)
  -- function num : 0_0
  if (notification.userInfo).guideID == 7 and (notification.userInfo).guideStatus ~= "Start" then
    self._activeGuideGroup = true
  end
end

GachaMainDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : GachaMainDialog, GachaType
  ((GachaMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._baseSceneController = nil
  self._moneyList = {}
  self._cardPoolList = {}
  self._hasDrawCard = false
  self._poolOneDrawType = GachaType.Money
  self._poolTenDrawType = GachaType.Money
  self._tenDrawGuide = false
  self._poolInfo = nil
end

GachaMainDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : TableFrame, _ENV, GuidTypes, HandleGuideStatusChanged
  self._moneyPanel = self:GetChild("TopFrame")
  self._poolParent = self:GetChild("Frame")
  self._FirstGachaFrameParent = self:GetChild("FirstGachaFrame")
  self._poolPanel = self:GetChild("PoolList")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._moneyFrame = (TableFrame.Create)(self._moneyPanel, self, false, false, true)
  self._poolFrame = (TableFrame.Create)(self._poolPanel, self, true, true, true)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  if ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuidTypes.NEW_USER_TEN_DRAW) == 0 then
    self._tenDrawGuide = true
  end
  if self._tenDrawGuide then
    self._FirstGachaInfo = (DialogManager.CreateSingletonChildDialog)("gacha.firstgachadetaildialog", self._dialogName, self:GetRootWindow())
  end
  self:OnRefreshPools()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBagDialogDestroy, Common.n_DialogWillDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshPools, Common.n_RefreshDrawCardPool, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDrawCardResult, Common.n_DrawCard, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMoney, Common.n_ItemNumModify, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMoney, Common.n_ItemAdd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
end

GachaMainDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._moneyFrame):Destroy()
  ;
  (self._poolFrame):Destroy()
  if self._poolInfo then
    (self._poolInfo):Destroy()
    ;
    (self._poolInfo):RootWindowDestroy()
    self._poolInfo = nil
  end
  ;
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
  ;
  (DialogManager.DestroySingletonDialog)("gacha.firstgachadetaildialog")
  if self._baseSceneController then
    (self._baseSceneController):SetCameraAnimatorState(0)
  end
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  if self._activeGuideGroup then
    ((DialogManager.GetGroup)("Guide")):SetObjectActive(true)
    self._activeGuideGroup = false
  end
end

GachaMainDialog.Init = function(self, sceneController)
  -- function num : 0_4
  self._baseSceneController = sceneController
end

GachaMainDialog.OnBagDialogDestroy = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  if ((notification.userInfo)._dialogName ~= "equip.bagdialog" or self._activeGuideGroup) and (notification.userInfo)._dialogName == "bag.itemaccountdialog" then
    ((DialogManager.GetGroup)("Guide")):SetObjectActive(true)
    self._activeGuideGroup = false
  end
end

GachaMainDialog.OnDrawCardResult = function(self, notification)
  -- function num : 0_6
  self._hasDrawCard = false
  ;
  (self._poolFrame):ReloadAllCell()
  ;
  (self._poolFrame):MoveToTop(self._selectedPoolIndex, false)
end

GachaMainDialog.OnRefreshMoney = function(self)
  -- function num : 0_7
  (self._moneyFrame):ReloadAllCell()
  self:Refresh()
end

GachaMainDialog.Refresh = function(self)
  -- function num : 0_8 , upvalues : _ENV, CardPool, GachaType
  local pool = (self._cardPoolList)[self._selectedPoolIndex]
  while 1 do
    if pool then
      if (self._moneyList)[#self._moneyList] then
        (table.remove)(self._moneyList, #self._moneyList)
        -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local record = CardPool:GetRecorder(pool.id)
  for i,v in ipairs(record.currencyShow) do
    (table.insert)(self._moneyList, v)
  end
  ;
  (self._moneyFrame):ReloadAllCell()
  if pool.value then
    if (pool.value).itemid ~= 0 and (pool.value).moneyId ~= 0 then
      self._poolOneDrawType = GachaType.MoneyAndItem
    else
      if (pool.value).itemid == 0 and (pool.value).moneyId ~= 0 then
        self._poolOneDrawType = GachaType.Money
      else
        if (pool.value).itemid ~= 0 and (pool.value).moneyId == 0 then
          self._poolOneDrawType = GachaType.Item
        else
          self._poolOneDrawType = GachaType.Wrong
        end
      end
    end
    if (pool.value).itemidTen ~= 0 and (pool.value).moneyIdTen ~= 0 then
      self._poolTenDrawType = GachaType.MoneyAndItem
    else
      if (pool.value).itemidTen == 0 and (pool.value).moneyIdTen ~= 0 then
        self._poolTenDrawType = GachaType.Money
      else
        if (pool.value).itemidTen ~= 0 and (pool.value).moneyIdTen == 0 then
          self._poolTenDrawType = GachaType.Item
        else
          self._poolTenDrawType = GachaType.Wrong
        end
      end
    end
  end
  if not self._poolInfo then
    self._poolInfo = (DialogManager.CreateDialog)("gacha.gachapoolinfodialog", (self._poolParent)._uiObject)
    -- DECOMPILER ERROR at PC120: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._poolInfo)._delegate = self
  end
  ;
  (self._poolInfo):RefreshInfo(pool)
  ;
  (self._poolFrame):FireEvent("select", pool.id)
end

GachaMainDialog.OnRefreshPools = function(self)
  -- function num : 0_9 , upvalues : _ENV, GuidTypes, tenDrawGuidePoolId, CardPool
  if ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuidTypes.NEW_USER_TEN_DRAW) ~= 0 then
    self._tenDrawGuide = not self._tenDrawGuide
    local lastSelectedPoolId = nil
    if self._tenDrawGuide then
      lastSelectedPoolId = tenDrawGuidePoolId
    elseif self._selectedPoolIndex and #self._cardPoolList > 0 and (self._cardPoolList)[self._selectedPoolIndex] then
      lastSelectedPoolId = ((self._cardPoolList)[self._selectedPoolIndex]).id
    end
    self._selectedPoolIndex = nil
    self._cardPoolList = ((NekoData.BehaviorManager).BM_Gacha):GetGachaPools()
    ;
    (table.sort)(self._cardPoolList, function(a, b)
    -- function num : 0_9_0 , upvalues : CardPool
    local _a = (CardPool:GetRecorder(a.id)).rank
    local _b = (CardPool:GetRecorder(b.id)).rank
    if a.id >= b.id then
      do return _a ~= _b end
      do return _a < _b end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
    if lastSelectedPoolId then
      for i,v in ipairs(self._cardPoolList) do
        if v.id == lastSelectedPoolId then
          self._selectedPoolIndex = i
          break
        end
      end
    end
    local carPoolNum = #self._cardPoolList
    if carPoolNum <= 1 then
      (self._poolFrame):SetSlide(false)
    else
      (self._poolFrame):SetSlide(true)
    end
    if not self._selectedPoolIndex then
      self._selectedPoolIndex = 1
    end
    ;
    (self._poolFrame):ReloadAllCell()
    ;
    (self._poolFrame):MoveToTop()
    self:Refresh()
    -- DECOMPILER ERROR: 9 unprocessed JMP targets
  end
end

GachaMainDialog.SendProtocol = function(self, flag, type, id, costType)
  -- function num : 0_10 , upvalues : _ENV, CDrawCardDef
  local curDayTimes = ((NekoData.BehaviorManager).BM_Gacha):GetCurrentDayDrawTimes()
  local limitTimes = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(90)).Value)
  -- DECOMPILER ERROR at PC26: Unhandled construct in 'MakeBoolean' P1

  if type == CDrawCardDef.TYPE_ONE and limitTimes < curDayTimes + 1 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100320)
    return 
  end
  if (type == CDrawCardDef.TYPE_TEN or type == CDrawCardDef.TYPE_CHARGE_TEN) and limitTimes < curDayTimes + 10 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100320)
    return 
  end
  self._hasDrawCard = flag
  self._drawType = type
  local csend = (LuaNetManager.CreateProtocol)("protocol.card.cdrawcard")
  csend.poolId = id
  csend.drawType = type
  csend.costType = costType
  ;
  ((NekoData.DataManager).DM_Game):SetCurrentCardPoolID(id)
  csend:Send()
end

GachaMainDialog.OnDiscountBtnClick = function(self)
  -- function num : 0_11 , upvalues : _ENV, Item, CDrawCardDef
  if #self._cardPoolList <= 0 then
    LogError("GachaMainDialog", "there are no card pools")
  else
    local poolData = (self._cardPoolList)[self._selectedPoolIndex]
    do
      if poolData and poolData.id and not self._hasDrawCard then
        local count = (poolData.value).chargeItemNumTen
        local totalCount = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((poolData.value).chargeItemIdTen)
        if count and totalCount and count <= totalCount then
          ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(10, {count, ((Item.Create)((poolData.value).chargeItemIdTen)):GetName(), totalCount}, function()
    -- function num : 0_11_0 , upvalues : self, CDrawCardDef, poolData
    self:SendProtocol(true, CDrawCardDef.TYPE_CHARGE_TEN, poolData.id, CDrawCardDef.ITEM_COST_SOUL)
  end
, {}, nil, {})
        else
          if (poolData.value).chargeItemIdTen == DataCommon.SoulDropID then
            ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(108, nil, function()
    -- function num : 0_11_1 , upvalues : _ENV
    ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(19)
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  end
, {}, nil, {})
          else
            ;
            ((NekoData.BehaviorManager).BM_Message):SendMessageById(100017, {((Item.Create)((poolData.value).chargeItemIdTen)):GetName()})
          end
        end
      else
        do
          LogError("GachaMainDialog", "card pool data error.")
        end
      end
    end
  end
end

GachaMainDialog.OnOneBtnClick = function(self)
  -- function num : 0_12 , upvalues : _ENV, GachaType, Item, CDrawCardDef
  if #self._cardPoolList <= 0 then
    LogError("GachaMainDialog", "there are no card pools")
  else
    local poolData = (self._cardPoolList)[self._selectedPoolIndex]
    do
      if poolData and poolData.id and not self._hasDrawCard then
        local useOneItem = false
        local itemCount = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById((poolData.value).itemid)
        local itemNeedCount = (poolData.value).itemnum
        if itemNeedCount <= itemCount and itemNeedCount ~= 0 then
          useOneItem = true
        else
          useOneItem = false
        end
        local count = (poolData.value).moneyNum
        local totalCount = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((poolData.value).moneyId)
        if self._poolOneDrawType == GachaType.MoneyAndItem then
          if useOneItem then
            ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(10, {itemNeedCount, ((Item.Create)((poolData.value).itemid)):GetName(), itemCount}, function()
    -- function num : 0_12_0 , upvalues : self, CDrawCardDef, poolData
    self:SendProtocol(true, CDrawCardDef.TYPE_ONE, poolData.id, CDrawCardDef.ITEM_COST_ORDINARY)
  end
, {}, nil, {})
          else
            if count and totalCount and count <= totalCount then
              ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(10, {count, ((Item.Create)((poolData.value).moneyId)):GetName(), totalCount}, function()
    -- function num : 0_12_1 , upvalues : self, CDrawCardDef, poolData
    self:SendProtocol(true, CDrawCardDef.TYPE_ONE, poolData.id, CDrawCardDef.ITEM_COST_SOUL)
  end
, {}, nil, {})
            else
              if (poolData.value).moneyId == DataCommon.SoulDropID then
                ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(108, nil, function()
    -- function num : 0_12_2 , upvalues : _ENV
    ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(19)
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  end
, {}, nil, {})
              else
                ;
                ((NekoData.BehaviorManager).BM_Message):SendMessageById(100017, {((Item.Create)((poolData.value).moneyId)):GetName()})
              end
            end
          end
        else
          if self._poolOneDrawType == GachaType.Money then
            if count and totalCount and count <= totalCount then
              ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(10, {count, ((Item.Create)((poolData.value).moneyId)):GetName(), totalCount}, function()
    -- function num : 0_12_3 , upvalues : self, CDrawCardDef, poolData
    self:SendProtocol(true, CDrawCardDef.TYPE_ONE, poolData.id, CDrawCardDef.ITEM_COST_SOUL)
  end
, {}, nil, {})
            else
              if (poolData.value).moneyId == DataCommon.SoulDropID then
                ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(108, nil, function()
    -- function num : 0_12_4 , upvalues : _ENV
    ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(19)
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  end
, {}, nil, {})
              else
                ;
                ((NekoData.BehaviorManager).BM_Message):SendMessageById(100017, {((Item.Create)((poolData.value).moneyId)):GetName()})
              end
            end
          else
            if self._poolOneDrawType == GachaType.Item then
              if useOneItem then
                ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(10, {itemNeedCount, ((Item.Create)((poolData.value).itemid)):GetName(), itemCount}, function()
    -- function num : 0_12_5 , upvalues : self, CDrawCardDef, poolData
    self:SendProtocol(true, CDrawCardDef.TYPE_ONE, poolData.id, CDrawCardDef.ITEM_COST_ORDINARY)
  end
, {}, nil, {})
              else
                ;
                ((NekoData.BehaviorManager).BM_Message):SendMessageById(100084)
              end
            else
              LogError("GachaMainDialog", "there is no money or item to draw card")
            end
          end
        end
      else
        do
          LogError("GachaMainDialog", "card pool data error.")
        end
      end
    end
  end
end

GachaMainDialog.OnFiveBtnClick = function(self)
  -- function num : 0_13 , upvalues : _ENV, GachaType, Item, CDrawCardDef
  if #self._cardPoolList <= 0 then
    LogError("GachaMainDialog", "there are no card pools")
  else
    local poolData = (self._cardPoolList)[self._selectedPoolIndex]
    do
      if poolData and poolData.id and not self._hasDrawCard then
        local useTenItem = false
        local itemCount = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById((poolData.value).itemidTen)
        local itemNeedCount = (poolData.value).itemnumTen
        if itemNeedCount <= itemCount and itemNeedCount ~= 0 then
          useTenItem = true
        else
          useTenItem = false
        end
        local count = (poolData.value).moneyNumTen
        local totalCount = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((poolData.value).moneyIdTen)
        if self._poolTenDrawType == GachaType.MoneyAndItem then
          if useTenItem then
            ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(10, {itemNeedCount, ((Item.Create)((poolData.value).itemidTen)):GetName(), itemCount}, function()
    -- function num : 0_13_0 , upvalues : self, CDrawCardDef, poolData
    self:SendProtocol(true, CDrawCardDef.TYPE_TEN, poolData.id, CDrawCardDef.ITEM_COST_ORDINARY)
  end
, {}, nil, {})
          else
            if count and totalCount and count <= totalCount then
              ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(10, {count, ((Item.Create)((poolData.value).moneyIdTen)):GetName(), totalCount}, function()
    -- function num : 0_13_1 , upvalues : self, CDrawCardDef, poolData
    self:SendProtocol(true, CDrawCardDef.TYPE_TEN, poolData.id, CDrawCardDef.ITEM_COST_SOUL)
  end
, {}, nil, {})
            else
              if (poolData.value).moneyIdTen == DataCommon.SoulDropID then
                ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(108, nil, function()
    -- function num : 0_13_2 , upvalues : _ENV
    ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(19)
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  end
, {}, nil, {})
              else
                ;
                ((NekoData.BehaviorManager).BM_Message):SendMessageById(100017, {((Item.Create)((poolData.value).moneyIdTen)):GetName()})
              end
            end
          end
        else
          if self._poolTenDrawType == GachaType.Money then
            if count and totalCount and count <= totalCount then
              ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(10, {count, ((Item.Create)((poolData.value).moneyIdTen)):GetName(), totalCount}, function()
    -- function num : 0_13_3 , upvalues : self, CDrawCardDef, poolData
    self:SendProtocol(true, CDrawCardDef.TYPE_TEN, poolData.id, CDrawCardDef.ITEM_COST_SOUL)
  end
, {}, nil, {})
            else
              if (poolData.value).moneyIdTen == DataCommon.SoulDropID then
                ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(108, nil, function()
    -- function num : 0_13_4 , upvalues : _ENV
    ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(19)
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  end
, {}, nil, {})
              else
                ;
                ((NekoData.BehaviorManager).BM_Message):SendMessageById(100017, {((Item.Create)((poolData.value).moneyIdTen)):GetName()})
              end
            end
          else
            if self._poolTenDrawType == GachaType.Item then
              if useTenItem then
                ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(10, {itemNeedCount, ((Item.Create)((poolData.value).itemidTen)):GetName(), itemCount}, function()
    -- function num : 0_13_5 , upvalues : self, CDrawCardDef, poolData
    self:SendProtocol(true, CDrawCardDef.TYPE_TEN, poolData.id, CDrawCardDef.ITEM_COST_ORDINARY)
  end
, {}, nil, {})
              else
                ;
                ((NekoData.BehaviorManager).BM_Message):SendMessageById(100084)
              end
            else
              LogError("GachaMainDialog", "there is no money or item to draw card")
            end
          end
        end
      else
        do
          LogError("GachaMainDialog", "card pool data error.")
        end
      end
    end
  end
end

GachaMainDialog.OnTenDrawGuideBtnClick = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.card.cbeforedrawtencard")
  csend:Send()
  ;
  ((NekoData.DataManager).DM_Game):SetCurrentCardPoolID(1)
  self._hasDrawCard = true
  self._drawType = -1
end

GachaMainDialog.GetDrawType = function(self)
  -- function num : 0_15
  return self._drawType
end

GachaMainDialog.GetSelectedPool = function(self)
  -- function num : 0_16
  return (self._cardPoolList)[self._selectedPoolIndex]
end

GachaMainDialog.visibleChangeDo = function(self, cellIndex)
  -- function num : 0_17
  if cellIndex ~= self._selectedPoolIndex then
    self._selectedPoolIndex = cellIndex
    self:Refresh()
  end
end

GachaMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_18
  if frame == self._moneyFrame then
    return #self._moneyList
  else
    return #self._cardPoolList
  end
end

GachaMainDialog.CellAtIndex = function(self, frame)
  -- function num : 0_19
  if frame == self._poolFrame then
    return "gacha.poolcell"
  else
    if frame == self._moneyFrame then
      return "gacha.moneycell"
    end
  end
end

GachaMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_20
  if frame == self._poolFrame then
    return (self._cardPoolList)[index]
  else
    if frame == self._moneyFrame then
      return (self._moneyList)[index]
    end
  end
end

GachaMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(50) then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(50)
  end
  self:Destroy()
end

GachaMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_22 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

GachaMainDialog.OnPoolCellClick = function(self, data)
  -- function num : 0_23 , upvalues : _ENV
  if not data then
    LogError("nil data")
    return 
  end
  local index = nil
  for i,v in ipairs(self._cardPoolList) do
    if data.id == v.id then
      index = i
      break
    end
  end
  do
    if index then
      self._selectedPoolIndex = index
      self:Refresh()
    end
  end
end

return GachaMainDialog

