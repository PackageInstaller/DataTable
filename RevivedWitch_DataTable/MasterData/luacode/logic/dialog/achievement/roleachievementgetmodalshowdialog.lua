-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/roleachievementgetmodalshowdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local RoleAchievementGetModalShowDialog = class("RoleAchievementGetModalShowDialog", Dialog)
RoleAchievementGetModalShowDialog.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementGetModalShowDialog.AssetName = "AchievementMedalShow"
local BottomToTop = 3
RoleAchievementGetModalShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleAchievementGetModalShowDialog
  ((RoleAchievementGetModalShowDialog.super).Ctor)(self, ...)
end

RoleAchievementGetModalShowDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, GridFrame
  self._num = self:GetChild("Back/Choose/Num")
  self._maxNum = self:GetChild("Back/Choose/NumMax")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._cellArea = self:GetChild("Back/Frame")
  self._cellFrame = (GridFrame.Create)(self._cellArea, self, true, 5)
  ;
  (self._cellFrame):SetMargin(40, 0)
  self._getMedalBtn = self:GetChild("GetMedal")
  ;
  (self._getMedalBtn):Subscribe_PointerClickEvent(self.OnGetMedalBtnClick, self)
end

RoleAchievementGetModalShowDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._cellFrame):Destroy()
end

RoleAchievementGetModalShowDialog.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._modalList = {}
  self._achievement = ((NekoData.BehaviorManager).BM_Task):GetAchievement()
  for k,v in pairs((self._achievement).badges) do
    (table.insert)(self._modalList, k)
  end
  self._showList = (self._achievement).showBadges
  if self._showList then
    (self._num):SetText((table.nums)(self._showList))
  else
    ;
    (self._num):SetText(0)
  end
  if self._modalList then
    (self._cellFrame):ReloadAllCell()
    ;
    (self._cellFrame):FireEvent("ChangeSelect", self._showList)
  end
end

RoleAchievementGetModalShowDialog.OnCurPosChange = function(self, frame, proportion)
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

RoleAchievementGetModalShowDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._modalList
end

RoleAchievementGetModalShowDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "achievement.roleachievementgetmodalshowcell"
end

RoleAchievementGetModalShowDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  local data = {}
  data.id = (self._modalList)[index]
  return data
end

RoleAchievementGetModalShowDialog.OnCellClicked = function(self, id)
  -- function num : 0_8 , upvalues : _ENV
  if not self._showList then
    self._showList = {}
  end
  for k,v in pairs(self._showList) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

    if v == id then
      (self._showList)[k] = nil
      ;
      (self._num):SetText((table.nums)(self._showList))
      ;
      (self._cellFrame):FireEvent("ChangeSelect", self._showList)
      return 
    end
  end
  local max = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(41)).Value)
  if max <= (table.nums)(self._showList) then
    return 
  else
    ;
    (table.insert)(self._showList, id)
  end
  ;
  (self._num):SetText((table.nums)(self._showList))
  ;
  (self._cellFrame):FireEvent("ChangeSelect", self._showList)
end

RoleAchievementGetModalShowDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

RoleAchievementGetModalShowDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.caddbadges")
  if protocol then
    local list = {}
    for _,v in pairs(self._showList) do
      (table.insert)(list, v)
    end
    protocol.badges = list
    protocol:Send()
  end
end

RoleAchievementGetModalShowDialog.OnGetMedalBtnClick = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("task.taskmaindialog")
  if dialog then
    (DialogManager.DestroySingletonDialog)("task.taskmaindialog")
  end
  local dlg = (DialogManager.CreateSingletonDialog)("task.taskmaindialog")
  if dlg then
    dlg:ToPage(4)
  end
end

return RoleAchievementGetModalShowDialog

