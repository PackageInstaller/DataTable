-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/scene/towerv2defeatdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2DefeatDialog = class("TowerV2DefeatDialog", Dialog)
TowerV2DefeatDialog.AssetBundleName = "ui/layouts.stair"
TowerV2DefeatDialog.AssetName = "StairDefeat"
local TowerV2SceneParts = require("logic.dialog.towerv2.scene.towerv2sceneparts")
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
TowerV2DefeatDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2DefeatDialog, TowerV2SceneParts
  ((TowerV2DefeatDialog.super).Ctor)(self, ...)
  self._parts = (TowerV2SceneParts.Create)(self)
end

TowerV2DefeatDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._cost = {panel = self:GetChild("DownArea/CostBack"), value = self:GetChild("DownArea/CostBack/Txt2"), insufficient = self:GetChild("DownArea/CostBack/Txt2Red")}
  self._team = self:GetChild("DownArea/DualBtn/TeamBtn")
  self._retreat = self:GetChild("DownArea/DualBtn/GoBtn")
  self._backBtn = self:GetChild("BackBtn")
  self._teams = {
links = {}
}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

      ((self._teams).links)[i] = self:GetChild("Link" .. i)
    end
  end
  for i = 1, 6 do
    local path_t = "Char" .. i
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._teams)[i] = {board = self:GetChild(path_t), icon = self:GetChild(path_t .. "/Back/Photo"), hp = self:GetChild(path_t .. "/Frame"), dot = self:GetChild(path_t .. "/Dot")}
    ;
    (((self._teams)[i]).dot):SetActive(false)
  end
  self._nodeCount = self:GetChild("Detail/Count/Num")
  self._nodeTotal = self:GetChild("Detail/Count/NumMax")
  self._rewardPreview = self:GetChild("Detail/Count/Box")
  self._rewardRedpoint = self:GetChild("Detail/Count/Box/NewRedDot1")
  self._positionFrame = self:GetChild("PositionFrame")
  self._positionMark = self:GetChild("StairPositionCurrent")
  self._spirit = {text = self:GetChild("TopGroup/VIT/Text"), button = self:GetChild("TopGroup/VIT/Add"), reddot = self:GetChild("TopGroup/VIT/RedDot")}
  self._buff = self:GetChild("BuffBtn")
  self._buffRedpoint = self:GetChild("BuffBtn/Effect")
  self._progress = {start = self:GetChild("TitleBack/Empty"), 
text = {desc = self:GetChild("TitleBack/Txt1"), value = self:GetChild("TitleBack/Txt2")}
}
  self._refesh = {text = self:GetChild("Detail/Refresh/Time"), info = self:GetChild("Detail/Refresh/Ibtn")}
  self._progressFrame = self:GetChild("TitleBack")
  for i = 1, 6 do
    (((self._teams)[i]).board):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    (self._parts):OnTeamCharClicked(i)
  end
, self)
  end
  ;
  (self._team):Subscribe_PointerClickEvent(self.OnTeamClick, self)
  ;
  (self._retreat):Subscribe_PointerClickEvent(self.OnRetreatClick, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  ((self._refesh).info):Subscribe_PointerClickEvent((self._parts).OnRefreshInfoClick, self._parts)
  ;
  (self._rewardPreview):Subscribe_PointerClickEvent((self._parts).OnPreviewRewardClick, self._parts)
  ;
  ((self._spirit).button):Subscribe_PointerClickEvent((self._parts).OnSpiritClick, self._parts)
  ;
  (self._buff):Subscribe_PointerClickEvent((self._parts).OnBuffClick, self._parts)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNewStairs, Common.n_TowerV2Refresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_TowerV2Reward, nil)
  ;
  (self._parts):OnCreate()
  ;
  (self._parts):Init()
end

TowerV2DefeatDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._runtimePackerLuaAgent then
    (self._runtimePackerLuaAgent):Release()
    self._runtimePackerLuaAgent = nil
  end
  ;
  (self._parts):Destroy()
end

TowerV2DefeatDialog.Refresh = function(self)
  -- function num : 0_3
  (self._parts):Refresh()
end

TowerV2DefeatDialog.OnNewStairs = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("towerv2.scene.towerv2defeatdialog")
end

TowerV2DefeatDialog.OnRetreatClick = function(self)
  -- function num : 0_5 , upvalues : bm_towerv2, _ENV
  local cost = ((bm_towerv2:GetFloorInfoByIndex(1)).cfg).apCost
  if cost <= ((NekoData.BehaviorManager).BM_Currency):GetSpirit() then
    bm_towerv2:Retreat()
    ;
    ((self._cost).panel):SetActive(false)
  else
    ;
    ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  end
end

TowerV2DefeatDialog.OnTeamClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.towerv2teameditdialog")
  dialog:GoTowerBattle("retreat")
end

TowerV2DefeatDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(59, nil, function()
    -- function num : 0_7_0 , upvalues : _ENV
    ((EffectFactory.CreateJumpBackEffect)(66)):Run()
  end
, nil, nil)
end

TowerV2DefeatDialog.AddNewModal = function(self)
  -- function num : 0_8
end

return TowerV2DefeatDialog

