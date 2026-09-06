local UIManager = CS.PixelNeko.UI.UIManager
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local CBattleConfig = BeanManager.GetTableByName("battle.cbattleconstcfg")
local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local PositionRange = {}
for i, v in ipairs(string.split(CBattleConfig:GetRecorder(83).attr, ";")) do
  PositionRange[i] = tonumber(v)
end
local DamageNumCell = class("DamageNumCell", Dialog)
DamageNumCell.AssetBundleName = "ui/layouts.battle"
DamageNumCell.AssetName = "DamageNum"
local DamageTypeEnum = {
  None = 0,
  Damage = 1,
  BreakBuff = 2,
  DamageCrit = 3,
  Heal = 4,
  HealCrit = 5,
  BreakBuffCrit = 6,
  Resist = 7
}

function DamageNumCell:Ctor(...)
  DamageNumCell.super.Ctor(self, ...)
end

function DamageNumCell:OnCreate()
  self._childWind = {}
  self._childWind.attack = {}
  self._childWind.attack[DamageTypeEnum.Damage] = self:GetChild("Damage")
  self._childWind.attack[DamageTypeEnum.BreakBuff] = self:GetChild("Critic/Weakness")
  self._childWind.attack[DamageTypeEnum.DamageCrit] = self:GetChild("Critic/Critic")
  self._childWind.attack[DamageTypeEnum.Heal] = self:GetChild("Heal")
  self._childWind.attack[DamageTypeEnum.HealCrit] = self:GetChild("CriticHeal")
  self._childWind.attack[DamageTypeEnum.BreakBuffCrit] = self:GetChild("Critic/CriticWeak")
  self._childWind.attack[DamageTypeEnum.Resist] = self:GetChild("Resist")
  self._childWind.skill = {}
  self._childWind.skill[DamageTypeEnum.Damage] = self:GetChild("DamageSkill")
  self._childWind.skill[DamageTypeEnum.BreakBuff] = self:GetChild("Critic/Weakness")
  self._childWind.skill[DamageTypeEnum.DamageCrit] = self:GetChild("Critic/Critic")
  self._childWind.skill[DamageTypeEnum.Heal] = self:GetChild("HealSkill")
  self._childWind.skill[DamageTypeEnum.HealCrit] = self:GetChild("CriticHeal")
  self._childWind.skill[DamageTypeEnum.BreakBuffCrit] = self:GetChild("Critic/CriticWeak")
  self._childWind.skill[DamageTypeEnum.Resist] = self:GetChild("Resist")
  self._critic = self:GetChild("Critic")
  self._miss = self:GetChild("Miss")
  self._invincible = self:GetChild("Invincible")
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationEnd, self)
end

function DamageNumCell:OnDestroy()
end

function DamageNumCell:SetDelegate(delegate)
  self._delegate = delegate
end

function DamageNumCell:Refresh(battler, damageType, num, skillid)
  self:GetRootWindow():SetActive(true)
  self:GetRootWindow():PlayAnimation("DamageNumShow")
  local skillType
  if skillid then
    local cskillRecord = CSkillTable:GetRecorder(skillid)
    if cskillRecord and cskillRecord.type == 5 then
      skillType = "attack"
    else
      skillType = "skill"
    end
  end
  local stringText = num
  if damageType == DamageTypeEnum.Damage or damageType == DamageTypeEnum.BreakBuff or damageType == DamageTypeEnum.DamageCrit or damageType == DamageTypeEnum.BreakBuffCrit or damageType == DamageTypeEnum.Resist then
    if num and num == 0 then
      stringText = "-" .. tostring(num)
    end
  elseif (damageType == DamageTypeEnum.Heal or damageType == DamageTypeEnum.HealCrit) and num and num == 0 then
    stringText = "+" .. tostring(num)
  end
  self._miss:SetActive(not skillType and damageType == DamageTypeEnum.Heal)
  self._invincible:SetActive(not skillType and damageType == DamageTypeEnum.HealCrit)
  if skillType then
    if skillType == "attack" then
      for _, v in ipairs(self._childWind.skill) do
        v:SetActive(false)
      end
      self._critic:SetActive(damageType == DamageTypeEnum.BreakBuff or damageType == DamageTypeEnum.DamageCrit or damageType == DamageTypeEnum.BreakBuffCrit)
      for k, v in ipairs(self._childWind.attack) do
        v:SetActive(damageType == k)
        if damageType == k then
          if damageType == DamageTypeEnum.BreakBuff or damageType == DamageTypeEnum.DamageCrit or damageType == DamageTypeEnum.BreakBuffCrit then
            self._critic:SetText(stringText)
          else
            v:SetText(stringText)
          end
        end
      end
    elseif skillType == "skill" then
      for _, v in ipairs(self._childWind.attack) do
        v:SetActive(false)
      end
      self._critic:SetActive(damageType == DamageTypeEnum.BreakBuff or damageType == DamageTypeEnum.DamageCrit or damageType == DamageTypeEnum.BreakBuffCrit)
      for k, v in ipairs(self._childWind.skill) do
        v:SetActive(damageType == k)
        if damageType == k then
          if damageType == DamageTypeEnum.BreakBuff or damageType == DamageTypeEnum.DamageCrit or damageType == DamageTypeEnum.BreakBuffCrit then
            self._critic:SetText(stringText)
          else
            v:SetText(stringText)
          end
        end
      end
    end
  else
    for _, v in ipairs(self._childWind.skill) do
      v:SetActive(false)
    end
    for _, v in ipairs(self._childWind.attack) do
      v:SetActive(false)
    end
    self._critic:SetActive(false)
  end
  local ox, oy, oz = battler:GetSlotPosition("HitPoint")
  local x, y = UIManager.ScreenPointToLocalPointInRectangle(nil, UIManager.WorldToScreenPointInMargin("BattleMain", ox, oy, oz))
  local range
  if battler:IsLeftCamp() then
    range = {
      deltaLX = -PositionRange[1],
      deltaRX = -PositionRange[2],
      deltaDY = PositionRange[4],
      deltaUY = PositionRange[3]
    }
  else
    range = {
      deltaLX = PositionRange[1],
      deltaRX = PositionRange[2],
      deltaDY = PositionRange[4],
      deltaUY = PositionRange[3]
    }
  end
  local randomX = math.random() * (range.deltaRX - range.deltaLX) + range.deltaLX
  local randomY = math.random() * (range.deltaUY - range.deltaDY) + range.deltaDY
  self:GetRootWindow():SetAnchoredPosition(x + randomX, y + randomY)
end

function DamageNumCell:SetPosition(x, y)
  self:GetRootWindow():SetPosition(0.5, x, 0.5, y)
end

function DamageNumCell:OnAnimationEnd()
  if self._delegate then
    self:GetRootWindow():SetActive(false)
    self._delegate:RecycleDamageNumCell(self)
  end
end

return DamageNumCell
