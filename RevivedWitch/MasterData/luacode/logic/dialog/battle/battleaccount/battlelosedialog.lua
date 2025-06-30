-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/battlelosedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleLoseDialog = class("BattleLoseDialog", Dialog)
BattleLoseDialog.AssetBundleName = "ui/layouts.battlelose"
BattleLoseDialog.AssetName = "BattleDeathWhiteScreen"
BattleLoseDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleLoseDialog
  ((BattleLoseDialog.super).Ctor)(self, ...)
  self._groupName = "Chat"
end

BattleLoseDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetRootWindow()):Subscribe_StateEnterEvent(self.OnStateEnter, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateExit, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
end

BattleLoseDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

BattleLoseDialog.OnStateEnter = function(self, handle, statename, normalizedTime)
  -- function num : 0_3 , upvalues : _ENV
  if statename == "BattleLoseWhiteScreen" then
    ((DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")):SetDialogLibraryId(161)
  end
end

BattleLoseDialog.OnStateExit = function(self, handle, statename, normalizedTime)
  -- function num : 0_4 , upvalues : _ENV, BattleLoseDialog
  if statename == "BattleLoseWhiteScreenExit" then
    (LuaNotificationCenter.PostNotification)(Common.n_BattleLoseAnimationEnd, BattleLoseDialog, self)
  end
end

BattleLoseDialog.OnNPCChatEnd = function(self, notification)
  -- function num : 0_5
  if notification.userInfo == 161 then
    (self:GetRootWindow()):SetAnimatorBool("isExit", true)
  end
end

return BattleLoseDialog

