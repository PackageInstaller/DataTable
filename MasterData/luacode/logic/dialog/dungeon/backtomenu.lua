-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/backtomenu.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BackToMenu = class("BackToMenu", Dialog)
BackToMenu.AssetBundleName = "ui/layouts.dungeon"
BackToMenu.AssetName = "BackToMainMenu"
BackToMenu.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BackToMenu
  ((BackToMenu.super).Ctor)(self, ...)
  self._groupName = "Default"
end

BackToMenu.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnMouseClicked, self)
end

BackToMenu.OnDestroy = function(self)
  -- function num : 0_2
end

BackToMenu.OnMouseClicked = function(self, args)
  -- function num : 0_3 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
  csend:Send()
end

return BackToMenu

