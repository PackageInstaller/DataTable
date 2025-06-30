-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/horizontalactivetimecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HorizontalActiveTimeCell = class("HorizontalActiveTimeCell", Dialog)
HorizontalActiveTimeCell.AssetBundleName = "ui/layouts.battle"
HorizontalActiveTimeCell.AssetName = "ATBCell"
local cNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local cImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
HorizontalActiveTimeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HorizontalActiveTimeCell
  ((HorizontalActiveTimeCell.super).Ctor)(self, ...)
  self._headIcon = nil
  self._frameRed = nil
  self._frameBlue = nil
  self._animator = nil
end

HorizontalActiveTimeCell.OnCreate = function(self)
  -- function num : 0_1
  self._headIcon = self:GetChild("Back/Photo")
  self._frameRed = self:GetChild("FrameR")
  self._frameBlue = self:GetChild("FrameB")
  self._animator = ((self._rootWindow):GetUIObject()):GetComponent("Animator")
end

HorizontalActiveTimeCell.OnDestroy = function(self)
  -- function num : 0_2
end

HorizontalActiveTimeCell.GetEntityID = function(self)
  -- function num : 0_3
  return self._entityID
end

HorizontalActiveTimeCell.Refresh = function(self, info)
  -- function num : 0_4 , upvalues : cNPCShape, cImagePathTable
  local camp = info.orientation
  ;
  ((self._frameBlue):GetUIObject()):SetActive(camp == 1)
  ;
  ((self._frameBlue):GetUIObject()):SetActive(camp ~= 1)
  local npcShapeRecorder = cNPCShape:GetRecorder(info.shapeId)
  local headIconID = npcShapeRecorder.headID
  local imageRecord = cImagePathTable:GetRecorder(headIconID)
  if imageRecord then
    (self._headIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    (self._headIcon):SetSprite("", "")
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

HorizontalActiveTimeCell.SetActive = function(self, isActive)
  -- function num : 0_5
  ((self._rootWindow):GetUIObject()):SetActive(isActive)
end

HorizontalActiveTimeCell.Active = function(self)
  -- function num : 0_6
end

HorizontalActiveTimeCell.In = function(self)
  -- function num : 0_7
  (self._animator):SetTrigger("In")
end

HorizontalActiveTimeCell.Out = function(self)
  -- function num : 0_8
  (self._animator):SetTrigger("Out")
end

HorizontalActiveTimeCell.Show = function(self)
  -- function num : 0_9
  (self._animator):SetTrigger("Show")
end

HorizontalActiveTimeCell.Change = function(self)
  -- function num : 0_10
end

return HorizontalActiveTimeCell

