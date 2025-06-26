-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battlelead2dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleLead2Dialog = class("BattleLead2Dialog", Dialog)
BattleLead2Dialog.AssetBundleName = "ui/layouts.battlenew"
BattleLead2Dialog.AssetName = "BattleNewTutorial2"
BattleLead2Dialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleLead2Dialog
  ((BattleLead2Dialog.super).Ctor)(self, ...)
  self._groupName = "Default"
end

BattleLead2Dialog.OnCreate = function(self)
  -- function num : 0_1
end

BattleLead2Dialog.OnDestroy = function(self)
  -- function num : 0_2
end

return BattleLead2Dialog

