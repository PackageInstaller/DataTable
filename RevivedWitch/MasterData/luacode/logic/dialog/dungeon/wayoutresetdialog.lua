-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/wayoutresetdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local WayoutResetDialog = class("WayoutReset", Dialog)
WayoutResetDialog.AssetBundleName = "ui/layouts.dungeon"
WayoutResetDialog.AssetName = "DungeonGearReset"
WayoutResetDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : WayoutResetDialog
  ((WayoutResetDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
end

WayoutResetDialog.OnCreate = function(self)
  -- function num : 0_1
  self._button = self:GetChild("Button0")
  ;
  (self._button):Subscribe_PointerClickEvent(self.OnClick, self)
end

WayoutResetDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

WayoutResetDialog.SetData = function(self, switch)
  -- function num : 0_3
  self._switch = switch
end

WayoutResetDialog.OnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((EffectFactory.CreateFreezeEffect)()):Run()
  local effect = (self._switch):Reset()
  effect:Run()
  effect:Then(function()
    -- function num : 0_4_0 , upvalues : _ENV
    ((EffectFactory.CreateThawEffect)()):Run()
  end
)
end

return WayoutResetDialog

