-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/bosshpcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CBossHpLineCfg = (BeanManager.GetTableByName)("battle.cbosshplinecfg")
local CCbuffConfigTable = (BeanManager.GetTableByName)("buff.ccbuffconfig")
local CSkillShow_Common = (BeanManager.GetTableByName)("skill.cskillshow_common")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local ColumnsNum = 6
local SkillShowCountDownType = {NotLoad = 0, LoadInterrupt = 1, ContinualInterrupt = 2, InfiniteInterrupt = 3, LoadNotInterrupt = 4, ContinualNotInterrupt = 5, InfiniteNotInterrupt = 6}
local SkillAttrType = {Magic = 1, Physics = 2}
local BossHPCell = class("BossHPCell", Dialog)
BossHPCell.AssetBundleName = "ui/layouts.battle"
BossHPCell.AssetName = "BossHP"
BossHPCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossHPCell
  ((BossHPCell.super).Ctor)(self, ...)
  self._redMove = false
  self._greenMove = false
  self._redDelta = 0.01
  self._greenDelta = 0.08
  self._delayTime = 0.3
  self._greenTotalTime = 0.01
  self._readTotalTime = 0.5
  self._greenTask = nil
  self._redTask = nil
  self._redTaskNew = nil
  self._time = 0
  self._delay = false
  self._continualBuffs = {}
  self._needDelete = false
  self._upStage = nil
  self._buffs = {}
  self._invincibleStateCount = 0
  self._shieldList = {}
  self._shieldValue = 0
  self._normalHPBarAsset = {assetBundle = "", assetName = ""}
end

BossHPCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, ColumnsNum
  self._progressBar = self:GetChild("HPBar/HPBarBoss")
  self._firstImage = self:GetChild("HPBar/HPBarBoss/_Green/Mask/Image")
  self._secondImage = self:GetChild("HPBar/HPBarBoss/_Red/Mask/Image")
  self._hpCurrent = self:GetChild("HPBar/HPNum/HPNum")
  self._hpMax = self:GetChild("HPBar/HPNum/MaxHP")
  self._line = self:GetChild("HPBar/HPNum/Line")
  self._num = self:GetChild("HPBar/HPNum/Num")
  ;
  (self._hpMax):SetActive(false)
  ;
  (self._line):SetActive(false)
  ;
  (self._hpCurrent):SetActive(false)
  ;
  (self._num):SetActive(true)
  self._level = self:GetChild("BossDetail/Level")
  self._name = self:GetChild("BossDetail/Name")
  self._buffPanel = self:GetChild("BuffFrame")
  self._spellBack = self:GetChild("SpellProgress")
  self._spellCanBreak = self:GetChild("SpellProgress/Back")
  self._spellUnBreak = self:GetChild("SpellProgress/UnBreakBack")
  self._spellPhyProgress = self:GetChild("SpellProgress/ImagePhy")
  self._spellMagicProgress = self:GetChild("SpellProgress/ImageMag")
  self._spellSkillName = self:GetChild("SpellProgress/SkillName")
  self._unBreakEffect = self:GetChild("HPBar/EffectUnBreak")
  self._normalShield = self:GetChild("HPBar/HPBarBoss/Shield")
  self._normalShieldProgress = self:GetChild("HPBar/HPBarBoss/Shield/Image")
  ;
  (self._normalShieldProgress):SetFillAmount(0)
  self._effectViolentAnimator = self:GetChild("HPBar/EffectViolent")
  self._frame = (GridFrame.Create)(self._buffPanel, self, true, ColumnsNum, false, false, true)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
end

BossHPCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

BossHPCell.OnAnimationEnd = function(self)
  -- function num : 0_3
  if self._needDelete then
    self:Destroy()
    self:RootWindowDestroy()
  end
end

BossHPCell.SetData = function(self, battler, delegate)
  -- function num : 0_4 , upvalues : _ENV
  self._delegate = delegate
  self._battler = battler
  local nameTextId = (self._battler):GetNameTextId()
  if nameTextId > 0 then
    (self._name):SetText((TextManager.GetText)(nameTextId))
  end
  ;
  (self._level):SetText((self._battler):GetLevel())
  self._entityId = battler:GetEntityId()
  self._battler = battler
  if (self._battler):GetViolentState() then
    (self._effectViolentAnimator):SetAnimatorTrigger("Stay")
  end
end

BossHPCell.OnUpdate = function(self, battler, deltaTime)
  -- function num : 0_5 , upvalues : _ENV, CImagePathTable, CBossHpLineCfg
  if battler then
    local currentHp = battler:GetHp()
    if currentHp < 0 then
      currentHp = 0
    end
    local hpUp = {}
    local hpDown = {}
    local totalHp = 0
    local bossHpStage = battler:GetBossHpStage()
    for i,v in ipairs(bossHpStage) do
      if currentHp <= totalHp + v then
        hpUp.stage = i
        hpUp.maxHp = v
        hpUp.hp = currentHp - totalHp
        break
      end
      totalHp = totalHp + v
    end
    do
      if not hpUp.hp or not hpUp.stage or not hpUp.maxHp then
        return 
      end
      if hpUp.maxHp < hpUp.hp + self._shieldValue then
        hpUp.maxHp = hpUp.hp + self._shieldValue
      end
      if hpUp.stage and hpUp.stage > 1 then
        hpDown.stage = hpUp.stage - 1
      else
        if hpUp.stage == 1 then
          (self._num):SetActive(false)
          ;
          (self._hpCurrent):SetActive(true)
          ;
          (self._hpCurrent):SetText((math.floor)(currentHp))
        end
      end
      local record = nil
      if not hpUp.stage then
        (self._progressBar):SetFirstValue(0)
        ;
        (self._progressBar):SetSecondValue(0)
      else
        ;
        (self._progressBar):SetFirstValue(hpUp.hp / hpUp.maxHp)
        if self._upStage ~= hpUp.stage then
          self._upStage = hpUp.stage
          if not CImagePathTable:GetRecorder(tonumber((CBossHpLineCfg:GetRecorder(self._upStage)).string)) then
            record = DataCommon.DefaultImageAsset
          end
          ;
          (self._firstImage):SetSprite(record.assetBundle, record.assetName)
          -- DECOMPILER ERROR at PC121: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (self._normalHPBarAsset).assetBundle = record.assetBundle
          -- DECOMPILER ERROR at PC124: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (self._normalHPBarAsset).assetName = record.assetName
          if hpDown.stage then
            (self._num):SetActive(true)
            ;
            (self._hpCurrent):SetActive(false)
            ;
            (self._num):SetText("X" .. hpUp.stage)
            if not CImagePathTable:GetRecorder(tonumber((CBossHpLineCfg:GetRecorder(hpDown.stage)).string)) then
              record = DataCommon.DefaultImageAsset
            end
            ;
            (self._secondImage):SetSprite(record.assetBundle, record.assetName)
            ;
            (self._progressBar):SetSecondValue(1)
          else
            ;
            (self._progressBar):SetSecondValue(0)
          end
        end
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
          (self._spellProgressBar):SetActive(false)
        else
          ;
          (self._spellProgressBar):SetFillAmount(((self._skillLoadingTask).subject).value)
        end
      end
      if self._shieldValue > 0 then
        (self._normalShieldProgress):SetFillAmount((hpUp.hp + self._shieldValue) / hpUp.maxHp)
        ;
        (self._normalShield):SetActive(true)
      else
        ;
        (self._normalShield):SetActive(false)
      end
    end
  end
end

BossHPCell.Show = function(self, show, notDestroy)
  -- function num : 0_6
  if not show then
    if not notDestroy then
      self._needDelete = true
      ;
      (self:GetRootWindow()):PlayAnimation("BossHP")
      if not (self:GetRootWindow()):IsActive() then
        self:Destroy()
        self:RootWindowDestroy()
      end
    else
      ;
      (self:GetRootWindow()):SetActive(false)
    end
  else
    ;
    (self:GetRootWindow()):SetActive(true)
  end
end

BossHPCell.RefreshBuffs = function(self, info)
  -- function num : 0_7 , upvalues : _ENV, CCbuffConfigTable, CImagePathTable
  local buff, index = nil, nil
  for i,v in ipairs(self._buffs) do
    if v.id == info.buffid then
      buff = v
      index = i
      break
    end
  end
  do
    LogInfoFormat("BossHPCell", "------ buffid = %s, counttime = %s ----", info.buffid, info.counttime)
    if buff then
      local buffConfigRecord = CCbuffConfigTable:GetRecorder(info.buffid)
      if info.counttime == 0 then
        (table.remove)(self._buffs, index)
        ;
        (self._frame):RemoveCellsAtIndex({index})
      else
        if buffConfigRecord.stacktimes > 0 then
          buff.counttime = info.counttime
          buff.num = buff.num + 1
          if buffConfigRecord.stacktimes < buff.num then
            buff.num = buffConfigRecord.stacktimes
          end
        else
          buff.counttime = info.counttime
        end
        ;
        (self._frame):FireEvent("RefreshCell", buff)
      end
    else
      do
        local buffConfigRecord = CCbuffConfigTable:GetRecorder(info.buffid)
        if buffConfigRecord then
          local imageRecord = CImagePathTable:GetRecorder(buffConfigRecord.iconId)
          if imageRecord then
            local buffInfo = {}
            buffInfo.id = info.buffid
            buffInfo.counttime = info.counttime
            buffInfo.num = 1
            ;
            (table.insert)(self._buffs, buffInfo)
            ;
            (self._frame):InsertCellsAtIndex({#self._buffs})
          end
        end
      end
    end
  end
end

BossHPCell.BeginShowSkillLoading = function(self, skillid, type, lasttime, skillattr)
  -- function num : 0_8 , upvalues : CSkillShow_Common, _ENV, SkillAttrType, SkillShowCountDownType
  (self._spellBack):SetActive(true)
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
      LogWarningFormat("BossHPCell", "skillid %s dont have skill name in cskillshow_common", skillid)
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

BossHPCell.ClearSkillLoading = function(self, skillid)
  -- function num : 0_9
  if self._skillLoadingSkillId == skillid then
    self._skillLoadingTask = nil
    ;
    (self._spellBack):SetActive(false)
  end
end

BossHPCell.RefreshInvincibleState = function(self, state)
  -- function num : 0_10 , upvalues : CImagePathTable, _ENV
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
    ;
    (self._firstImage):SetSprite((self._normalHPBarAsset).assetBundle, (self._normalHPBarAsset).assetName)
  else
    ;
    (self._unBreakEffect):SetActive(true)
    if not CImagePathTable:GetRecorder(12121) then
      local record = DataCommon.DefaultImageAsset
    end
    ;
    (self._firstImage):SetSprite(record.assetBundle, record.assetName)
  end
end

BossHPCell.RefreshShield = function(self, protocol)
  -- function num : 0_11 , upvalues : _ENV
  local preShieldValue = self._shieldValue
  self._shieldValue = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._shieldList)[protocol.buffid] = protocol.value
  for _,v in pairs(self._shieldList) do
    self._shieldValue = self._shieldValue + v
  end
end

BossHPCell.RefreshName = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local nameTextId = (self._battler):GetNameTextId()
  if nameTextId > 0 then
    (self._name):SetText((TextManager.GetText)(nameTextId))
  end
end

BossHPCell.StartViolent = function(self)
  -- function num : 0_13
  (self._effectViolentAnimator):SetAnimatorTrigger("Start")
end

BossHPCell.NumberOfCell = function(self, frame)
  -- function num : 0_14
  return #self._buffs
end

BossHPCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_15
  return "newbattle.buffcell"
end

BossHPCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_16
  return (self._buffs)[index]
end

return BossHPCell

