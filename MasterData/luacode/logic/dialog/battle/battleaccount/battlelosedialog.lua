local BattleLoseDialog = class("BattleLoseDialog", Dialog)
BattleLoseDialog.AssetBundleName = "ui/layouts.battlelose"
BattleLoseDialog.AssetName = "BattleDeathWhiteScreen"

function BattleLoseDialog:Ctor(...)
  BattleLoseDialog.super.Ctor(self, ...)
  self._groupName = "Chat"
end

function BattleLoseDialog:OnCreate()
  self:GetRootWindow():Subscribe_StateEnterEvent(self.OnStateEnter, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
end

function BattleLoseDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BattleLoseDialog:OnStateEnter(handle, statename, normalizedTime)
  if statename == "BattleLoseWhiteScreen" then
    DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog"):SetDialogLibraryId(161)
  end
end

function BattleLoseDialog:OnStateExit(handle, statename, normalizedTime)
  if statename == "BattleLoseWhiteScreenExit" then
    LuaNotificationCenter.PostNotification(Common.n_BattleLoseAnimationEnd, BattleLoseDialog, self)
  end
end

function BattleLoseDialog:OnNPCChatEnd(notification)
  if notification.userInfo == 161 then
    self:GetRootWindow():SetAnimatorBool("isExit", true)
  end
end

return BattleLoseDialog
