-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2buffcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2BuffCell = class("TowerEventBoxTips", Dialog)
TowerV2BuffCell.AssetBundleName = "ui/layouts.stair"
TowerV2BuffCell.AssetName = "StairBuffListCell"
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
TowerV2BuffCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2BuffCell
  ((TowerV2BuffCell.super).Ctor)(self, ...)
end

TowerV2BuffCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Name")
  self._detail = self:GetChild("Detail")
  self._rank = self:GetChild("Rank")
  self._icon = self:GetChild("Buff")
  self._back = self:GetChild("Back")
end

TowerV2BuffCell.OnDestroy = function(self)
  -- function num : 0_2
end

TowerV2BuffCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, cimagepath
  local cfg = (self._cellData).cfg
  if not cfg then
    LogErrorFormat("towerv2", "buff not found: %s, %s", (self._cellData).id, (self._cellData).count)
  end
  ;
  (self._name):SetText((TextManager.GetText)(cfg.Blessingname))
  ;
  (self._detail):SetText((TextManager.GetText)(cfg.Qualitytextid))
  ;
  (self._rank):SetText((TextManager.GetText)(tonumber(cfg.Qualityname)))
  local recorder = cimagepath:GetRecorder(cfg.Iconpath)
  ;
  (self._icon):SetSprite(recorder.assetBundle, recorder.assetName)
  local id = nil
  if cfg.QualityTyp == 1 then
    id = 12647
  else
    if cfg.QualityTyp == 2 then
      id = 12648
    end
  end
  recorder = cimagepath:GetRecorder(id)
  ;
  (self._back):SetSprite(recorder.assetBundle, recorder.assetName)
end

TowerV2BuffCell.OnCellClick = function(self)
  -- function num : 0_4
  (self._delegate):OnCellClick((self._cellData).id)
end

return TowerV2BuffCell

