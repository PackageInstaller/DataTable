local TableFrame = require("framework.ui.frame.table.tableframe")
local CMonsterConfigTable = BeanManager.GetTableByName("npc.cmonsterconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local GuildBossInfoCellLock = class("GuildBossInfoCellLock", Dialog)
GuildBossInfoCellLock.AssetBundleName = "ui/layouts.guild"
GuildBossInfoCellLock.AssetName = "GuildBossChooseCellLocked"

function GuildBossInfoCellLock:Ctor(...)
  GuildBossInfoCellLock.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function GuildBossInfoCellLock:OnCreate()
end

function GuildBossInfoCellLock:OnDestroy()
end

function GuildBossInfoCellLock:RefreshCell()
end

return GuildBossInfoCellLock
