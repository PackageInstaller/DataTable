-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/unlockhighagdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local UnLockHighAgDialog = class("UnLockHighAgDialog", Dialog)
local UIManager = ((CS.PixelNeko).UI).UIManager
UnLockHighAgDialog.AssetBundleName = "ui/layouts.baseshop"
UnLockHighAgDialog.AssetName = "CoinHighBuy"
UnLockHighAgDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UnLockHighAgDialog
  ((UnLockHighAgDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

UnLockHighAgDialog.OnCreate = function(self)
  -- function num : 0_1
  self._endTimeTxt = self:GetChild("Back/Time")
  self._unlockItemIcon = self:GetChild("Back/Frame/Image")
  self._unlockItemNum = self:GetChild("Back/Frame/Num")
  self._unLockCollections = {}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

    (self._unLockCollections)[i] = self:GetChild("Back/Frame/Detail" .. i)
  end
  self._buyBtn = self:GetChild("Back/BuyBtn")
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (self:GetChild("Back")):Subscribe_PointerClickEvent(self.OnBackClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:InitUIData()
end

UnLockHighAgDialog.OnDestroy = function(self)
  -- function num : 0_2
end

UnLockHighAgDialog.InitUIData = function(self)
  -- function num : 0_3 , upvalues : _ENV, Item, CItemAttrTable
  local endtime = ((NekoData.BehaviorManager).BM_Activity):GetEndTime(DataCommon.AgCoinActivityID)
  local timeStr = (TextManager.GetText)((((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1183)).msgTextID)
  timeStr = (string.gsub)(str, "%$parameter1%$", (ServerGameTimer.GetDetailTimeStr)(endtime))
  ;
  (self._endTimeTxt):SetText(timeStr)
  local manager = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
  local item = (Item.Create)(manager:GetUnLockHighItemid())
  ;
  (self._unlockItemIcon):SetSprite((item:GetIcon()).assetBundle, (item:GetIcon()).assetName)
  ;
  (self._unlockItemNum):SetText(manager:GetUnLockHighItemNum())
  local collections = manager:GetColltion()
  local highCollections = {}
  for i = 1, #collections do
    local id = (collections[i]).highItemId
    local num = (collections[i]).highItemNum
    if not highCollections[id] then
      highCollections[id] = num
    else
      highCollections[id] = highCollections[id] + num
    end
  end
  local index = 0
  for id,num in pairs(highCollections) do
    index = index + 1
    local itemName = (TextManager.GetText)((CItemAttrTable:GetRecorder(id)).nameTextID)
    local str = itemName .. " X" .. num
    if (self._unLockCollections)[index] then
      ((self._unLockCollections)[index]):SetText(str)
    end
  end
  for i = index + 1, 5 do
    ((self._unLockCollections)[i]):SetActive(false)
  end
end

UnLockHighAgDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local limiteTaskEndtime = ((NekoData.BehaviorManager).BM_Activity):GetEndTime(DataCommon.AgCoinActivityID)
  if not limiteTaskEndtime then
    local dialog = (DialogManager.GetDialog)("shop.shopmaindialog")
    if dialog then
      do
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100120)
        self:Destroy()
        do return  end
        local manager = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
        if manager:GetUnLockHighItemid() == DataCommon.DiamodID and not ((NekoData.BehaviorManager).BM_Currency):IsDiamodEnough(manager:GetUnLockHighItemNum()) then
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100077)
          self:Destroy()
          return 
        end
        local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cunlockhigh")
        protocol:Send()
        self:Destroy()
      end
    end
  end
end

UnLockHighAgDialog.OnBackClicked = function(self)
  -- function num : 0_5
end

UnLockHighAgDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

return UnLockHighAgDialog

