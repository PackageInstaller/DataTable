-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonitemaccountcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local DungeonItemAccountCell = class("DungeonItemAccountCell", Dialog)
DungeonItemAccountCell.AssetBundleName = "ui/layouts.dungeon"
DungeonItemAccountCell.AssetName = "DungeonItemCell"
DungeonItemAccountCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonItemAccountCell
  ((DungeonItemAccountCell.super).Ctor)(self, ...)
end

DungeonItemAccountCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("Frame/BackGround/Icon")
  self._count = self:GetChild("Frame/Count")
  self._name = self:GetChild("Frame/Name")
  ;
  (self._count):SetActive(false)
end

DungeonItemAccountCell.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonItemAccountCell.Refresh = function(self, data)
  -- function num : 0_3 , upvalues : Item
  self._data = data.id
  local item = (Item.Create)(data.id)
  local imageRecord = item:GetIcon()
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.num then
    (self._count):SetNumber(data.num)
    ;
    (self._count):SetActive(true)
  end
  ;
  (self._name):SetText(data.name)
end

return DungeonItemAccountCell

