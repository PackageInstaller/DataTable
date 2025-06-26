-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/monsterbooktagcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MonsterBookTagCell = class("MonsterBookTagCell", Dialog)
MonsterBookTagCell.AssetBundleName = "ui/layouts.tujian"
MonsterBookTagCell.AssetName = "MonsterBookKeyCell"
MonsterBookTagCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonsterBookTagCell
  ((MonsterBookTagCell.super).Ctor)(self, ...)
end

MonsterBookTagCell.OnCreate = function(self)
  -- function num : 0_1
  self._tag = self:GetChild("Txt")
end

MonsterBookTagCell.OnDestroy = function(self)
  -- function num : 0_2
end

MonsterBookTagCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._tag):SetText((TextManager.GetText)(data))
end

return MonsterBookTagCell

