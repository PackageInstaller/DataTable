local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CBossHpLineCfg = BeanManager.GetTableByName("battle.cbosshplinecfg")
local CCbuffConfigTable = BeanManager.GetTableByName("buff.ccbuffconfig")
local CSkillShow_Common = BeanManager.GetTableByName("skill.cskillshow_common")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local ColumnsNum = 6
local SkillShowCountDownType = {
  NotLoad = 0,
  LoadInterrupt = 1,
  ContinualInterrupt = 2,
  InfiniteInterrupt = 3,
  LoadNotInterrupt = 4,
  ContinualNotInterrupt = 5,
  InfiniteNotInterrupt = 6
}
local SkillAttrType = {Magic = 1, Physics = 2}
local BossHPCell = class("BossHPCell", Dialog)
BossHPCell.AssetBundleName = "ui/layouts.battle"
BossHPCell.AssetName = "BossHP"

function BossHPCell:Ctor(...)
  BossHPCell.super.Ctor(self, ...)
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

function BossHPCell:OnCreate()
  self._progressBar = self:GetChild("HPBar/HPBarBoss")
  self._firstImage = self:GetChild("HPBar/HPBarBoss/_Green/Mask/Image")
  self._secondImage = self:GetChild("HPBar/HPBarBoss/_Red/Mask/Image")
  self._hpCurrent = self:GetChild("HPBar/HPNum/HPNum")
  self._hpMax = self:GetChild("HPBar/HPNum/MaxHP")
  self._line = self:GetChild("HPBar/HPNum/Line")
  self._num = self:GetChild("HPBar/HPNum/Num")
  self._hpMax:SetActive(false)
  self._line:SetActive(false)
  self._hpCurrent:SetActive(false)
  self._num:SetActive(true)
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
  self._normalShieldProgress:SetFillAmount(0)
  self._effectViolentAnimator = self:GetChild("HPBar/EffectViolent")
  self._frame = GridFrame.Create(self._buffPanel, self, true, ColumnsNum, false, false, true)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationEnd, self)
end

function BossHPCell:OnDestroy()
  self._frame:Destroy()
end

function BossHPCell:OnAnimationEnd()
  if self._needDelete then
    self:Destroy()
    self:RootWindowDestroy()
  end
end

function BossHPCell:SetData(battler, delegate)
  self._delegate = delegate
  self._battler = battler
  local nameTextId = self._battler:GetNameTextId()
  if 0 < nameTextId then
    self._name:SetText(TextManager.GetText(nameTextId))
  end
  self._level:SetText(self._battler:GetLevel())
  self._entityId = battler:GetEntityId()
  self._battler = battler
  if self._battler:GetViolentState() then
    self._effectViolentAnimator:SetAnimatorTrigger("Stay")
  end
end

function BossHPCell:OnUpdate(battler, deltaTime)
  if battler then
    local currentHp = battler:GetHp()
    if currentHp < 0 then
      currentHp = 0
    end
    local hpUp = {}
    local hpDown = {}
    local totalHp = 0
    local bossHpStage = battler:GetBossHpStage()
    for i, v in ipairs(bossHpStage) do
      if currentHp <= totalHp + v then
        hpUp.stage = i
        hpUp.maxHp = v
        hpUp.hp = currentHp - totalHp
        break
      end
      totalHp = totalHp + v
    end
    if not (hpUp.hp and hpUp.stage) or not hpUp.maxHp then
      return
    end
    if hpUp.hp + self._shieldValue > hpUp.maxHp then
      hpUp.maxHp = hpUp.hp + self._shieldValue
    end
    if hpUp.stage and hpUp.stage > 1 then
      hpDown.stage = hpUp.stage - 1
    elseif hpUp.stage == 1 then
      self._num:SetActive(false)
      self._hpCurrent:SetActive(true)
      self._hpCurrent:SetText(math.floor(currentHp))
    end
    local record
    if not hpUp.stage then
      self._progressBar:SetFirstValue(0)
      self._progressBar:SetSecondValue(0)
    else
      self._progressBar:SetFirstValue(hpUp.hp / hpUp.maxHp)
      if self._upStage ~= hpUp.stage then
        self._upStage = hpUp.stage
        record = CImagePathTable:GetRecorder(tonumber(CBossHpLineCfg:GetRecorder(self._upStage).string)) or DataCommon.DefaultImageAsset
        self._firstImage:SetSprite(record.assetBundle, record.assetName)
        self._normalHPBarAsset.assetBundle = record.assetBundle
        self._normalHPBarAsset.assetName = record.assetName
        if hpDown.stage then
          self._num:SetActive(true)
          self._hpCurrent:SetActive(false)
          self._num:SetText("X" .. hpUp.stage)
          record = CImagePathTable:GetRecorder(tonumber(CBossHpLineCfg:GetRecorder(hpDown.stage).string)) or DataCommon.DefaultImageAsset
          self._secondImage:SetSprite(record.assetBundle, record.assetName)
          self._progressBar:SetSecondValue(1)
        else
          self._progressBar:SetSecondValue(0)
        end
      end
    end
    self._entityId = battler:GetEntityId()
    if self._skillLoadingTask then
      if self._skillLoadingTask:update(deltaTime) then
        self._skillLoadingTask = nil
        self._spellProgressBar:SetFillAmount(self._skillLoadingDes)
        self._spellBack:SetActive(false)
        self._spellProgressBar:SetActive(false)
      else
        self._spellProgressBar:SetFillAmount(self._skillLoadingTask.subject.value)
      end
    end
    if 0 < self._shieldValue then
      self._normalShieldProgress:SetFillAmount((hpUp.hp + self._shieldValue) / hpUp.maxHp)
      self._normalShield:SetActive(true)
    else
      self._normalShield:SetActive(false)
    end
  end
end

function BossHPCell:Show(show, notDestroy)
  if not show then
    if not notDestroy then
      self._needDelete = true
      self:GetRootWindow():PlayAnimation("BossHP")
      if not self:GetRootWindow():IsActive() then
        self:Destroy()
        self:RootWindowDestroy()
      end
    else
      self:GetRootWindow():SetActive(false)
    end
  else
    self:GetRootWindow():SetActive(true)
  end
end

function BossHPCell:RefreshBuffs(info)
  local buff, index
  for i, v in ipairs(self._buffs) do
    if v.id == info.buffid then
      buff = v
      index = i
      break
    end
  end
  LogInfoFormat("BossHPCell", "------ buffid = %s, counttime = %s ----", info.buffid, info.counttime)
  if buff then
    local buffConfigRecord = CCbuffConfigTable:GetRecorder(info.buffid)
    if info.counttime == 0 then
      table.remove(self._buffs, index)
      self._frame:RemoveCellsAtIndex({index})
    else
      if 0 < buffConfigRecord.stacktimes then
        buff.counttime = info.counttime
        buff.num = buff.num + 1
        if buff.num > buffConfigRecord.stacktimes then
          buff.num = buffConfigRecord.stacktimes
        end
      else
        buff.counttime = info.counttime
      end
      self._frame:FireEvent("RefreshCell", buff)
    end
  else
    local buffConfigRecord = CCbuffConfigTable:GetRecorder(info.buffid)
    if buffConfigRecord then
      local imageRecord = CImagePathTable:GetRecorder(buffConfigRecord.iconId)
      if imageRecord then
        local buffInfo = {}
        buffInfo.id = info.buffid
        buffInfo.counttime = info.counttime
        buffInfo.num = 1
        table.insert(self._buffs, buffInfo)
        self._frame:InsertCellsAtIndex({
          #self._buffs
        })
      end
    end
  end
end

function BossHPCell:BeginShowSkillLoading(skillid, type, lasttime, skillattr)
  self._spellBack:SetActive(true)
  self._skillLoadingSkillId = skillid
  local record = CSkillShow_Common:GetRecorder(skillid)
  if record then
    local name = TextManager.GetText(record.nameTextID)
    self._spellSkillName:SetText(name)
  else
    self._spellSkillName:SetText("")
    LogWarningFormat("BossHPCell", "skillid %s dont have skill name in cskillshow_common", skillid)
  end
  if skillattr == SkillAttrType.Magic then
    self._spellProgressBar = self._spellMagicProgress
    self._spellMagicProgress:SetActive(true)
    self._spellPhyProgress:SetActive(false)
  else
    self._spellProgressBar = self._spellPhyProgress
    self._spellMagicProgress:SetActive(false)
    self._spellPhyProgress:SetActive(true)
  end
  if type == SkillShowCountDownType.LoadNotInterrupt or type == SkillShowCountDownType.ContinualNotInterrupt or type == SkillShowCountDownType.InfiniteNotInterrupt then
    self._spellUnBreak:SetActive(true)
    self._spellCanBreak:SetActive(false)
  else
    self._spellUnBreak:SetActive(false)
    self._spellCanBreak:SetActive(true)
  end
  if type == SkillShowCountDownType.InfiniteInterrupt or type == SkillShowCountDownType.InfiniteNotInterrupt then
    self._spellProgressBar:SetFillAmount(1)
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
    self._skillLoadingTask = Tween.new(lasttime / 30, first, last, "linear")
  end
end

function BossHPCell:ClearSkillLoading(skillid)
  if self._skillLoadingSkillId == skillid then
    self._skillLoadingTask = nil
    self._spellBack:SetActive(false)
  end
end

function BossHPCell:RefreshInvincibleState(state)
  local StateType = {Begin = 0, End = 1}
  if state == StateType.Begin then
    self._invincibleStateCount = self._invincibleStateCount + 1
  elseif state == StateType.End then
    self._invincibleStateCount = self._invincibleStateCount - 1
  end
  if 0 >= self._invincibleStateCount then
    self._invincibleStateCount = 0
    self._unBreakEffect:SetActive(false)
    self._firstImage:SetSprite(self._normalHPBarAsset.assetBundle, self._normalHPBarAsset.assetName)
  else
    self._unBreakEffect:SetActive(true)
    local record = CImagePathTable:GetRecorder(12121) or DataCommon.DefaultImageAsset
    self._firstImage:SetSprite(record.assetBundle, record.assetName)
  end
end

function BossHPCell:RefreshShield(protocol)
  local preShieldValue = self._shieldValue
  self._shieldValue = 0
  self._shieldList[protocol.buffid] = protocol.value
  for _, v in pairs(self._shieldList) do
    self._shieldValue = self._shieldValue + v
  end
end

function BossHPCell:RefreshName()
  local nameTextId = self._battler:GetNameTextId()
  if 0 < nameTextId then
    self._name:SetText(TextManager.GetText(nameTextId))
  end
end

function BossHPCell:StartViolent()
  self._effectViolentAnimator:SetAnimatorTrigger("Start")
end

function BossHPCell:NumberOfCell(frame)
  return #self._buffs
end

function BossHPCell:CellAtIndex(frame, index)
  return "newbattle.buffcell"
end

function BossHPCell:DataAtIndex(frame, index)
  return self._buffs[index]
end

return BossHPCell
