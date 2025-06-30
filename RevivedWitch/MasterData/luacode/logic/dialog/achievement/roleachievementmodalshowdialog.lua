-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/roleachievementmodalshowdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CAchievementBagConfig = (BeanManager.GetTableByName)("mission.cachievebadgeconfig")
local CAchieveBadgeGroupConfig = (BeanManager.GetTableByName)("mission.cachievebadgegroup")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local RoleAchievementModalShowDialog = class("RoleAchievementModalShowDialog", Dialog)
RoleAchievementModalShowDialog.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementModalShowDialog.AssetName = "AchievementAllMedal"
local BottomToTop = 3
RoleAchievementModalShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleAchievementModalShowDialog
  ((RoleAchievementModalShowDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._modalList = {}
end

RoleAchievementModalShowDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, GridFrame
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._cellArea = self:GetChild("Back/Frame")
  self._cellFrame = (GridFrame.Create)(self._cellArea, self, true, 5)
  self._empty = self:GetChild("Empty")
end

RoleAchievementModalShowDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._cellFrame):Destroy()
end

RoleAchievementModalShowDialog.SetData = function(self, info)
  -- function num : 0_3 , upvalues : CAchieveBadgeGroupConfig, _ENV
  local allIds = CAchieveBadgeGroupConfig:GetAllIds()
  for i = 1, #allIds do
    local recorder = CAchieveBadgeGroupConfig:GetRecorder(allIds[i])
    local data = {recorder = recorder, 
getList = {}
, 
noGetList = {}
}
    local len = #recorder.badgeIDList
    for j = 1, len do
      local ishas = false
      if info.badges then
        for id,time in pairs(info.badges) do
          if (recorder.badgeIDList)[j] == id then
            ishas = true
          end
        end
      end
      do
        do
          if ishas then
            (table.insert)(data.getList, {id = (recorder.badgeIDList)[j], time = (info.badges)[(recorder.badgeIDList)[j]]})
          else
            ;
            (table.insert)(data.noGetList, (recorder.badgeIDList)[j])
          end
          -- DECOMPILER ERROR at PC60: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
    ;
    (table.insert)(self._modalList, data)
  end
  ;
  (self._empty):SetActive(#self._modalList == 0)
  ;
  (self._cellFrame):ReloadAllCell()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

RoleAchievementModalShowDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_4
  local width, height = (self._cellArea):GetRectSize()
  local total = (self._cellFrame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetScrollSize(1)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  end
end

RoleAchievementModalShowDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._modalList
end

RoleAchievementModalShowDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "achievement.roleachievementmodalshowcell"
end

RoleAchievementModalShowDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._modalList)[index]
end

RoleAchievementModalShowDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

return RoleAchievementModalShowDialog

