-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/dreamspiralunlockdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Role = require("logic.manager.experimental.types.role")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkinShopCfg = (BeanManager.GetTableByName)("recharge.cskinshopspecialcfg")
local UIBackManager = require("framework.ui.uibackmanager")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UnlockCfg = (BeanManager.GetTableByName)("recharge.cseasonpassunlock")
local CRole = (BeanManager.GetTableByName)("item.croleitem")
local CSkinItem = (BeanManager.GetTableByName)("item.cskinitem")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local DreamSpiralUnlockDialog = class("DreamSpiralUnlockDialog", Dialog)
DreamSpiralUnlockDialog.AssetBundleName = "ui/layouts.baseshop"
DreamSpiralUnlockDialog.AssetName = "BattlePassBuy"
DreamSpiralUnlockDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DreamSpiralUnlockDialog
  ((DreamSpiralUnlockDialog.super).Ctor)(self, ...)
  self._groupName = "ModalFrame"
  self._handler = nil
  self._modelHandle = nil
  self._roleData = nil
  self._fashionName = ""
  self._roleName = ""
end

DreamSpiralUnlockDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._time = self:GetChild("Panel/Time")
  self._price = self:GetChild("Panel/Price/Num")
  self._priceIcon = self:GetChild("Panel/Price/RMB")
  self._nameImage = self:GetChild("Panel/NameImg")
  self._rolePanel = self:GetChild("Panel/Role")
  self._live2D = self:GetChild("Panel/Role/Live2D")
  self._rolePhoto = self:GetChild("Panel/Role/Photo")
  self._buyBtn = self:GetChild("Panel/BuyBtn")
  self._closeBtn = self:GetChild("Panel/CloseBtn")
  local frame = self:GetChild("Panel/Frame")
  self._frame = (GridFrame.Create)(frame, self, true, 4, true)
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBackBtnClicked, Common.n_DreamSpiralRefresh, nil)
end

DreamSpiralUnlockDialog.OnBackBtnClicked = function(self)
  -- function num : 0_2
  self:Destroy()
end

DreamSpiralUnlockDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._handler then
    (self._live2D):Release(self._handler)
    self._live2D = nil
    self._handler = nil
  end
  ;
  (self._frame):Destroy()
end

local handleData = function(items, itemId, num)
  -- function num : 0_4
  if itemId <= 0 then
    return 
  end
  if not items[itemId] then
    items[itemId] = num
  else
    items[itemId] = items[itemId] + num
  end
end

DreamSpiralUnlockDialog.Refresh = function(self, moneyType)
  -- function num : 0_5 , upvalues : Item, _ENV, UnlockCfg, CRole, Role, CImagePathTable, handleData
  local imageRecord = ((Item.Create)(moneyType)):GetIcon()
  ;
  (self._priceIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local id = DataCommon.AgCoinActivityID
  local mgr = ((NekoData.BehaviorManager).BM_Activity):GetManager(id)
  self._info = mgr:GetBaseInfo()
  local datalist = mgr:GetColltion()
  ;
  (self._price):SetText(((self._info).chargeInfo).price)
  local d = (os.date)("*t", (self._info).endTime // 1000)
  local mid = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1334)).msgTextID
  local str = (TextManager.GetText)(mid)
  str = (string.gsub)(str, "%$parameter1%$", d.year)
  str = (string.gsub)(str, "%$parameter2%$", d.month)
  str = (string.gsub)(str, "%$parameter3%$", d.day)
  str = (string.gsub)(str, "%$parameter4%$", (string.format)("%02d:%02d:%02d", d.hour, d.min, d.sec))
  ;
  (self._time):SetText(str)
  local unlockCfg = UnlockCfg:GetRecorder((self._info).actId)
  local itemId = unlockCfg.ItemID
  local roleCfg = CRole:GetRecorder(itemId)
  local role = (Role.Create)(roleCfg.roleid)
  local shapeRecord = role:GetShapeLive2DRecord()
  ;
  (self._rolePanel):SetAnimatorTrigger("loadReady")
  if not CImagePathTable:GetRecorder(unlockCfg.nameImageID) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._nameImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if (Live2DManager.CanUse)() and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DPrefabName ~= nil and shapeRecord.live2DAssetBundleName ~= "" and shapeRecord.live2DAssetBundleName ~= nil and not self._handler then
    (self._rolePhoto):SetActive(false)
    self._handler = (self._live2D):AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
  end
  local lihuiImage = role:GetShapeLiHuiImageRecord()
  ;
  (self._rolePhoto):SetActive(true)
  ;
  (self._rolePhoto):SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
  local scale = role:GetPhotoScale()
  ;
  (self._rolePhoto):SetLocalScale(scale, scale, scale)
  do
    local photoPos = role:GetPhotoPosition()
    ;
    (self._rolePhoto):SetAnchoredPosition(photoPos[1], photoPos[2])
    local items = {}
    for k,v in ipairs(datalist) do
      if (v.high).itemId > 0 then
        handleData(items, (v.high).itemId, (v.high).itemNum)
      end
    end
    local itemList = {}
    for k,v in pairs(items) do
      local item = (Item.Create)(k)
      item:SetCount(v)
      ;
      (table.insert)(itemList, item)
    end
    ;
    (table.sort)(itemList, function(aItem, bItem)
    -- function num : 0_5_0
    if bItem:GetID() >= aItem:GetID() then
      do return aItem:GetPinJiID() ~= bItem:GetPinJiID() end
      do return bItem:GetPinJiID() < aItem:GetPinJiID() end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
    self._items = itemList
    ;
    (self._frame):ReloadAllCell()
  end
end

DreamSpiralUnlockDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local hasDiamond = ((NekoData.BehaviorManager).BM_Currency):GetDiamond()
  if ((self._info).chargeInfo).price <= hasDiamond then
    local cmd = (LuaNetManager.CreateProtocol)("protocol.activity.cunlockhigh")
    if cmd then
      cmd:Send()
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(15, nil, function()
    -- function num : 0_6_0 , upvalues : _ENV
    local dialog = (DialogManager.GetDialog)("shop.shopmaindialog")
    if dialog then
      (DialogManager.DestroySingletonDialog)("shop.shopmaindialog")
    end
    ;
    ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(4)
    ;
    (DialogManager.DestroySingletonDialog)("shop.dreamspiralunlockdialog")
  end
, {}, nil, {})
    end
  end
end

DreamSpiralUnlockDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._items
end

DreamSpiralUnlockDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "shop.dreamspiralitemcell"
end

DreamSpiralUnlockDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._items)[index]
end

return DreamSpiralUnlockDialog

