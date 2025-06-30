-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipqhequipcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local EquipQHEquipCell = class("EquipQHEquipCell", Dialog)
EquipQHEquipCell.AssetBundleName = "ui/layouts.equip"
EquipQHEquipCell.AssetName = "EquipQHEquipCell"
EquipQHEquipCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipQHEquipCell
  ((EquipQHEquipCell.super).Ctor)(self, ...)
end

EquipQHEquipCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Frame/Panel/Icon")
  self._frame = self:GetChild("Frame/Panel/Frame")
  self._reduceBtn = self:GetChild("Frame/Reduce")
  self._lvText = self:GetChild("Frame/Panel/Level/Num")
  self._lvMaxText = self:GetChild("Frame/Panel/Level/NumMax")
  self._select = self:GetChild("Frame/Panel/Select")
  self._charBack = self:GetChild("Frame/Panel/CharBack")
  self._charPhoto = self:GetChild("Frame/Panel/CharPhoto")
  ;
  (self._select):SetActive(false)
  ;
  (self._charPhoto):SetActive(false)
  ;
  (self._charBack):SetActive(false)
  ;
  (self._reduceBtn):Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_LongPressEvent(self.OnCellLongPress, self)
end

EquipQHEquipCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipQHEquipCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CItemAttrTable, CImagePathTable
  local id = nil
  local item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(data.key)
  id = item:GetID()
  local record = item:GetPinJiImage()
  ;
  (self._frame):SetSprite(record.assetBundle, record.assetName)
  local imageId = (CItemAttrTable:GetRecorder(id)).icon
  if not CImagePathTable:GetRecorder(imageId) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._lvText):SetText(item:GetStrengthenLevel())
  ;
  (self._lvMaxText):SetText(item:GetStrengthenMaxLevel())
end

EquipQHEquipCell.OnReduceBtnClicked = function(self)
  -- function num : 0_4
  (self._delegate):ReduceItems((self._cellData).key)
end

EquipQHEquipCell.OnCellLongPress = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
  if tipsDialog then
    tipsDialog:Init((self._cellData).key)
    tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_5_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
  end
end

return EquipQHEquipCell

