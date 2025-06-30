-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/chrismascall/callrankcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CallRankCellHelper = require("logic.dialog.activity.chrismascall.callrankcellhelper")
local CallRankCell = class("CallRankCell", Dialog)
CallRankCell.AssetBundleName = "ui/layouts.activitychristmascall"
CallRankCell.AssetName = "ActivityChristmasCallRankCell"
CallRankCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CallRankCell
  ((CallRankCell.super).Ctor)(self, ...)
end

CallRankCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : CallRankCellHelper
  self._callRankCellHelper = (CallRankCellHelper.Create)(self:GetRootWindow())
end

CallRankCell.OnDestroy = function(self)
  -- function num : 0_2
  if self._callRankCellHelper then
    (self._callRankCellHelper):OnDestroy()
  end
end

CallRankCell.RefreshCell = function(self, data)
  -- function num : 0_3
  if self._callRankCellHelper then
    (self._callRankCellHelper):RefreshCell(data)
  end
end

return CallRankCell

