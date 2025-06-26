-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/equipbookcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipBookCell = class("EquipBookCell", Dialog)
EquipBookCell.AssetBundleName = "ui/layouts.tujian"
EquipBookCell.AssetName = "EquipBookCell"
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local PinJiTable = (BeanManager.GetTableByName)("item.citempinji")
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
EquipBookCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBookCell
  ((EquipBookCell.super).Ctor)(self, ...)
end

EquipBookCell.OnCreate = function(self)
  -- function num : 0_1
  self._normal = self:GetChild("Normal")
  self._normalBack = self:GetChild("Normal/Back")
  self._icon = self:GetChild("Normal/Icon")
  self._select = self:GetChild("Select")
  self._lock = self:GetChild("Lock")
  self._lockItemIcon = self:GetChild("Lock/Icon_black")
  self._num = self:GetChild("Num")
  ;
  (self._normal):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self:GetChild("Lock/Back")):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

EquipBookCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipBookCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, HandBookTypeEnum, PinJiTable
  if not CImagePathTable:GetRecorder(data.icon) then
    local record = DataCommon.DefaultImageAsset
  end
  if ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(data.id, HandBookTypeEnum.EQUIP) then
    (self._lock):SetActive(false)
    ;
    (self._normal):SetActive(true)
    ;
    (self._icon):SetSprite(record.assetBundle, record.assetName)
  else
    ;
    (self._normal):SetActive(false)
    ;
    (self._lock):SetActive(true)
    ;
    (self._lockItemIcon):SetSprite(record.assetBundle, record.assetName)
  end
  ;
  (self._num):SetText(data.equipNumber)
  ;
  (self._select):SetActive((self._delegate)._selectId == data.id)
  local rarityRecorder = PinJiTable:GetRecorder(data.rarity)
  record = CImagePathTable:GetRecorder(rarityRecorder.imageDir)
  ;
  (self._normalBack):SetSprite(record.assetBundle, record.assetName)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipBookCell.OnCellClicked = function(self)
  -- function num : 0_4
  if not self._cellData then
    return 
  end
  ;
  (self._delegate):OnSelectEquip(self._cellData)
end

EquipBookCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if self._cellData and eventName == "ChooseEquip" then
    if (self._cellData).id == arg then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
  end
end

return EquipBookCell

