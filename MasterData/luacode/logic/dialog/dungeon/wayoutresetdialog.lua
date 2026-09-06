local WayoutResetDialog = class("WayoutReset", Dialog)
WayoutResetDialog.AssetBundleName = "ui/layouts.dungeon"
WayoutResetDialog.AssetName = "DungeonGearReset"

function WayoutResetDialog:Ctor(...)
  WayoutResetDialog.super.Ctor(self, ...)
  self._groupName = "Default"
end

function WayoutResetDialog:OnCreate()
  self._button = self:GetChild("Button0")
  self._button:Subscribe_PointerClickEvent(self.OnClick, self)
end

function WayoutResetDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function WayoutResetDialog:SetData(switch)
  self._switch = switch
end

function WayoutResetDialog:OnClick()
  EffectFactory.CreateFreezeEffect():Run()
  local effect = self._switch:Reset()
  effect:Run()
  effect:Then(function()
    EffectFactory.CreateThawEffect():Run()
  end)
end

return WayoutResetDialog
