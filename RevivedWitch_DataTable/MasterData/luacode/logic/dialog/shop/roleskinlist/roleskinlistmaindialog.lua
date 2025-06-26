-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/roleskinlist/roleskinlistmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CUpdateUISortType = require("protocols.def.protocol.login.cupdateuisorttype")
local RoleSkin = require("logic.manager.experimental.types.roleskin")
local UIManager = ((CS.PixelNeko).UI).UIManager
local RoleSkinListMainDialog = class("BaseCharacterCellListAll", Dialog)
RoleSkinListMainDialog.AssetBundleName = "ui/layouts.baseshop"
RoleSkinListMainDialog.AssetName = "FashionShopList"
RoleSkinListMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleSkinListMainDialog
  ((RoleSkinListMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._skinList = {}
  self._screeningConditions = {}
  self._sortCriteriaNameId = 502901
  self._isAscendingOrder = false
  self._listByConditions = {}
  self._roleHelperCurPos = nil
end

RoleSkinListMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame, UIManager
  self._title = self:GetChild("Title")
  ;
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1902))
  self._cellFrame = self:GetChild("CellLargeFrame")
  self._filterBtn = self:GetChild("FliterBtn")
  self._filterBtnTxt = self:GetChild("FliterBtn/_Text")
  self._timeBtn = self:GetChild("TimeBtn")
  self._timeBtnTxt = self:GetChild("TimeBtn/_Text")
  self._sortBtn = self:GetChild("SortBtn")
  self._sortUpBtnImg = self:GetChild("SortBtn/Up")
  ;
  (self._sortUpBtnImg):SetActive(self._isAscendingOrder)
  self._sortDownBtnImg = self:GetChild("SortBtn/Down")
  ;
  (self._sortDownBtnImg):SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt = self:GetChild("SortBtn/_TextUp")
  ;
  (self._sortUpBtnTxt):SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt = self:GetChild("SortBtn/_TextDown")
  ;
  (self._sortDownBtnTxt):SetActive(not self._isAscendingOrder)
  ;
  (self._filterBtn):Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  ;
  (self._timeBtn):Subscribe_PointerClickEvent(self.OnTimeBtnClick, self)
  ;
  (self._sortBtn):Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = ((require("logic.dialog.common.filterdialog")).Create)(self._filterPanel)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._frame = (TableFrame.Create)(self._cellFrame, self, true, true)
  local ratio = (UIManager.GetScreenWHRatio)()
  if ratio > 2 then
    local wAnchor, wWidth = (self._cellFrame):GetWidth()
    local px, pox, py, poy = (self._cellFrame):GetPosition()
    local cellDialog = (DialogManager.CreateDialog)("shop.roleskinlist.roleskinlistmaincellcell", nil)
    local rootWindow = cellDialog:GetRootWindow()
    local cellWidth = rootWindow:GetRectSize()
    cellDialog:RootWindowDestroy()
    ;
    (self._cellFrame):SetWidth(wAnchor, wWidth + cellWidth)
    ;
    (self._cellFrame):SetPosition(px, pox - cellWidth / 2, py, poy)
  end
  do
    ;
    (UIBackManager.SetUIBackShow)(true)
    ;
    (UIBackManager.SetUIModalBackColor)(3)
    self._rewardBtn = self:GetChild("RewardBtn")
    self._rewardBtn_num = self:GetChild("RewardBtn/Loading/Num/Num")
    self._rewardBtn_redDot = self:GetChild("RewardBtn/Box/RedDot")
    self._rewardBtn_text = self:GetChild("RewardBtn/Loading/Num/Text")
    ;
    (self._rewardBtn):Subscribe_PointerClickEvent(self.OnRewardBtnClick, self)
    ;
    (self._rewardBtn_num):SetText(((NekoData.BehaviorManager).BM_SkinList):GetProcessStr())
    ;
    (LuaNotificationCenter.AddObserver)(self, self.RefreshRewardRedDot, Common.n_RefreshSkinCollectAwardStatus, nil)
  end
end

RoleSkinListMainDialog.Init = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._rewardBtn_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1903))
  ;
  (self._filterBtnTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2102))
  self:LoadLocalData()
  self:RefreshRewardRedDot()
end

RoleSkinListMainDialog.RefreshRewardRedDot = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._rewardBtn_redDot):SetActive(((NekoData.BehaviorManager).BM_SkinList):IsHasBoxReddot())
end

RoleSkinListMainDialog.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._filterDlg then
    (self._filterDlg):Destroy()
    self._filterDlg = nil
  end
  ;
  (DialogManager.DestroySingletonDialog)("shop.roleskinlist.roleskinlistrewarddialog")
  ;
  (self._frame):Destroy()
  self._frame = nil
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (UIBackManager.SetUIBackShow)(false)
end

RoleSkinListMainDialog.OnRefresh = function(self, notification)
  -- function num : 0_5
  self:LoadLocalData()
  if self._roleHelperCurPos and self._frame then
    (self._frame):MoveToAssignedPos(self._roleHelperCurPos)
  end
end

RoleSkinListMainDialog.LoadLocalData = function(self)
  -- function num : 0_6 , upvalues : _ENV, RoleSkin
  self._skinList = {}
  local skinlist = ((NekoData.BehaviorManager).BM_SkinList):GetSkinList()
  for skinID,_ in pairs(skinlist) do
    local roleSkin = (RoleSkin.Create)(skinID)
    ;
    (table.insert)(self._skinList, roleSkin)
  end
  self:ScreeningAndSorting()
end

RoleSkinListMainDialog.GetNumByRoleId = function(self, id)
  -- function num : 0_7 , upvalues : _ENV
  local count = 0
  for i,v in ipairs(self._listByConditions) do
    if v:GetSkinId() == id then
      count = count + 1
    end
  end
  return count
end

RoleSkinListMainDialog.ScreeningAndSorting = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (self._timeBtnTxt):SetText((TextManager.GetText)(self._sortCriteriaNameId))
  local templist = {}
  for k,v in pairs(self._skinList) do
    (table.insert)(templist, v)
  end
  for k,v in pairs(self._screeningConditions) do
    local select = false
    local indexMap = {}
    for index,value in ipairs(v) do
      select = true
      for i,skin in ipairs(templist) do
        -- DECOMPILER ERROR at PC55: Unhandled construct in 'MakeBoolean' P3

        if (value.nameid == 502897 and skin:GetYearBySkin() == 2021) or value.nameid ~= 502898 or value.nameid == 503060 and skin:GetYearBySkin() == 2023 then
          indexMap[i] = i
        end
      end
    end
    for index,value in ipairs(v) do
      for i,skin in ipairs(templist) do
        if (value.nameid == 502899 and ((NekoData.BehaviorManager).BM_SkinList):IsUnLockSkin(skin:GetSkinId())) or value.nameid == 502900 and not ((NekoData.BehaviorManager).BM_SkinList):IsUnLockSkin(skin:GetSkinId()) then
          indexMap[i] = i
        end
      end
    end
    if select then
      local deleteList = {}
      for i = 1, #templist do
        if not indexMap[i] then
          (table.insert)(deleteList, i)
        end
      end
      do
        do
          while deleteList[#deleteList] do
            (table.remove)(templist, deleteList[#deleteList])
            ;
            (table.remove)(deleteList, #deleteList)
          end
          -- DECOMPILER ERROR at PC129: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC129: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC129: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  local tempskinlist = {}
  for i,skin in ipairs(templist) do
    local year = skin:GetYearBySkin()
    if year ~= 0 then
      do
        do
          if not tempskinlist[year] then
            local temp = {}
            temp.title = year
            temp.skinlist = {}
            tempskinlist[year] = temp
          end
          ;
          (table.insert)((tempskinlist[year]).skinlist, skin)
          -- DECOMPILER ERROR at PC154: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC154: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC154: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for id,list in pairs(tempskinlist) do
    (table.sort)(list.skinlist, function(a, b)
    -- function num : 0_8_0 , upvalues : self, _ENV
    local _a, _b = nil, nil
    if self._sortCriteriaNameId == 502901 then
      _a = a:GetYearBySkin()
      _b = b:GetYearBySkin()
    end
    if not _a then
      LogError("_a", a:GetSkinId())
    end
    if not _b then
      LogError("_b", b:GetSkinId())
    end
    if _a >= _b then
      do return not self._isAscendingOrder end
      do return _b < _a end
      do return false end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  end
  do
    while (self._listByConditions)[#self._listByConditions] do
      (table.remove)(self._listByConditions, #self._listByConditions)
    end
    local tempkeyList = {}
    for k,_ in pairs(tempskinlist) do
      (table.insert)(tempkeyList, k)
    end
    ;
    (table.sort)(tempkeyList, function(a, b)
    -- function num : 0_8_1 , upvalues : self
    if self._isAscendingOrder then
      if b >= a then
        do return self._sortCriteriaNameId ~= 502901 end
        do return a < b end
        do return false end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
)
    for i,v in ipairs(tempkeyList) do
      (table.insert)(self._listByConditions, tempskinlist[v])
    end
    if self._frame then
      (self._frame):ReloadAllCell()
      ;
      (self._frame):RefreshUIParticleClipper()
    end
  end
end

RoleSkinListMainDialog.OnFilterBtnClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 1, "SkinHandBook", self._screeningConditions)
end

RoleSkinListMainDialog.OnTimeBtnClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 2, "SkinHandBook", self._sortCriteriaNameId)
end

RoleSkinListMainDialog.OnSortBtnClick = function(self)
  -- function num : 0_11
  self._isAscendingOrder = not self._isAscendingOrder
  ;
  (self._sortUpBtnImg):SetActive(self._isAscendingOrder)
  ;
  (self._sortDownBtnImg):SetActive(not self._isAscendingOrder)
  ;
  (self._sortUpBtnTxt):SetActive(self._isAscendingOrder)
  ;
  (self._sortDownBtnTxt):SetActive(not self._isAscendingOrder)
  self:ScreeningAndSorting()
end

RoleSkinListMainDialog.SetSortCriteriaNameId = function(self, nameId)
  -- function num : 0_12
  if nameId ~= self._sortCriteriaNameId then
    self._sortCriteriaNameId = nameId
    self:ScreeningAndSorting()
  end
end

RoleSkinListMainDialog.SetScreeningConditions = function(self, screeningConditions)
  -- function num : 0_13
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

RoleSkinListMainDialog.SetRoleHelperCurPos = function(self)
  -- function num : 0_14
  self._roleHelperCurPos = (self._frame):GetCurrentPosition()
end

RoleSkinListMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_15
  return #self._listByConditions
end

RoleSkinListMainDialog.CellAtIndex = function(self, frame)
  -- function num : 0_16
  if frame == self._frame then
    return "shop.roleskinlist.roleskinlistmaincell"
  end
end

RoleSkinListMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_17
  if frame == self._frame then
    return (self._listByConditions)[index]
  end
end

RoleSkinListMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_18
  self:Destroy()
end

RoleSkinListMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

RoleSkinListMainDialog.SendCUpdateUISortType = function(self)
  -- function num : 0_20
end

RoleSkinListMainDialog.ShouldLengthChange = function(self)
  -- function num : 0_21
  return true
end

RoleSkinListMainDialog.OnRewardBtnClick = function(self)
  -- function num : 0_22 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("shop.roleskinlist.roleskinlistrewarddialog")):Init()
end

RoleSkinListMainDialog.SendUnLockSkin = function(self, skinid)
  -- function num : 0_23
  (self._frame):FireEvent("UnLock", skinid)
end

return RoleSkinListMainDialog

