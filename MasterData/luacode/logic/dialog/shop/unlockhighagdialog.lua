local Item = require("logic.manager.experimental.types.item")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local UnLockHighAgDialog = class("UnLockHighAgDialog", Dialog)
local UIManager = CS.PixelNeko.UI.UIManager
UnLockHighAgDialog.AssetBundleName = "ui/layouts.baseshop"
UnLockHighAgDialog.AssetName = "CoinHighBuy"

function UnLockHighAgDialog:Ctor(...)
  UnLockHighAgDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function UnLockHighAgDialog:OnCreate()
  self._endTimeTxt = self:GetChild("Back/Time")
  self._unlockItemIcon = self:GetChild("Back/Frame/Image")
  self._unlockItemNum = self:GetChild("Back/Frame/Num")
  self._unLockCollections = {}
  for i = 1, 5 do
    self._unLockCollections[i] = self:GetChild("Back/Frame/Detail" .. i)
  end
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  self:GetChild("Back"):Subscribe_PointerClickEvent(self.OnBackClicked, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:InitUIData()
end

function UnLockHighAgDialog:OnDestroy()
end

function UnLockHighAgDialog:InitUIData()
  local endtime = NekoData.BehaviorManager.BM_Activity:GetEndTime(DataCommon.AgCoinActivityID)
  local timeStr = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1183).msgTextID)
  timeStr = string.gsub(str, "%$parameter1%$", ServerGameTimer.GetDetailTimeStr(endtime))
  self._endTimeTxt:SetText(timeStr)
  local manager = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  local item = Item.Create(manager:GetUnLockHighItemid())
  self._unlockItemIcon:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
  self._unlockItemNum:SetText(manager:GetUnLockHighItemNum())
  local collections = manager:GetColltion()
  local highCollections = {}
  for i = 1, #collections do
    local id = collections[i].highItemId
    local num = collections[i].highItemNum
    if not highCollections[id] then
      highCollections[id] = num
    else
      highCollections[id] = highCollections[id] + num
    end
  end
  local index = 0
  for id, num in pairs(highCollections) do
    index = index + 1
    local itemName = TextManager.GetText(CItemAttrTable:GetRecorder(id).nameTextID)
    local str = itemName .. " X" .. num
    if self._unLockCollections[index] then
      self._unLockCollections[index]:SetText(str)
    end
  end
  for i = index + 1, 5 do
    self._unLockCollections[i]:SetActive(false)
  end
end

function UnLockHighAgDialog:OnBuyBtnClicked()
  local limiteTaskEndtime = NekoData.BehaviorManager.BM_Activity:GetEndTime(DataCommon.AgCoinActivityID)
  if not limiteTaskEndtime then
    local dialog = DialogManager.GetDialog("shop.shopmaindialog")
    if dialog then
    end
    NekoData.BehaviorManager.BM_Message:SendMessageById(100120)
    self:Destroy()
    return
  end
  local manager = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  if manager:GetUnLockHighItemid() == DataCommon.DiamodID and not NekoData.BehaviorManager.BM_Currency:IsDiamodEnough(manager:GetUnLockHighItemNum()) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100077)
    self:Destroy()
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cunlockhigh")
  protocol:Send()
  self:Destroy()
end

function UnLockHighAgDialog:OnBackClicked()
end

function UnLockHighAgDialog:OnBackBtnClicked()
  self:Destroy()
end

return UnLockHighAgDialog
