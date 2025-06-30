-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battleeditor/pve/arrangeleftrolecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ArrangeLeftRoleCell = class("ArrangeLeftRoleCell", Dialog)
ArrangeLeftRoleCell.AssetBundleName = "ui/layouts.battleeditor"
ArrangeLeftRoleCell.AssetName = "ArrangeCharactorCell"
ArrangeLeftRoleCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ArrangeLeftRoleCell
  ((ArrangeLeftRoleCell.super).Ctor)(self, ...)
  self._id = 0
end

ArrangeLeftRoleCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Image")
  self._selectFrame = self:GetChild("SelectFrame")
end

ArrangeLeftRoleCell.OnDestroy = function(self)
  -- function num : 0_2
end

ArrangeLeftRoleCell.SetRoleConfigId = function(self, roleConfigId)
  -- function num : 0_3 , upvalues : RoleConfigTable, CNpcShapeTable, CImagePathTable, _ENV
  self._id = roleConfigId
  ;
  (self._selectFrame):SetActive(false)
  local monsterRecord = RoleConfigTable:GetRecorder(roleConfigId)
  local shapeRecord = CNpcShapeTable:GetRecorder(monsterRecord.shapeID)
  if not CImagePathTable:GetRecorder(shapeRecord.headID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

ArrangeLeftRoleCell.Selected = function(self, selected)
  -- function num : 0_4
  (self._selectFrame):SetActive(selected)
end

return ArrangeLeftRoleCell

