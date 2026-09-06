local CCbuffConfigTable = BeanManager.GetTableByName("buff.ccbuffconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BuffCell = class("BuffCell", Dialog)
BuffCell.AssetBundleName = "ui/layouts.battle"
BuffCell.AssetName = "BuffCell"

function BuffCell:Ctor(...)
  BuffCell.super.Ctor(self, ...)
end

function BuffCell:OnCreate()
end

function BuffCell:OnDestroy()
end

function BuffCell:RefreshCell(data)
  local iconRecord = CImagePathTable:GetRecorder(data.iconid) or DataCommon.DefaultImageAsset
  self:GetRootWindow():SetSprite(iconRecord.assetBundle, iconRecord.assetName)
end

return BuffCell
