local NpcChatBackLogDialog = class("NpcChatBackLogDialog", Dialog)
NpcChatBackLogDialog.AssetBundleName = "ui/layouts.dramadialog"
NpcChatBackLogDialog.AssetName = "DramaBacklog"

function NpcChatBackLogDialog:Ctor(...)
  NpcChatBackLogDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function NpcChatBackLogDialog:OnCreate()
  self._backText = self:GetChild("WindowBack/Text")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function NpcChatBackLogDialog:OnDestroy()
end

function NpcChatBackLogDialog:SetData(info)
  self._backText:SetText(info.backlog)
end

function NpcChatBackLogDialog:OnBackBtnClicked(args)
  DialogManager.DestroySingletonDialog("npcchat.npcchatbacklogdialog")
end

return NpcChatBackLogDialog
