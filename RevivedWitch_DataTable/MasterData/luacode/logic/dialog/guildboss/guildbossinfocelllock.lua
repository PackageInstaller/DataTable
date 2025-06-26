-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guildboss/guildbossinfocelllock.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local GuildBossInfoCellLock = class("GuildBossInfoCellLock", Dialog)
GuildBossInfoCellLock.AssetBundleName = "ui/layouts.guild"
GuildBossInfoCellLock.AssetName = "GuildBossChooseCellLocked"
GuildBossInfoCellLock.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildBossInfoCellLock
  ((GuildBossInfoCellLock.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

GuildBossInfoCellLock.OnCreate = function(self)
  -- function num : 0_1
end

GuildBossInfoCellLock.OnDestroy = function(self)
  -- function num : 0_2
end

GuildBossInfoCellLock.RefreshCell = function(self)
  -- function num : 0_3
end

return GuildBossInfoCellLock

