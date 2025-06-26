-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/damagenumcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DamageNumCell = class("DamageNumCell", Dialog)
DamageNumCell.AssetBundleName = "ui/layouts.battle"
DamageNumCell.AssetName = "DamageNum"
DamageNumCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DamageNumCell
  ((DamageNumCell.super).Ctor)(self, ...)
  self._id = 0
  self._num = 0
end

DamageNumCell.OnCreate = function(self)
  -- function num : 0_1
  self._damageText = self:GetChild("Damage")
  self._healText = self:GetChild("Heal")
  self._criticText = self:GetChild("Critic")
  self._missText = self:GetChild("Miss")
  self._invincibleText = self:GetChild("Invincible")
  ;
  (self._healText):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  ;
  (self._damageText):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  ;
  (self._criticText):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  ;
  (self._missText):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  ;
  (self._invincibleText):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
end

DamageNumCell.OnDestroy = function(self)
  -- function num : 0_2
end

DamageNumCell.Refresh = function(self, battler, num, x, y, critical, damageType)
  -- function num : 0_3 , upvalues : _ENV
  if damageType == "heal" then
    (self._healText):SetText(tostring(num))
    ;
    (self._damageText):SetActive(false)
    ;
    (self._criticText):SetActive(false)
    ;
    (self._missText):SetActive(false)
    ;
    (self._invincibleText):SetActive(false)
  else
    if damageType == "damage" then
      if critical then
        (self._criticText):SetText(tostring(num))
        ;
        (self._damageText):SetActive(false)
      else
        ;
        (self._damageText):SetText(tostring(num))
        ;
        (self._criticText):SetActive(false)
      end
      ;
      (self._healText):SetActive(false)
      ;
      (self._missText):SetActive(false)
      ;
      (self._invincibleText):SetActive(false)
    else
      if damageType == "invincible" then
        (self._healText):SetActive(false)
        ;
        (self._damageText):SetActive(false)
        ;
        (self._criticText):SetActive(false)
        ;
        (self._missText):SetActive(false)
      else
        if damageType == "miss" then
          (self._healText):SetActive(false)
          ;
          (self._damageText):SetActive(false)
          ;
          (self._criticText):SetActive(false)
          ;
          (self._invincibleText):SetActive(false)
        else
          ;
          (self._healText):SetActive(false)
          ;
          (self._damageText):SetActive(false)
          ;
          (self._criticText):SetActive(false)
          ;
          (self._missText):SetActive(false)
          ;
          (self._invincibleText):SetActive(false)
        end
      end
    end
  end
  self._battler = battler
  self:SetPosition(x, y)
end

DamageNumCell.SetPosition = function(self, x, y)
  -- function num : 0_4
  (self:GetRootWindow()):SetAnchoredPosition(x, y)
end

DamageNumCell.OnAnimationEnd = function(self)
  -- function num : 0_5
  self:Destroy()
end

return DamageNumCell

