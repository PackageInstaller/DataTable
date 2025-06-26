-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/aprilfoolsdayclickeffectcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AprilFoolsDayClickEffectCell = class("AprilFoolsDayClickEffectCell", Dialog)
AprilFoolsDayClickEffectCell.AssetBundleName = "ui/layouts"
AprilFoolsDayClickEffectCell.AssetName = "ActivityAprilFoolsClickCell"
AprilFoolsDayClickEffectCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AprilFoolsDayClickEffectCell
  ((AprilFoolsDayClickEffectCell.super).Ctor)(self, ...)
end

AprilFoolsDayClickEffectCell.OnCreate = function(self)
  -- function num : 0_1
end

AprilFoolsDayClickEffectCell.OnDestroy = function(self)
  -- function num : 0_2
end

AprilFoolsDayClickEffectCell.PlayEffect = function(self)
  -- function num : 0_3
  (self:GetRootWindow()):SetAnimatorTrigger("OnClick")
end

AprilFoolsDayClickEffectCell.PlayAudio = function(self, audioId)
  -- function num : 0_4 , upvalues : _ENV
  (LuaAudioManager.PlayBGM)(audioId, true)
end

return AprilFoolsDayClickEffectCell

