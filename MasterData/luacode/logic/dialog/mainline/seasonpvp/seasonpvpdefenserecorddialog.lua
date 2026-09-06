local CArenaLoopReward = BeanManager.GetTableByName("dungeonselect.carenaloopreward")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CArenaSeasonConfig = BeanManager.GetTableByName("dungeonselect.carenaseasonconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SeasonPvpDefenseRecordDialog = class("SeasonPvpDefenseRecordDialog", Dialog)
SeasonPvpDefenseRecordDialog.AssetBundleName = "ui/layouts.seasonpvp"
SeasonPvpDefenseRecordDialog.AssetName = "SeasonPVPDefenseRecord"
local RankType = {CurrentSeason = 0, Totle = 1}

function SeasonPvpDefenseRecordDialog:Ctor(...)
  SeasonPvpDefenseRecordDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = {}
  self._playerIndex = -1
end

function SeasonPvpDefenseRecordDialog:OnCreate()
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
  self._panel = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
end

function SeasonPvpDefenseRecordDialog:OnCloseBtnClicked()
  self:Destroy()
end

function SeasonPvpDefenseRecordDialog:OnDestroy()
  self._frame:Destroy()
end

function SeasonPvpDefenseRecordDialog:Init(data)
  self._entryList = {}
  if data.enemyRoleList then
    for k, v in pairs(data.enemyRoleList) do
      table.insert(self._entryList, v)
    end
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function SeasonPvpDefenseRecordDialog:NumberOfCell(frame)
  return #self._entryList
end

function SeasonPvpDefenseRecordDialog:CellAtIndex(frame, index)
  return "mainline.seasonpvp.seasonpvpdefenserecordcell"
end

function SeasonPvpDefenseRecordDialog:DataAtIndex(frame, index)
  return self._entryList[index]
end

return SeasonPvpDefenseRecordDialog
