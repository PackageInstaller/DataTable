local NpcChatSelectCell = class("NpcChatSelectCell", Dialog)
NpcChatSelectCell.AssetBundleName = "ui/layouts.dramadialog"
NpcChatSelectCell.AssetName = "DramaSelectionCell"

function NpcChatSelectCell:Ctor(...)
  NpcChatSelectCell.super.Ctor(self, ...)
end

function NpcChatSelectCell:OnCreate()
  self._text = self:GetChild("Select1/_Text")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function NpcChatSelectCell:OnDestroy()
end

function NpcChatSelectCell:RefreshCell(data)
  if data.chooseText then
    self._text:SetText(tostring(data.chooseText))
  end
  if data.playEffect then
    self:GetRootWindow():SetAnimatorInteger("important", 1)
  else
    self:GetRootWindow():SetAnimatorInteger("important", 0)
  end
end

function NpcChatSelectCell:OnCellClicked(args, luawindow)
  self._delegate:OnCellClicked(self._cellData.index)
end

return NpcChatSelectCell
