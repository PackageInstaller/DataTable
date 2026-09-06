local SettingMenu = class("SettingMenu", Dialog)
SettingMenu.AssetBundleName = "ui/layouts.dungeon"
SettingMenu.AssetName = "TempMiniMap"

function SettingMenu:Ctor(...)
  SettingMenu.super.Ctor(self, ...)
  self._groupName = "Default"
end

function SettingMenu:OnCreate()
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnMouseClicked, self)
end

function SettingMenu:OnDestroy()
end

function SettingMenu:OnMouseClicked(args)
  DialogManager.DestroySingletonDialog("dungeon.settingmenu")
  DialogManager.CreateSingletonDialog("dungeon.systemsettingdialog")
end

return SettingMenu
