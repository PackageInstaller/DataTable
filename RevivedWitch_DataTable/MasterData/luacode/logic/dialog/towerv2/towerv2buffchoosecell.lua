-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2buffchoosecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2BuffChooseCell = class("TowerEventBoxTips", Dialog)
TowerV2BuffChooseCell.AssetBundleName = "ui/layouts.stair"
TowerV2BuffChooseCell.AssetName = "StairBuffChooseCell"
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
local cstairblessingdeploy = (BeanManager.GetTableByName)("dungeonselect.cstairblessingdeploy")
TowerV2BuffChooseCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2BuffChooseCell
  ((TowerV2BuffChooseCell.super).Ctor)(self, ...)
end

TowerV2BuffChooseCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("Back")
  self._name = self:GetChild("Back/Name")
  self._detail = self:GetChild("Back/Detail")
  self._rank = self:GetChild("Back/Rank")
  self._icon = self:GetChild("Back/Buff")
  self._selected = self:GetChild("Effect/Click")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

TowerV2BuffChooseCell.OnDestroy = function(self)
  -- function num : 0_2
end

TowerV2BuffChooseCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : cstairblessingdeploy, _ENV, cimagepath
  local cfg = cstairblessingdeploy:GetRecorder(self._cellData)
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
    id = 12645
  else
    if cfg.QualityTyp == 2 then
      id = 12646
    end
  end
  recorder = cimagepath:GetRecorder(id)
  ;
  (self._back):SetSprite(recorder.assetBundle, recorder.assetName)
end

TowerV2BuffChooseCell.OnCellClick = function(self)
  -- function num : 0_4
  (self._delegate):OnCellClick(self._cellData)
end

TowerV2BuffChooseCell.OnEvent = function(self, eventName, id)
  -- function num : 0_5
  if self._cellData ~= id then
    (self._selected):SetActive(eventName ~= "selected")
    if eventName == "appear" then
      (self:GetRootWindow()):PlayAnimation("StairBuffChooseCell")
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

return TowerV2BuffChooseCell

