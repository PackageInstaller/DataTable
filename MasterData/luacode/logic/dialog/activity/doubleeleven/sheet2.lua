local Item = require("logic.manager.experimental.types.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CElevenItemCfg = BeanManager.GetTableByName("activity.celevenitemcfg")
local Sheet2 = class("Sheet2", Dialog)
local ColumnNum = 3
Sheet2.AssetBundleName = "ui/layouts.activityeleven"
Sheet2.AssetName = "ActivityElevenTicket"

function Sheet2:Ctor(...)
  Sheet2.super.Ctor(self, ...)
  self._cardData = {}
  self._cardCanClick = false
  self._gainItemInfo = nil
end

function Sheet2:OnCreate()
  self._activeTime = self:GetChild("ActiveTime")
  self._cardPanel = self:GetChild("FrameCard")
  self._tipsBtn = self:GetChild("Tips")
  self._poolRestar = self:GetChild("PoolRestar")
  self._poolRuler1 = self:GetChild("PoolRuler1")
  self._poolRuler2 = self:GetChild("PoolRuler2")
  self._poolRulerNum = self:GetChild("PoolRulerNum")
  self._currencyIcon = self:GetChild("Item")
  self._currencyNum = self:GetChild("NowNum")
  self._cardFrame = GridFrame.Create(self._cardPanel, self, true, ColumnNum, false)
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, function(_, notification)
    self:RefreshCardData(true, notification)
  end, Common.n_OnSOpenDoubleElevenCard, nil)
  self:SetStaticRes()
end

function Sheet2:SetStaticRes()
  self._needOnceCurrencyNum = CElevenItemCfg:GetRecorder(1).itemNum
  self._activeTime:SetText(TextManager.GetText(CStringRes:GetRecorder(1641).msgTextID))
  self._poolRestar:SetText(TextManager.GetText(CStringRes:GetRecorder(1648).msgTextID))
  self._poolRuler1:SetText(TextManager.GetText(CStringRes:GetRecorder(1646).msgTextID))
  self._poolRuler2:SetText(TextManager.GetText(CStringRes:GetRecorder(1647).msgTextID))
  self._poolRulerNum:SetText(self._needOnceCurrencyNum)
  self._currencyItem = Item.Create(DataCommon.CrystalBall)
  self._currencyIcon:SetSprite(self._currencyItem:GetIcon().assetBundle, self._currencyItem:GetIcon().assetName)
end

function Sheet2:OnDestroy()
  if self._cardFrame then
    self._cardFrame:Destroy()
  end
end

function Sheet2:SetData(data)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.DoubleElevenActivityID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DoubleElevenActivityID)
  self:RefreshCurrencyData()
  self:RefreshCardData(false)
end

function Sheet2:RefreshCurrencyData()
  local haveCurrencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.CrystalBall)
  self._currencyNum:SetText(NumberManager.GetShowNumber(haveCurrencyNum))
end

function Sheet2:RefreshCardData(refresh, notification)
  if not refresh then
    for key, _ in pairs(self._cardData) do
      self._cardData[key] = nil
    end
    local remoteCardData = self._bm:GetOpenCards()
    for i = 1, 9 do
      if remoteCardData[i] then
        local item = Item.Create(remoteCardData[i].itemId)
        item:SetCount(remoteCardData[i].itemNum)
        self._cardData[i] = {
          item = item,
          state = "ToFace",
          index = i
        }
      else
        self._cardData[i] = {state = "ToBack", index = i}
      end
    end
    self._cardFrame:ReloadAllCell()
  else
    local isGoldCard = self._bm:GetCardIsGoldCard(notification.userInfo.cardType)
    local cardIndex = notification.userInfo.position
    local cardItemInfo = notification.userInfo.itemInfo
    self._gainItemInfo = cardItemInfo
    local item = Item.Create(cardItemInfo.id)
    item:SetCount(cardItemInfo.number)
    self._cardData[cardIndex].item = item
    if isGoldCard then
      self._cardData[cardIndex].state = "HaveGoldCard"
    else
      self._cardData[cardIndex].state = "HaveNormalCard"
    end
    DialogManager.CreateSingletonDialog("guide.blockclickdialog")
    self._cardFrame:FireEvent("RefreshOneCell", {
      index = cardIndex,
      data = self._cardData
    })
  end
  self._cardCanClick = true
end

function Sheet2:CellAtIndex(frame, index)
  return "activity.doubleeleven.cardcell"
end

function Sheet2:NumberOfCell(frame, index)
  return #self._cardData
end

function Sheet2:DataAtIndex(frame, index)
  return self._cardData[index]
end

function Sheet2:OnOneCardClicked(index)
  if self._cardCanClick == false then
    return
  end
  local haveCurrencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.CrystalBall)
  if haveCurrencyNum < self._needOnceCurrencyNum then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100411)
    return
  else
    self._cardCanClick = false
    self._bm:SendOpenOneCardProtocol(index)
  end
end

function Sheet2:OnOneGoldCardToFace()
  self._bm:ClearCardsData()
  DialogManager.CreateSingletonDialog("guide.blockclickdialog")
  self._cardFrame:FireEvent("ClearAllCard")
end

function Sheet2:OnOpenCardAnimationEnd()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  if self._gainItemInfo then
    local data = {
      items = {
        self._gainItemInfo
      }
    }
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.ItemAccount,
      data = data
    })
    self._gainItemInfo = nil
  end
end

function Sheet2:OnClearCardAnimationEnd()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
end

function Sheet2:OnTipsBtnClicked()
  local dialogName = "activity.doubleeleven.tipsdialog"
  local dialog = DialogManager.CreateSingletonDialog(dialogName)
  if dialog then
    dialog:SetData(CStringRes:GetRecorder(1649).msgTextID, CStringRes:GetRecorder(1650).msgTextID)
  end
end

return Sheet2
