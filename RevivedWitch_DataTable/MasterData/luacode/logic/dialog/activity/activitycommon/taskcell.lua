-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/activitycommon/taskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskCell = class("TaskCell", Dialog)
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
TaskCell.AssetBundleName = "ui/layouts.activitycommon"
TaskCell.AssetName = "ActivityCommon1TaskCell"
TaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TaskCell
  ((TaskCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

TaskCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  self._name = self:GetChild("ItemTxt")
  self._commitBtn = self:GetChild("GoBack/GetBtn")
  self._commitBtn_text = self:GetChild("GoBack/GetBtn/_Text")
  ;
  (self._commitBtn_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1865))
  self._goBtn = self:GetChild("GoBack/GoBtn")
  self._goBtn_Text = self:GetChild("GoBack/GoBtn/_Text")
  ;
  (self._goBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1718))
  self._normalBack = self:GetChild("GoBack")
  self._greyBack = self:GetChild("GoBack/Grey")
  self._greyBackText = self:GetChild("GoBack/Grey/GotBtn/_Text")
  ;
  (self._greyBackText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1900))
  self._limit = self:GetChild("Limit")
  self._loading = self:GetChild("Loading")
  self._progress = self:GetChild("Loading/Progress")
  self._progressNum = self:GetChild("Loading/Num/Num")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  ;
  (self._commitBtn):Subscribe_PointerClickEvent(self.OnCommitClick, self)
  self._itemPanel = self:GetChild("TaskCellFrame")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, false, false, false)
end

TaskCell.OnDestroy = function(self)
  -- function num : 0_2
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
end

TaskCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Status, CImagePathTable
  self._task = data
  ;
  (self._name):SetText(data:GetName())
  local progress = (self._task):GetProgress()
  if #progress == 0 then
    (self._loading):SetActive(false)
  else
    ;
    (self._loading):SetActive(true)
    local text = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1058)).msgTextID
    text = (TextManager.GetText)(text)
    text = text:gsub("%$parameter(%d)", {["1"] = (progress[1]).current, ["2"] = (progress[1]).total})
    ;
    (self._progress):SetFillAmount((((self._task):GetProgress())[1]).current / (((self._task):GetProgress())[1]).total)
    ;
    (self._progressNum):SetText(text)
  end
  do
    local status = data:GetStatus()
    local greyShow = status == Status.COMMITED
    if not CImagePathTable:GetRecorder((((self._delegate)._style).cfg).gobackPic) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._greyBack):SetActive(greyShow)
    ;
    (self._normalBack):SetActive(true)
    if imageRecord then
      (self._greyBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._normalBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    ;
    (self._commitBtn):SetActive(status == Status.FINISHED)
    ;
    (self._goBtn):SetActive(status ~= Status.FINISHED)
    ;
    (self._commitBtn):SetActive(status == Status.FINISHED)
    local awards = data:GetAwards()
    self._itemList = awards
    ;
    (self._itemFrame):ReloadAllCell()
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

TaskCell.OnCommitClick = function(self)
  -- function num : 0_4 , upvalues : Status
  if (self._task):GetStatus() == Status.FINISHED then
    (self._delegate):OnCommitClick((self._task):GetID())
  end
end

TaskCell.OnGoBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_ActivityTasks):HandleTask(self._task)
end

TaskCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.activitycommon.itemcell"
end

TaskCell.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._itemList
end

TaskCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._itemList)[index]
end

return TaskCell

