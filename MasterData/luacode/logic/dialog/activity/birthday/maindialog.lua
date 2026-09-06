local TabFrame = require("framework.ui.frame.tab.tabframe")
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.activitylogin"
MainDialog.AssetName = "ActivityLoginMain"

function MainDialog:Ctor(...)
  MainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function MainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._panel = self:GetChild("Frame")
  self._frame = TabFrame.Create(self._panel, self)
  self._sheetBtn = {}
  for i = 1, 2 do
    self._sheetBtn[i] = self:GetChild("Cutbtn" .. tostring(i))
    self._sheetBtn[i]:Subscribe_PointerClickEvent(function()
      self:OnSheetBtnClicked(i)
    end, self)
  end
  self:SetData()
  self:OnSheetBtnClicked(1)
end

function MainDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function MainDialog:SetData()
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
end

function MainDialog:OnSheetBtnClicked(index)
  if index == 1 then
    self:ToFramePage(1):SetData()
  else
    self._bm:SendCGetShopInfo()
  end
end

function MainDialog:OnBackBtnClicked()
  self:Destroy()
end

function MainDialog:ToFramePage(index)
  for key, value in pairs(self._sheetBtn) do
    value:SetSelected(key == index)
  end
  return self._frame:ToPage(index)
end

function MainDialog:CellAtIndex(frame, index)
  if index == 1 then
    return "activity.birthday.sheet1"
  elseif index == 2 then
    return "activity.birthday.sheet2"
  end
end

function MainDialog:ToTaskDetail(storyId)
  self:ToFramePage(1):SetData()
end

function MainDialog:OpenShop(shopID)
  self:ToFramePage(2):SetData(shopID)
end

return MainDialog
