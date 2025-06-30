-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/chrismascall/maindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.activitychristmascall"
MainDialog.AssetName = "ActivityChristmasCallMain"
MainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainDialog
  ((MainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

MainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._panel = self:GetChild("Frame")
  self._frame = (TabFrame.Create)(self._panel, self)
  self._sheetBtn = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

      (self._sheetBtn)[i] = {}
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._sheetBtn)[i]).root = self:GetChild("Cutbtn" .. tostring(i))
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._sheetBtn)[i]).redDot = self:GetChild("Cutbtn" .. tostring(i) .. "/RedDot")
      ;
      (((self._sheetBtn)[i]).root):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnSheetBtnClicked(i)
  end
, self)
    end
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_1 , upvalues : _ENV
    if GlobalGameFSM:GetCurrentState() ~= "Dungeon" then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100033)
    end
  end
, Common.n_OnSChristmasSupportActivityEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_2 , upvalues : self
    self:RefreshRedDot(1)
  end
, Common.n_RefreshChristmasMailRedDot, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_3 , upvalues : self
    self:RefreshRedDot(1)
  end
, Common.n_RefreshChristmasScore, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_4 , upvalues : self
    self:RefreshRedDot(1)
  end
, Common.n_OnRefreshChristmasFoodStallsStatus, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_5 , upvalues : self
    self:RefreshRedDot(2)
  end
, Common.n_OnSChristmasSupportRedpoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_6 , upvalues : self
    self:RefreshRedDot(2)
  end
, Common.n_OnLocalRefreshChristmasSupportRedpoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_7 , upvalues : self
    self:RefreshRedDot(2)
  end
, Common.n_OnSOpenChristmasSupportActivity, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_8 , upvalues : self
    self:RefreshRedDot(2)
  end
, Common.n_OnSChristmasSupportActivityEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_9 , upvalues : self
    self:RefreshRedDot(3)
  end
, Common.n_OnSChristmasSupportRedpoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_10 , upvalues : self
    self:RefreshRedDot(3)
  end
, Common.n_OnLocalRefreshChristmasSupportRedpoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_11 , upvalues : self
    self:RefreshRedDot(3)
  end
, Common.n_OnSOpenChristmasSupportActivity, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_12 , upvalues : self
    self:RefreshRedDot(3)
  end
, Common.n_OnSChristmasSupportActivityEnd, nil)
  self:SetData()
  self:OnSheetBtnClicked(1)
end

MainDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._frame then
    (self._frame):Destroy()
  end
end

MainDialog.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)):GetIsOpen() then
    self:RefreshRedDot(1)
    self:RefreshRedDot(2)
    self:RefreshRedDot(3)
  else
    for i = 1, 3 do
      (((self._sheetBtn)[i]).root):SetActive(false)
    end
  end
end

MainDialog.OnSheetBtnClicked = function(self, index)
  -- function num : 0_4 , upvalues : _ENV
  if index == 1 then
    (self:ToFramePage(1)):SetData()
  else
    if index == 2 then
      (self:ToFramePage(2)):SetData()
    else
      if (self._bm):GetShopCanOpen() then
        (self._bm):SendCGetShopInfo()
      else
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100441)
      end
    end
  end
end

MainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

MainDialog.ToFramePage = function(self, index)
  -- function num : 0_6 , upvalues : _ENV
  for key,value in pairs(self._sheetBtn) do
    (value.root):SetSelected(key == index)
  end
  do return (self._frame):ToPage(index) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

MainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if index == 1 then
    return "activity.chrismascall.sheet1"
  else
    if index == 2 then
      return "activity.chrismascall.sheet2"
    else
      return "activity.chrismascall.sheet3"
    end
  end
end

MainDialog.OpenShop = function(self, shopID)
  -- function num : 0_8
  (self:ToFramePage(3)):SetData(shopID)
end

MainDialog.ToProgressDialog = function(self, shopID)
  -- function num : 0_9
  local sheet = self:ToFramePage(2)
  sheet:SetData()
  local dialog = sheet:OnProgressBtnClicked()
  if dialog then
    dialog:OnSheetBtnClicked(2)
  end
end

MainDialog.RefreshRedDot = function(self, index)
  -- function num : 0_10 , upvalues : _ENV
  if index == 1 then
    (((self._sheetBtn)[1]).redDot):SetActive((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):ShowRedDot())
  else
    if index == 2 then
      if not (self._bm):GetRedDot(((self._bm):GetSChristmasSupportRedPointDef()).TOTAL_CALL) and not (self._bm):GetRedDot(((self._bm):GetSChristmasSupportRedPointDef()).STAGE) then
        (((self._sheetBtn)[2]).redDot):SetActive((self._bm):GetRedDot(((self._bm):GetSChristmasSupportRedPointDef()).RANKING))
        if index == 3 then
          (((self._sheetBtn)[3]).redDot):SetActive((self._bm):GetRedDot(((self._bm):GetSChristmasSupportRedPointDef()).FREE_GOOD))
        end
      end
    end
  end
end

return MainDialog

