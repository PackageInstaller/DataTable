-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/battlelose1187dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleLose1187Dialog = class("BattleLose1187Dialog", Dialog)
BattleLose1187Dialog.AssetBundleName = "ui/layouts.guide"
BattleLose1187Dialog.AssetName = "YuanNianGuide"
BattleLose1187Dialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleLose1187Dialog
  ((BattleLose1187Dialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

BattleLose1187Dialog.OnCreate = function(self)
  -- function num : 0_1
  self._confirmButton = self:GetChild("Back/ConfirmButton")
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

BattleLose1187Dialog.OnDestroy = function(self)
  -- function num : 0_2
end

BattleLose1187Dialog.OnClickConfirmBtn = function(self)
  -- function num : 0_3
  self:Destroy()
end

return BattleLose1187Dialog

