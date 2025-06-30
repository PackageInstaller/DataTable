-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/offlinepvp/offlinepvpaccountcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local WorldInfoTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectworld")
local Item = require("logic.manager.experimental.types.item")
local OfflinePvpAccountCell = class("OfflinePvpAccountCell", Dialog)
OfflinePvpAccountCell.AssetBundleName = "ui/layouts.offlinepvp"
OfflinePvpAccountCell.AssetName = "OffLinePVPAccountCell"
OfflinePvpAccountCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OfflinePvpAccountCell
  ((OfflinePvpAccountCell.super).Ctor)(self, ...)
end

OfflinePvpAccountCell.OnCreate = function(self)
  -- function num : 0_1
  self._itemFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemSelect = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._itemCount = self:GetChild("Panel/ItemCell/_Count")
  ;
  (self._itemIcon):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self._itemSelect):SetActive(false)
end

OfflinePvpAccountCell.OnDestroy = function(self)
  -- function num : 0_2
end

OfflinePvpAccountCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  local item = (Item.Create)(data.itemId)
  local imageRecord = item:GetPinJiImage()
  ;
  (self._itemFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetIcon()
  ;
  (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemCount):SetText((NumberManager.GetShowNumber)(data.count))
end

OfflinePvpAccountCell.OnCellClicked = function(self)
  -- function num : 0_4
end

return OfflinePvpAccountCell

