-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/horizontalactivetimecurrentcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HorizontalActiveTimeCurrentCell = class("HorizontalActiveTimeCurrentCell", Dialog)
HorizontalActiveTimeCurrentCell.AssetBundleName = "ui/layouts.battle"
HorizontalActiveTimeCurrentCell.AssetName = "ATBCurrentCell"
local cNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local cImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
HorizontalActiveTimeCurrentCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HorizontalActiveTimeCurrentCell
  ((HorizontalActiveTimeCurrentCell.super).Ctor)(self, ...)
  self._headIcon = nil
  self._frameRed = nil
  self._frameBlue = nil
  self._animator = nil
end

HorizontalActiveTimeCurrentCell.OnCreate = function(self)
  -- function num : 0_1
  self._headIcon = self:GetChild("Back/Photo")
  self._frameRed = self:GetChild("FrameR")
  self._frameBlue = self:GetChild("FrameB")
  self._animator = ((self._rootWindow):GetUIObject()):GetComponent("Animator")
end

HorizontalActiveTimeCurrentCell.OnDestroy = function(self)
  -- function num : 0_2
end

HorizontalActiveTimeCurrentCell.GetEntityID = function(self)
  -- function num : 0_3
  return self._entityID
end

HorizontalActiveTimeCurrentCell.Refresh = function(self, entityId, orientation, shapeId)
  -- function num : 0_4 , upvalues : cNPCShape, cImagePathTable
  local camp = orientation
  ;
  ((self._frameBlue):GetUIObject()):SetActive(camp == 1)
  ;
  ((self._frameBlue):GetUIObject()):SetActive(camp ~= 1)
  local npcShapeRecorder = cNPCShape:GetRecorder(shapeId)
  local headIconID = npcShapeRecorder.headID
  local imageRecord = cImagePathTable:GetRecorder(headIconID)
  if imageRecord then
    (self._headIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    (self._headIcon):SetSprite("", "")
  end
  ;
  (self._animator):SetTrigger("CellAct")
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

HorizontalActiveTimeCurrentCell.SetActive = function(self, isActive)
  -- function num : 0_5
  ((self._rootWindow):GetUIObject()):SetActive(isActive)
end

HorizontalActiveTimeCurrentCell.Active = function(self)
  -- function num : 0_6
end

return HorizontalActiveTimeCurrentCell

