-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/monsterbookpropcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MonsterBookPropertyCell = class("MonsterBookPropertyCell", Dialog)
MonsterBookPropertyCell.AssetBundleName = "ui/layouts.tujian"
MonsterBookPropertyCell.AssetName = "MonsterBookPropCell"
MonsterBookPropertyCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonsterBookPropertyCell
  ((MonsterBookPropertyCell.super).Ctor)(self, ...)
end

MonsterBookPropertyCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Prop/Image")
  self._progress = self:GetChild("Prop/Progress")
end

MonsterBookPropertyCell.OnDestroy = function(self)
  -- function num : 0_2
end

MonsterBookPropertyCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable
  local imageRecord = CImagePathTable:GetRecorder(data.icon)
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._progress):SetFillAmount(data.num)
end

return MonsterBookPropertyCell

