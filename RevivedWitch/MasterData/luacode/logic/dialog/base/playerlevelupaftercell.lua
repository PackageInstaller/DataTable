-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/base/playerlevelupaftercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PlayerLevelUpAfterCell = class("PlayerLevelUpAfterCell", Dialog)
PlayerLevelUpAfterCell.AssetBundleName = "ui/layouts.basemainhud"
PlayerLevelUpAfterCell.AssetName = "MagicLevelUpUnLock"
PlayerLevelUpAfterCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PlayerLevelUpAfterCell
  ((PlayerLevelUpAfterCell.super).Ctor)(self, ...)
end

PlayerLevelUpAfterCell.OnCreate = function(self)
  -- function num : 0_1
  self._txt = self:GetChild("Txt1")
end

PlayerLevelUpAfterCell.OnDestroy = function(self)
  -- function num : 0_2
end

PlayerLevelUpAfterCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local str = (TextManager.GetText)(data.value)
  ;
  (self._txt):SetText(str)
end

return PlayerLevelUpAfterCell

