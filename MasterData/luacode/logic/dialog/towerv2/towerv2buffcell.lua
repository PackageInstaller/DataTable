local TowerV2BuffCell = class("TowerEventBoxTips", Dialog)
TowerV2BuffCell.AssetBundleName = "ui/layouts.stair"
TowerV2BuffCell.AssetName = "StairBuffListCell"
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")

function TowerV2BuffCell:Ctor(...)
  TowerV2BuffCell.super.Ctor(self, ...)
end

function TowerV2BuffCell:OnCreate()
  self._name = self:GetChild("Name")
  self._detail = self:GetChild("Detail")
  self._rank = self:GetChild("Rank")
  self._icon = self:GetChild("Buff")
  self._back = self:GetChild("Back")
end

function TowerV2BuffCell:OnDestroy()
end

function TowerV2BuffCell:RefreshCell()
  local cfg = self._cellData.cfg
  if not cfg then
    LogErrorFormat("towerv2", "buff not found: %s, %s", self._cellData.id, self._cellData.count)
  end
  self._name:SetText(TextManager.GetText(cfg.Blessingname))
  self._detail:SetText(TextManager.GetText(cfg.Qualitytextid))
  self._rank:SetText(TextManager.GetText(tonumber(cfg.Qualityname)))
  local recorder = cimagepath:GetRecorder(cfg.Iconpath)
  self._icon:SetSprite(recorder.assetBundle, recorder.assetName)
  local id
  if cfg.QualityTyp == 1 then
    id = 12647
  elseif cfg.QualityTyp == 2 then
    id = 12648
  end
  recorder = cimagepath:GetRecorder(id)
  self._back:SetSprite(recorder.assetBundle, recorder.assetName)
end

function TowerV2BuffCell:OnCellClick()
  self._delegate:OnCellClick(self._cellData.id)
end

return TowerV2BuffCell
