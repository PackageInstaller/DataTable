local TaskCell = class("TaskCell", Dialog)
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local Item = require("logic.manager.experimental.types.item")
TaskCell.AssetBundleName = "ui/layouts.activity1yearanniversary"
TaskCell.AssetName = "Activity1YearOtherTaskCell"

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
  self._greyBack = self:GetChild("Grey")
  self._greyBackText = self:GetChild("Grey/GotBtn/_Text")
  self._greyBackText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1900))
  self._itemCell = {}
  self._itemCell.cell = self:GetChild("TaskCellItem/Panel/ItemCell")
  self._itemCell.icon = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Icon")
  self._itemCell.frame = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Frame")
  self._itemCell.count = self:GetChild("TaskCellItem/Panel/ItemCell/_Count")
  self._itemCell.cell:Subscribe_PointerClickEvent(self.OnItemClicked, self)
  self._itemCell1 = {}
  self._itemCell1.cell = self:GetChild("TaskCellItem (1)/Panel/ItemCell")
  self._itemCell1.icon = self:GetChild("TaskCellItem (1)/Panel/ItemCell/_BackGround/Icon")
  self._itemCell1.frame = self:GetChild("TaskCellItem (1)/Panel/ItemCell/_BackGround/Frame")
  self._itemCell1.count = self:GetChild("TaskCellItem (1)/Panel/ItemCell/_Count")
  self._itemCell1.cell:Subscribe_PointerClickEvent(self.OnItem1Clicked, self)
  self._limit = self:GetChild("Limit")
  self._loading = self:GetChild("Loading")
  self._progress = self:GetChild("Loading/Progress")
  self._progressNum = self:GetChild("Loading/Num/Num")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  self._commitBtn:Subscribe_PointerClickEvent(self.OnCommitClick, self)
end

function TaskCell:OnDestroy()
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
  self._greyBack:SetActive(greyShow)
  self._normalBack:SetActive(not greyShow)
  self._commitBtn:SetActive(status == Status.FINISHED)
  self._goBtn:SetActive(status ~= Status.FINISHED)
  self._commitBtn:SetActive(status == Status.FINISHED)
  local awards = data:GetAwards()
  local image = awards[1]:GetIcon()
  self._itemCell.icon:SetSprite(image.assetBundle, image.assetName)
  image = awards[1]:GetPinJiImage()
  self._itemCell.frame:SetSprite(image.assetBundle, image.assetName)
  self._itemCell.count:SetText(NumberManager.GetShowNumber(awards[1]:GetCount()))
  self._itemCell.item = awards[1]
  if awards[2] then
    self._itemCell1.cell:SetActive(true)
    local image = awards[2]:GetIcon()
    self._itemCell1.icon:SetSprite(image.assetBundle, image.assetName)
    image = awards[2]:GetPinJiImage()
    self._itemCell1.frame:SetSprite(image.assetBundle, image.assetName)
    self._itemCell1.count:SetText(NumberManager.GetShowNumber(awards[2]:GetCount()))
    self._itemCell1.item = awards[2]
  else
    self._itemCell1.cell:SetActive(false)
  end
end

function TaskCell:OnCommitClick()
  if self._task:GetStatus() == Status.FINISHED then
    self._delegate:OnCommitClick(self._task:GetID())
  end
end

function TaskCell:OnItemClicked()
  local width, height = self._itemCell.cell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._itemCell.item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell.cell:GetLocalPointInUiRootPanel())
  end
end

function TaskCell:OnItem1Clicked()
  local width, height = self._itemCell1.cell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._itemCell1.item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell1.cell:GetLocalPointInUiRootPanel())
  end
end

function TaskCell:OnGoBtnClick()
  NekoData.BehaviorManager.BM_ActivityTasks:HandleTask(self._task)
end

return TaskCell
