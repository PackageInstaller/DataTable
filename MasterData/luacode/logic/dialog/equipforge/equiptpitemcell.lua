-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equiptpitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local EquipTPItemCell = class("EquipTPItemCell", Dialog)
EquipTPItemCell.AssetBundleName = "ui/layouts.equip"
EquipTPItemCell.AssetName = "EquipTPItemCell"
EquipTPItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipTPItemCell
  ((EquipTPItemCell.super).Ctor)(self, ...)
  self._selectedItem = {}
end

EquipTPItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._addIcon = self:GetChild("Item/Add")
  self._itemIcon = self:GetChild("Item/Item")
  self._itemFrame = self:GetChild("Item")
  self._topBlack = self:GetChild("Item/TopBlack")
  self._itemLevelPanel = self:GetChild("Item/Level")
  self._itemLv = self:GetChild("Item/Level/Num")
  self._itemLvMax = self:GetChild("Item/Level/NumMax")
  ;
  (self:GetRootWindow()):Subscribe_LongPressEvent(self.OnCellLongPress, self)
end

EquipTPItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipTPItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CVarconfig, CImagePathTable
  self._selectedItem = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(data)
  if self._selectedItem then
    local imageRecord = (self._selectedItem):GetIcon()
    ;
    (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._itemIcon):SetActive(true)
    ;
    (self._addIcon):SetActive(false)
    imageRecord = (self._selectedItem):GetPinJiImage()
    ;
    (self._itemFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._itemLevelPanel):SetActive(true)
    ;
    (self._topBlack):SetActive(true)
    ;
    (self._itemLv):SetText((self._selectedItem):GetStrengthenLevel())
    ;
    (self._itemLvMax):SetText((self._selectedItem):GetMaxLevel())
  else
    do
      local defaultCellVarRecord = CVarconfig:GetRecorder(28)
      local imageRecord = CImagePathTable:GetRecorder(tonumber(defaultCellVarRecord.Value))
      ;
      (self._itemFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._itemLevelPanel):SetActive(false)
      ;
      (self._topBlack):SetActive(false)
      ;
      (self._itemIcon):SetActive(false)
      ;
      (self._addIcon):SetActive(true)
    end
  end
end

EquipTPItemCell.OnCellLongPress = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if not self._selectedItem then
    return 
  end
  local tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
  if tipsDialog then
    tipsDialog:Init(self._cellData)
    tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
  end
end

return EquipTPItemCell

