-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/medaltipsdotcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MedalTipsDotCell = class("MedalTipsDotCell", Dialog)
MedalTipsDotCell.AssetBundleName = "ui/layouts.bag"
MedalTipsDotCell.AssetName = "ItemTipsAchievementMedalDot"
MedalTipsDotCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MedalTipsDotCell
  ((MedalTipsDotCell.super).Ctor)(self, ...)
end

MedalTipsDotCell.OnCreate = function(self)
  -- function num : 0_1
  self._light = self:GetChild("Dot1")
  self._dark = self:GetChild("Dot0")
end

MedalTipsDotCell.OnDestroy = function(self)
  -- function num : 0_2
end

MedalTipsDotCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._light):SetActive(data == (self._delegate)._curShowIndex)
  ;
  (self._dark):SetActive(data ~= (self._delegate)._curShowIndex)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

MedalTipsDotCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_4
  if self._cellData ~= (self._delegate)._curShowIndex then
    (self._light):SetActive(eventName ~= "Switch")
    ;
    (self._dark):SetActive(self._cellData ~= (self._delegate)._curShowIndex)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

return MedalTipsDotCell

