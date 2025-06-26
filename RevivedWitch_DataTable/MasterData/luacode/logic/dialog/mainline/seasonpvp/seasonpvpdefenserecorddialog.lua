-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/seasonpvp/seasonpvpdefenserecorddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CArenaLoopReward = (BeanManager.GetTableByName)("dungeonselect.carenaloopreward")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CArenaSeasonConfig = (BeanManager.GetTableByName)("dungeonselect.carenaseasonconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SeasonPvpDefenseRecordDialog = class("SeasonPvpDefenseRecordDialog", Dialog)
SeasonPvpDefenseRecordDialog.AssetBundleName = "ui/layouts.seasonpvp"
SeasonPvpDefenseRecordDialog.AssetName = "SeasonPVPDefenseRecord"
local RankType = {CurrentSeason = 0, Totle = 1}
SeasonPvpDefenseRecordDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SeasonPvpDefenseRecordDialog
  ((SeasonPvpDefenseRecordDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
  self._playerIndex = -1
end

SeasonPvpDefenseRecordDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._closeBtn = self:GetChild("Back/CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
  self._panel = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
end

SeasonPvpDefenseRecordDialog.OnCloseBtnClicked = function(self)
  -- function num : 0_2
  self:Destroy()
end

SeasonPvpDefenseRecordDialog.OnDestroy = function(self)
  -- function num : 0_3
  (self._frame):Destroy()
end

SeasonPvpDefenseRecordDialog.Init = function(self, data)
  -- function num : 0_4 , upvalues : _ENV
  self._entryList = {}
  if data.enemyRoleList then
    for k,v in pairs(data.enemyRoleList) do
      (table.insert)(self._entryList, v)
    end
  end
  do
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
  end
end

SeasonPvpDefenseRecordDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._entryList
end

SeasonPvpDefenseRecordDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "mainline.seasonpvp.seasonpvpdefenserecordcell"
end

SeasonPvpDefenseRecordDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._entryList)[index]
end

return SeasonPvpDefenseRecordDialog

