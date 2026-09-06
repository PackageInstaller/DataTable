local CRoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local TuJianCharacterInfoStoryCell = class("TuJianCharacterInfoStoryCell", Dialog)
TuJianCharacterInfoStoryCell.AssetBundleName = "ui/layouts.tujian"
TuJianCharacterInfoStoryCell.AssetName = "TuJianCharInfoStory"

function TuJianCharacterInfoStoryCell:Ctor(...)
  TuJianCharacterInfoStoryCell.super.Ctor(self, ...)
end

function TuJianCharacterInfoStoryCell:OnCreate()
  self._describe = self:GetChild("Describe/Name")
  self._story = self:GetChild("Story/Name")
end

function TuJianCharacterInfoStoryCell:OnDestroy()
end

function TuJianCharacterInfoStoryCell:RefreshCell(data)
  local roleConfig = CRoleConfigTable:GetRecorder(data.id)
  self._describe:SetText(TextManager.GetText(roleConfig.shortintro))
  self._story:SetText(TextManager.GetText(roleConfig.backstory))
end

return TuJianCharacterInfoStoryCell
