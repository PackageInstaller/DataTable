local BattleLose1186Dialog = class("BattleLose1186Dialog", Dialog)
BattleLose1186Dialog.AssetBundleName = "ui/layouts.battlelose"
BattleLose1186Dialog.AssetName = "BattleDeathWhiteSpecial"

function BattleLose1186Dialog:Ctor(...)
  BattleLose1186Dialog.super.Ctor(self, ...)
  self._groupName = "Chat"
end

function BattleLose1186Dialog:OnCreate()
  self:GetRootWindow():Subscribe_StateEnterEvent(self.OnStateEnter, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
end

function BattleLose1186Dialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BattleLose1186Dialog:OnStateEnter(handle, statename, normalizedTime)
  if statename == "BattleLoseWhiteScreen" then
    DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog"):SetDialogLibraryId(396)
  end
end

function BattleLose1186Dialog:OnStateExit(handle, statename, normalizedTime)
  if statename == "BattleLoseWhiteScreenExit" then
    LuaNotificationCenter.PostNotification(Common.n_BattleLoseAnimationEnd, BattleLose1186Dialog, self)
  end
end

function BattleLose1186Dialog:OnNPCChatEnd(notification)
  if notification.userInfo == 396 then
    self:GetRootWindow():SetAnimatorBool("isExit", true)
  end
end

return BattleLose1186Dialog
