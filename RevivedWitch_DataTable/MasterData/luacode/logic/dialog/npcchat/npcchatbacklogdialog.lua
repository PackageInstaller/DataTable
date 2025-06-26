-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/npcchat/npcchatbacklogdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NpcChatBackLogDialog = class("NpcChatBackLogDialog", Dialog)
NpcChatBackLogDialog.AssetBundleName = "ui/layouts.dramadialog"
NpcChatBackLogDialog.AssetName = "DramaBacklog"
NpcChatBackLogDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NpcChatBackLogDialog
  ((NpcChatBackLogDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

NpcChatBackLogDialog.OnCreate = function(self)
  -- function num : 0_1
  self._backText = self:GetChild("WindowBack/Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

NpcChatBackLogDialog.OnDestroy = function(self)
  -- function num : 0_2
end

NpcChatBackLogDialog.SetData = function(self, info)
  -- function num : 0_3
  (self._backText):SetText(info.backlog)
end

NpcChatBackLogDialog.OnBackBtnClicked = function(self, args)
  -- function num : 0_4 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("npcchat.npcchatbacklogdialog")
end

return NpcChatBackLogDialog

