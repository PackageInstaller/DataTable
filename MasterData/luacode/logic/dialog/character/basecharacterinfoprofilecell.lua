local Role = require("logic.manager.experimental.types.role")
local BaseCharacterInfoProFileCell = class("BaseCharacterInfoProFileCell", Dialog)
BaseCharacterInfoProFileCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterInfoProFileCell.AssetName = "BaseCharacterInfoProfile"

function BaseCharacterInfoProFileCell:Ctor(...)
  BaseCharacterInfoProFileCell.super.Ctor(self, ...)
end

function BaseCharacterInfoProFileCell:OnCreate()
  self._heightNum = self:GetChild("Height/Num")
  self._weightNum = self:GetChild("Weight/Num")
  self._booldNum = self:GetChild("Boold/Num")
  self._hobbyNum = self:GetChild("Hobby/Num")
  self._natureNum = self:GetChild("Nature/Num")
  self._sexNum = self:GetChild("Sex/Num")
  self._describe = self:GetChild("Describe/Name")
  self._story = self:GetChild("Story/Name")
end

function BaseCharacterInfoProFileCell:OnDestroy()
end

function BaseCharacterInfoProFileCell:RefreshCell(data)
  local role = Role.Create(data:GetId())
  self._heightNum:SetText(role:GetRoleHeight())
  self._weightNum:SetText(role:GetRoleWeight())
  self._booldNum:SetText(role:GetRoleBloodType())
  self._hobbyNum:SetText(role:GetRoleHobby())
  self._natureNum:SetText(role:GetRoleAttribute())
  self._sexNum:SetText(role:GetRoleSex())
  self._describe:SetText(role:GetRoleShortInfo())
  self._story:SetText(role:GetRoleBackStory())
end

return BaseCharacterInfoProFileCell
