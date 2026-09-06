local BackToMenu = class("BackToMenu", Dialog)
BackToMenu.AssetBundleName = "ui/layouts.dungeon"
BackToMenu.AssetName = "BackToMainMenu"

function BackToMenu:Ctor(...)
  BackToMenu.super.Ctor(self, ...)
  self._groupName = "Default"
end

function BackToMenu:OnCreate()
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnMouseClicked, self)
end

function BackToMenu:OnDestroy()
end

function BackToMenu:OnMouseClicked(args)
  local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
  csend:Send()
end

return BackToMenu
