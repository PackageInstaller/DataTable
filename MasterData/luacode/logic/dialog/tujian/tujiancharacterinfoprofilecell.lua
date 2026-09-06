local CRoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local TuJianCharacterInfoProfileCell = class("TuJianCharacterInfoProfileCell", Dialog)
TuJianCharacterInfoProfileCell.AssetBundleName = "ui/layouts.tujian"
TuJianCharacterInfoProfileCell.AssetName = "TuJianCharInfoProfile"

function TuJianCharacterInfoProfileCell:Ctor(...)
  TuJianCharacterInfoProfileCell.super.Ctor(self, ...)
end

function TuJianCharacterInfoProfileCell:OnCreate()
  self._height = self:GetChild("Height/Num")
  self._weight = self:GetChild("Weight/Num")
  self._blood = self:GetChild("Boold/Num")
  self._hobby = self:GetChild("Hobby/Num")
  self._nature = self:GetChild("Nature/Num")
  self._sex = self:GetChild("Sex/Num")
end

function TuJianCharacterInfoProfileCell:OnDestroy()
end

function TuJianCharacterInfoProfileCell:RefreshCell(data)
  local roleConfig = CRoleConfigTable:GetRecorder(data.id)
  self._height:SetText(tostring(roleConfig.height))
  self._weight:SetText(tostring(roleConfig.weight))
  self._blood:SetText(tostring(roleConfig.bloodtype))
  self._hobby:SetText(tostring(roleConfig.hobby))
  self._nature:SetText(tostring(roleConfig.attribute))
  self._sex:SetText(TextManager.GetText(roleConfig.sex))
end

return TuJianCharacterInfoProfileCell
