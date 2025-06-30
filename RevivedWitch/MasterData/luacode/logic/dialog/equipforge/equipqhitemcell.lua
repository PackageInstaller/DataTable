-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipqhitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local EquipQHItemCell = class("EquipQHItemCell", Dialog)
EquipQHItemCell.AssetBundleName = "ui/layouts.equip"
EquipQHItemCell.AssetName = "EquipQHItemCell"
EquipQHItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipQHItemCell
  ((EquipQHItemCell.super).Ctor)(self, ...)
end

EquipQHItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._count = self:GetChild("ItemCell/_Count")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._reduceBtn = self:GetChild("Reduce")
  ;
  (self._reduceBtn):Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
end

EquipQHItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipQHItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item, CItemAttrTable, CImagePathTable
  (self._count):SetText((NumberManager.GetShowNumber)(data.count))
  local id = nil
  if data.tag == "item" then
    id = data.key
    local item = (Item.Create)(id)
    local record = item:GetPinJiImage()
    ;
    (self._frame):SetSprite(record.assetBundle, record.assetName)
  else
    do
      if data.tag == "equip" then
        local item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(data.key)
        id = item:GetID()
        local record = item:GetPinJiImage()
        ;
        (self._frame):SetSprite(record.assetBundle, record.assetName)
      end
      do
        local imageId = (CItemAttrTable:GetRecorder(id)).icon
        local imageRecord = CImagePathTable:GetRecorder(imageId)
        ;
        (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
    end
  end
end

EquipQHItemCell.OnReduceBtnClicked = function(self)
  -- function num : 0_4
  (self._delegate):ReduceItems((self._cellData).key)
end

return EquipQHItemCell

