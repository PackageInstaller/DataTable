-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/aprilfoolstowerbattledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CMonster_Handbook = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CClownSpecialCfg = (BeanManager.GetTableByName)("activity.cclownspecialcfg")
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local EventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local AprilFoolsTowerBattleDialog = class("AprilFoolsTowerBattleDialog", Dialog)
AprilFoolsTowerBattleDialog.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsTowerBattleDialog.AssetName = "ActivityAprilFoolsBattle"
local charNumber = 3
local ResultType = {Success = 1, Failed = 0}
local RightEnemyIndex = 0
AprilFoolsTowerBattleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AprilFoolsTowerBattleDialog, _ENV
  ((AprilFoolsTowerBattleDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AprilFoolsDayActivityManagerID)
end

AprilFoolsTowerBattleDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : charNumber, AnimatorStaticFunctions, _ENV, CStringRes
  self._title = self:GetChild("BattleBack/Text")
  self._char = {}
  for i = 1, charNumber do
    do
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

      (self._char)[i] = {}
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).model = self:GetChild("BattleBack/Char" .. i .. "/Model")
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).modelAnimator = (AnimatorStaticFunctions.Get)((((self._char)[i]).model)._uiObject)
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).healthNumTxt = self:GetChild("BattleBack/Char" .. i .. "/Health/HealthNum")
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).panel = self:GetChild("BattleBack/Char" .. i)
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).injuryNum = self:GetChild("BattleBack/Char" .. i .. "/AtkShow")
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).injuryNumAnimator = (AnimatorStaticFunctions.Get)((((self._char)[i]).injuryNum)._uiObject)
      ;
      (((self._char)[i]).injuryNum):SetActive(false)
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).name = self:GetChild("BattleBack/Char" .. i .. "/CharName")
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).attackEffect = self:GetChild("BattleBack/Char" .. i .. "/Effect")
      -- DECOMPILER ERROR at PC98: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._char)[i]).attackNumTxt = self:GetChild("BattleBack/Char" .. i .. "/Attack/AttackNum")
      ;
      (((self._char)[i]).model):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
      ;
      (((self._char)[i]).injuryNum):Subscribe_StateExitEvent(function(s, handle, stateName, normalizedTime)
    -- function num : 0_1_0 , upvalues : self, i
    self:OnInjuryNumAnimationStateExit(i, handle, stateName, normalizedTime)
  end
, self)
    end
  end
  self._enemyName = self:GetChild("BattleBack/Enemy/CharName")
  self._enemyAttackNumTxt = self:GetChild("BattleBack/Enemy/Attack/AttackNum")
  self._enemyModel = self:GetChild("BattleBack/Enemy/Model")
  self._enemyModelAnimator = (AnimatorStaticFunctions.Get)((self._enemyModel)._uiObject)
  self._enemyInjuryNum = self:GetChild("BattleBack/Enemy/AtkShow")
  self._enemyInjuryNumAnimator = (AnimatorStaticFunctions.Get)((self._enemyInjuryNum)._uiObject)
  ;
  (self._enemyInjuryNum):SetActive(false)
  self._enemyHealthNumTxt = self:GetChild("BattleBack/Enemy/Health/HealthNum")
  self._enemyAttackEffect = self:GetChild("BattleBack/Enemy/Effect")
  self._rigthTagTxt = self:GetChild("LineR/Text")
  self._leftTagTxt = self:GetChild("LineB/Text")
  self._skipBtn = self:GetChild("SkipBtn")
  ;
  (self._enemyModel):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  ;
  (self._enemyInjuryNum):Subscribe_StateExitEvent(function(s, handle, stateName, normalizedTime)
    -- function num : 0_1_1 , upvalues : self
    self:OnInjuryNumAnimationStateExit(0, handle, stateName, normalizedTime)
  end
, self)
  ;
  (self._skipBtn):Subscribe_PointerClickEvent(self.OnSkipBtnClicked, self)
  ;
  (self._title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1789)).msgTextID))
  ;
  (self._leftTagTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1843)).msgTextID))
  ;
  (self._rigthTagTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1844)).msgTextID))
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogWillDestroy, Common.n_DialogWillDestroy, nil)
end

AprilFoolsTowerBattleDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._enemyModelHandler ~= 0 then
    (self._enemyModel):ReleaseModel(self._enemyModelHandler)
    self._enemyModelHandler = 0
  end
  for i,c in ipairs(self._char) do
    if c.handler then
      (c.model):ReleaseModel(c.handler)
      c.handler = nil
    end
  end
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

AprilFoolsTowerBattleDialog.SetData = function(self, serverResult, data)
  -- function num : 0_3 , upvalues : _ENV, charNumber, Role, CStringRes, TransformStaticFunctions, EventTriggerHelper, AnimatorStaticFunctions, CMonster_Handbook, CNPCShape, CClownSpecialCfg
  self._floorData = data
  self._charList = (self._bm):GetGardenPartyRoleList()
  self._leftQueue = {}
  for _,c in ipairs(self._charList) do
    (table.insert)(self._leftQueue, {attack = c.attack, blood = c.blood, battlesort = c.battlesort, roleId = c.roleId})
  end
  if #self._leftQueue <= 0 then
    LogError("AprilFoolsTowerBattleDialog", "left has no character")
    self:RealQuit()
    return 
  end
  ;
  (table.sort)(self._leftQueue, function(a, b)
    -- function num : 0_3_0
    do return a.battlesort < b.battlesort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i = 1, charNumber do
    (((self._char)[i]).panel):SetActive(false)
  end
  local npcShapeRecorder, role = nil, nil
  local i = charNumber
  for _,c in ipairs(self._leftQueue) do
    if (self._char)[i] then
      c.index = i
      ;
      (((self._char)[i]).panel):SetActive(true)
      ;
      (((self._char)[i]).attackNumTxt):SetText(c.attack)
      ;
      (((self._char)[i]).healthNumTxt):SetText(c.blood)
      role = (Role.Create)(c.roleId)
      if c.roleId == 1 then
        (((self._char)[i]).name):SetText((TextManager.GetText)((CStringRes:GetRecorder(1778)).msgTextID))
      else
        ;
        (((self._char)[i]).name):SetText(role:GetRoleName())
      end
      npcShapeRecorder = role:GetModelRecord()
      if ((self._char)[i]).handler then
        (((self._char)[i]).model):ReleaseModel(((self._char)[i]).handler)
        -- DECOMPILER ERROR at PC128: Confused about usage of register: R11 in 'UnsetPending'

        ;
        ((self._char)[i]).handler = nil
      end
      -- DECOMPILER ERROR at PC138: Confused about usage of register: R11 in 'UnsetPending'

      ;
      ((self._char)[i]).handler = (((self._char)[i]).model):AddModelSync(npcShapeRecorder.assetBundle, npcShapeRecorder.assetName)
      -- DECOMPILER ERROR at PC151: Confused about usage of register: R11 in 'UnsetPending'

      ;
      ((self._char)[i]).prefabModel = (TransformStaticFunctions.GetChild)((((self._char)[i]).model)._uiObject, "Model/" .. npcShapeRecorder.assetName .. "(Clone)")
      ;
      (EventTriggerHelper.AddStateExitListener)(((self._char)[i]).prefabModel, self.OnPrefabModelAnimationStateExit, self)
      -- DECOMPILER ERROR at PC166: Confused about usage of register: R11 in 'UnsetPending'

      ;
      ((self._char)[i]).prefabModelAnimator = (AnimatorStaticFunctions.Get)(((self._char)[i]).prefabModel)
    else
      LogErrorFormat("AprilFoolsTowerBattleDialog", "index %s char not on UI", i)
    end
    i = i - 1
  end
  self._rightQueue = {attack = (self._floorData).enemyATK, blood = (self._floorData).enemyHP}
  ;
  (self._enemyAttackNumTxt):SetText((self._rightQueue).attack)
  ;
  (self._enemyHealthNumTxt):SetText((self._rightQueue).blood)
  local record = CMonster_Handbook:GetRecorder((self._floorData).handbookid)
  ;
  (self._enemyName):SetText((TextManager.GetText)(record.nameTextID))
  npcShapeRecorder = CNPCShape:GetRecorder(record.shapeID)
  if self._enemyModelHandler ~= 0 then
    (self._enemyModel):ReleaseModel(self._enemyModelHandler)
    self._enemyModelHandler = 0
  end
  self._enemyModelHandler = (self._enemyModel):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
  local scale = (self._floorData).scale
  ;
  (self._enemyModel):SetLocalScale(-scale, scale, scale)
  self._result = self:MakeBattleOpList()
  if self._result == serverResult then
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
    self._task = (ServerGameTimer.AddTask)(tonumber((CClownSpecialCfg:GetRecorder(11)).Value), -1, function()
    -- function num : 0_3_1 , upvalues : self
    self:Act()
  end
, nil)
  else
    LogErrorFormat("AprilFoolsTowerBattleDialog", "serverResult %s clientResult %s. operation failure", serverResult, self._result)
    self:RealQuit()
  end
end

AprilFoolsTowerBattleDialog.OnAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_4 , upvalues : _ENV
  if stateName == "ActivityAprilFoolsbattleSet" then
    (table.remove)(self._opList, 1)
    self:Act()
  end
end

AprilFoolsTowerBattleDialog.OnPrefabModelAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_5
  if stateName == "Hit" and self._disappearCharTarget then
    (((self._char)[self._disappearCharTarget]).panel):SetActive(false)
    self._disappearCharTarget = nil
  end
end

AprilFoolsTowerBattleDialog.OnInjuryNumAnimationStateExit = function(self, index, handle, stateName, normalizedTime)
  -- function num : 0_6
  if stateName == "AtkShow" then
    if index == 0 then
      (self._enemyInjuryNum):SetActive(false)
    else
      ;
      (((self._char)[index]).injuryNum):SetActive(false)
    end
  end
end

AprilFoolsTowerBattleDialog.OnSkipBtnClicked = function(self)
  -- function num : 0_7
  self:Quit()
end

AprilFoolsTowerBattleDialog.Act = function(self)
  -- function num : 0_8 , upvalues : RightEnemyIndex, _ENV, charNumber
  if #self._opList > 0 then
    local op = (self._opList)[1]
    if op.index == RightEnemyIndex then
      (self._enemyModelAnimator):SetTrigger("Attack")
    else
      ;
      (((self._char)[op.index]).modelAnimator):SetTrigger("Attack")
    end
    if op.target == RightEnemyIndex then
      (self._enemyInjuryNum):SetActive(true)
      ;
      (self._enemyInjuryNum):SetText("-" .. tostring(op.damage))
      ;
      (self._enemyInjuryNumAnimator):SetTrigger("Num")
      ;
      (self._enemyHealthNumTxt):SetText(op.blood)
      ;
      (self._enemyAttackEffect):SetActive(false)
      ;
      (self._enemyAttackEffect):SetActive(true)
      ;
      (self._enemyModelAnimator):Play("AtkShowMonsterHit")
    else
      for i = 1, charNumber do
        (((self._char)[i]).injuryNum):SetActive(false)
      end
      ;
      (((self._char)[op.target]).injuryNum):SetActive(true)
      ;
      (((self._char)[op.target]).injuryNum):SetText("-" .. tostring(op.damage))
      ;
      (((self._char)[op.target]).injuryNumAnimator):SetTrigger("Num")
      ;
      (((self._char)[op.target]).healthNumTxt):SetText(op.blood)
      if op.blood <= 0 then
        self._disappearCharTarget = op.target
      end
      ;
      (((self._char)[op.target]).attackEffect):SetActive(false)
      ;
      (((self._char)[op.target]).attackEffect):SetActive(true)
      ;
      (((self._char)[op.target]).prefabModelAnimator):Play("Hit")
    end
  else
    do
      self:Quit()
    end
  end
end

AprilFoolsTowerBattleDialog.MakeBattleOpList = function(self)
  -- function num : 0_9 , upvalues : _ENV, RightEnemyIndex, ResultType
  self._opList = {}
  local removeList = {}
  local leftV = nil
  while 1 do
    for _,v in ipairs(self._leftQueue) do
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'

      (self._rightQueue).blood = (self._rightQueue).blood - v.attack
      ;
      (table.insert)(self._opList, {index = v.index, damage = v.attack, target = RightEnemyIndex, blood = (self._rightQueue).blood})
      if (self._rightQueue).blood <= 0 then
        return ResultType.Success
      end
    end
    removeList = {}
    leftV = (self._leftQueue)[1]
    leftV.blood = leftV.blood - (self._rightQueue).attack
    ;
    (table.insert)(self._opList, {index = RightEnemyIndex, damage = (self._rightQueue).attack, target = leftV.index, blood = leftV.blood})
    for i,v in ipairs(self._leftQueue) do
      if v.blood <= 0 then
        (table.insert)(removeList, 1, i)
      end
    end
    for _,i in ipairs(removeList) do
      (table.remove)(self._leftQueue, i)
    end
    if #self._leftQueue == 0 then
      return ResultType.Failed
    end
  end
end

AprilFoolsTowerBattleDialog.Quit = function(self)
  -- function num : 0_10 , upvalues : ResultType, _ENV
  if self._result == ResultType.Failed then
    (DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolstowerbattlefaileddialog")
  else
    self:RealQuit()
  end
end

AprilFoolsTowerBattleDialog.RealQuit = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_AprilFoolsClientBattleProcessOver, self, nil)
  self:Destroy()
end

AprilFoolsTowerBattleDialog.OnDialogWillDestroy = function(self, notification)
  -- function num : 0_12
  if (notification.userInfo)._dialogName == "activity.aprilfoolsday.aprilfoolstowerbattlefaileddialog" then
    self:RealQuit()
  end
end

return AprilFoolsTowerBattleDialog

