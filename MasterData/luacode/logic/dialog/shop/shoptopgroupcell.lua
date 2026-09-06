local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ShopTopGroupCell = class("ShopTopGroupCell", Dialog)
ShopTopGroupCell.AssetBundleName = "ui/layouts.baseshop"
ShopTopGroupCell.AssetName = "ShopTopGroupCell"

function ShopTopGroupCell:Ctor(...)
  ShopTopGroupCell.super.Ctor(self, ...)
end

function ShopTopGroupCell:OnCreate()
  self._board = self:GetChild("Num0")
  self._img = self:GetChild("Num0/Icon")
  self._num = self:GetChild("Num0/Text")
  self._addBtn = self:GetChild("Num0/Add")
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddClicked, self)
  self._board:Subscribe_PointerClickEvent(self.OnBoardClicked, self)
end

function ShopTopGroupCell:OnDestroy()
end

function ShopTopGroupCell:RefreshCell(data)
  self._data = data
  self._moneyType = tonumber(self._data.moneyType)
  if self._moneyType > 10000 then
    self._board:SetActive(true)
    local item = Item.Create(self._moneyType)
    self._img:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
  else
    self._board:SetActive(false)
  end
  if self._data.moneyType == DataCommon.AgCoinID then
    self._totalMoney = NumberManager.GetShowNumber(NekoData.BehaviorManager.BM_Activity:GetManager(2):GetDreamCoins())
  elseif self._data.moneyType == DataCommon.PVPKeys then
    self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._data.moneyType)
    self._limit = BeanManager.GetTableByName("dungeonselect.carenaapconfig"):GetRecorder(1).apLimit
    local str = TextManager.GetText(CStringRes:GetRecorder(1022).msgTextID)
    str = string.gsub(str, "%$parameter1%$", NumberManager.GetShowNumber(self._totalMoney))
    str = string.gsub(str, "%$parameter2%$", NumberManager.GetShowNumber(self._limit))
    self._totalMoney = str
  else
    self._totalMoney = NumberManager.GetShowNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._data.moneyType))
  end
  self._num:SetText(self._totalMoney)
  if self._data.moneyType == DataCommon.FriendShipID or self._data.moneyType == DataCommon.WhiteCoin or self._data.moneyType == DataCommon.GoldCoin or self._data.moneyType == DataCommon.FurnitureCion or self._data.moneyType == DataCommon.FashionID or self._data.moneyType == DataCommon.TowerCoin or self._data.moneyType == DataCommon.PVPCoin or self._data.moneyType == DataCommon.GuildCoin then
    self._addBtn:SetActive(false)
  else
    self._addBtn:SetActive(true)
  end
end

function ShopTopGroupCell:OnAddClicked()
  if self._moneyType == DataCommon.DiamodID then
    NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(4)
  elseif self._moneyType == DataCommon.ManaID then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = Item.Create(DataCommon.ManaID)
      })
      local width, height = self._addBtn:GetRectSize()
      tipsDialog:SetTipsPosition(width, height, self._addBtn:GetLocalPointInUiRootPanel())
    end
  elseif self._moneyType == DataCommon.SpiritID then
    NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  elseif self._moneyType == DataCommon.AgCoinID then
    local dialog = DialogManager.GetDialog("task.taskmaindialog")
    if dialog then
      DialogManager.DestroySingletonDialog("task.taskmaindialog")
    end
    local dlg = DialogManager.CreateSingletonDialog("task.taskmaindialog")
    if dlg then
      dlg:ToPage(5)
    end
  elseif self._moneyType == DataCommon.PVPKeys then
    local exchangeTimes = NekoData.BehaviorManager.BM_Activity:GetKeyExchangeTimes()
    if exchangeTimes <= 0 then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100233)
      return
    end
    local dialog = DialogManager.CreateSingletonDialog("mainline.offlinepvp.offlinepvpexchangekeyconfirm")
    if dialog then
      dialog:Init(exchangeTimes)
    end
  elseif self._moneyType == DataCommon.SoulDropID then
    NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(19)
  end
end

function ShopTopGroupCell:OnBoardClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(self._moneyType)
    })
    local width, height = self._board:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._board:GetLocalPointInUiRootPanel())
  end
end

return ShopTopGroupCell
