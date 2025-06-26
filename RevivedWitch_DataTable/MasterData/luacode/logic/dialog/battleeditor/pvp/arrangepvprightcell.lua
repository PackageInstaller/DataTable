-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battleeditor/pvp/arrangepvprightcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ArrangePVPRightCell = class("ArrangePVPRightCell", Dialog)
ArrangePVPRightCell.AssetBundleName = "ui/layouts.battleeditor"
ArrangePVPRightCell.AssetName = "ArrangeCharactorCell"
ArrangePVPRightCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ArrangePVPRightCell
  ((ArrangePVPRightCell.super).Ctor)(self, ...)
end

ArrangePVPRightCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Image")
  self._selectFrame = self:GetChild("SelectFrame")
  ;
  (self:GetRootWindow()):Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  ;
  (self:GetRootWindow()):Subscribe_DragEvent(self.OnDrag, self)
  ;
  (self:GetRootWindow()):Subscribe_EndDragEvent(self.OnEndDrag, self)
  ;
  (self:GetRootWindow()):Subscribe_CancelDragEvent(self.OnEndDrag, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self:GetRootWindow()):SetUserData(self)
end

ArrangePVPRightCell.OnDestroy = function(self)
  -- function num : 0_2
end

ArrangePVPRightCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CNpcShapeTable, CImagePathTable, _ENV
  local shapeRecord = CNpcShapeTable:GetRecorder(data.shapeID)
  if not CImagePathTable:GetRecorder(shapeRecord.headID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._selectFrame):SetActive((self._delegate):GetSelectedID() == data.id)
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ArrangePVPRightCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_4
  if arg ~= (self._cellData).id then
    (self._selectFrame):SetActive(eventName ~= "SelectIndex")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

ArrangePVPRightCell.OnBeginDrag = function(self, args)
  -- function num : 0_5
  (self._delegate):SetSelectedID((self._cellData).id)
  ;
  (self._delegate):OnRightCellBeginDrag(args.position)
end

ArrangePVPRightCell.OnDrag = function(self, args)
  -- function num : 0_6
  (self._delegate):OnRightCellDrag(args.position)
end

ArrangePVPRightCell.OnEndDrag = function(self, args)
  -- function num : 0_7
  (self._delegate):OnRightCellEndDrag(args.position)
end

ArrangePVPRightCell.OnCellClicked = function(self, args)
  -- function num : 0_8
  (self._delegate):SetSelectedID((self._cellData).id)
end

return ArrangePVPRightCell

