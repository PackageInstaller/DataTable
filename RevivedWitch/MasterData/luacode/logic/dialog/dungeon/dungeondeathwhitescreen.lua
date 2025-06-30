-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeondeathwhitescreen.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonDeathWhiteScreen = class("DungeonDeathWhiteScreen", Dialog)
DungeonDeathWhiteScreen.AssetBundleName = "ui/layouts.battlelose"
DungeonDeathWhiteScreen.AssetName = "BattleDeathWhiteScreen"
DungeonDeathWhiteScreen.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonDeathWhiteScreen
  ((DungeonDeathWhiteScreen.super).Ctor)(self, ...)
  self._groupName = "Chat"
end

DungeonDeathWhiteScreen.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetRootWindow()):Subscribe_StateEnterEvent(self.OnStateEnter, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateExit, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
end

DungeonDeathWhiteScreen.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

DungeonDeathWhiteScreen.SetData = function(self, t)
  -- function num : 0_3 , upvalues : _ENV
  self._type = tonumber(t) or 0
end

DungeonDeathWhiteScreen.OnStateEnter = function(self, handle, statename, normalizedTime)
  -- function num : 0_4 , upvalues : _ENV
  if statename == "BattleLoseWhiteScreen" then
    ((DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")):SetDialogLibraryId(161)
  end
end

DungeonDeathWhiteScreen.OnStateExit = function(self, handle, statename, normalizedTime)
  -- function num : 0_5 , upvalues : _ENV
  if statename == "BattleLoseWhiteScreenExit" then
    LogInfoFormat("DungeonDeathWhiteScreen", "statename %s self._type %s", statename, self._type)
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
    req.enterCityType = self._type or 0
    req:Send()
  end
end

DungeonDeathWhiteScreen.OnNPCChatEnd = function(self, notification)
  -- function num : 0_6
  if notification.userInfo == 161 then
    (self:GetRootWindow()):SetAnimatorBool("isExit", true)
  end
end

return DungeonDeathWhiteScreen

