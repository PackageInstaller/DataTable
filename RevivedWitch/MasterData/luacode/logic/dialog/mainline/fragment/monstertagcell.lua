-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/fragment/monstertagcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MonsterTagCell = class("MonsterTagCell", Dialog)
MonsterTagCell.AssetBundleName = "ui/layouts.fragment"
MonsterTagCell.AssetName = "LevelInfoKeyCell"
MonsterTagCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonsterTagCell
  ((MonsterTagCell.super).Ctor)(self, ...)
end

MonsterTagCell.OnCreate = function(self)
  -- function num : 0_1
  self._tag = self:GetChild("Txt")
end

MonsterTagCell.OnDestroy = function(self)
  -- function num : 0_2
end

MonsterTagCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._tag):SetText((TextManager.GetText)(data))
end

return MonsterTagCell

