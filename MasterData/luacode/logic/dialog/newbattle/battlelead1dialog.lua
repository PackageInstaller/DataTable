-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battlelead1dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleLead1Dialog = class("BattleLead1Dialog", Dialog)
BattleLead1Dialog.AssetBundleName = "ui/layouts.battlenew"
BattleLead1Dialog.AssetName = "BattleNewTutorial1"
BattleLead1Dialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleLead1Dialog
  ((BattleLead1Dialog.super).Ctor)(self, ...)
  self._groupName = "Default"
end

BattleLead1Dialog.OnCreate = function(self)
  -- function num : 0_1
end

BattleLead1Dialog.OnDestroy = function(self)
  -- function num : 0_2
end

return BattleLead1Dialog

