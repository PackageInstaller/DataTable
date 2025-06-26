-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battleskillsmallcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
local CCostSkillTable = (BeanManager.GetTableByName)("skill.ccostskill")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSkillItem = (BeanManager.GetTableByName)("item.cskillitem")
local RoleConfig = (BeanManager.GetTableByName)("role.roleconfig")
local CIconTypeCfg = (BeanManager.GetTableByName)("skill.cicontypecfg")
local CSkillAutoWeightCfg = (BeanManager.GetTableByName)("skill.cskillautoweightcfg")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local BattleSkillSmallCell = class("BattleSkillSmallCell", Dialog)
BattleSkillSmallCell.AssetBundleName = "ui/layouts.battlenew"
BattleSkillSmallCell.AssetName = "BattleCharSkillCellSmall"
local AutoBattleModeType = {Optional = 1, Default = 2}
local PowerAccumulateStateType = {Filling = 1, Full = 2, BreakOut = 3, Drain = 4}
local OnNewBattleGuide1SpecialSkillEffect = function(self, notification)
  -- function num : 0_0 , upvalues : _ENV
  local userInfo = notification.userInfo
  if userInfo == nil then
    return userInfo
  end
  if userInfo.guideID == 1 then
    self._guideId = 1
    local dialog = (DialogManager.GetDialog)("battle.battletutorial.battletutorial1dialog")
    if dialog then
      self._guideEffectHandler = (dialog._skillPanelEffect1):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1052))
      self._currentEffectPanel = dialog._skillPanelEffect1
    end
  else
    do
      self._guideId = 2
      do
        -- DECOMPILER ERROR at PC36: Unhandled construct in 'MakeBoolean' P1

        if userInfo.stageID == "shanbi" and self._cellData == 6000501 then
          local dialog = (DialogManager.GetDialog)("battle.battletutorial.battletutorial2dialog")
          if dialog then
            self._guideEffectHandler = (dialog._skillPanelEffect6):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1052))
            self._currentEffectPanel = dialog._skillPanelEffect2
          end
        end
        do
          if (userInfo.stageID == "linghunjian1" or userInfo.stageID == "linghunjian2") and self._cellData == 6001101 then
            local dialog = (DialogManager.GetDialog)("battle.battletutorial.battletutorial2dialog")
            if dialog then
              self._guideEffectHandler = (dialog._skillPanelEffect6):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1052))
              self._currentEffectPanel = dialog._skillPanelEffect6
            end
          end
          self._isInBattleGuideSpecialSkillEffect = true
        end
      end
    end
  end
end

local OnNewBattleGuideTimeType1002Start = function(self, notification)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Unhandled construct in 'MakeBoolean' P1

  if notification.userInfo == 1 and self._cellData == 6016101 then
    self._battleGuideState = true
    ;
    ((NekoData.BehaviorManager).BM_Guide):CreateGuideDialogInBattle(nil, function()
    -- function num : 0_1_0 , upvalues : self
    local width, height = (self._frame):GetRectSize()
    local screenPos = (self._frame):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = screenPos.x, posY = screenPos.y}
  end
, function()
    -- function num : 0_1_1 , upvalues : self
    local width, height = (self._frame):GetRectSize()
    local screenPos = (self._frame):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = screenPos.x, posY = screenPos.y}
  end
, "Up", 2301123)
    ;
    ((NekoData.DataManager).DM_TimeScale):SetBattleGuidePause()
  end
  if notification.userInfo == 2 and self._cellData == 6076101 then
    self._battleGuideState = true
    ;
    ((NekoData.BehaviorManager).BM_Guide):CreateGuideDialogInBattle(nil, function()
    -- function num : 0_1_2 , upvalues : self
    local width, height = (self._frame):GetRectSize()
    local screenPos = (self._frame):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = screenPos.x, posY = screenPos.y}
  end
, function()
    -- function num : 0_1_3 , upvalues : self
    local width, height = (self._frame):GetRectSize()
    local screenPos = (self._frame):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = screenPos.x, posY = screenPos.y}
  end
, "Up", 2301129)
    ;
    ((NekoData.DataManager).DM_TimeScale):SetBattleGuidePause()
  end
end

local OnNewBattleGuideTimeType1003 = function(self, notification)
  -- function num : 0_2 , upvalues : _ENV
  if notification.userInfo == 4 and self._cellData == 6016201 then
    self._battleGuideState = true
    self._battleGuideTimeType_1003_guide_stage4 = true
    ;
    ((NekoData.BehaviorManager).BM_Guide):CreateGuideDialogInBattle(nil, function()
    -- function num : 0_2_0 , upvalues : self
    local width, height = (self._frame):GetRectSize()
    local screenPos = (self._frame):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = screenPos.x, posY = screenPos.y}
  end
, function()
    -- function num : 0_2_1 , upvalues : self
    local width, height = (self._frame):GetRectSize()
    local screenPos = (self._frame):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = screenPos.x, posY = screenPos.y}
  end
, "Up", 2301166)
    ;
    ((NekoData.DataManager).DM_TimeScale):SetBattleGuidePause()
  end
end

BattleSkillSmallCell.Ctor = function(self, ...)
  -- function num : 0_3 , upvalues : BattleSkillSmallCell
  ((BattleSkillSmallCell.super).Ctor)(self, ...)
  self._forbidClick = true
  self._energySkillCanClick = true
  self._tag = false
  self._useEffectHandler = nil
  self._activeEffectHandler = nil
  self._effectHandler = 0
  self._autoEffectHandler = nil
  self._dusty = false
  self._skillCostRecord = nil
  self._greyTag = false
  self._isInBattleGuideSpecialSkillEffect = false
  self._guideId = 0
  self._isCanUseSkill = true
  self._isSkillInCD = false
  self._beanNum = 0
  self._collaborativeskillnum = 0
end

BattleSkillSmallCell.OnCreate = function(self)
  -- function num : 0_4 , upvalues : _ENV, OnNewBattleGuide1SpecialSkillEffect, OnNewBattleGuideTimeType1002Start, OnNewBattleGuideTimeType1003
  self._back = self:GetChild("SkillBack1/Back")
  self._frame = self:GetChild("SkillBack1/Frame")
  self._skill = self:GetChild("SkillBack1/Frame/Skill1")
  self._yellow = self:GetChild("SkillBack1/Frame/YellowBack")
  self._yellowNum = self:GetChild("SkillBack1/Frame/YellowBack/Num")
  self._blue = self:GetChild("SkillBack1/Frame/BlueBack")
  self._blueNum = self:GetChild("SkillBack1/Frame/BlueBack/Num")
  self._useEffect = self:GetChild("SkillBack1/Frame/EffectUse")
  self._activeEffect = self:GetChild("SkillBack1/Frame/EffectActive")
  self._effect = self:GetChild("SkillBack1/Frame/Effect")
  self._autoEffect = self:GetChild("SkillBack1/Frame/EffectAuto")
  self._grey = self:GetChild("SkillBack1/Frame/Grey")
  self._guideEffect = self:GetChild("Effect")
  self._countTimeTxt = self:GetChild("SkillBack1/Frame/Time")
  self._skillTypeImg = self:GetChild("SkillBack1/Frame/SkillType")
  self._energySkillTag = self:GetChild("SkillBack1/Frame/EnergySkill")
  self._skillMarkPanel = self:GetChild("SkillBack1/Frame/SkillMarkFrame")
  self._lockTag = self:GetChild("SkillBack1/Frame/Lock")
  ;
  (self._lockTag):SetActive(false)
  self._guideEffectHandler = nil
  self._currentEffectPanel = nil
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_LateUpdate, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, OnNewBattleGuide1SpecialSkillEffect, Common.n_NewBattleGuide1SpecialSkillEffect, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, OnNewBattleGuideTimeType1002Start, Common.n_NewBattleGuideTimeType1002Start, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, OnNewBattleGuideTimeType1003, Common.n_NewBattleGuideTimeType1003, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBattlerCanUseSkill, Common.n_BattlerUseSkill, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnCollaborativeSkillNumChange, Common.n_CollaborativeSkillNumChange, nil)
end

BattleSkillSmallCell.OnDestroy = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._autoEffectHandler then
    (self._autoEffect):ReleaseEffect(self._autoEffectHandler)
    self._autoEffectHandler = nil
  end
  if self._collaborativeSkillFrame then
    (self._collaborativeSkillFrame):Destroy()
    self._collaborativeSkillFrame = nil
  end
  if self._lightEnergySkillTimeTask then
    (GameTimer.RemoveTask)(self._lightEnergySkillTimeTask)
    self._lightEnergySkillTimeTask = nil
  end
end

BattleSkillSmallCell.RefreshCell = function(self, data)
  -- function num : 0_6 , upvalues : CSkillTable, CImagePathTable, _ENV, CSkillItem, CIconTypeCfg, CCostSkillTable, AutoBattleModeType, GridFrame
  if data and data == 0 then
    (self._frame):SetActive(false)
    self._tag = false
    self._dusty = true
  end
  local blueBackShowTag = true
  local yellowBackShowTag = true
  self._isEnergySkill = ((self._delegate)._cellData):IfSkillIsEnergy(self._cellData)
  if data and data ~= 0 then
    if ((self._delegate)._cellData):IsAlive() then
      (self._frame):SetActive(true)
      self._dusty = false
    else
      ;
      (self._frame):SetActive(false)
      self._dusty = true
    end
    self._tag = true
    local skillRecord = CSkillTable:GetRecorder(data)
    if not CImagePathTable:GetRecorder(skillRecord.icon) then
      local image = DataCommon.DefaultImageAsset
    end
    ;
    (self._skill):SetSprite(image.assetBundle, image.assetName)
    local record = (((BattleECS.Utility).DataUtility).cSkillItemTable)[self._cellData]
    if record then
      local contractskillid = record.itemId
      local skillItemRecorder = CSkillItem:GetRecorder(contractskillid)
      if skillItemRecorder then
        local recorder = CIconTypeCfg:GetRecorder(skillItemRecorder.iconType)
        if recorder then
          if not CImagePathTable:GetRecorder(recorder.iconID) then
            image = DataCommon.DefaultImageAsset
          end
          ;
          (self._skillTypeImg):SetSprite(image.assetBundle, image.assetName)
        else
          LogErrorFormat("BattleSkillSmallCell", "skillitemid %s skillid %s dont have iconType", contractskillid, self._cellData)
        end
      else
        do
          do
            LogErrorFormat("BattleSkillSmallCell", "roleid %s skillid %s skillitemid %s dont exist in CSkillItem", ((self._delegate)._cellData):GetConfigId(), self._cellData, contractskillid)
            LogErrorFormat("BattleSkillSmallCell", "skillid %s dont exist in DataUtility.cSkillItemTable", self._cellData)
            self._skillCostRecord = CCostSkillTable:GetRecorder(data)
            self._pureCostRec = nil
            while self._pureCostRec and self._pureCostRec do
              (table.remove)(self._pureCostRec, #self._pureCostRec)
            end
            if self._skillCostRecord and (self._skillCostRecord).pureCost and (self._skillCostRecord).pureCost ~= "" then
              self._pureCostRec = (string.split)((self._skillCostRecord).pureCost, ";")
              self._chaosFunc = self:GetFunction((self._pureCostRec)[2])
              self._orderFunc = self:GetFunction((self._pureCostRec)[1])
            end
            local orderCost, chaosCost = self:GetSkillCost()
            if chaosCost == 0 then
              yellowBackShowTag = false
              if orderCost == 0 then
                blueBackShowTag = false
              else
                blueBackShowTag = true
                if not CImagePathTable:GetRecorder(10332) then
                  image = DataCommon.DefaultImageAsset
                end
                ;
                (self._blue):SetSprite(image.assetBundle, image.assetName)
                ;
                (self._blueNum):SetText(orderCost)
              end
            else
              if orderCost == 0 then
                yellowBackShowTag = false
              else
                yellowBackShowTag = true
                if not CImagePathTable:GetRecorder(10332) then
                  image = DataCommon.DefaultImageAsset
                end
                ;
                (self._yellow):SetSprite(image.assetBundle, image.assetName)
                ;
                (self._yellowNum):SetText(orderCost)
              end
              blueBackShowTag = true
              if not CImagePathTable:GetRecorder(10331) then
                image = DataCommon.DefaultImageAsset
              end
              ;
              (self._blue):SetSprite(image.assetBundle, image.assetName)
              ;
              (self._blueNum):SetText(chaosCost)
            end
            if not self._isEnergySkill then
              if self._autoEffectHandler then
                (self._autoEffect):ReleaseEffect(self._autoEffectHandler)
                self._autoEffectHandler = nil
              end
              self._tempAutoBattle = ((NekoData.BehaviorManager).BM_Battle):GetTempAutoBattleInfo()
              if (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight == 1 then
                local list = {}
                local autoSkillList = {}
                if ((NekoData.BehaviorManager).BM_Game):GetAutoBattleMode() == AutoBattleModeType.Optional then
                  autoSkillList = ((NekoData.BehaviorManager).BM_Battle):GetOptionalModeAutoBattleSkillInfo()
                end
                for _,v in ipairs(autoSkillList) do
                  if (CCostSkillTable:GetRecorder(v.skillId)).OrderCost ~= 0 then
                    (table.insert)(list, {roleId = v.roleId, skillId = v.skillId, effectId = 1053, cost = orderCost})
                  else
                    if (CCostSkillTable:GetRecorder(v.skillId)).ChaosCost ~= 0 then
                      (table.insert)(list, {roleId = v.roleId, skillId = v.skillId, effectId = 1054, cost = chaosCost})
                    end
                  end
                end
                for _,v in ipairs(list) do
                  if v.roleId == ((self._delegate)._cellData):GetConfigId() and v.cost ~= 0 and data == v.skillId and not self._autoEffectHandler then
                    self._autoEffectHandler = (self._autoEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(v.effectId))
                  end
                end
              end
            end
            do
              self._isSkillInCD = ((self._delegate)._cellData):GetSkillIsInCD(self._cellData)
              if self._isEnergySkill then
                if self._autoEffectHandler then
                  (self._autoEffect):ReleaseEffect(self._autoEffectHandler)
                  self._autoEffectHandler = nil
                end
                self._energySkillCanClick = false
                self._collaborativeskillnum = ((self._delegate)._cellData):GetCollaborativeSkillNum()
                if self._collaborativeskillnum > 0 then
                  if self._collaborativeSkillFrame then
                    (self._collaborativeSkillFrame):Destroy()
                    self._collaborativeSkillFrame = nil
                  end
                  self._collaborativeSkillFrame = (GridFrame.Create)(self._skillMarkPanel, self, true, self._collaborativeskillnum, false, true)
                  self._skillbeandata = {}
                  for i = 1, self._collaborativeskillnum do
                    local temp = {}
                    temp.id = i
                    ;
                    (table.insert)(self._skillbeandata, temp)
                  end
                  ;
                  (self._collaborativeSkillFrame):ReloadAllCell()
                end
                ;
                (self._energySkillTag):SetActive(true)
                blueBackShowTag = false
                yellowBackShowTag = false
              else
                self._energySkillCanClick = true
                if self._collaborativeSkillFrame then
                  (self._collaborativeSkillFrame):Destroy()
                  self._collaborativeSkillFrame = nil
                end
                ;
                (self._energySkillTag):SetActive(false)
              end
              ;
              (self._blue):SetActive(blueBackShowTag)
              ;
              (self._yellow):SetActive(yellowBackShowTag)
            end
          end
        end
      end
    end
  end
end

BattleSkillSmallCell.OnUpdate = function(self, notification)
  -- function num : 0_7 , upvalues : CCostSkillTable, _ENV, AutoBattleModeType
  local orderCost, chaosCost = self:GetSkillCost()
  -- DECOMPILER ERROR at PC9: Unhandled construct in 'MakeBoolean' P1

  if chaosCost == 0 and orderCost ~= 0 then
    (self._blueNum):SetText(orderCost)
  end
  if orderCost ~= 0 then
    (self._yellowNum):SetText(orderCost)
  end
  ;
  (self._blueNum):SetText(chaosCost)
  if self._isSkillInCD then
    local time = ((self._delegate)._cellData):GetSkillCountTime(self._cellData) - (notification.userInfo).deltaTime / 0.033333333333333
    if time >= 0 then
      if (CCostSkillTable:GetRecorder(self._cellData)).isCDDisplay == 1 then
        (self._countTimeTxt):SetActive(true)
        ;
        (self._countTimeTxt):SetText((string.format)("%.1f", time / 30))
      end
      ;
      ((self._delegate)._cellData):SetSkillCountTime(self._cellData, time)
    else
      ;
      (self._countTimeTxt):SetActive(false)
      ;
      ((self._delegate)._cellData):SetSkillCountTime(self._cellData, 0)
    end
  else
    do
      ;
      (self._countTimeTxt):SetActive(false)
      if not self._dusty then
        local power1, power1Max = ((NekoData.BehaviorManager).BM_Battle):GetPower1()
        local power2, power2Max = ((NekoData.BehaviorManager).BM_Battle):GetPower2()
        local canUseSkillTag = (orderCost > power1 or chaosCost > power2 or self._isCanUseSkill) and not self._isSkillInCD and not self._isEnergySkill
        if self._isEnergySkill then
          local isEnergySkillAndFull = self:IsFullBean()
        end
        if canUseSkillTag or isEnergySkillAndFull then
          (self._grey):SetActive(false)
          self._greyTag = false
          ;
          (self._activeEffect):SetActive(true)
          if not self._activeEffectHandler then
            self._activeEffectHandler = (self._activeEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1055))
          end
          ;
          (self._useEffect):SetActive(true)
          if not self._useEffectHandler then
            self._useEffectHandler = (self._useEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1052))
          end
          local autoSkillList = {}
          if (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight == 1 and self._tag then
            if ((NekoData.BehaviorManager).BM_Game):GetAutoBattleMode() == AutoBattleModeType.Optional then
              autoSkillList = ((NekoData.BehaviorManager).BM_Battle):GetOptionalModeAutoBattleSkillInfo()
            elseif ((NekoData.BehaviorManager).BM_Game):GetAutoBattleMode() == AutoBattleModeType.Default then
              autoSkillList = ((NekoData.BehaviorManager).BM_Battle):GetDefaultModeAutoBattleSkillInfo()
            end
            for _,v in ipairs(autoSkillList) do
              if v.roleId == ((self._delegate)._cellData):GetConfigId() and self._cellData == v.skillId and v.canClick then
                v.canClick = false
                self:OnCellClicked(true)
              end
            end
          end
        else
          (self._grey):SetActive(true)
          self._greyTag = true
          if self._activeEffectHandler then
            (self._activeEffect):SetActive(false)
          end
          if self._useEffectHandler then
            (self._useEffect):SetActive(false)
          end
        end
      end
      -- DECOMPILER ERROR: 12 unprocessed JMP targets
    end
  end
end

BattleSkillSmallCell.OnCellClicked = function(self, arg)
  -- function num : 0_8 , upvalues : _ENV, AutoBattleModeType, PowerAccumulateStateType, CSkillAutoWeightCfg
  if self._forbidClick and self._energySkillCanClick and not self._dusty then
    -- DECOMPILER ERROR at PC38: Unhandled construct in 'MakeBoolean' P1

    if type(arg) ~= "boolean" and self._tempAutoBattle and (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight == 1 and ((NekoData.BehaviorManager).BM_Game):GetAutoBattleMode() == AutoBattleModeType.Optional then
      local autoBattle = ((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()
      if ((self._delegate)._delegate)._breakOutPowerState == PowerAccumulateStateType.BreakOut then
        for roleId,skillId in pairs((self._tempAutoBattle).eruptSkill) do
          -- DECOMPILER ERROR at PC58: Confused about usage of register: R8 in 'UnsetPending'

          if ((self._delegate)._cellData):GetConfigId() == roleId then
            ((self._tempAutoBattle).eruptSkill)[roleId] = self._cellData
            -- DECOMPILER ERROR at PC61: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (autoBattle.eruptSkill)[roleId] = self._cellData
            ;
            ((self._delegate)._delegate):ChangeAutoBattleSkills()
            break
          end
        end
      else
        do
          do
            local orderCost, chaosCost = self:GetSkillCost()
            -- DECOMPILER ERROR at PC83: Confused about usage of register: R5 in 'UnsetPending'

            if orderCost ~= 0 and self._cellData ~= ((self._tempAutoBattle).orderSKill).skillId then
              ((self._tempAutoBattle).orderSKill).skillId = self._cellData
              -- DECOMPILER ERROR at PC90: Confused about usage of register: R5 in 'UnsetPending'

              ;
              ((self._tempAutoBattle).orderSKill).roleId = ((self._delegate)._cellData):GetConfigId()
              -- DECOMPILER ERROR at PC93: Confused about usage of register: R5 in 'UnsetPending'

              ;
              (autoBattle.orderSKill).skillId = self._cellData
              -- DECOMPILER ERROR at PC99: Confused about usage of register: R5 in 'UnsetPending'

              ;
              (autoBattle.orderSKill).roleId = ((self._delegate)._cellData):GetConfigId()
              ;
              ((self._delegate)._delegate):ChangeAutoBattleSkills()
            else
              -- DECOMPILER ERROR at PC116: Confused about usage of register: R5 in 'UnsetPending'

              if chaosCost ~= 0 and self._cellData ~= ((self._tempAutoBattle).disorderSkill).skillId then
                ((self._tempAutoBattle).disorderSkill).skillId = self._cellData
                -- DECOMPILER ERROR at PC123: Confused about usage of register: R5 in 'UnsetPending'

                ;
                ((self._tempAutoBattle).disorderSkill).roleId = ((self._delegate)._cellData):GetConfigId()
                -- DECOMPILER ERROR at PC126: Confused about usage of register: R5 in 'UnsetPending'

                ;
                (autoBattle.disorderSkill).skillId = self._cellData
                -- DECOMPILER ERROR at PC132: Confused about usage of register: R5 in 'UnsetPending'

                ;
                (autoBattle.disorderSkill).roleId = ((self._delegate)._cellData):GetConfigId()
                ;
                ((self._delegate)._delegate):ChangeAutoBattleSkills()
              end
            end
            if self._tag and not self._greyTag then
              do
                if (self._delegate)._guideFinished == false then
                  local battleID = (self._delegate)._battleID
                  if battleID == 1120 or battleID == 1122 then
                    if self._isInBattleGuideSpecialSkillEffect then
                      (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuide1SpecialSkillClicked, nil, nil)
                      if self._guideEffectHandler ~= nil and self._guideId == 1 then
                        (self._currentEffectPanel):ReleaseEffect(self._guideEffectHandler)
                      end
                      if self._guideEffectHandler ~= nil and self._guideId == 2 then
                        (self._currentEffectPanel):ReleaseEffect(self._guideEffectHandler)
                      end
                      self._guideEffectHandler = nil
                      self._isInBattleGuideSpecialSkillEffect = false
                    else
                      return 
                    end
                  end
                end
                do
                  local creq = (BattleClientProtocolManager.CreateProtocol)("action.cskillact")
                  creq.entityId = ((self._delegate)._cellData):GetEntityId()
                  creq.skillid = self._cellData
                  ;
                  ((NekoData.BehaviorManager).BM_Battle):SendProtocolToLogicWorld(creq)
                  ;
                  (self._delegate):OnControlOtherSkill(((self._delegate)._cellData):GetEntityId(), self._cellData)
                  if arg == true and (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight == 1 then
                    ((self._delegate)._cellData):SetSkillAutoCDTime(self._cellData, (CSkillAutoWeightCfg:GetRecorder(self._cellData)).autoCD)
                  end
                  if (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight == 0 then
                    if self._effectHandler and self._effectHandler ~= 0 then
                      (self._effect):ReleaseEffect(self._effectHandler)
                      self._effectHandler = 0
                    end
                    self._effectHandler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1056))
                    ;
                    (self:GetRootWindow()):PlayAnimation("BattleSkillUse")
                    self._tag = false
                  else
                    self._tag = true
                  end
                  if self._battleGuideState then
                    self._battleGuideState = false
                    ;
                    ((NekoData.BehaviorManager).BM_Guide):DestroyGuideDialogInBattle()
                    if self._battleGuideTimeType_1003_guide_stage4 then
                      self._battleGuideTimeType_1003_guide_stage4 = false
                      ;
                      (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuideTimeType1003, self, 5)
                    end
                  end
                  local dialog = (DialogManager.GetDialog)("newbattle.battleroleskillsdetaildialog")
                  if dialog then
                    dialog:Destroy()
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

BattleSkillSmallCell.GetSkillCost = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local orderCost = 0
  local chaosCost = 0
  if self._pureCostRec then
    local power1, power1Max = ((NekoData.BehaviorManager).BM_Battle):GetPower2()
    if self._chaosFuncpara == "orderpwr" then
      chaosCost = tonumber((self._chaosFunc)((math.floor)(power1)))
    else
      if self._chaosFuncpara == "chaospwr" then
        chaosCost = tonumber((self._chaosFunc)((math.floor)(power1)))
      else
        if self._chaosFuncpara == "chaoscostreduce" then
          chaosCost = tonumber((self._chaosFunc)(((self._delegate)._cellData):GetskillPowerCostReduceChaos()))
        else
          if self._chaosFuncpara == "ordercostreduce" then
            chaosCost = tonumber((self._chaosFunc)(((self._delegate)._cellData):GetskillPowerCostReduceOrder()))
          end
        end
      end
    end
    local power2, power2Max = ((NekoData.BehaviorManager).BM_Battle):GetPower1()
    if self._orderFuncpara == "orderpwr" then
      orderCost = tonumber((self._orderFunc)((math.floor)(power2)))
    else
      if self._orderFuncpara == "chaospwr" then
        orderCost = tonumber((self._orderFunc)((math.floor)(power2)))
      else
        if self._orderFuncpara == "chaoscostreduce" then
          orderCost = tonumber((self._orderFunc)(((self._delegate)._cellData):GetskillPowerCostReduceChaos()))
        else
          if self._orderFuncpara == "ordercostreduce" then
            orderCost = tonumber((self._orderFunc)(((self._delegate)._cellData):GetskillPowerCostReduceOrder()))
          end
        end
      end
    end
  else
    do
      if self._skillCostRecord then
        orderCost = (self._skillCostRecord).OrderCost
        chaosCost = (self._skillCostRecord).ChaosCost
      end
      return orderCost, chaosCost
    end
  end
end

BattleSkillSmallCell.GetFunction = function(self, funcStr)
  -- function num : 0_10 , upvalues : _ENV
  if (string.find)(funcStr, "orderpwr") then
    local str = "return function(orderpwr) return " .. funcStr .. " end"
    return (assert(load(str)))(), "orderpwr"
  else
    do
      if (string.find)(funcStr, "chaoscostreduce") then
        local str = "return function(chaoscostreduce) return " .. funcStr .. " end"
        return (assert(load(str)))(), "chaoscostreduce"
      else
        do
          if (string.find)(funcStr, "ordercostreduce") then
            local str = "return function(ordercostreduce) return " .. funcStr .. " end"
            return (assert(load(str)))(), "ordercostreduce"
          else
            do
              if (string.find)(funcStr, "chaospwr") then
                local str = "return function(chaospwr) return " .. funcStr .. " end"
                return (assert(load(str)))(), "chaospwr"
              end
            end
          end
        end
      end
    end
  end
end

BattleSkillSmallCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_11 , upvalues : _ENV, AutoBattleModeType, CCostSkillTable
  if eventName == "ShowSkillCardBack" and arg == ((self._delegate)._cellData):GetEntityId() then
    (self._frame):SetActive(false)
    self._tag = false
    self._dusty = true
  else
    if eventName == "ShowSkillCardFrame" and arg == ((self._delegate)._cellData):GetEntityId() then
      (self._frame):SetActive(true)
      self._tag = true
      self._dusty = false
    end
  end
  if eventName == "NoClickSkill" and arg.entityId == ((self._delegate)._cellData):GetEntityId() and arg.releaseSkill == self._cellData and not self._dusty then
    self._tag = false
  end
  if eventName == "ChangeAutoSkill" and not self._isEnergySkill then
    if self._autoEffectHandler then
      (self._autoEffect):ReleaseEffect(self._autoEffectHandler)
      self._autoEffectHandler = nil
    end
    if (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight == 1 then
      local list = {}
      local autoSkillList = {}
      local orderCost, chaosCost = self:GetSkillCost()
      if ((NekoData.BehaviorManager).BM_Game):GetAutoBattleMode() == AutoBattleModeType.Optional then
        autoSkillList = ((NekoData.BehaviorManager).BM_Battle):GetOptionalModeAutoBattleSkillInfo()
      end
      for _,v in ipairs(autoSkillList) do
        if (CCostSkillTable:GetRecorder(v.skillId)).OrderCost ~= 0 then
          (table.insert)(list, {roleId = v.roleId, skillId = v.skillId, effectId = 1053, cost = orderCost})
        else
          if (CCostSkillTable:GetRecorder(v.skillId)).ChaosCost ~= 0 then
            (table.insert)(list, {roleId = v.roleId, skillId = v.skillId, effectId = 1054, cost = chaosCost})
          end
        end
      end
      for _,v in ipairs(list) do
        if v.roleId == ((self._delegate)._cellData):GetConfigId() and v.cost ~= 0 and self._cellData == v.skillId and not self._autoEffectHandler then
          self._autoEffectHandler = (self._autoEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(v.effectId))
        end
      end
    end
  end
  do
    if eventName == "ForbidClick" then
      self._forbidClick = arg
    end
    if eventName == "SkillCDStateChange" and self._cellData == arg.skillid then
      self._isSkillInCD = ((self._delegate)._cellData):GetSkillIsInCD(self._cellData)
      ;
      ((self._delegate)._cellData):SetSkillCountTime(self._cellData, (CCostSkillTable:GetRecorder(self._cellData)).CDfraps)
    end
    if eventName == "ChangeSkillAutoEffectState" then
      (self._autoEffect):SetActive(arg)
    end
  end
end

BattleSkillSmallCell.OnAnimationEnd = function(self)
  -- function num : 0_12
  if not self._dusty and not self._tag then
    self._tag = true
  end
end

BattleSkillSmallCell.OnBattlerCanUseSkill = function(self, notification)
  -- function num : 0_13 , upvalues : _ENV
  local scanType = {canUse = 0, haveCanNotUseSkillBuff = 1, wrongPos = 2, roleIsInSkill = 3, canNotUseYingXiSkill = 4}
  if (notification.userInfo).entityid == ((self._delegate)._cellData):GetEntityId() then
    if (notification.userInfo).iscan == scanType.canUse then
      self._isCanUseSkill = true
    else
      if (notification.userInfo).iscan == scanType.roleIsInSkill then
        if (((BattleECS.Utility).Utility).IsSkillCanUseNotNeedRoleInSkill)(self._cellData) then
          self._isCanUseSkill = true
        else
          self._isCanUseSkill = false
        end
      else
        self._isCanUseSkill = false
      end
    end
    if (notification.userInfo).iscan == scanType.canNotUseYingXiSkill then
      if (((BattleECS.Utility).Utility).IsYingXiSkill)(self._cellData) then
        self._isCanUseSkill = false
      else
        self._isCanUseSkill = true
      end
    end
  end
end

BattleSkillSmallCell.OnCollaborativeSkillNumChange = function(self, notification)
  -- function num : 0_14 , upvalues : _ENV, CVarconfig
  local entityId = (notification.userInfo).entityid
  if self._isEnergySkill and ((self._delegate)._cellData):GetEntityId() == entityId then
    local num = (notification.userInfo).num
    if self:IsFullBean() and not self._lightEnergySkillTimeTask then
      self._lightEnergySkillTimeTask = (GameTimer.AddTask)(tonumber((CVarconfig:GetRecorder(89)).Value) / 1000, -1, function(num)
    -- function num : 0_14_0 , upvalues : self
    self._beanNum = self._collaborativeskillnum - num
    if self._collaborativeSkillFrame then
      (self._collaborativeSkillFrame):ReloadAllCell()
    end
    self._lightEnergySkillTimeTask = nil
  end
, num)
    else
      if self._lightEnergySkillTimeTask then
        (GameTimer.RemoveTask)(self._lightEnergySkillTimeTask)
        self._lightEnergySkillTimeTask = nil
      end
      self._beanNum = self._collaborativeskillnum - num
      if self._collaborativeSkillFrame then
        (self._collaborativeSkillFrame):ReloadAllCell()
      end
    end
  end
end

BattleSkillSmallCell.NumberOfCell = function(self, frame)
  -- function num : 0_15
  if frame == self._collaborativeSkillFrame then
    return #self._skillbeandata
  end
end

BattleSkillSmallCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_16
  if frame == self._collaborativeSkillFrame then
    return "newbattle.collaborativesskillbeancell"
  end
end

BattleSkillSmallCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_17
  if frame == self._collaborativeSkillFrame then
    return (self._skillbeandata)[index]
  end
end

BattleSkillSmallCell.IsFullBean = function(self)
  -- function num : 0_18
  do return self._collaborativeskillnum > 0 and self._beanNum == self._collaborativeskillnum end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BattleSkillSmallCell.IsFilledBean = function(self, id)
  -- function num : 0_19
  do return id <= self._beanNum and self._beanNum ~= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return BattleSkillSmallCell

