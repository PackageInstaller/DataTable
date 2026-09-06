local DungeonDeathWhiteScreen = class("DungeonDeathWhiteScreen", Dialog)
DungeonDeathWhiteScreen.AssetBundleName = "ui/layouts.battlelose"
DungeonDeathWhiteScreen.AssetName = "BattleDeathWhiteScreen"

function DungeonDeathWhiteScreen:Ctor(...)
  DungeonDeathWhiteScreen.super.Ctor(self, ...)
  self._groupName = "Chat"
end

function DungeonDeathWhiteScreen:OnCreate()
  self:GetRootWindow():Subscribe_StateEnterEvent(self.OnStateEnter, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
end

function DungeonDeathWhiteScreen:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function DungeonDeathWhiteScreen:SetData(t)
  self._type = tonumber(t) or 0
end

function DungeonDeathWhiteScreen:OnStateEnter(handle, statename, normalizedTime)
  if statename == "BattleLoseWhiteScreen" then
    DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog"):SetDialogLibraryId(161)
  end
end

function DungeonDeathWhiteScreen:OnStateExit(handle, statename, normalizedTime)
  if statename == "BattleLoseWhiteScreenExit" then
    LogInfoFormat("DungeonDeathWhiteScreen", "statename %s self._type %s", statename, self._type)
    local req = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    req.enterCityType = self._type or 0
    req:Send()
  end
end

function DungeonDeathWhiteScreen:OnNPCChatEnd(notification)
  if notification.userInfo == 161 then
    self:GetRootWindow():SetAnimatorBool("isExit", true)
  end
end

return DungeonDeathWhiteScreen
