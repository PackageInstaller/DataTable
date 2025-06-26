-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battleeditor/charactorinfocell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CharactorInfoCell = class("CharactorInfoCell", Dialog)
CharactorInfoCell.AssetBundleName = "ui/layouts.battleeditor"
CharactorInfoCell.AssetName = "CharactorInfoCell"
CharactorInfoCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharactorInfoCell
  ((CharactorInfoCell.super).Ctor)(self, ...)
end

CharactorInfoCell.OnCreate = function(self, root)
  -- function num : 0_1
  self._photo = self:GetChild("Photo")
  self._name = self:GetChild("NameBack/NameTXT")
  self._jobName = self:GetChild("NameBack/JobTXT")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

CharactorInfoCell.OnDestroy = function(self)
  -- function num : 0_2
end

CharactorInfoCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CNpcShapeTable, CImagePathTable, _ENV
  local shapeRecord = CNpcShapeTable:GetRecorder(data.shapeID)
  if not CImagePathTable:GetRecorder(shapeRecord.bustID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._name):SetText(data.name)
  ;
  (self._jobName):SetText(data.vocation)
  ;
  (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

CharactorInfoCell.OnCellClicked = function(self, args)
  -- function num : 0_4 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("battleeditor.charactorinfodetaildialog")):RefreshRoleInfoDetail((self._cellData).id)
end

return CharactorInfoCell

