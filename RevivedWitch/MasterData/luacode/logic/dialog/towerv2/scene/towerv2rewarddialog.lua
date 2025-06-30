-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/scene/towerv2rewarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2RewardDialog = class("TowerV2RewardDialog", Dialog)
TowerV2RewardDialog.AssetBundleName = "ui/layouts.stair"
TowerV2RewardDialog.AssetName = "StairReward"
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
local cstringres = (BeanManager.GetTableByName)("message.cstringres")
local TowerV2SceneParts = require("logic.dialog.towerv2.scene.towerv2sceneparts")
local GridFrame = require("framework.ui.frame.grid.gridframe")
TowerV2RewardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2RewardDialog, TowerV2SceneParts
  ((TowerV2RewardDialog.super).Ctor)(self, ...)
  self._parts = (TowerV2SceneParts.Create)(self)
end

TowerV2RewardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._title = self:GetChild("Title")
  self._frame = self:GetChild("Frame/Line/ItemFrame")
  self._team = self:GetChild("TeamBtn")
  ;
  (self._team):Subscribe_PointerClickEvent(self.OnTeamClick, self)
  self._continue = self:GetChild("GoBtn")
  ;
  (self._continue):Subscribe_PointerClickEvent(self.OnContinueClick, self)
  self._back = self:GetChild("BackBtn")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._cost = {panel = self:GetChild("GoBtn/CostBack"), value = self:GetChild("GoBtn/CostBack/Txt2"), insufficient = self:GetChild("GoBtn/CostBack/Txt2Red")}
  self._teams = {
links = {}
}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

      ((self._teams).links)[i] = self:GetChild("Link" .. i)
    end
  end
  for i = 1, 6 do
    local path_t = "Char" .. i
    -- DECOMPILER ERROR at PC97: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._teams)[i] = {board = self:GetChild(path_t), icon = self:GetChild(path_t .. "/Back/Photo"), hp = self:GetChild(path_t .. "/Frame"), dot = self:GetChild(path_t .. "/Dot")}
    ;
    (((self._teams)[i]).dot):SetActive(false)
  end
  self._spirit = {text = self:GetChild("TopGroup/VIT/Text"), button = self:GetChild("TopGroup/VIT/Add"), reddot = self:GetChild("TopGroup/VIT/RedDot")}
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
  self._helper = (GridFrame.Create)(self._frame, self, true, 3)
  ;
  (self._frame):SetActive(false)
  for i = 1, 6 do
    (((self._teams)[i]).board):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    (self._parts):OnTeamCharClicked(i)
  end
, self)
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReward, Common.n_TowerV2Reward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNewStairs, Common.n_TowerV2Refresh, nil)
  self._handle = (self:GetRootWindow()):Subscribe_StateUpdateEvent(self.OnStateUpdate, self)
  ;
  ((self._refesh).info):Subscribe_PointerClickEvent((self._parts).OnRefreshInfoClick, self._parts)
  ;
  (self._rewardPreview):Subscribe_PointerClickEvent((self._parts).OnPreviewRewardClick, self._parts)
  ;
  ((self._spirit).button):Subscribe_PointerClickEvent((self._parts).OnSpiritClick, self._parts)
  ;
  (self._buff):Subscribe_PointerClickEvent((self._parts).OnBuffClick, self._parts)
  ;
  (self._parts):OnCreate()
end

TowerV2RewardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._helper):Destroy()
  ;
  (self._parts):Destroy()
end

TowerV2RewardDialog.SetData = function(self, items)
  -- function num : 0_3
  if not items then
    self._items = {}
    ;
    (self._parts):Init()
    self:Refresh()
  end
end

TowerV2RewardDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV, cstringres, bm_towerv2
  if #self._items ~= 0 then
    (self._frame):SetActive(true)
    ;
    (self._helper):ReloadAllCell()
  end
  local text = (TextManager.GetText)((cstringres:GetRecorder(1388)).msgTextID)
  text = text .. (TextManager.GetText)(((bm_towerv2:GetCurrentFloorInfo()).cfg).name)
  ;
  (self._parts):Refresh()
  local complete = bm_towerv2:GetState() == "complete"
  ;
  (self._team):SetActive(not complete)
  ;
  (self._continue):SetActive(not complete)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TowerV2RewardDialog.OnReward = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  self:SetData(((NekoData.BehaviorManager).BM_TowerV2):GetLastRewards())
  self:Refresh()
end

TowerV2RewardDialog.OnNewStairs = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("towerv2.scene.towerv2rewarddialog")
end

TowerV2RewardDialog.OnContinueClick = function(self)
  -- function num : 0_7 , upvalues : bm_towerv2, _ENV
  local cost = bm_towerv2:GetSpiritCost(bm_towerv2:GetCurrentFloorID())
  if cost <= ((NekoData.BehaviorManager).BM_Currency):GetSpirit() then
    ((NekoData.BehaviorManager).BM_TowerV2):Forward()
  else
    ;
    ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  end
end

TowerV2RewardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV, bm_towerv2
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(59, nil, function()
    -- function num : 0_8_0 , upvalues : bm_towerv2, _ENV
    local type = 66
    if bm_towerv2:GetState() == "complete" then
      type = nil
    end
    ;
    ((EffectFactory.CreateJumpBackEffect)(type)):Run()
  end
)
end

TowerV2RewardDialog.OnTeamClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.towerv2teameditdialog")
  dialog:GoTowerBattle("forward")
end

TowerV2RewardDialog.OnStateUpdate = function(self, handle, stateName, normalizedTime)
  -- function num : 0_10 , upvalues : bm_towerv2, _ENV
  if normalizedTime >= 1 and bm_towerv2:GetState() == "complete" then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(116, nil, function()
    -- function num : 0_10_0 , upvalues : _ENV
    ((EffectFactory.CreateJumpBackEffect)()):Run()
  end
)
    ;
    (self:GetRootWindow()):Unsubscribe_StateUpdateEvent(self._handle)
  end
end

TowerV2RewardDialog.AddNewModal = function(self)
  -- function num : 0_11
end

TowerV2RewardDialog.NumberOfCell = function(self, helper)
  -- function num : 0_12
  return #self._items
end

TowerV2RewardDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_13
  return "towerv2.towerv2itemcell"
end

TowerV2RewardDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_14
  return (self._items)[index]
end

return TowerV2RewardDialog

