-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battlelead3dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleLead3Dialog = class("BattleLead3Dialog", Dialog)
BattleLead3Dialog.AssetBundleName = "ui/layouts.battlenew"
BattleLead3Dialog.AssetName = "BattleNewTutorial3"
BattleLead3Dialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleLead3Dialog
  ((BattleLead3Dialog.super).Ctor)(self, ...)
  self._groupName = "Default"
end

BattleLead3Dialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._powerEffect = self:GetChild("Effect1")
  self._skillEffect = self:GetChild("Effect2")
  self._handlePower = (self._powerEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1036))
  self._handleSkill = (self._skillEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1037))
  ;
  (self._powerEffect):Subscribe_UIEffectEndEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:Destroy()
  end
)
end

BattleLead3Dialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._battleword):AddFirstBattleIndex(1)
  if self._handleSkill then
    (self._skillEffect):ReleaseEffect(self._handleSkill)
    self._handleSkill = nil
  end
  if self._handlePower then
    (self._skillEffect):ReleaseEffect(self._handlePower)
    self._handlePower = nil
  end
end

BattleLead3Dialog.SetData = function(self, world)
  -- function num : 0_3
  self._battleword = world
end

return BattleLead3Dialog

