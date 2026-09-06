local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SkinTypeId = 91
local Sheet2 = class("Sheet2", Dialog)
Sheet2.AssetBundleName = "ui/layouts.activityspringouting"
Sheet2.AssetName = "ActivitySpringOutingShop"

function Sheet2:Ctor(...)
  Sheet2.super.Ctor(self, ...)
  self._goodsData = {}
end

function Sheet2:OnCreate()
  self._activityTime = self:GetChild("ActiveTime")
  self._desTxt = self:GetChild("Txt")
  self._tipsBtn = self:GetChild("Tips")
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._cellPanel = self:GetChild("FrameShop")
  self._cellFrame = TableFrame.Create(self._cellPanel, self, false, true, false)
  LuaNotificationCenter.AddObserver(self, self.OnSDragonBoatFestivalInfo, Common.n_SDragonBoatFestivalInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshShopInfo, Common.n_RefreshShopInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshShopInfo, Common.n_BuyShopGood, nil)
  self:SetStaticRes()
end

function Sheet2:SetStaticRes()
  self._activityTime:SetText(TextManager.GetText(CStringRes:GetRecorder(1812).msgTextID))
  self._desTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1842).msgTextID))
end

function Sheet2:OnDestroy()
  if self._cellFrame then
    self._cellFrame:Destroy()
  end
end

function Sheet2:SetData(shopID)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._shopID = shopID
  self:RefreshShopInfo()
end

function Sheet2:RefreshShopInfo()
  local goodsData = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(self._shopID)
  if PrintTable then
    LogError("_shopID", tostring(self._shopID))
    PrintTable(goodsData, 3, "goodsData")
  end
  if #goodsData ~= 3 then
    LogErrorFormat("DragonBoatFestival.Sheet2.SetData", "The shop goods length error! | %d", #goodsData)
    return
  end
  if self._goodsData then
    for key, _ in pairs(self._goodsData) do
      self._goodsData[key] = nil
    end
  else
    self._goodsData = {}
  end
  for _, value in pairs(goodsData) do
    table.insert(self._goodsData, value)
  end
  table.sort(self._goodsData, function(a, b)
    return a.discountPrice < b.discountPrice
  end)
  self._cellFrame:ReloadAllCell()
end

function Sheet2:NumberOfCell(frame)
  return #self._goodsData
end

function Sheet2:CellAtIndex(frame, index)
  return "activity.dragonboatfestival.shopgoodscell"
end

function Sheet2:DataAtIndex(frame, index)
  return {
    data = self._goodsData[index],
    index = index
  }
end

function Sheet2:OnTipsBtnClicked()
  local dialogName = "activity.dragonboatfestival.tipsdialog"
  local dialog = DialogManager.CreateSingletonDialog(dialogName)
  if dialog then
    dialog:SetData(CStringRes:GetRecorder(1810).msgTextID, CStringRes:GetRecorder(1814).msgTextID)
  end
end

function Sheet2:OnSDragonBoatFestivalInfo()
end

return Sheet2
