-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/debug/battlegmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleGMDialog = class("BattleGMDialog", Dialog)
BattleGMDialog.AssetBundleName = "ui/layouts.gm"
BattleGMDialog.AssetName = "BattleGM"
BattleGMDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleGMDialog
  ((BattleGMDialog.super).Ctor)(self, ...)
  self._groupName = "ModalFrame"
  self._clickSelfInvinvible = false
  self._clickEnemyInvinvible = false
end

BattleGMDialog.OnCreate = function(self)
  -- function num : 0_1
  self._selfInvincible = self:GetChild("Image/Btn1")
  self._enemyInvincible = self:GetChild("Image/Btn2")
  self._resetBattle = self:GetChild("Image/Btn3")
  self._statusFull = self:GetChild("Image/Btn4")
  self._removeBossOneHPStage = self:GetChild("Image/Btn5")
  self._selfHurtRate = self:GetChild("Image/InputField1")
  self._enemyHurtRate = self:GetChild("Image/InputField2")
  self._excuteBtn = self:GetChild("Image/CommonButtonCancel")
  self._fullEnergyBtn = self:GetChild("Image/Btn8")
  ;
  (self._selfInvincible):Subscribe_PointerClickEvent(self.OnSelfInvincibleClick, self)
  ;
  (self._enemyInvincible):Subscribe_PointerClickEvent(self.OnEnemyInvincibleClick, self)
  ;
  (self._resetBattle):Subscribe_PointerClickEvent(self.OnResetBattleClick, self)
  ;
  (self._statusFull):Subscribe_PointerClickEvent(self.OnStatusFullClick, self)
  ;
  (self._removeBossOneHPStage):Subscribe_PointerClickEvent(self.OnRemoveBossOneHPStageClick, self)
  ;
  (self._excuteBtn):Subscribe_PointerClickEvent(self.OnExcuteBtnClick, self)
  ;
  (self._fullEnergyBtn):Subscribe_PointerClickEvent(self.OnFullEnergyBtnClick, self)
end

BattleGMDialog.OnDestroy = function(self)
  -- function num : 0_2
end

BattleGMDialog.SetData = function(self, data)
  -- function num : 0_3
  self._clickSelfInvinvible = data.selfInvinvible
  ;
  (self._selfInvincible):SetSelected(data.selfInvinvible)
  self._clickEnemyInvinvible = data.enemyInvinvible
  ;
  (self._enemyInvincible):SetSelected(data.enemyInvinvible)
end

BattleGMDialog.OnSelfInvincibleClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  if not controller then
    controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
  end
  if controller then
    self._clickSelfInvinvible = not self._clickSelfInvinvible
    ;
    (self._selfInvincible):SetSelected(self._clickSelfInvinvible)
    controller:GMSetSelfPlayerInvincible(self._clickSelfInvinvible)
  else
    LogError("BattleGMDialog", "无有效战斗场景")
  end
end

BattleGMDialog.OnEnemyInvincibleClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  if not controller then
    controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
  end
  if controller then
    self._clickEnemyInvinvible = not self._clickEnemyInvinvible
    ;
    (self._enemyInvincible):SetSelected(self._clickEnemyInvinvible)
    controller:GMSetEnemyPlayerInvincible(self._clickEnemyInvinvible)
  else
    LogError("BattleGMDialog", "无有效战斗场景")
  end
end

BattleGMDialog.OnResetBattleClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  if not controller then
    controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
  end
  if controller then
    (DialogManager.DestroySingletonDialog)("newbattle.battlenewmaindialog")
    local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
    controller:OnSBattleStart(protocol)
  else
    do
      LogError("BattleGMDialog", "无有效战斗场景")
    end
  end
end

BattleGMDialog.OnStatusFullClick = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  if not controller then
    controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
  end
  if controller then
    controller:GMMakeLeftPlayerStatusFull()
  else
    LogError("BattleGMDialog", "无有效战斗场景")
  end
end

BattleGMDialog.OnRemoveBossOneHPStageClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  if not controller then
    controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
  end
  if controller then
    controller:GMRemoveBossOneHpStage()
  else
    LogError("BattleGMDialog", "无有效战斗场景")
  end
end

BattleGMDialog.OnExcuteBtnClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  if not controller then
    controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
  end
  if controller then
    local upRate = 1
    local baseRate = 1000 / upRate
    local selfHurtRate = tonumber((self._selfHurtRate):GetText()) or upRate
    local enemyHurtRate = tonumber((self._enemyHurtRate):GetText()) or upRate
    if selfHurtRate <= 0 then
      selfHurtRate = 0.01
    end
    if enemyHurtRate <= 0 then
      enemyHurtRate = 0.01
    end
    if selfHurtRate >= 10 then
      selfHurtRate = 9.99
    end
    if enemyHurtRate >= 10 then
      enemyHurtRate = 9.99
    end
    local selfReduceRate = upRate - enemyHurtRate
    local enemyReduceRate = upRate - selfHurtRate
    local data = {
attribute = {}
}
    local campType = {LeftCamp = 1, RightCamp = 2}
    data.camp = campType.LeftCamp
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (data.attribute).physicalreduce = (math.ceil)(selfReduceRate * baseRate)
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (data.attribute).magicreduce = (math.ceil)(selfReduceRate * baseRate)
    controller:GMSUpdateOneCampAttribute(data)
    data.camp = campType.RightCamp
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (data.attribute).physicalreduce = (math.ceil)(enemyReduceRate * baseRate)
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (data.attribute).magicreduce = (math.ceil)(enemyReduceRate * baseRate)
    controller:GMSUpdateOneCampAttribute(data)
  else
    do
      LogError("BattleGMDialog", "无有效战斗场景")
    end
  end
end

BattleGMDialog.OnFullEnergyBtnClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  if not controller then
    controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
  end
  if controller then
    controller:GMFullEnergyPower()
  else
    LogError("BattleGMDialog", "无有效战斗场景")
  end
end

BattleGMDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return BattleGMDialog

