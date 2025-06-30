-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battleguidetimetype1003stage4maskdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleGuideTimeType1003Stage4MaskDialog = class("BattleGuideTimeType1003Stage4MaskDialog", Dialog)
BattleGuideTimeType1003Stage4MaskDialog.AssetBundleName = "ui/layouts"
BattleGuideTimeType1003Stage4MaskDialog.AssetName = "WindowMask"
BattleGuideTimeType1003Stage4MaskDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleGuideTimeType1003Stage4MaskDialog
  ((BattleGuideTimeType1003Stage4MaskDialog.super).Ctor)(self, ...)
  self._groupName = "Guide"
end

BattleGuideTimeType1003Stage4MaskDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  LogInfo("BattleGuideTimeType1003Stage4MaskDialog", "OnCreate")
end

BattleGuideTimeType1003Stage4MaskDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("BattleGuideTimeType1003Stage4MaskDialog", "OnDestroy")
end

return BattleGuideTimeType1003Stage4MaskDialog

