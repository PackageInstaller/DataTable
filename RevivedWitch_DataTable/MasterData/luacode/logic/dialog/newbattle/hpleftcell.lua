-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/hpleftcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local CanvasStaticFunctions = (((CS.PixelNeko).Lua).UI).CanvasStaticFunctions
local CCbuffConfigTable = (BeanManager.GetTableByName)("buff.ccbuffconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSkillShow_Common = (BeanManager.GetTableByName)("skill.cskillshow_common")
local CRoleBreakCfgTable = (BeanManager.GetTableByName)("role.crolebreakcfg")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local ColumnsNum = 4
local SkillShowCountDownType = {NotLoad = 0, LoadInterrupt = 1, ContinualInterrupt = 2, InfiniteInterrupt = 3, LoadNotInterrupt = 4, ContinualNotInterrupt = 5, InfiniteNotInterrupt = 6}
local SkillAttrType = {Magic = 1, Physics = 2}
local HPLeftCell = class("HPLeftCell", Dialog)
HPLeftCell.AssetBundleName = "ui/layouts.battle"
HPLeftCell.AssetName = "HPcell"
HPLeftCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HPLeftCell, _ENV
  ((HPLeftCell.super).Ctor)(self, ...)
  self._battler = nil
  self._needDelete = false
  self._showTag = false
  self._buffs = {}
  self._hpBarAnimationFraps = 0
  self._hpChangeTotalFrame = tonumber((((BeanManager.GetTableByName)("battle.cbattleconstcfg")):GetRecorder(7)).attr)
  self._invincibleStateCount = 0
  self._shieldList = {}
  self._shieldValue = 0
  self._hpCellShowState = false
  self._beanNum = 0
end

HPLeftCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : CanvasStaticFunctions
  self._lv = self:GetChild("Lv")
  self._level = self:GetChild("Level")
  self._name = self:GetChild("Name")
  self._greenProgressBar = self:GetChild("HPCell/_Background/Image")
  self._redProgressBar = self:GetChild("HPCell/_Red/Mask/Image")
  self._buffPanel = self:GetChild("BuffFrame")
  self._buffCharPanel = self:GetChild("BuffFrameChar")
  self._usingBuffPanel = self._buffPanel
  self._spellBack = self:GetChild("SpellProgress")
  self._spellCanBreak = self:GetChild("SpellProgress/Back")
  self._spellUnBreak = self:GetChild("SpellProgress/UnBreakBack")
  self._spellPhyProgress = self:GetChild("SpellProgress/ImagePhy")
  self._spellMagicProgress = self:GetChild("SpellProgress/ImageMag")
  self._spellSkillName = self:GetChild("SpellProgress/SkillName")
  self._unBreakEffect = self:GetChild("HPCell/EffectUnBreak")
  self._normalShield = self:GetChild("HPCell/_Background/Shield")
  self._normalShieldProgress = self:GetChild("HPCell/_Background/Shield/Image")
  self._secondHurtTxt = self:GetChild("TestTxt")
  self._secondHurtNum = self:GetChild("TestNum")
  self._secondAllHurtTxt = self:GetChild("TestTxtAll")
  self._secondAllHurtNum = self:GetChild("TestNumAll")
  self._breakLevel = self:GetChild("BreakLevel")
  ;
  (self._normalShieldProgress):SetFillAmount(0)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  ;
  (CanvasStaticFunctions.SetCanvasPixelPerfect)((self._rootWindow)._uiObject, false)
end

HPLeftCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._buffFrame):Destroy()
end

HPLeftCell.OnUpdate = function(self, battler, deltaTime)
  -- function num : 0_3 , upvalues : UIManager
  if battler then
    local hp = battler:GetHp()
    local hpMax = battler:GetHpMax()
    if hpMax < hp + self._shieldValue then
      hpMax = hp + self._shieldValue
    end
    if battler:GetHpBarAnimationState() then
      self._hpBarAnimationFraps = self._hpBarAnimationFraps + 1
      local value = hp * self._hpBarAnimationFraps / self._hpChangeTotalFrame / (hpMax)
      ;
      (self._greenProgressBar):SetFillAmount(value)
      if self._hpBarAnimationFraps == self._hpChangeTotalFrame then
        self._hpBarAnimationFraps = 0
        battler:SetHpBarAnimationState(false)
      end
    else
      do
        self._hpBarAnimationFraps = 0
        ;
        (self._greenProgressBar):SetFillAmount(hp / (hpMax))
        local ox, oy, oz = battler:GetSlotPosition("HitPoint_Head")
        local x, y = (UIManager.ScreenPointToLocalPointInRectangle)(nil, (UIManager.WorldToScreenPointInMargin)("BattleMain", ox, oy, oz))
        ;
        (self:GetRootWindow()):SetAnchoredPosition(x, y)
        if hp > 0 and not self._showTag then
          self:Show(true)
        end
        self._entityId = battler:GetEntityId()
        if self._skillLoadingTask then
          if (self._skillLoadingTask):update(deltaTime) then
            self._skillLoadingTask = nil
            ;
            (self._spellProgressBar):SetFillAmount(self._skillLoadingDes)
            ;
            (self._spellBack):SetActive(false)
            ;
            (self._name):SetActive(self._showName)
            ;
            (self._spellProgressBar):SetActive(false)
            ;
            (self._buffCharPanel):SetActive(true)
          else
            ;
            (self._spellProgressBar):SetFillAmount(((self._skillLoadingTask).subject).value)
          end
        end
        if self._shieldValue > 0 then
          (self._normalShieldProgress):SetFillAmount((hp + self._shieldValue) / (hpMax))
          ;
          (self._normalShield):SetActive(true)
        else
          ;
          (self._normalShield):SetActive(false)
        end
      end
    end
  end
end

HPLeftCell.SetShowTag = function(self, state)
  -- function num : 0_4
  self._showTag = state
end

HPLeftCell.SetData = function(self, battler, delegate)
  -- function num : 0_5 , upvalues : GridFrame, ColumnsNum, _ENV, CRoleBreakCfgTable, RoleConfigTable, Role, CStringRes, UIManager
  self._delegate = delegate
  self._battler = battler
  if not self._showTag then
    self:Show(true)
  end
  if self._buffFrame then
    (self._buffFrame):Destroy()
    self._buffFrame = nil
  end
  if battler:IsRightCamp() then
    self._buffFrame = (GridFrame.Create)(self._buffPanel, self, true, ColumnsNum, false, true)
    self._usingBuffPanel = self._buffPanel
    ;
    (self._buffCharPanel):SetHeight(0, 0)
    local totalLength = (self._buffFrame):GetTotalLength()
    ;
    (self._usingBuffPanel):SetHeight(0, totalLength)
    local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
    local r = CMonsterConfigTable:GetRecorder(battler:GetConfigId())
    local nameTextId = battler:GetNameTextId()
    if nameTextId > 0 then
      (self._name):SetActive(true)
      self._showName = true
      local name = (TextManager.GetText)(nameTextId)
      local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
      local userName = ((NekoData.BehaviorManager).BM_Battle):GetArenaEnemyNameByBattleID(protocol.battleid) or ""
      name = (string.gsub)(name, "%$heroine%$", userName)
      ;
      (self._name):SetText(name)
      self._logName = (TextManager.GetText)(nameTextId)
    else
      do
        ;
        (self._name):SetActive(false)
        self._showName = false
        local levelNum = battler:GetLevel()
        local isNeedShowBreakLv = false
        for _,v in ipairs(((BattleECS.Utility).DataUtility).cCellBattleInfoTable) do
          if ((self._delegate)._battleWorld)._battleID == tonumber(v.battleId) then
            isNeedShowBreakLv = true
          end
        end
        ;
        (self._breakLevel):SetActive(false)
        if isNeedShowBreakLv then
          local breakLv = 0
          local allIds = CRoleBreakCfgTable:GetAllIds()
          for i = 1, #allIds do
            local recorder = CRoleBreakCfgTable:GetRecorder(allIds[i])
            local roleRecord = RoleConfigTable:GetRecorder(battler:GetConfigId())
            if not roleRecord then
              local fatherEntityId = battler:GetFatherEntityId()
              local fatherBattler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(fatherEntityId)
              if not fatherBattler then
                fatherBattler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(fatherEntityId)
              end
              if fatherBattler then
                roleRecord = RoleConfigTable:GetRecorder(fatherBattler:GetConfigId())
                levelNum = fatherBattler:GetLevel()
              end
            end
            do
              if roleRecord and recorder.breakType == roleRecord.breakType then
                local levelmax = -1
                local role = (Role.Create)(battler:GetConfigId())
                role:SetUniqueEquipAttrs({specialWeaponLevel = battler:GetExclusiveLevel(), 
specialWeaponProperties = {}
, 
specialWeaponPropertiesForNextLevel = {}
})
                if role then
                  levelmax = role:GetLevelMaxByBreakRecord(recorder)
                end
                if recorder.levelmin < levelNum and levelNum <= levelmax then
                  breakLv = recorder.breaklv
                  levelNum = levelNum - recorder.levelmin
                  local str = (TextManager.GetText)((CStringRes:GetRecorder(1542)).msgTextID)
                  ;
                  (self._breakLevel):SetActive(true)
                  ;
                  (self._breakLevel):SetText(str:gsub("%$parameter1%$", recorder.breaklv))
                  LogInfoFormat("HPLeftCell", "role id %s breakType %s inbattle current level %s breakLv %s show level %s levelmin %s levelmax %s", battler:GetConfigId(), roleRecord.breakType, battler:GetLevel(), breakLv, levelNum, recorder.levelmin, levelmax)
                  break
                end
              end
              do
                -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out DO_STMT

              end
            end
          end
        end
        do
          do
            if levelNum > 0 then
              (self._lv):SetActive(true)
              ;
              (self._level):SetActive(true)
              ;
              (self._level):SetText(levelNum)
            else
              if r then
                (self._lv):SetActive(true)
                ;
                (self._level):SetActive(true)
                ;
                (self._level):SetText(r.npcLevel)
              else
                ;
                (self._lv):SetActive(false)
                ;
                (self._level):SetActive(false)
              end
            end
            self._showName = false
            ;
            (self._lv):SetActive(false)
            ;
            (self._level):SetActive(false)
            ;
            (self._name):SetActive(false)
            ;
            (self._breakLevel):SetActive(false)
            self._buffFrame = (GridFrame.Create)(self._buffCharPanel, self, true, ColumnsNum, false, true)
            self._usingBuffPanel = self._buffCharPanel
            ;
            (self._buffPanel):SetHeight(0, 0)
            local totalLength = (self._buffFrame):GetTotalLength()
            ;
            (self._usingBuffPanel):SetHeight(0, totalLength)
            do
              local nameTextId = battler:GetNameTextId()
              if nameTextId > 0 then
                self._logName = (TextManager.GetText)(nameTextId)
              end
              self._entityId = battler:GetEntityId()
              local ox, oy, oz = battler:GetSlotPosition("HitPoint_Head")
              local x, y = (UIManager.ScreenPointToLocalPointInRectangle)(nil, (UIManager.WorldToScreenPointInMargin)("BattleMain", ox, oy, oz))
              ;
              (self:GetRootWindow()):SetAnchoredPosition(x, y)
            end
          end
        end
      end
    end
  end
end

HPLeftCell.SetPosition = function(self, x, xoffect, y, yoffect)
  -- function num : 0_6
  (self:GetRootWindow()):SetPosition(x, xoffect, y, yoffect)
end

HPLeftCell.Show = function(self, show, notDestroy)
  -- function num : 0_7
  if show then
    self._showTag = true
    self._needDelete = false
    ;
    (self:GetRootWindow()):PlayAnimation("HPCellShow")
    self._hpCellShowState = true
  else
    if not notDestroy then
      self._needDelete = true
    end
    ;
    (self:GetRootWindow()):PlayAnimation("HPCellHide")
    self._hpCellShowState = false
  end
end

HPLeftCell.OnAnimationEnd = function(self)
  -- function num : 0_8
  if self._needDelete then
    self:Destroy()
    self:RootWindowDestroy()
  end
end

HPLeftCell.RefreshBuffs = function(self, info)
  -- function num : 0_9 , upvalues : _ENV, CCbuffConfigTable, CImagePathTable
  local buff, index = nil, nil
  for i,v in ipairs(self._buffs) do
    if v.id == info.buffid and (info.stacklayer == -1 or info.stacklayer == v.stacklayer) then
      buff = v
      index = i
      break
    end
  end
  do
    LogInfoFormat("HPLeftCell", "------ buffid = %s, counttime = %s, name = %s, layer = %s ----", info.buffid, info.counttime, self._logName, info.stacklayer)
    if buff then
      local buffConfigRecord = CCbuffConfigTable:GetRecorder(info.buffid)
      if info.counttime == 0 then
        (table.remove)(self._buffs, index)
        ;
        (self._buffFrame):RemoveCellsAtIndex({index})
        local totalLength = (self._buffFrame):GetTotalLength()
        ;
        (self._usingBuffPanel):SetHeight(0, totalLength)
      else
        do
          buff.counttime = info.counttime
          if buffConfigRecord.stacktimes > 0 then
            buff.num = buff.num + 1
            if buffConfigRecord.stacktimes < buff.num then
              buff.num = buffConfigRecord.stacktimes
            end
          else
            if buffConfigRecord.stacktimes == 0 then
              local OverRideType = {Cover = 0, RespectivelyShow = 1, Overlay = 2, OverlayWithoutRefreshTime = 3}
              if buffConfigRecord.overrideSelfType == OverRideType.RespectivelyShow or buffConfigRecord.overrideSelfType == OverRideType.Overlay or buffConfigRecord.overrideSelfType == OverRideType.OverlayWithoutRefreshTime then
                buff.num = buff.num + 1
              end
            end
          end
          do
            do
              ;
              (self._buffFrame):FireEvent("RefreshCell", buff)
              if info.counttime ~= 0 then
                local buffConfigRecord = CCbuffConfigTable:GetRecorder(info.buffid)
                if buffConfigRecord then
                  local imageRecord = CImagePathTable:GetRecorder(buffConfigRecord.iconId)
                  if imageRecord then
                    local buffInfo = {}
                    buffInfo.id = info.buffid
                    buffInfo.counttime = info.counttime
                    buffInfo.num = 1
                    buffInfo.stacklayer = info.stacklayer
                    ;
                    (table.insert)(self._buffs, buffInfo)
                    ;
                    (self._buffFrame):InsertCellsAtIndex({#self._buffs})
                    local totalLength = (self._buffFrame):GetTotalLength()
                    ;
                    (self._usingBuffPanel):SetHeight(0, totalLength)
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

HPLeftCell.BeginShowSkillLoading = function(self, skillid, type, lasttime, skillattr)
  -- function num : 0_10 , upvalues : CSkillShow_Common, _ENV, SkillAttrType, SkillShowCountDownType
  (self._buffCharPanel):SetActive(false)
  ;
  (self._spellBack):SetActive(true)
  ;
  (self._name):SetActive(false)
  self._skillLoadingSkillId = skillid
  local record = CSkillShow_Common:GetRecorder(skillid)
  if record then
    local name = (TextManager.GetText)(record.nameTextID)
    ;
    (self._spellSkillName):SetText(name)
  else
    do
      ;
      (self._spellSkillName):SetText("")
      LogWarningFormat("HPLeftCell", "skillid %s dont have skill name in cskillshow_common", skillid)
      if skillattr == SkillAttrType.Magic then
        self._spellProgressBar = self._spellMagicProgress
        ;
        (self._spellMagicProgress):SetActive(true)
        ;
        (self._spellPhyProgress):SetActive(false)
      else
        self._spellProgressBar = self._spellPhyProgress
        ;
        (self._spellMagicProgress):SetActive(false)
        ;
        (self._spellPhyProgress):SetActive(true)
      end
      if type == SkillShowCountDownType.LoadNotInterrupt or type == SkillShowCountDownType.ContinualNotInterrupt or type == SkillShowCountDownType.InfiniteNotInterrupt then
        (self._spellUnBreak):SetActive(true)
        ;
        (self._spellCanBreak):SetActive(false)
      else
        ;
        (self._spellUnBreak):SetActive(false)
        ;
        (self._spellCanBreak):SetActive(true)
      end
      if type == SkillShowCountDownType.InfiniteInterrupt or type == SkillShowCountDownType.InfiniteNotInterrupt then
        (self._spellProgressBar):SetFillAmount(1)
        self._skillLoadingTask = nil
      else
        local beginValue = 0
        local endValue = 1
        if type == SkillShowCountDownType.ContinualInterrupt or type == SkillShowCountDownType.ContinualNotInterrupt then
          beginValue = 1
          endValue = 0
        end
        local first = {value = beginValue}
        local last = {value = endValue}
        self._skillLoadingDes = endValue
        self._skillLoadingTask = (Tween.new)(lasttime / 30, first, last, "linear")
      end
    end
  end
end

HPLeftCell.ClearSkillLoading = function(self, skillid)
  -- function num : 0_11
  if self._skillLoadingSkillId == skillid then
    self._skillLoadingTask = nil
    ;
    (self._spellBack):SetActive(false)
    ;
    (self._name):SetActive(self._showName)
  end
end

HPLeftCell.RefreshInvincibleState = function(self, state)
  -- function num : 0_12 , upvalues : CImagePathTable, _ENV
  local StateType = {Begin = 0, End = 1}
  if state == StateType.Begin then
    self._invincibleStateCount = self._invincibleStateCount + 1
  else
    if state == StateType.End then
      self._invincibleStateCount = self._invincibleStateCount - 1
    end
  end
  if self._invincibleStateCount <= 0 then
    self._invincibleStateCount = 0
    ;
    (self._unBreakEffect):SetActive(false)
    if not CImagePathTable:GetRecorder(12123) then
      local record = DataCommon.DefaultImageAsset
    end
    ;
    (self._greenProgressBar):SetSprite(record.assetBundle, record.assetName)
  else
    do
      ;
      (self._unBreakEffect):SetActive(self._hpCellShowState)
      if not CImagePathTable:GetRecorder(12122) then
        local record = DataCommon.DefaultImageAsset
      end
      ;
      (self._greenProgressBar):SetSprite(record.assetBundle, record.assetName)
    end
  end
end

HPLeftCell.RefreshShield = function(self, protocol)
  -- function num : 0_13 , upvalues : _ENV
  local preShieldValue = self._shieldValue
  self._shieldValue = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._shieldList)[protocol.buffid] = protocol.value
  for _,v in pairs(self._shieldList) do
    self._shieldValue = self._shieldValue + v
  end
end

HPLeftCell.RefreshSecondHurtNumShowState = function(self, state)
  -- function num : 0_14
  (self._secondHurtNum):SetText(0)
  ;
  (self._secondAllHurtNum):SetText(0)
  ;
  (self._secondHurtNum):SetActive(state)
  ;
  (self._secondHurtTxt):SetActive(state)
  ;
  (self._secondAllHurtNum):SetActive(state)
  ;
  (self._secondAllHurtTxt):SetActive(state)
end

HPLeftCell.RefreshSecondHurtNum = function(self, num, totalNum)
  -- function num : 0_15
  (self._secondHurtNum):SetText(num)
  ;
  (self._secondAllHurtNum):SetText(totalNum)
end

HPLeftCell.RefreshName = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local nameTextId = (self._battler):GetNameTextId()
  if nameTextId > 0 then
    (self._name):SetText((TextManager.GetText)(nameTextId))
    self._logName = (TextManager.GetText)(nameTextId)
  end
end

HPLeftCell.GetCellIndex = function(self, buffId)
  -- function num : 0_17 , upvalues : _ENV
  for i,v in ipairs(self._buffs) do
    if v.id == buffId then
      return i
    end
  end
end

HPLeftCell.NumberOfCell = function(self, frame)
  -- function num : 0_18
  if frame == self._buffFrame then
    return #self._buffs
  end
end

HPLeftCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_19
  if frame == self._buffFrame then
    return "newbattle.buffcell"
  end
end

HPLeftCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_20
  if frame == self._buffFrame then
    return (self._buffs)[index]
  end
end

return HPLeftCell

