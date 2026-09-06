local TabFrame = require("framework.ui.frame.tab.tabframe")
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.activitychristmascall"
MainDialog.AssetName = "ActivityChristmasCallMain"

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
  for i = 1, 3 do
    self._sheetBtn[i] = {}
    self._sheetBtn[i].root = self:GetChild("Cutbtn" .. tostring(i))
    self._sheetBtn[i].redDot = self:GetChild("Cutbtn" .. tostring(i) .. "/RedDot")
    self._sheetBtn[i].root:Subscribe_PointerClickEvent(function()
      self:OnSheetBtnClicked(i)
    end, self)
  end
  LuaNotificationCenter.AddObserver(self, function()
    if GlobalGameFSM:GetCurrentState() ~= "Dungeon" then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100033)
    end
  end, Common.n_OnSChristmasSupportActivityEnd, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshRedDot(1)
  end, Common.n_RefreshChristmasMailRedDot, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshRedDot(1)
  end, Common.n_RefreshChristmasScore, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshRedDot(1)
  end, Common.n_OnRefreshChristmasFoodStallsStatus, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshRedDot(2)
  end, Common.n_OnSChristmasSupportRedpoint, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshRedDot(2)
  end, Common.n_OnLocalRefreshChristmasSupportRedpoint, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshRedDot(2)
  end, Common.n_OnSOpenChristmasSupportActivity, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshRedDot(2)
  end, Common.n_OnSChristmasSupportActivityEnd, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshRedDot(3)
  end, Common.n_OnSChristmasSupportRedpoint, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshRedDot(3)
  end, Common.n_OnLocalRefreshChristmasSupportRedpoint, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshRedDot(3)
  end, Common.n_OnSOpenChristmasSupportActivity, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshRedDot(3)
  end, Common.n_OnSChristmasSupportActivityEnd, nil)
  self:SetData()
  self:OnSheetBtnClicked(1)
end

function MainDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function MainDialog:SetData()
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  if NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID):GetIsOpen() then
    self:RefreshRedDot(1)
    self:RefreshRedDot(2)
    self:RefreshRedDot(3)
  else
    for i = 1, 3 do
      self._sheetBtn[i].root:SetActive(false)
    end
  end
end

function MainDialog:OnSheetBtnClicked(index)
  if index == 1 then
    self:ToFramePage(1):SetData()
  elseif index == 2 then
    self:ToFramePage(2):SetData()
  elseif self._bm:GetShopCanOpen() then
    self._bm:SendCGetShopInfo()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100441)
  end
end

function MainDialog:OnBackBtnClicked()
  self:Destroy()
end

function MainDialog:ToFramePage(index)
  for key, value in pairs(self._sheetBtn) do
    value.root:SetSelected(key == index)
  end
  return self._frame:ToPage(index)
end

function MainDialog:CellAtIndex(frame, index)
  if index == 1 then
    return "activity.chrismascall.sheet1"
  elseif index == 2 then
    return "activity.chrismascall.sheet2"
  else
    return "activity.chrismascall.sheet3"
  end
end

function MainDialog:OpenShop(shopID)
  self:ToFramePage(3):SetData(shopID)
end

function MainDialog:ToProgressDialog(shopID)
  local sheet = self:ToFramePage(2)
  sheet:SetData()
  local dialog = sheet:OnProgressBtnClicked()
  if dialog then
    dialog:OnSheetBtnClicked(2)
  end
end

function MainDialog:RefreshRedDot(index)
  if index == 1 then
    self._sheetBtn[1].redDot:SetActive(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):ShowRedDot())
  elseif index == 2 then
    self._sheetBtn[2].redDot:SetActive(self._bm:GetRedDot(self._bm:GetSChristmasSupportRedPointDef().TOTAL_CALL) or self._bm:GetRedDot(self._bm:GetSChristmasSupportRedPointDef().STAGE) or self._bm:GetRedDot(self._bm:GetSChristmasSupportRedPointDef().RANKING))
  elseif index == 3 then
    self._sheetBtn[3].redDot:SetActive(self._bm:GetRedDot(self._bm:GetSChristmasSupportRedPointDef().FREE_GOOD))
  end
end

return MainDialog
