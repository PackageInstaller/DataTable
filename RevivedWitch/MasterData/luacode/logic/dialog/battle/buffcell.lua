-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/buffcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCbuffConfigTable = (BeanManager.GetTableByName)("buff.ccbuffconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BuffCell = class("BuffCell", Dialog)
BuffCell.AssetBundleName = "ui/layouts.battle"
BuffCell.AssetName = "BuffCell"
BuffCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BuffCell
  ((BuffCell.super).Ctor)(self, ...)
end

BuffCell.OnCreate = function(self)
  -- function num : 0_1
end

BuffCell.OnDestroy = function(self)
  -- function num : 0_2
end

BuffCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder(data.iconid) then
    local iconRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self:GetRootWindow()):SetSprite(iconRecord.assetBundle, iconRecord.assetName)
end

return BuffCell

