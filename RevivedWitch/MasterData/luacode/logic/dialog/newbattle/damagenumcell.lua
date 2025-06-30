-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/damagenumcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local CBattleConfig = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
local PositionRange = {}
for i,v in ipairs((string.split)((CBattleConfig:GetRecorder(83)).attr, ";")) do
  PositionRange[i] = tonumber(v)
end
local DamageNumCell = class("DamageNumCell", Dialog)
DamageNumCell.AssetBundleName = "ui/layouts.battle"
DamageNumCell.AssetName = "DamageNum"
local DamageTypeEnum = {None = 0, Damage = 1, BreakBuff = 2, DamageCrit = 3, Heal = 4, HealCrit = 5, BreakBuffCrit = 6, Resist = 7}
DamageNumCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DamageNumCell
  ((DamageNumCell.super).Ctor)(self, ...)
end

DamageNumCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : DamageTypeEnum
  self._childWind = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._childWind).attack = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).attack)[DamageTypeEnum.Damage] = self:GetChild("Damage")
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).attack)[DamageTypeEnum.BreakBuff] = self:GetChild("Critic/Weakness")
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).attack)[DamageTypeEnum.DamageCrit] = self:GetChild("Critic/Critic")
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).attack)[DamageTypeEnum.Heal] = self:GetChild("Heal")
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).attack)[DamageTypeEnum.HealCrit] = self:GetChild("CriticHeal")
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).attack)[DamageTypeEnum.BreakBuffCrit] = self:GetChild("Critic/CriticWeak")
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).attack)[DamageTypeEnum.Resist] = self:GetChild("Resist")
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._childWind).skill = {}
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).skill)[DamageTypeEnum.Damage] = self:GetChild("DamageSkill")
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).skill)[DamageTypeEnum.BreakBuff] = self:GetChild("Critic/Weakness")
  -- DECOMPILER ERROR at PC77: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).skill)[DamageTypeEnum.DamageCrit] = self:GetChild("Critic/Critic")
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).skill)[DamageTypeEnum.Heal] = self:GetChild("HealSkill")
  -- DECOMPILER ERROR at PC91: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).skill)[DamageTypeEnum.HealCrit] = self:GetChild("CriticHeal")
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).skill)[DamageTypeEnum.BreakBuffCrit] = self:GetChild("Critic/CriticWeak")
  -- DECOMPILER ERROR at PC105: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._childWind).skill)[DamageTypeEnum.Resist] = self:GetChild("Resist")
  self._critic = self:GetChild("Critic")
  self._miss = self:GetChild("Miss")
  self._invincible = self:GetChild("Invincible")
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
end

DamageNumCell.OnDestroy = function(self)
  -- function num : 0_2
end

DamageNumCell.SetDelegate = function(self, delegate)
  -- function num : 0_3
  self._delegate = delegate
end

DamageNumCell.Refresh = function(self, battler, damageType, num, skillid)
  -- function num : 0_4 , upvalues : CSkillTable, DamageTypeEnum, _ENV, UIManager, PositionRange
  (self:GetRootWindow()):SetActive(true)
  ;
  (self:GetRootWindow()):PlayAnimation("DamageNumShow")
  local skillType = nil
  do
    if skillid then
      local cskillRecord = CSkillTable:GetRecorder(skillid)
      if cskillRecord and cskillRecord.type == 5 then
        skillType = "attack"
      else
        skillType = "skill"
      end
    end
    local stringText = num
    if (damageType == DamageTypeEnum.Damage or damageType == DamageTypeEnum.BreakBuff or damageType == DamageTypeEnum.DamageCrit or damageType == DamageTypeEnum.BreakBuffCrit or damageType == DamageTypeEnum.Resist) and num and num == 0 then
      stringText = "-" .. tostring(num)
    end
    if (damageType == DamageTypeEnum.Heal or damageType == DamageTypeEnum.HealCrit) and num and num == 0 then
      stringText = "+" .. tostring(num)
    end
    ;
    (self._miss):SetActive(not skillType and damageType == DamageTypeEnum.Heal)
    ;
    (self._invincible):SetActive(not skillType and damageType == DamageTypeEnum.HealCrit)
    if skillType then
      if skillType == "attack" then
        for _,v in ipairs((self._childWind).skill) do
          v:SetActive(false)
        end
        ;
        (self._critic):SetActive(damageType == DamageTypeEnum.BreakBuff or damageType == DamageTypeEnum.DamageCrit or damageType == DamageTypeEnum.BreakBuffCrit)
        for k,v in ipairs((self._childWind).attack) do
          v:SetActive(damageType == k)
          if damageType == k then
            if damageType == DamageTypeEnum.BreakBuff or damageType == DamageTypeEnum.DamageCrit or damageType == DamageTypeEnum.BreakBuffCrit then
              (self._critic):SetText(stringText)
            else
              v:SetText(stringText)
            end
          end
        end
      elseif skillType == "skill" then
        for _,v in ipairs((self._childWind).attack) do
          v:SetActive(false)
        end
        ;
        (self._critic):SetActive(damageType == DamageTypeEnum.BreakBuff or damageType == DamageTypeEnum.DamageCrit or damageType == DamageTypeEnum.BreakBuffCrit)
        for k,v in ipairs((self._childWind).skill) do
          v:SetActive(damageType == k)
          if damageType == k then
            if damageType == DamageTypeEnum.BreakBuff or damageType == DamageTypeEnum.DamageCrit or damageType == DamageTypeEnum.BreakBuffCrit then
              (self._critic):SetText(stringText)
            else
              v:SetText(stringText)
            end
          end
        end
      end
    else
      for _,v in ipairs((self._childWind).skill) do
        v:SetActive(false)
      end
      for _,v in ipairs((self._childWind).attack) do
        v:SetActive(false)
      end
      ;
      (self._critic):SetActive(false)
    end
    local ox, oy, oz = battler:GetSlotPosition("HitPoint")
    local x, y = (UIManager.ScreenPointToLocalPointInRectangle)(nil, (UIManager.WorldToScreenPointInMargin)("BattleMain", ox, oy, oz))
    local range = nil
    if battler:IsLeftCamp() then
      range = {deltaLX = -PositionRange[1], deltaRX = -PositionRange[2], deltaDY = PositionRange[4], deltaUY = PositionRange[3]}
    else
      range = {deltaLX = PositionRange[1], deltaRX = PositionRange[2], deltaDY = PositionRange[4], deltaUY = PositionRange[3]}
    end
    local randomX = (math.random)() * (range.deltaRX - range.deltaLX) + range.deltaLX
    local randomY = (math.random)() * (range.deltaUY - range.deltaDY) + range.deltaDY
    ;
    (self:GetRootWindow()):SetAnchoredPosition(x + randomX, y + randomY)
    -- DECOMPILER ERROR: 22 unprocessed JMP targets
  end
end

DamageNumCell.SetPosition = function(self, x, y)
  -- function num : 0_5
  (self:GetRootWindow()):SetPosition(0.5, x, 0.5, y)
end

DamageNumCell.OnAnimationEnd = function(self)
  -- function num : 0_6
  if self._delegate then
    (self:GetRootWindow()):SetActive(false)
    ;
    (self._delegate):RecycleDamageNumCell(self)
  end
end

return DamageNumCell

