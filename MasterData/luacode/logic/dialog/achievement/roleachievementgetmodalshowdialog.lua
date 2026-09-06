local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local RoleAchievementGetModalShowDialog = class("RoleAchievementGetModalShowDialog", Dialog)
RoleAchievementGetModalShowDialog.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementGetModalShowDialog.AssetName = "AchievementMedalShow"
local BottomToTop = 3

function RoleAchievementGetModalShowDialog:Ctor(...)
  RoleAchievementGetModalShowDialog.super.Ctor(self, ...)
end

function RoleAchievementGetModalShowDialog:OnCreate()
  self._num = self:GetChild("Back/Choose/Num")
  self._maxNum = self:GetChild("Back/Choose/NumMax")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._cellArea = self:GetChild("Back/Frame")
  self._cellFrame = GridFrame.Create(self._cellArea, self, true, 5)
  self._cellFrame:SetMargin(40, 0)
  self._getMedalBtn = self:GetChild("GetMedal")
  self._getMedalBtn:Subscribe_PointerClickEvent(self.OnGetMedalBtnClick, self)
end

function RoleAchievementGetModalShowDialog:OnDestroy()
  self._cellFrame:Destroy()
end

function RoleAchievementGetModalShowDialog:SetData()
  self._modalList = {}
  self._achievement = NekoData.BehaviorManager.BM_Task:GetAchievement()
  for k, v in pairs(self._achievement.badges) do
    table.insert(self._modalList, k)
  end
  self._showList = self._achievement.showBadges
  if self._showList then
    self._num:SetText(table.nums(self._showList))
  else
    self._num:SetText(0)
  end
  if self._modalList then
    self._cellFrame:ReloadAllCell()
    self._cellFrame:FireEvent("ChangeSelect", self._showList)
  end
end

function RoleAchievementGetModalShowDialog:OnCurPosChange(frame, proportion)
  local width, height = self._cellArea:GetRectSize()
  local total = self._cellFrame:GetTotalLength()
  if height < total then
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetScrollSize(1)
    self._scrollBar:SetScrollValue(proportion)
  end
end

function RoleAchievementGetModalShowDialog:NumberOfCell(frame)
  return #self._modalList
end

function RoleAchievementGetModalShowDialog:CellAtIndex(frame, index)
  return "achievement.roleachievementgetmodalshowcell"
end

function RoleAchievementGetModalShowDialog:DataAtIndex(frame, index)
  local data = {}
  data.id = self._modalList[index]
  return data
end

function RoleAchievementGetModalShowDialog:OnCellClicked(id)
  if not self._showList then
    self._showList = {}
  end
  for k, v in pairs(self._showList) do
    if v == id then
      self._showList[k] = nil
      self._num:SetText(table.nums(self._showList))
      self._cellFrame:FireEvent("ChangeSelect", self._showList)
      return
    end
  end
  local max = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(41).Value)
  if max <= table.nums(self._showList) then
    return
  else
    table.insert(self._showList, id)
  end
  self._num:SetText(table.nums(self._showList))
  self._cellFrame:FireEvent("ChangeSelect", self._showList)
end

function RoleAchievementGetModalShowDialog:OnBackBtnClicked()
  self:Destroy()
end

function RoleAchievementGetModalShowDialog:OnConfirmBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.task.caddbadges")
  if protocol then
    local list = {}
    for _, v in pairs(self._showList) do
      table.insert(list, v)
    end
    protocol.badges = list
    protocol:Send()
  end
end

function RoleAchievementGetModalShowDialog:OnGetMedalBtnClick()
  local dialog = DialogManager.GetDialog("task.taskmaindialog")
  if dialog then
    DialogManager.DestroySingletonDialog("task.taskmaindialog")
  end
  local dlg = DialogManager.CreateSingletonDialog("task.taskmaindialog")
  if dlg then
    dlg:ToPage(4)
  end
end

return RoleAchievementGetModalShowDialog
