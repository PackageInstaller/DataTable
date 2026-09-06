local TaskCfg = BeanManager.GetTableByName("mission.ccoinmissionconfig")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local AgCoinAccessTaskCell = class("AgCoinAccessTaskCell", Dialog)
AgCoinAccessTaskCell.AssetBundleName = "ui/layouts.baseshop"
AgCoinAccessTaskCell.AssetName = "CoinGetCell"

function AgCoinAccessTaskCell:Ctor(...)
  AgCoinAccessTaskCell.super.Ctor(self, ...)
end

function AgCoinAccessTaskCell:OnCreate()
  self._taskName = self:GetChild("Txt")
  self._taskCurValue = self:GetChild("Txt1")
  self._taskDestValue = self:GetChild("Txt3")
  self._coinIcon = self:GetChild("Image")
  self._coinNum = self:GetChild("Num")
end

function AgCoinAccessTaskCell:OnDestroy()
end

function AgCoinAccessTaskCell:RefreshCell(data)
  local cfg = TaskCfg:GetRecorder(data.taskid)
  self._taskName:SetText(TextManager.GetText(cfg.missionnameTextID))
  self._taskCurValue:SetText(data.curValue)
  self._taskDestValue:SetText(data.destValue)
  local itemcfg = CItemAttrTable:GetRecorder(cfg.itemid)
  local iconinfo = CImagePathTable:GetRecorder(itemcfg.icon) or DataCommon.DefaultImageAsset
  self._coinIcon:SetSprite(iconinfo.assetBundle, iconinfo.assetName)
  self._coinNum:SetText(cfg.itemnum)
end

return AgCoinAccessTaskCell
