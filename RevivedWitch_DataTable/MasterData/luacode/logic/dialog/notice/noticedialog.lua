-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/notice/noticedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NoticeDialog = class("NoticeDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local VerticalTableFrameInverseImpl = require("framework.ui.frame.table.verticaltableframeinverseimpl")
NoticeDialog.AssetBundleName = "ui/layouts.activeannouce"
NoticeDialog.AssetName = "ActiveAnnounce"
NoticeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NoticeDialog
  ((NoticeDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

NoticeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, VerticalTableFrameInverseImpl, _ENV
  self._groups = {activity = self:GetChild("Back/GroupBtn1"), system = self:GetChild("Back/GroupBtn2")}
  self._titleBoard = self:GetChild("Back/Selections/CellFrame")
  self._contentBoard = self:GetChild("Back/Content/Frame")
  self._close = self:GetChild("CloseBtn")
  ;
  (self._close):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._titleHelper = (TableFrame.Create)(self._titleBoard, self, true, true, true)
  self._contentHelperInterface = {}
  self._contentHelper = (VerticalTableFrameInverseImpl.Create)(self._contentHelperInterface, self._contentBoard, self, true, false, "ViewportHardMask")
  self._lastDiableNoticeTimeKey = tostring((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid) .. "_lastDiableNoticeTime"
  self._lastDiableNoticeTime = (((CS.UnityEngine).PlayerPrefs).GetInt)(self._lastDiableNoticeTimeKey, 0)
  self._toggleButton = self:GetChild("_Toggle_0")
  ;
  (self._toggleButton):SetIsOnType(self._lastDiableNoticeTime ~= 0)
  ;
  (self._toggleButton):Subscribe_ValueChangedEvent(self.ToggleButtonValueChanged, self)
  self._selectedGroup = "activity"
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNoticeReceive, Common.n_InGameAnnouncement, nil)
  ;
  (NoticeManager.ClearInGameNotice)()
  ;
  (NoticeManager.RequestInGameNotice)()
  for k,v in pairs(self._groups) do
    do
      v:Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, k
    if self._data then
      self:OnGroupClick(k)
    end
  end
)
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

NoticeDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._titleHelper):Destroy()
  ;
  (self._contentHelper):Destroy()
  ;
  (NoticeManager.CheckNewInGameNotice)()
  ;
  (NoticeManager.SetInGameRedPoint)(false)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_NewInGameAnnouncement, NoticeManager)
end

NoticeDialog.SetData = function(self, data)
  -- function num : 0_3
  self._data = data
  self._selected = 1
  ;
  (self._titleHelper):SetSlide(#self._data > 1)
  self:Refresh()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

NoticeDialog.Refresh = function(self)
  -- function num : 0_4
  (self._titleHelper):ReloadAllCell()
  ;
  (self._contentHelper):ReloadAllCell()
  ;
  (self._contentHelper):MoveToTop(false)
  ;
  (self._titleHelper):FireEvent("selected", self._selected)
  ;
  (self._titleHelper):MoveToTop(false)
end

NoticeDialog.OnGroupClick = function(self, group)
  -- function num : 0_5 , upvalues : _ENV
  self._selectedGroup = group
  for k,v in pairs(self._groups) do
    v:SetSelected(k == group)
  end
  local notice = (NoticeManager.GetInGameNotice)()
  if notice[group] then
    self:SetData(notice[group])
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

NoticeDialog.OnNoticeReceive = function(self, notification)
  -- function num : 0_6
  self:OnGroupClick(self._selectedGroup)
end

NoticeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("notice.noticedialog")
end

NoticeDialog.OnLinkClick = function(self, link)
  -- function num : 0_8 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_GotoLink):HandleGoto(link)
end

NoticeDialog.OnPageClick = function(self, index)
  -- function num : 0_9
  self._selected = index
  self:Refresh()
end

NoticeDialog.NumberOfCell = function(self, helper)
  -- function num : 0_10
  if helper == self._titleHelper then
    return #self._data
  else
    if helper == self._contentHelperInterface then
      return #((self._data)[self._selected]).content
    end
  end
end

NoticeDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_11 , upvalues : _ENV
  if helper == self._titleHelper then
    return "notice.noticepagecell"
  else
    if helper == self._contentHelperInterface then
      local attrs = ((((self._data)[self._selected]).content)[index]).attrs
      if attrs.img then
        return "notice.noticeimagecell"
      end
      if attrs.level then
        if attrs.level == 1 then
          return "notice.noticetitle1cell"
        else
          if attrs.level == 2 then
            return "notice.noticetextcell"
          end
        end
      end
      if attrs.align then
        if attrs.align == "right" then
          return "notice.noticesigncell"
        else
          if attrs.align == "center" then
            return "notice.noticetextcentercell"
          else
            return "notice.noticetextcell"
          end
        end
      end
      if attrs.text then
        return "notice.noticetextcell"
      end
      LogWarning("noticedialog", "Find unknown type of cell. Fallback to noticetextcell to show it.")
      return "notice.noticetextcell"
    end
  end
end

NoticeDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_12
  if helper == self._titleHelper then
    return {index = index, data = (self._data)[index]}
  else
    if helper == self._contentHelperInterface then
      return (((self._data)[self._selected]).content)[index]
    end
  end
end

NoticeDialog.ShouldLengthChange = function(self, helper, index)
  -- function num : 0_13
  do return helper == self._contentHelperInterface end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

NoticeDialog.ToggleButtonValueChanged = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local value = (self._toggleButton):GetIsOnType()
  if value then
    local nowDay = tonumber((os.date)("!%Y%m%d", (ServerGameTimer.GetServerTimeForecast)() // 1000))
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)(self._lastDiableNoticeTimeKey, nowDay)
  else
    do
      ;
      (((CS.UnityEngine).PlayerPrefs).SetInt)(self._lastDiableNoticeTimeKey, 0)
    end
  end
end

return NoticeDialog

