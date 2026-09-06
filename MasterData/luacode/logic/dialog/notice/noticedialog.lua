local NoticeDialog = class("NoticeDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local VerticalTableFrameInverseImpl = require("framework.ui.frame.table.verticaltableframeinverseimpl")
NoticeDialog.AssetBundleName = "ui/layouts.activeannouce"
NoticeDialog.AssetName = "ActiveAnnounce"

function NoticeDialog:Ctor(...)
  NoticeDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function NoticeDialog:OnCreate()
  self._groups = {
    activity = self:GetChild("Back/GroupBtn1"),
    system = self:GetChild("Back/GroupBtn2")
  }
  self._titleBoard = self:GetChild("Back/Selections/CellFrame")
  self._contentBoard = self:GetChild("Back/Content/Frame")
  self._close = self:GetChild("CloseBtn")
  self._close:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._titleHelper = TableFrame.Create(self._titleBoard, self, true, true, true)
  self._contentHelperInterface = {}
  self._contentHelper = VerticalTableFrameInverseImpl.Create(self._contentHelperInterface, self._contentBoard, self, true, false, "ViewportHardMask")
  self._lastDiableNoticeTimeKey = tostring(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid) .. "_lastDiableNoticeTime"
  self._lastDiableNoticeTime = CS.UnityEngine.PlayerPrefs.GetInt(self._lastDiableNoticeTimeKey, 0)
  self._toggleButton = self:GetChild("_Toggle_0")
  self._toggleButton:SetIsOnType(self._lastDiableNoticeTime ~= 0)
  self._toggleButton:Subscribe_ValueChangedEvent(self.ToggleButtonValueChanged, self)
  self._selectedGroup = "activity"
  LuaNotificationCenter.AddObserver(self, self.OnNoticeReceive, Common.n_InGameAnnouncement, nil)
  NoticeManager.ClearInGameNotice()
  NoticeManager.RequestInGameNotice()
  for k, v in pairs(self._groups) do
    v:Subscribe_PointerClickEvent(function()
      if self._data then
        self:OnGroupClick(k)
      end
    end)
  end
end

function NoticeDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._titleHelper:Destroy()
  self._contentHelper:Destroy()
  NoticeManager.CheckNewInGameNotice()
  NoticeManager.SetInGameRedPoint(false)
  LuaNotificationCenter.PostNotification(Common.n_NewInGameAnnouncement, NoticeManager)
end

function NoticeDialog:SetData(data)
  self._data = data
  self._selected = 1
  self._titleHelper:SetSlide(#self._data > 1)
  self:Refresh()
end

function NoticeDialog:Refresh()
  self._titleHelper:ReloadAllCell()
  self._contentHelper:ReloadAllCell()
  self._contentHelper:MoveToTop(false)
  self._titleHelper:FireEvent("selected", self._selected)
  self._titleHelper:MoveToTop(false)
end

function NoticeDialog:OnGroupClick(group)
  self._selectedGroup = group
  for k, v in pairs(self._groups) do
    v:SetSelected(k == group)
  end
  local notice = NoticeManager.GetInGameNotice()
  if notice[group] then
    self:SetData(notice[group])
  end
end

function NoticeDialog:OnNoticeReceive(notification)
  self:OnGroupClick(self._selectedGroup)
end

function NoticeDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("notice.noticedialog")
end

function NoticeDialog:OnLinkClick(link)
  NekoData.BehaviorManager.BM_GotoLink:HandleGoto(link)
end

function NoticeDialog:OnPageClick(index)
  self._selected = index
  self:Refresh()
end

function NoticeDialog:NumberOfCell(helper)
  if helper == self._titleHelper then
    return #self._data
  elseif helper == self._contentHelperInterface then
    return #self._data[self._selected].content
  end
end

function NoticeDialog:CellAtIndex(helper, index)
  if helper == self._titleHelper then
    return "notice.noticepagecell"
  elseif helper == self._contentHelperInterface then
    local attrs = self._data[self._selected].content[index].attrs
    if attrs.img then
      return "notice.noticeimagecell"
    end
    if attrs.level then
      if attrs.level == 1 then
        return "notice.noticetitle1cell"
      elseif attrs.level == 2 then
        return "notice.noticetextcell"
      end
    end
    if attrs.align then
      if attrs.align == "right" then
        return "notice.noticesigncell"
      elseif attrs.align == "center" then
        return "notice.noticetextcentercell"
      else
        return "notice.noticetextcell"
      end
    end
    if attrs.text then
      return "notice.noticetextcell"
    end
    LogWarning("noticedialog", "Find unknown type of cell. Fallback to noticetextcell to show it.")
    return "notice.noticetextcell"
  end
end

function NoticeDialog:DataAtIndex(helper, index)
  if helper == self._titleHelper then
    return {
      index = index,
      data = self._data[index]
    }
  elseif helper == self._contentHelperInterface then
    return self._data[self._selected].content[index]
  end
end

function NoticeDialog:ShouldLengthChange(helper, index)
  return helper == self._contentHelperInterface
end

function NoticeDialog:ToggleButtonValueChanged()
  local value = self._toggleButton:GetIsOnType()
  if value then
    local nowDay = tonumber(os.date("!%Y%m%d", ServerGameTimer.GetServerTimeForecast() // 1000))
    CS.UnityEngine.PlayerPrefs.SetInt(self._lastDiableNoticeTimeKey, nowDay)
  else
    CS.UnityEngine.PlayerPrefs.SetInt(self._lastDiableNoticeTimeKey, 0)
  end
end

return NoticeDialog
