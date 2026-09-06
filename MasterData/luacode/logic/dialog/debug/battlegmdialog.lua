local BattleGMDialog = class("BattleGMDialog", Dialog)
BattleGMDialog.AssetBundleName = "ui/layouts.gm"
BattleGMDialog.AssetName = "BattleGM"

function BattleGMDialog:Ctor(...)
  BattleGMDialog.super.Ctor(self, ...)
  self._groupName = "ModalFrame"
  self._clickSelfInvinvible = false
  self._clickEnemyInvinvible = false
end

function BattleGMDialog:OnCreate()
  self._selfInvincible = self:GetChild("Image/Btn1")
  self._enemyInvincible = self:GetChild("Image/Btn2")
  self._resetBattle = self:GetChild("Image/Btn3")
  self._statusFull = self:GetChild("Image/Btn4")
  self._removeBossOneHPStage = self:GetChild("Image/Btn5")
  self._selfHurtRate = self:GetChild("Image/InputField1")
  self._enemyHurtRate = self:GetChild("Image/InputField2")
  self._excuteBtn = self:GetChild("Image/CommonButtonCancel")
  self._fullEnergyBtn = self:GetChild("Image/Btn8")
  self._selfInvincible:Subscribe_PointerClickEvent(self.OnSelfInvincibleClick, self)
  self._enemyInvincible:Subscribe_PointerClickEvent(self.OnEnemyInvincibleClick, self)
  self._resetBattle:Subscribe_PointerClickEvent(self.OnResetBattleClick, self)
  self._statusFull:Subscribe_PointerClickEvent(self.OnStatusFullClick, self)
  self._removeBossOneHPStage:Subscribe_PointerClickEvent(self.OnRemoveBossOneHPStageClick, self)
  self._excuteBtn:Subscribe_PointerClickEvent(self.OnExcuteBtnClick, self)
  self._fullEnergyBtn:Subscribe_PointerClickEvent(self.OnFullEnergyBtnClick, self)
end

function BattleGMDialog:OnDestroy()
end

function BattleGMDialog:SetData(data)
  self._clickSelfInvinvible = data.selfInvinvible
  self._selfInvincible:SetSelected(data.selfInvinvible)
  self._clickEnemyInvinvible = data.enemyInvinvible
  self._enemyInvincible:SetSelected(data.enemyInvinvible)
end

function BattleGMDialog:OnSelfInvincibleClick()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
  controller = controller or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
  if controller then
    self._clickSelfInvinvible = not self._clickSelfInvinvible
    self._selfInvincible:SetSelected(self._clickSelfInvinvible)
    controller:GMSetSelfPlayerInvincible(self._clickSelfInvinvible)
  else
    LogError("BattleGMDialog", "无有效战斗场景")
  end
end

function BattleGMDialog:OnEnemyInvincibleClick()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
  controller = controller or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
  if controller then
    self._clickEnemyInvinvible = not self._clickEnemyInvinvible
    self._enemyInvincible:SetSelected(self._clickEnemyInvinvible)
    controller:GMSetEnemyPlayerInvincible(self._clickEnemyInvinvible)
  else
    LogError("BattleGMDialog", "无有效战斗场景")
  end
end

function BattleGMDialog:OnResetBattleClick()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
  controller = controller or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
  if controller then
    DialogManager.DestroySingletonDialog("newbattle.battlenewmaindialog")
    local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
    controller:OnSBattleStart(protocol)
  else
    LogError("BattleGMDialog", "无有效战斗场景")
  end
end

function BattleGMDialog:OnStatusFullClick()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
  controller = controller or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
  if controller then
    controller:GMMakeLeftPlayerStatusFull()
  else
    LogError("BattleGMDialog", "无有效战斗场景")
  end
end

function BattleGMDialog:OnRemoveBossOneHPStageClick()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
  controller = controller or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
  if controller then
    controller:GMRemoveBossOneHpStage()
  else
    LogError("BattleGMDialog", "无有效战斗场景")
  end
end

function BattleGMDialog:OnExcuteBtnClick()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
  controller = controller or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
  if controller then
    local upRate = 1
    local baseRate = 1000 / upRate
    local selfHurtRate = tonumber(self._selfHurtRate:GetText()) or upRate
    local enemyHurtRate = tonumber(self._enemyHurtRate:GetText()) or upRate
    if selfHurtRate <= 0 then
      selfHurtRate = 0.01
    end
    if enemyHurtRate <= 0 then
      enemyHurtRate = 0.01
    end
    if 10 <= selfHurtRate then
      selfHurtRate = 9.99
    end
    if 10 <= enemyHurtRate then
      enemyHurtRate = 9.99
    end
    local selfReduceRate = upRate - enemyHurtRate
    local enemyReduceRate = upRate - selfHurtRate
    local data = {
      attribute = {}
    }
    local campType = {LeftCamp = 1, RightCamp = 2}
    data.camp = campType.LeftCamp
    data.attribute.physicalreduce = math.ceil(selfReduceRate * baseRate)
    data.attribute.magicreduce = math.ceil(selfReduceRate * baseRate)
    controller:GMSUpdateOneCampAttribute(data)
    data.camp = campType.RightCamp
    data.attribute.physicalreduce = math.ceil(enemyReduceRate * baseRate)
    data.attribute.magicreduce = math.ceil(enemyReduceRate * baseRate)
    controller:GMSUpdateOneCampAttribute(data)
  else
    LogError("BattleGMDialog", "无有效战斗场景")
  end
end

function BattleGMDialog:OnFullEnergyBtnClick()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
  controller = controller or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
  if controller then
    controller:GMFullEnergyPower()
  else
    LogError("BattleGMDialog", "无有效战斗场景")
  end
end

function BattleGMDialog:OnBackBtnClicked()
  return DataCommon.BackPressed_SkipResponse
end

return BattleGMDialog
