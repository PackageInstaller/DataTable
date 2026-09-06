local TaskCell = class("TaskCell", Dialog)
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
TaskCell.AssetBundleName = "ui/layouts.activitycommon"
TaskCell.AssetName = "ActivityCommon1TaskCell"

function TaskCell:Ctor(...)
  TaskCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function TaskCell:OnCreate()
  self._name = self:GetChild("ItemTxt")
  self._commitBtn = self:GetChild("GoBack/GetBtn")
  self._commitBtn_text = self:GetChild("GoBack/GetBtn/_Text")
  self._commitBtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1865))
  self._goBtn = self:GetChild("GoBack/GoBtn")
  self._goBtn_Text = self:GetChild("GoBack/GoBtn/_Text")
  self._goBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1718))
  self._normalBack = self:GetChild("GoBack")
  self._greyBack = self:GetChild("GoBack/Grey")
  self._greyBackText = self:GetChild("GoBack/Grey/GotBtn/_Text")
  self._greyBackText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1900))
  self._limit = self:GetChild("Limit")
  self._loading = self:GetChild("Loading")
  self._progress = self:GetChild("Loading/Progress")
  self._progressNum = self:GetChild("Loading/Num/Num")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  self._commitBtn:Subscribe_PointerClickEvent(self.OnCommitClick, self)
  self._itemPanel = self:GetChild("TaskCellFrame")
  self._itemFrame = TableFrame.Create(self._itemPanel, self, false, false, false)
end

function TaskCell:OnDestroy()
  if self._itemFrame then
    self._itemFrame:Destroy()
  end
end

function TaskCell:RefreshCell(data)
  self._task = data
  self._name:SetText(data:GetName())
  local progress = self._task:GetProgress()
  if #progress == 0 then
    self._loading:SetActive(false)
  else
    self._loading:SetActive(true)
    local text = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1058).msgTextID
    text = TextManager.GetText(text)
    text = text:gsub("%$parameter(%d)", {
      ["1"] = progress[1].current,
      ["2"] = progress[1].total
    })
    self._progress:SetFillAmount(self._task:GetProgress()[1].current / self._task:GetProgress()[1].total)
    self._progressNum:SetText(text)
  end
  local status = data:GetStatus()
  local greyShow = status == Status.COMMITED
  local imageRecord = CImagePathTable:GetRecorder(self._delegate._style.cfg.gobackPic) or DataCommon.DefaultImageAsset
  self._greyBack:SetActive(greyShow)
  self._normalBack:SetActive(true)
  if imageRecord then
    self._greyBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._normalBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  self._commitBtn:SetActive(status == Status.FINISHED)
  self._goBtn:SetActive(status ~= Status.FINISHED)
  self._commitBtn:SetActive(status == Status.FINISHED)
  local awards = data:GetAwards()
  self._itemList = awards
  self._itemFrame:ReloadAllCell()
end

function TaskCell:OnCommitClick()
  if self._task:GetStatus() == Status.FINISHED then
    self._delegate:OnCommitClick(self._task:GetID())
  end
end

function TaskCell:OnGoBtnClick()
  NekoData.BehaviorManager.BM_ActivityTasks:HandleTask(self._task)
end

function TaskCell:CellAtIndex(frame, index)
  return "activity.activitycommon.itemcell"
end

function TaskCell:NumberOfCell(frame)
  return #self._itemList
end

function TaskCell:DataAtIndex(frame, index)
  return self._itemList[index]
end

return TaskCell
