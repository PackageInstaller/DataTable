local DamageNumCell = class("DamageNumCell", Dialog)
DamageNumCell.AssetBundleName = "ui/layouts.battle"
DamageNumCell.AssetName = "DamageNum"

function DamageNumCell:Ctor(...)
  DamageNumCell.super.Ctor(self, ...)
  self._id = 0
  self._num = 0
end

function DamageNumCell:OnCreate()
  self._damageText = self:GetChild("Damage")
  self._healText = self:GetChild("Heal")
  self._criticText = self:GetChild("Critic")
  self._missText = self:GetChild("Miss")
  self._invincibleText = self:GetChild("Invincible")
  self._healText:Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  self._damageText:Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  self._criticText:Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  self._missText:Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  self._invincibleText:Subscribe_StateExitEvent(self.OnAnimationEnd, self)
end

function DamageNumCell:OnDestroy()
end

function DamageNumCell:Refresh(battler, num, x, y, critical, damageType)
  if damageType == "heal" then
    self._healText:SetText(tostring(num))
    self._damageText:SetActive(false)
    self._criticText:SetActive(false)
    self._missText:SetActive(false)
    self._invincibleText:SetActive(false)
  elseif damageType == "damage" then
    if critical then
      self._criticText:SetText(tostring(num))
      self._damageText:SetActive(false)
    else
      self._damageText:SetText(tostring(num))
      self._criticText:SetActive(false)
    end
    self._healText:SetActive(false)
    self._missText:SetActive(false)
    self._invincibleText:SetActive(false)
  elseif damageType == "invincible" then
    self._healText:SetActive(false)
    self._damageText:SetActive(false)
    self._criticText:SetActive(false)
    self._missText:SetActive(false)
  elseif damageType == "miss" then
    self._healText:SetActive(false)
    self._damageText:SetActive(false)
    self._criticText:SetActive(false)
    self._invincibleText:SetActive(false)
  else
    self._healText:SetActive(false)
    self._damageText:SetActive(false)
    self._criticText:SetActive(false)
    self._missText:SetActive(false)
    self._invincibleText:SetActive(false)
  end
  self._battler = battler
  self:SetPosition(x, y)
end

function DamageNumCell:SetPosition(x, y)
  self:GetRootWindow():SetAnchoredPosition(x, y)
end

function DamageNumCell:OnAnimationEnd()
  self:Destroy()
end

return DamageNumCell
