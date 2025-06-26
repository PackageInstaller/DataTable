-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonuseitemssecondconfirmcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local DungeonUseItemsSecondConfirmCell = class("DungeonUseItemsSecondConfirmCell", Dialog)
DungeonUseItemsSecondConfirmCell.AssetBundleName = "ui/layouts.dungeon"
DungeonUseItemsSecondConfirmCell.AssetName = "DungeonItemCell"
DungeonUseItemsSecondConfirmCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonUseItemsSecondConfirmCell
  ((DungeonUseItemsSecondConfirmCell.super).Ctor)(self, ...)
end

DungeonUseItemsSecondConfirmCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("Frame/BackGround/Icon")
  self._count = self:GetChild("Frame/Count")
  ;
  (self._count):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnSelfClick, self)
end

DungeonUseItemsSecondConfirmCell.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonUseItemsSecondConfirmCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item
  self._data = data.data
  local item = (Item.Create)(data.data)
  local imageRecord = item:GetIcon()
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.num then
    (self._count):SetNumber(data.num)
    ;
    (self._count):SetActive(true)
  end
end

DungeonUseItemsSecondConfirmCell.OnSelfClick = function(self)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._delegate)._whichitem = self._data
end

return DungeonUseItemsSecondConfirmCell

