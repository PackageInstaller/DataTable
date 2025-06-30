-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battleeditor/pve/arrangeleftmonstercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ArrangeLeftMonsterCell = class("ArrangeLeftMonsterCell", Dialog)
ArrangeLeftMonsterCell.AssetBundleName = "ui/layouts.battleeditor"
ArrangeLeftMonsterCell.AssetName = "ArrangeCharactorCell"
ArrangeLeftMonsterCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ArrangeLeftMonsterCell
  ((ArrangeLeftMonsterCell.super).Ctor)(self, ...)
  self._id = 0
end

ArrangeLeftMonsterCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Image")
  self._selectFrame = self:GetChild("SelectFrame")
end

ArrangeLeftMonsterCell.OnDestroy = function(self)
  -- function num : 0_2
end

ArrangeLeftMonsterCell.SetMonsterId = function(self, monsterId)
  -- function num : 0_3 , upvalues : CMonsterConfigTable, CNpcShapeTable, CImagePathTable
  self._id = monsterId
  ;
  (self._selectFrame):SetActive(false)
  local monsterRecord = CMonsterConfigTable:GetRecorder(monsterId)
  local shapeRecord = CNpcShapeTable:GetRecorder(monsterRecord.shapeID)
  local imageRecord = CImagePathTable:GetRecorder(shapeRecord.headID)
  if imageRecord then
    (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    ;
    (self._image):SetSprite("", "")
  end
end

ArrangeLeftMonsterCell.Selected = function(self, selected)
  -- function num : 0_4
  (self._selectFrame):SetActive(selected)
end

return ArrangeLeftMonsterCell

