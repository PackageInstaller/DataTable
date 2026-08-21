-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/teamedit/teamtestgmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleEndType = (BattleClientProtocolManager.GetBeanDef)("data.battleendtype")
local TeamTestGMDialog = class("TeamTestGMDialog", Dialog)
TeamTestGMDialog.AssetBundleName = "ui/layouts.gm"
TeamTestGMDialog.AssetName = "BattleTest"
local hurtLevelNum = 4
local HurtLevelBehaviorName = {"newbattleaimuzhuang", "newbattleaimuzhuang1", "newbattleaimuzhuang2", "newbattleaimuzhuang3"}
local littleWoodMonsterId = 20055
TeamTestGMDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TeamTestGMDialog
  ((TeamTestGMDialog.super).Ctor)(self, ...)
  self._groupName = "ModalFrame"
  self._clickSecondHurtBtnTag = false
  self._clickSelfInvinvible = false
  self._opening = true
end

TeamTestGMDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : hurtLevelNum, _ENV
  self._secondHurtBtn = self:GetChild("Image/Btn1")
  self._secondHurtOpen = self:GetChild("Image/Btn1/TextOpen")
  self._secondHurtClose = self:GetChild("Image/Btn1/Text")
  self._selfInvincible = self:GetChild("Image/Btn2")
  self._resetBattle = self:GetChild("Image/Btn3")
  self._battleDetailBtn = self:GetChild("Image/Btn4")
  self._battleWinBtn = self:GetChild("Image/Btn5")
  self._closeBtn = self:GetChild("Image/CloseBtn")
  self._openBtn = self:GetChild("OpenBtn")
  self._LittleWoodHurtLevelBtn = {}
  for i = 1, hurtLevelNum do
    do
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R5 in 'UnsetPending'

      (self._LittleWoodHurtLevelBtn)[i] = self:GetChild("Image/ToggleGroup/Toggle" .. tostring(i))
      ;
      ((self._LittleWoodHurtLevelBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnLittleWoodHurtLevelBtnClicked(i)
  end
, self)
    end
  end
  ;
  (self._secondHurtBtn):Subscribe_PointerClickEvent(self.OnSecondHurtBtnClick, self)
  ;
  (self._selfInvincible):Subscribe_PointerClickEvent(self.OnSelfInvincibleClick, self)
  ;
  (self._resetBattle):Subscribe_PointerClickEvent(self.OnResetBattleClick, self)
  ;
  (self._battleDetailBtn):Subscribe_PointerClickEvent(self.OnBattleDetailBtnClick, self)
  ;
  (self._battleWinBtn):Subscribe_PointerClickEvent(self.OnBattleWinBtnClick, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnCloseBtnClick, self)
  ;
  (self._openBtn):Subscribe_PointerClickEvent(self.OnOpenBtnClick, self)
  for i = 1, hurtLevelNum do
    ((self._LittleWoodHurtLevelBtn)[i]):SetIsOnType(false)
  end
  ;
  ((self._LittleWoodHurtLevelBtn)[1]):SetIsOnType(true)
  ;
  (self._secondHurtOpen):SetActive(self._clickSecondHurtBtnTag)
  ;
  (self._secondHurtClose):SetActive(not self._clickSecondHurtBtnTag)
end

TeamTestGMDialog.OnDestroy = function(self)
  -- function num : 0_2
end

TeamTestGMDialog.OnSecondHurtBtnClick = function(self)
  -- function num : 0_3 , upvalues : _ENV, littleWoodMonsterId
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  if controller then
    self._clickSecondHurtBtnTag = not self._clickSecondHurtBtnTag
    ;
    (self._secondHurtBtn):SetSelected(self._clickSecondHurtBtnTag)
    ;
    (self._secondHurtOpen):SetActive(self._clickSecondHurtBtnTag)
    ;
    (self._secondHurtClose):SetActive(not self._clickSecondHurtBtnTag)
    local battlerList = ((NekoData.BehaviorManager).BM_Battle):GetRightBattlers()
    for entityId,battler in pairs(battlerList) do
      if battler:IsRightCamp() and battler:GetConfigId() == littleWoodMonsterId then
        controller:GMSetSecondHurtState(self._clickSecondHurtBtnTag, entityId)
        return 
      end
    end
  else
    do
      LogError("TeamTestGMDialog", "无有效战斗场景")
    end
  end
end

TeamTestGMDialog.OnSelfInvincibleClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  if controller then
    self._clickSelfInvinvible = not self._clickSelfInvinvible
    ;
    (self._selfInvincible):SetSelected(self._clickSelfInvinvible)
    controller:GMSetSelfPlayerInvincible(self._clickSelfInvinvible)
  else
    LogError("TeamTestGMDialog", "无有效战斗场景")
  end
end

TeamTestGMDialog.OnResetBattleClick = function(self)
  -- function num : 0_5 , upvalues : _ENV, hurtLevelNum, littleWoodMonsterId
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  if controller then
    (DialogManager.DestroySingletonDialog)("newbattle.battlenewmaindialog")
    local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
    controller:OnSBattleStart(protocol)
    self._clickSelfInvinvible = false
    ;
    (self._selfInvincible):SetSelected(self._clickSelfInvinvible)
    controller:GMSetSelfPlayerInvincible(self._clickSelfInvinvible)
    for i = 1, hurtLevelNum do
      ((self._LittleWoodHurtLevelBtn)[i]):SetIsOnType(false)
    end
    ;
    ((self._LittleWoodHurtLevelBtn)[1]):SetIsOnType(true)
    self._clickSecondHurtBtnTag = false
    ;
    (self._secondHurtBtn):SetSelected(self._clickSecondHurtBtnTag)
    local battlerList = ((NekoData.BehaviorManager).BM_Battle):GetRightBattlers()
    for entityId,battler in pairs(battlerList) do
      if battler:IsRightCamp() and battler:GetConfigId() == littleWoodMonsterId then
        controller:GMSetSecondHurtState(self._clickSecondHurtBtnTag, entityId)
        break
      end
    end
  else
    do
      LogError("TeamTestGMDialog", "无有效战斗场景")
    end
  end
end

TeamTestGMDialog.OnBattleDetailBtnClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("newbattle.battledetaildialog")
  if not dialog then
    ((DialogManager.CreateSingletonDialog)("newbattle.battledetaildialog")):SetData()
    ;
    ((NekoData.DataManager).DM_TimeScale):SetBattlePause()
  end
end

TeamTestGMDialog.OnBattleWinBtnClick = function(self)
  -- function num : 0_7 , upvalues : _ENV, BattleEndType
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.cbattlekill")
  protocol.type = BattleEndType.LeftWinCBattleKill
  ;
  ((NekoData.BehaviorManager).BM_Battle):SendProtocolToLogicWorld(protocol)
end

TeamTestGMDialog.OnLittleWoodHurtLevelBtnClicked = function(self, index)
  -- function num : 0_8 , upvalues : hurtLevelNum, _ENV, littleWoodMonsterId, HurtLevelBehaviorName
  for i = 1, hurtLevelNum do
    ((self._LittleWoodHurtLevelBtn)[i]):SetIsOnType(false)
  end
  ;
  ((self._LittleWoodHurtLevelBtn)[index]):SetIsOnType(true)
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  if controller then
    local battlerList = ((NekoData.BehaviorManager).BM_Battle):GetRightBattlers()
    for entityId,battler in pairs(battlerList) do
      if battler:IsRightCamp() and battler:GetConfigId() == littleWoodMonsterId then
        controller:ChangeEntityBehavior(HurtLevelBehaviorName[index], entityId)
        return 
      end
    end
    LogError("TeamTestGMDialog", "场景中没有木桩")
  else
    do
      LogError("TeamTestGMDialog", "无有效战斗场景")
    end
  end
end

TeamTestGMDialog.OnCloseBtnClick = function(self)
  -- function num : 0_9
  if self._opening then
    self._opening = false
    ;
    (self:GetRootWindow()):PlayAnimation("BattleTestHide")
  end
end

TeamTestGMDialog.OnOpenBtnClick = function(self)
  -- function num : 0_10
  if not self._opening then
    self._opening = true
    ;
    (self:GetRootWindow()):PlayAnimation("BattleTestShow")
  end
end

TeamTestGMDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return TeamTestGMDialog

