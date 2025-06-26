-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/battlelose1186dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleLose1186Dialog = class("BattleLose1186Dialog", Dialog)
BattleLose1186Dialog.AssetBundleName = "ui/layouts.battlelose"
BattleLose1186Dialog.AssetName = "BattleDeathWhiteSpecial"
BattleLose1186Dialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleLose1186Dialog
  ((BattleLose1186Dialog.super).Ctor)(self, ...)
  self._groupName = "Chat"
end

BattleLose1186Dialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetRootWindow()):Subscribe_StateEnterEvent(self.OnStateEnter, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateExit, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
end

BattleLose1186Dialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

BattleLose1186Dialog.OnStateEnter = function(self, handle, statename, normalizedTime)
  -- function num : 0_3 , upvalues : _ENV
  if statename == "BattleLoseWhiteScreen" then
    ((DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")):SetDialogLibraryId(396)
  end
end

BattleLose1186Dialog.OnStateExit = function(self, handle, statename, normalizedTime)
  -- function num : 0_4 , upvalues : _ENV, BattleLose1186Dialog
  if statename == "BattleLoseWhiteScreenExit" then
    (LuaNotificationCenter.PostNotification)(Common.n_BattleLoseAnimationEnd, BattleLose1186Dialog, self)
  end
end

BattleLose1186Dialog.OnNPCChatEnd = function(self, notification)
  -- function num : 0_5
  if notification.userInfo == 396 then
    (self:GetRootWindow()):SetAnimatorBool("isExit", true)
  end
end

return BattleLose1186Dialog

