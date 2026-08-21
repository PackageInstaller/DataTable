-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/offlinepvp/offlinepvpmainbuffcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local OffLinePvpMainBuffCell = class("OffLinePvpMainBuffCell", Dialog)
OffLinePvpMainBuffCell.AssetBundleName = "ui/layouts.offlinepvp"
OffLinePvpMainBuffCell.AssetName = "OffLinePVPMainBuffCell"
OffLinePvpMainBuffCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OffLinePvpMainBuffCell
  ((OffLinePvpMainBuffCell.super).Ctor)(self, ...)
end

OffLinePvpMainBuffCell.OnCreate = function(self)
  -- function num : 0_1
  self._txt = self:GetChild("Txt")
end

OffLinePvpMainBuffCell.OnDestroy = function(self)
  -- function num : 0_2
end

OffLinePvpMainBuffCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._txt):SetText((TextManager.GetText)(data))
end

return OffLinePvpMainBuffCell

