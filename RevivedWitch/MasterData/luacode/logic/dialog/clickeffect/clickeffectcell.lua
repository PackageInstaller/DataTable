-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/clickeffect/clickeffectcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ClickEffectCell = class("ClickEffectCell", Dialog)
ClickEffectCell.AssetBundleName = "ui/layouts"
ClickEffectCell.AssetName = "ClickCell"
ClickEffectCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ClickEffectCell
  ((ClickEffectCell.super).Ctor)(self, ...)
end

ClickEffectCell.OnCreate = function(self)
  -- function num : 0_1
end

ClickEffectCell.OnDestroy = function(self)
  -- function num : 0_2
end

ClickEffectCell.PlayEffect = function(self)
  -- function num : 0_3
  (self:GetRootWindow()):SetAnimatorTrigger("OnClick")
end

ClickEffectCell.PlayAudio = function(self, audioId)
  -- function num : 0_4 , upvalues : _ENV
  (LuaAudioManager.PlayBGM)(audioId, true)
end

return ClickEffectCell

