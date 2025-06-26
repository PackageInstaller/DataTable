-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/basecharacterinfoprofilecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local BaseCharacterInfoProFileCell = class("BaseCharacterInfoProFileCell", Dialog)
BaseCharacterInfoProFileCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterInfoProFileCell.AssetName = "BaseCharacterInfoProfile"
BaseCharacterInfoProFileCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseCharacterInfoProFileCell
  ((BaseCharacterInfoProFileCell.super).Ctor)(self, ...)
end

BaseCharacterInfoProFileCell.OnCreate = function(self)
  -- function num : 0_1
  self._heightNum = self:GetChild("Height/Num")
  self._weightNum = self:GetChild("Weight/Num")
  self._booldNum = self:GetChild("Boold/Num")
  self._hobbyNum = self:GetChild("Hobby/Num")
  self._natureNum = self:GetChild("Nature/Num")
  self._sexNum = self:GetChild("Sex/Num")
  self._describe = self:GetChild("Describe/Name")
  self._story = self:GetChild("Story/Name")
end

BaseCharacterInfoProFileCell.OnDestroy = function(self)
  -- function num : 0_2
end

BaseCharacterInfoProFileCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Role
  local role = (Role.Create)(data:GetId())
  ;
  (self._heightNum):SetText(role:GetRoleHeight())
  ;
  (self._weightNum):SetText(role:GetRoleWeight())
  ;
  (self._booldNum):SetText(role:GetRoleBloodType())
  ;
  (self._hobbyNum):SetText(role:GetRoleHobby())
  ;
  (self._natureNum):SetText(role:GetRoleAttribute())
  ;
  (self._sexNum):SetText(role:GetRoleSex())
  ;
  (self._describe):SetText(role:GetRoleShortInfo())
  ;
  (self._story):SetText(role:GetRoleBackStory())
end

return BaseCharacterInfoProFileCell

