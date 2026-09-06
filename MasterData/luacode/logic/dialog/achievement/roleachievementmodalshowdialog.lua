local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CAchievementBagConfig = BeanManager.GetTableByName("mission.cachievebadgeconfig")
local CAchieveBadgeGroupConfig = BeanManager.GetTableByName("mission.cachievebadgegroup")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local RoleAchievementModalShowDialog = class("RoleAchievementModalShowDialog", Dialog)
RoleAchievementModalShowDialog.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementModalShowDialog.AssetName = "AchievementAllMedal"
local BottomToTop = 3

function RoleAchievementModalShowDialog:Ctor(...)
  RoleAchievementModalShowDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._modalList = {}
end

function RoleAchievementModalShowDialog:OnCreate()
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._cellArea = self:GetChild("Back/Frame")
  self._cellFrame = GridFrame.Create(self._cellArea, self, true, 5)
  self._empty = self:GetChild("Empty")
end

function RoleAchievementModalShowDialog:OnDestroy()
  self._cellFrame:Destroy()
end

function RoleAchievementModalShowDialog:SetData(info)
  local allIds = CAchieveBadgeGroupConfig:GetAllIds()
  for i = 1, #allIds do
    local recorder = CAchieveBadgeGroupConfig:GetRecorder(allIds[i])
    local data = {
      recorder = recorder,
      getList = {},
      noGetList = {}
    }
    local len = #recorder.badgeIDList
    for j = 1, len do
      local ishas = false
      if info.badges then
        for id, time in pairs(info.badges) do
          if recorder.badgeIDList[j] == id then
            ishas = true
          end
        end
      end
      if ishas then
        table.insert(data.getList, {
          id = recorder.badgeIDList[j],
          time = info.badges[recorder.badgeIDList[j]]
        })
      else
        table.insert(data.noGetList, recorder.badgeIDList[j])
      end
    end
    table.insert(self._modalList, data)
  end
  self._empty:SetActive(#self._modalList == 0)
  self._cellFrame:ReloadAllCell()
end

function RoleAchievementModalShowDialog:OnCurPosChange(frame, proportion)
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

function RoleAchievementModalShowDialog:NumberOfCell(frame)
  return #self._modalList
end

function RoleAchievementModalShowDialog:CellAtIndex(frame, index)
  return "achievement.roleachievementmodalshowcell"
end

function RoleAchievementModalShowDialog:DataAtIndex(frame, index)
  return self._modalList[index]
end

function RoleAchievementModalShowDialog:OnBackBtnClicked()
  self:Destroy()
end

return RoleAchievementModalShowDialog
