local CDrawCardDef = LuaNetManager.GetProtocolDef("protocol.card.cdrawcard")
local CardPool = BeanManager.GetTableByName("item.ccardpool")
local TableFrame = require("framework.ui.frame.table.tableframe")
local LoopTableFrame = require("framework.ui.frame.looptable.looptableframe")
local Item = require("logic.manager.experimental.types.item")
local CSoulExchangeRecord = BeanManager.GetTableByName("item.csoulexchange"):GetRecorder(1)
local tenDrawGuidePoolId = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(44).Value)
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local GachaType = {
  Money = 1,
  Item = 2,
  MoneyAndItem = 3,
  Wrong = 4
}
local GachaMainDialog = class("GachaMainDialog", Dialog)
GachaMainDialog.AssetBundleName = "ui/layouts.gacha"
GachaMainDialog.AssetName = "GachaMain"

local function HandleGuideStatusChanged(self, notification)
  if notification.userInfo.guideID == 7 and notification.userInfo.guideStatus ~= "Start" then
    self._activeGuideGroup = true
  end
end

function GachaMainDialog:Ctor(...)
  GachaMainDialog.super.Ctor(self, ...)
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

function GachaMainDialog:OnCreate()
  self._moneyPanel = self:GetChild("TopFrame")
  self._poolParent = self:GetChild("Frame")
  self._FirstGachaFrameParent = self:GetChild("FirstGachaFrame")
  self._poolPanel = self:GetChild("PoolList")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._moneyFrame = TableFrame.Create(self._moneyPanel, self, false, false, true)
  self._poolFrame = TableFrame.Create(self._poolPanel, self, true, true, true)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  if NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuidTypes.NEW_USER_TEN_DRAW) == 0 then
    self._tenDrawGuide = true
  end
  if self._tenDrawGuide then
    self._FirstGachaInfo = DialogManager.CreateSingletonChildDialog("gacha.firstgachadetaildialog", self._dialogName, self:GetRootWindow())
  end
  self:OnRefreshPools()
  LuaNotificationCenter.AddObserver(self, self.OnBagDialogDestroy, Common.n_DialogWillDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshPools, Common.n_RefreshDrawCardPool, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDrawCardResult, Common.n_DrawCard, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMoney, Common.n_ItemNumModify, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMoney, Common.n_ItemAdd, nil)
  LuaNotificationCenter.AddObserver(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
end

function GachaMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._moneyFrame:Destroy()
  self._poolFrame:Destroy()
  if self._poolInfo then
    self._poolInfo:Destroy()
    self._poolInfo:RootWindowDestroy()
    self._poolInfo = nil
  end
  DialogManager.DestroySingletonDialog("mainline.bossrush.checkotherroleinfodialog")
  DialogManager.DestroySingletonDialog("gacha.firstgachadetaildialog")
  if self._baseSceneController then
    self._baseSceneController:SetCameraAnimatorState(0)
  end
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  if self._activeGuideGroup then
    DialogManager.GetGroup("Guide"):SetObjectActive(true)
    self._activeGuideGroup = false
  end
end

function GachaMainDialog:Init(sceneController)
  self._baseSceneController = sceneController
end

function GachaMainDialog:OnBagDialogDestroy(notification)
  if notification.userInfo._dialogName == "equip.bagdialog" then
  elseif self._activeGuideGroup and notification.userInfo._dialogName == "bag.itemaccountdialog" then
    DialogManager.GetGroup("Guide"):SetObjectActive(true)
    self._activeGuideGroup = false
  end
end

function GachaMainDialog:OnDrawCardResult(notification)
  LogInfoFormat("GachaMainDialog", "=====OnDrawCardResult 111")
  self._hasDrawCard = false
  self._poolFrame:ReloadAllCell()
  self._poolFrame:MoveToTop(self._selectedPoolIndex, false)
  LogInfoFormat("GachaMainDialog", "=====OnDrawCardResult 222")
end

function GachaMainDialog:OnRefreshMoney()
  self._moneyFrame:ReloadAllCell()
  self:Refresh()
end

function GachaMainDialog:Refresh()
  local pool = self._cardPoolList[self._selectedPoolIndex]
  if pool then
    while self._moneyList[#self._moneyList] do
      table.remove(self._moneyList, #self._moneyList)
    end
    local record = CardPool:GetRecorder(pool.id)
    for i, v in ipairs(record.currencyShow) do
      table.insert(self._moneyList, v)
    end
    self._moneyFrame:ReloadAllCell()
    if pool.value then
      if pool.value.itemid ~= 0 and pool.value.moneyId ~= 0 then
        self._poolOneDrawType = GachaType.MoneyAndItem
      elseif pool.value.itemid == 0 and pool.value.moneyId ~= 0 then
        self._poolOneDrawType = GachaType.Money
      elseif pool.value.itemid ~= 0 and pool.value.moneyId == 0 then
        self._poolOneDrawType = GachaType.Item
      else
        self._poolOneDrawType = GachaType.Wrong
      end
      if pool.value.itemidTen ~= 0 and pool.value.moneyIdTen ~= 0 then
        self._poolTenDrawType = GachaType.MoneyAndItem
      elseif pool.value.itemidTen == 0 and pool.value.moneyIdTen ~= 0 then
        self._poolTenDrawType = GachaType.Money
      elseif pool.value.itemidTen ~= 0 and pool.value.moneyIdTen == 0 then
        self._poolTenDrawType = GachaType.Item
      else
        self._poolTenDrawType = GachaType.Wrong
      end
    end
    if not self._poolInfo then
      self._poolInfo = DialogManager.CreateDialog("gacha.gachapoolinfodialog", self._poolParent._uiObject)
      self._poolInfo._delegate = self
    end
    self._poolInfo:RefreshInfo(pool)
    self._poolFrame:FireEvent("select", pool.id)
  end
end

function GachaMainDialog:OnRefreshPools()
  if self._tenDrawGuide then
    self._tenDrawGuide = NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuidTypes.NEW_USER_TEN_DRAW) == 0
  end
  local lastSelectedPoolId
  if self._tenDrawGuide then
    lastSelectedPoolId = tenDrawGuidePoolId
  elseif self._selectedPoolIndex and 0 < #self._cardPoolList and self._cardPoolList[self._selectedPoolIndex] then
    lastSelectedPoolId = self._cardPoolList[self._selectedPoolIndex].id
  end
  self._selectedPoolIndex = nil
  self._cardPoolList = NekoData.BehaviorManager.BM_Gacha:GetGachaPools()
  table.sort(self._cardPoolList, function(a, b)
    local _a = CardPool:GetRecorder(a.id).rank
    local _b = CardPool:GetRecorder(b.id).rank
    if _a == _b then
      return a.id < b.id
    else
      return _a < _b
    end
  end)
  if lastSelectedPoolId then
    for i, v in ipairs(self._cardPoolList) do
      if v.id == lastSelectedPoolId then
        self._selectedPoolIndex = i
        break
      end
    end
  end
  local carPoolNum = #self._cardPoolList
  if carPoolNum <= 1 then
    self._poolFrame:SetSlide(false)
  else
    self._poolFrame:SetSlide(true)
  end
  if not self._selectedPoolIndex then
    self._selectedPoolIndex = 1
  end
  self._poolFrame:ReloadAllCell()
  self._poolFrame:MoveToTop()
  self:Refresh()
end

function GachaMainDialog:SendProtocol(flag, type, id, costType)
  local curDayTimes = NekoData.BehaviorManager.BM_Gacha:GetCurrentDayDrawTimes()
  local limitTimes = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(90).Value)
  if type == CDrawCardDef.TYPE_ONE then
    if limitTimes < curDayTimes + 1 then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100320)
      return
    end
  elseif (type == CDrawCardDef.TYPE_TEN or type == CDrawCardDef.TYPE_CHARGE_TEN) and limitTimes < curDayTimes + 10 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100320)
    return
  end
  self._hasDrawCard = flag
  self._drawType = type
  local csend = LuaNetManager.CreateProtocol("protocol.card.cdrawcard")
  csend.poolId = id
  csend.drawType = type
  csend.costType = costType
  NekoData.DataManager.DM_Game:SetCurrentCardPoolID(id)
  csend:Send()
end

function GachaMainDialog:OnDiscountBtnClick()
  if #self._cardPoolList <= 0 then
    LogError("GachaMainDialog", "there are no card pools")
  else
    local poolData = self._cardPoolList[self._selectedPoolIndex]
    if poolData and poolData.id and not self._hasDrawCard then
      local count = poolData.value.chargeItemNumTen
      local totalCount = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(poolData.value.chargeItemIdTen)
      if count and totalCount and count <= totalCount then
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(10, {
          count,
          Item.Create(poolData.value.chargeItemIdTen):GetName(),
          totalCount
        }, function()
          self:SendProtocol(true, CDrawCardDef.TYPE_CHARGE_TEN, poolData.id, CDrawCardDef.ITEM_COST_SOUL)
        end, {}, nil, {})
      elseif poolData.value.chargeItemIdTen == DataCommon.SoulDropID then
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(108, nil, function()
          NekoData.DataManager.DM_Shop:ClientSetOpenShopID(19)
          local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
          if protocol then
            protocol:Send()
          end
        end, {}, nil, {})
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100017, {
          Item.Create(poolData.value.chargeItemIdTen):GetName()
        })
      end
    else
      LogError("GachaMainDialog", "card pool data error.")
    end
  end
end

function GachaMainDialog:OnOneBtnClick()
  if #self._cardPoolList <= 0 then
    LogError("GachaMainDialog", "there are no card pools")
  else
    local poolData = self._cardPoolList[self._selectedPoolIndex]
    if poolData and poolData.id and not self._hasDrawCard then
      local useOneItem = false
      local itemCount = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(poolData.value.itemid)
      local itemNeedCount = poolData.value.itemnum
      if itemCount >= itemNeedCount and itemNeedCount ~= 0 then
        useOneItem = true
      else
        useOneItem = false
      end
      local count = poolData.value.moneyNum
      local totalCount = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(poolData.value.moneyId)
      if self._poolOneDrawType == GachaType.MoneyAndItem then
        if useOneItem then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(10, {
            itemNeedCount,
            Item.Create(poolData.value.itemid):GetName(),
            itemCount
          }, function()
            self:SendProtocol(true, CDrawCardDef.TYPE_ONE, poolData.id, CDrawCardDef.ITEM_COST_ORDINARY)
          end, {}, nil, {})
        elseif count and totalCount and count <= totalCount then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(10, {
            count,
            Item.Create(poolData.value.moneyId):GetName(),
            totalCount
          }, function()
            self:SendProtocol(true, CDrawCardDef.TYPE_ONE, poolData.id, CDrawCardDef.ITEM_COST_SOUL)
          end, {}, nil, {})
        elseif poolData.value.moneyId == DataCommon.SoulDropID then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(108, nil, function()
            NekoData.DataManager.DM_Shop:ClientSetOpenShopID(19)
            local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
            if protocol then
              protocol:Send()
            end
          end, {}, nil, {})
        else
          NekoData.BehaviorManager.BM_Message:SendMessageById(100017, {
            Item.Create(poolData.value.moneyId):GetName()
          })
        end
      elseif self._poolOneDrawType == GachaType.Money then
        if count and totalCount and count <= totalCount then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(10, {
            count,
            Item.Create(poolData.value.moneyId):GetName(),
            totalCount
          }, function()
            self:SendProtocol(true, CDrawCardDef.TYPE_ONE, poolData.id, CDrawCardDef.ITEM_COST_SOUL)
          end, {}, nil, {})
        elseif poolData.value.moneyId == DataCommon.SoulDropID then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(108, nil, function()
            NekoData.DataManager.DM_Shop:ClientSetOpenShopID(19)
            local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
            if protocol then
              protocol:Send()
            end
          end, {}, nil, {})
        else
          NekoData.BehaviorManager.BM_Message:SendMessageById(100017, {
            Item.Create(poolData.value.moneyId):GetName()
          })
        end
      elseif self._poolOneDrawType == GachaType.Item then
        if useOneItem then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(10, {
            itemNeedCount,
            Item.Create(poolData.value.itemid):GetName(),
            itemCount
          }, function()
            self:SendProtocol(true, CDrawCardDef.TYPE_ONE, poolData.id, CDrawCardDef.ITEM_COST_ORDINARY)
          end, {}, nil, {})
        else
          NekoData.BehaviorManager.BM_Message:SendMessageById(100084)
        end
      else
        LogError("GachaMainDialog", "there is no money or item to draw card")
      end
    else
      LogError("GachaMainDialog", "card pool data error.")
    end
  end
end

function GachaMainDialog:OnFiveBtnClick()
  if #self._cardPoolList <= 0 then
    LogError("GachaMainDialog", "there are no card pools")
  else
    local poolData = self._cardPoolList[self._selectedPoolIndex]
    if poolData and poolData.id and not self._hasDrawCard then
      local useTenItem = false
      local itemCount = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(poolData.value.itemidTen)
      local itemNeedCount = poolData.value.itemnumTen
      if itemCount >= itemNeedCount and itemNeedCount ~= 0 then
        useTenItem = true
      else
        useTenItem = false
      end
      local count = poolData.value.moneyNumTen
      local totalCount = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(poolData.value.moneyIdTen)
      if self._poolTenDrawType == GachaType.MoneyAndItem then
        if useTenItem then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(10, {
            itemNeedCount,
            Item.Create(poolData.value.itemidTen):GetName(),
            itemCount
          }, function()
            self:SendProtocol(true, CDrawCardDef.TYPE_TEN, poolData.id, CDrawCardDef.ITEM_COST_ORDINARY)
          end, {}, nil, {})
        elseif count and totalCount and count <= totalCount then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(10, {
            count,
            Item.Create(poolData.value.moneyIdTen):GetName(),
            totalCount
          }, function()
            self:SendProtocol(true, CDrawCardDef.TYPE_TEN, poolData.id, CDrawCardDef.ITEM_COST_SOUL)
          end, {}, nil, {})
        elseif poolData.value.moneyIdTen == DataCommon.SoulDropID then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(108, nil, function()
            NekoData.DataManager.DM_Shop:ClientSetOpenShopID(19)
            local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
            if protocol then
              protocol:Send()
            end
          end, {}, nil, {})
        else
          NekoData.BehaviorManager.BM_Message:SendMessageById(100017, {
            Item.Create(poolData.value.moneyIdTen):GetName()
          })
        end
      elseif self._poolTenDrawType == GachaType.Money then
        if count and totalCount and count <= totalCount then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(10, {
            count,
            Item.Create(poolData.value.moneyIdTen):GetName(),
            totalCount
          }, function()
            self:SendProtocol(true, CDrawCardDef.TYPE_TEN, poolData.id, CDrawCardDef.ITEM_COST_SOUL)
          end, {}, nil, {})
        elseif poolData.value.moneyIdTen == DataCommon.SoulDropID then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(108, nil, function()
            NekoData.DataManager.DM_Shop:ClientSetOpenShopID(19)
            local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
            if protocol then
              protocol:Send()
            end
          end, {}, nil, {})
        else
          NekoData.BehaviorManager.BM_Message:SendMessageById(100017, {
            Item.Create(poolData.value.moneyIdTen):GetName()
          })
        end
      elseif self._poolTenDrawType == GachaType.Item then
        if useTenItem then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(10, {
            itemNeedCount,
            Item.Create(poolData.value.itemidTen):GetName(),
            itemCount
          }, function()
            self:SendProtocol(true, CDrawCardDef.TYPE_TEN, poolData.id, CDrawCardDef.ITEM_COST_ORDINARY)
          end, {}, nil, {})
        else
          NekoData.BehaviorManager.BM_Message:SendMessageById(100084)
        end
      else
        LogError("GachaMainDialog", "there is no money or item to draw card")
      end
    else
      LogError("GachaMainDialog", "card pool data error.")
    end
  end
end

function GachaMainDialog:OnTenDrawGuideBtnClick()
  local csend = LuaNetManager.CreateProtocol("protocol.card.cbeforedrawtencard")
  csend:Send()
  NekoData.DataManager.DM_Game:SetCurrentCardPoolID(1)
  self._hasDrawCard = true
  self._drawType = -1
end

function GachaMainDialog:GetDrawType()
  return self._drawType
end

function GachaMainDialog:GetSelectedPool()
  return self._cardPoolList[self._selectedPoolIndex]
end

function GachaMainDialog:visibleChangeDo(cellIndex)
  if cellIndex ~= self._selectedPoolIndex then
    self._selectedPoolIndex = cellIndex
    self:Refresh()
  end
end

function GachaMainDialog:NumberOfCell(frame)
  if frame == self._moneyFrame then
    return #self._moneyList
  else
    return #self._cardPoolList
  end
end

function GachaMainDialog:CellAtIndex(frame)
  if frame == self._poolFrame then
    return "gacha.poolcell"
  elseif frame == self._moneyFrame then
    return "gacha.moneycell"
  end
end

function GachaMainDialog:DataAtIndex(frame, index)
  if frame == self._poolFrame then
    return self._cardPoolList[index]
  elseif frame == self._moneyFrame then
    return self._moneyList[index]
  end
end

function GachaMainDialog:OnBackBtnClicked()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(50) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(50)
  end
  self:Destroy()
end

function GachaMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function GachaMainDialog:OnPoolCellClick(data)
  if not data then
    LogError("nil data")
    return
  end
  local index
  for i, v in ipairs(self._cardPoolList) do
    if data.id == v.id then
      index = i
      break
    end
  end
  if index then
    self._selectedPoolIndex = index
    self:Refresh()
  end
end

return GachaMainDialog
