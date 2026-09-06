local TowerV2BuffChooseCell = class("TowerEventBoxTips", Dialog)
TowerV2BuffChooseCell.AssetBundleName = "ui/layouts.stair"
TowerV2BuffChooseCell.AssetName = "StairBuffChooseCell"
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")
local cstairblessingdeploy = BeanManager.GetTableByName("dungeonselect.cstairblessingdeploy")

function TowerV2BuffChooseCell:Ctor(...)
  TowerV2BuffChooseCell.super.Ctor(self, ...)
end

function TowerV2BuffChooseCell:OnCreate()
  self._back = self:GetChild("Back")
  self._name = self:GetChild("Back/Name")
  self._detail = self:GetChild("Back/Detail")
  self._rank = self:GetChild("Back/Rank")
  self._icon = self:GetChild("Back/Buff")
  self._selected = self:GetChild("Effect/Click")
  self._back:Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function TowerV2BuffChooseCell:OnDestroy()
end

function TowerV2BuffChooseCell:RefreshCell()
  local cfg = cstairblessingdeploy:GetRecorder(self._cellData)
  self._name:SetText(TextManager.GetText(cfg.Blessingname))
  self._detail:SetText(TextManager.GetText(cfg.Qualitytextid))
  self._rank:SetText(TextManager.GetText(tonumber(cfg.Qualityname)))
  local recorder = cimagepath:GetRecorder(cfg.Iconpath)
  self._icon:SetSprite(recorder.assetBundle, recorder.assetName)
  local id
  if cfg.QualityTyp == 1 then
    id = 12645
  elseif cfg.QualityTyp == 2 then
    id = 12646
  end
  recorder = cimagepath:GetRecorder(id)
  self._back:SetSprite(recorder.assetBundle, recorder.assetName)
end

function TowerV2BuffChooseCell:OnCellClick()
  self._delegate:OnCellClick(self._cellData)
end

function TowerV2BuffChooseCell:OnEvent(eventName, id)
  if eventName == "selected" then
    self._selected:SetActive(self._cellData == id)
  elseif eventName == "appear" then
    self:GetRootWindow():PlayAnimation("StairBuffChooseCell")
  end
end

return TowerV2BuffChooseCell
