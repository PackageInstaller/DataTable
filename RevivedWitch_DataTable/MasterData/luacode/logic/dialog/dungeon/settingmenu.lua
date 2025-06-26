-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/settingmenu.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SettingMenu = class("SettingMenu", Dialog)
SettingMenu.AssetBundleName = "ui/layouts.dungeon"
SettingMenu.AssetName = "TempMiniMap"
SettingMenu.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingMenu
  ((SettingMenu.super).Ctor)(self, ...)
  self._groupName = "Default"
end

SettingMenu.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnMouseClicked, self)
end

SettingMenu.OnDestroy = function(self)
  -- function num : 0_2
end

SettingMenu.OnMouseClicked = function(self, args)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("dungeon.settingmenu")
  ;
  (DialogManager.CreateSingletonDialog)("dungeon.systemsettingdialog")
end

return SettingMenu

