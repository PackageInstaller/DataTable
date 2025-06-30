-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage/selectlevelmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local TabTypeEnum = (DataCommon.StarMirage).Type
local CategoryMap = {[1252] = 90, [1253] = 91}
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local CStarryMirrorDiffculty = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrordiffculty")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local SelectLevelMainDialog = class("SelectLevelMainDialog", Dialog)
SelectLevelMainDialog.AssetBundleName = "ui/layouts.activitystar"
SelectLevelMainDialog.AssetName = "ActivityStarMain"
SelectLevelMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SelectLevelMainDialog, _ENV
  ((SelectLevelMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._tabType = nil
  self._currencyList = {}
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.StarMirageManagerID)
end

SelectLevelMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabTypeEnum, _ENV, TableFrame, TabFrame
  self._backImage = self:GetChild("Background")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._currencyPanel = self:GetChild("TopGroup")
  self._tabPanel = self:GetChild("LevelPanel")
  self._hardOpenTime = self:GetChild("Time")
  self._hardOpenTime_txt = self:GetChild("Time/Text")
  self._activityEndTips = self:GetChild("EndTxt")
  self._activityEndTips_txt = self:GetChild("EndTxt/Text")
  self._switchBtns = {[TabTypeEnum.Easy] = self:GetChild("TypeBtn"), [TabTypeEnum.Hard] = self:GetChild("TypeBtn2")}
  for k,v in pairs(self._switchBtns) do
    do
      v:Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, k
    self:OnSwitchTypeBtnClicked(k)
  end
)
    end
  end
  self._width = (self._currencyPanel):GetRectSize()
  self._anchoredx = (self._currencyPanel):GetAnchoredPosition()
  self._currencyFrame = (TableFrame.Create)(self._currencyPanel, self, false, false)
  self._tabFrame = (TabFrame.Create)(self._tabPanel, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self:Init()
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(6)
  ;
  (LuaAudioManager.StopBGM)(136)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyPanel, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyPanel, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshActivity, Common.n_RefreshActivity, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshLevelList, Common.n_RefreshLevelList, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEnterMianCity, Common.n_EnterMianCity, nil)
end

SelectLevelMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Game):SetLocalCache((DataCommon.LocalCache).StarMirageOpenType, self._tabType)
  ;
  (LuaAudioManager.PlayBGM)(((NekoData.BehaviorManager).BM_Game):GetMainCityBgmID())
  ;
  (LuaAudioManager.StopBGM)(1252)
  ;
  (LuaAudioManager.StopBGM)(1253)
  ;
  (UIBackManager.SetUIBackShow)(false)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._currencyFrame):Destroy()
  ;
  (self._tabFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("activity.starmirage.accumulaterewarddialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.starmirage.shopmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.spiritrecoverdialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.starmirage.bossleveldetaildialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.starmirage.rankmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
end

SelectLevelMainDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._levelMap = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.StarMirageManagerID)):GetLevelMap()
  if (self._bm):CanEnterBattle() then
    (self._activityEndTips):SetActive(false)
  else
    ;
    (self._activityEndTips):SetActive(true)
    ;
    (self._activityEndTips_txt):SetText((TextManager.GetText)(1900587))
  end
end

local RefreshSwitchTypeBtnShow = function(self)
  -- function num : 0_4 , upvalues : _ENV, TabTypeEnum, CStarryMirrorDiffculty, CImagePathTable
  local value = (self._bm):IsUnlockFunctionById(((DataCommon.StarMirage).Function).HardId)
  if value == 0 then
    (self._hardOpenTime):SetActive(true)
    ;
    ((self._switchBtns)[TabTypeEnum.Easy]):SetActive(false)
    ;
    ((self._switchBtns)[TabTypeEnum.Hard]):SetActive(true)
    ;
    ((self._switchBtns)[TabTypeEnum.Hard]):SetInteractable(false)
    local record = CStarryMirrorDiffculty:GetRecorder(TabTypeEnum.Hard)
    local levelStartStr = (string.sub)(record.difficultystart, 6, 16)
    local monthStr = (string.sub)(levelStartStr, 1, 2)
    local dayStr = (string.sub)(levelStartStr, 4, 5)
    local hourStr = (string.sub)(levelStartStr, 7, -1)
    local str = (string.gsub)((TextManager.GetText)(1900882), "%$parameter1%$", tonumber(monthStr))
    str = (string.gsub)(str, "%$parameter2%$", tonumber(dayStr))
    str = (string.gsub)(str, "%$parameter3%$", hourStr)
    ;
    (self._hardOpenTime_txt):SetText(str)
  else
    do
      if value == -1 then
        (self._hardOpenTime):SetActive(false)
        ;
        ((self._switchBtns)[TabTypeEnum.Easy]):SetActive(false)
        ;
        ((self._switchBtns)[TabTypeEnum.Hard]):SetActive(true)
        ;
        ((self._switchBtns)[TabTypeEnum.Hard]):SetInteractable(true)
      else
        if value == 1 then
          (self._hardOpenTime):SetActive(false)
          if self._tabType == TabTypeEnum.Easy then
            ((self._switchBtns)[TabTypeEnum.Easy]):SetActive(false)
            ;
            ((self._switchBtns)[TabTypeEnum.Hard]):SetActive(true)
            ;
            ((self._switchBtns)[TabTypeEnum.Hard]):SetInteractable(true)
          else
            if self._tabType == TabTypeEnum.Hard then
              ((self._switchBtns)[TabTypeEnum.Easy]):SetActive(true)
              ;
              ((self._switchBtns)[TabTypeEnum.Hard]):SetActive(false)
            end
          end
        end
      end
      local record = CStarryMirrorDiffculty:GetRecorder(self._tabType)
      if not CImagePathTable:GetRecorder(record.eventmainbackground) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._backImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  end
end

SelectLevelMainDialog.RefreshCurrencyPanel = function(self)
  -- function num : 0_5 , upvalues : _ENV, TabTypeEnum
  while (self._currencyList)[#self._currencyList] do
    (table.remove)(self._currencyList, #self._currencyList)
  end
  ;
  (table.insert)(self._currencyList, DataCommon.SpiritID)
  if self._tabType == TabTypeEnum.Hard then
    (table.insert)(self._currencyList, DataCommon.RedStarCoin)
  else
    ;
    (table.insert)(self._currencyList, DataCommon.StarCoin)
  end
  local cellPanelWidth = self._width / 5 * #self._currencyList
  ;
  (self._currencyPanel):SetSize(0, cellPanelWidth, 0, self._height)
  ;
  (self._currencyPanel):SetAnchoredPosition(self._anchoredx, self._anchoredy)
  ;
  (self._currencyFrame):ReloadAllCell()
end

local SetRefreshData = function(self, data)
  -- function num : 0_6
  self._refreshData = data
end

SelectLevelMainDialog.RefreshData = function(self)
  -- function num : 0_7 , upvalues : _ENV, TabTypeEnum
  if self._refreshData then
    local easyTag, hardTag = nil, nil
    for i,info in ipairs(self._refreshData) do
      if info.battletype == ((DataCommon.StarMirage).Type).Hard then
        hardTag = true
      else
        easyTag = true
      end
    end
    do
      if easyTag then
        local tabCell = (self._tabFrame):GetCellAtIndex(TabTypeEnum.Easy)
        tabCell:RefreshByProtocol(self._refreshData)
      end
      if hardTag then
        local value = (self._bm):IsUnlockFunctionById(((DataCommon.StarMirage).Function).HardId)
        if value == 1 then
          local tabCell = (self._tabFrame):GetCellAtIndex(TabTypeEnum.Hard)
          tabCell:RefreshByProtocol(self._refreshData)
        end
      end
      do
        self._refreshData = nil
      end
    end
  end
end

SelectLevelMainDialog.OnRefreshActivity = function(self, notification)
  -- function num : 0_8 , upvalues : _ENV, RefreshSwitchTypeBtnShow, TabTypeEnum
  if (notification.userInfo).activityId == (DataCommon.Activities).StarMirage then
    self:Init()
    RefreshSwitchTypeBtnShow(self)
    local tabCell = (self._tabFrame):GetCellAtIndex(TabTypeEnum.Easy)
    tabCell:RefreshTabCell((self._levelMap)[TabTypeEnum.Easy], false, true)
    local value = (self._bm):IsUnlockFunctionById(((DataCommon.StarMirage).Function).HardId)
    if value == 1 then
      tabCell = (self._tabFrame):GetCellAtIndex(TabTypeEnum.Hard)
      tabCell:RefreshTabCell((self._levelMap)[TabTypeEnum.Hard], false, true)
    end
  end
end

SelectLevelMainDialog.OnRefreshLevelList = function(self, notification)
  -- function num : 0_9 , upvalues : _ENV, RefreshSwitchTypeBtnShow, SetRefreshData
  if (notification.userInfo).activityId == (DataCommon.Activities).StarMirage then
    self:Init()
    RefreshSwitchTypeBtnShow(self)
    SetRefreshData(self, (notification.userInfo).battleNodes)
    if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCity" then
      self:OnEnterMianCity()
    end
    local tabCell = ((self._tabFrame):GetCellAtIndex(self._tabType)):SelectLevelById(nil)
  end
end

SelectLevelMainDialog.OnEnterMianCity = function(self)
  -- function num : 0_10 , upvalues : _ENV, TabTypeEnum, CategoryMap
  self:RefreshData()
  ;
  (LuaAudioManager.StopBGM)(136)
  if self._tabType == TabTypeEnum.Easy then
    (LuaAudioManager.SetCategoryVolume)(CategoryMap[1253], 0)
  else
    if self._tabType == TabTypeEnum.Hard then
      (LuaAudioManager.SetCategoryVolume)(CategoryMap[1252], 0)
    end
  end
  ;
  (LuaAudioManager.PlayBGM)(1252)
  ;
  (LuaAudioManager.PlayBGM)(1253)
end

SelectLevelMainDialog.SetTabType = function(self, type)
  -- function num : 0_11 , upvalues : RefreshSwitchTypeBtnShow, _ENV, TabTypeEnum, CategoryMap, SysConfigEnum
  if self._tabType ~= type then
    self._tabType = type
    self._refreshData = nil
    RefreshSwitchTypeBtnShow(self)
    self:RefreshCurrencyPanel()
    local tabCell = (self._tabFrame):GetCellAtIndex(self._tabType)
    ;
    (tabCell._rootWindow):PlayAnimation("MainLevel1Show")
    ;
    (self._tabFrame):ToPage(self._tabType)
    tabCell:RefreshTabCell((self._levelMap)[self._tabType], true)
    ;
    (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
    local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
    if type == TabTypeEnum.Easy then
      (LuaAudioManager.SetCategoryVolume)(CategoryMap[1252], sysConfig[SysConfigEnum.musicNum])
      ;
      (LuaAudioManager.SetCategoryVolume)(CategoryMap[1253], 0)
    else
      if type == TabTypeEnum.Hard then
        (LuaAudioManager.SetCategoryVolume)(CategoryMap[1252], 0)
        ;
        (LuaAudioManager.SetCategoryVolume)(CategoryMap[1253], sysConfig[SysConfigEnum.musicNum])
      end
    end
    ;
    (LuaAudioManager.PlayBGM)(1252, false)
    ;
    (LuaAudioManager.PlayBGM)(1253, false)
  end
end

SelectLevelMainDialog.OnSwitchTypeBtnClicked = function(self, type)
  -- function num : 0_12 , upvalues : _ENV, TabTypeEnum
  if not (self._bm):CanEnterBattle() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100298)
    return 
  end
  if type == TabTypeEnum.Hard and (self._bm):IsUnlockFunctionById(((DataCommon.StarMirage).Function).HardId) == -1 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100297)
    return 
  end
  local tabCell = (self._tabFrame):GetCellAtIndex(self._tabType)
  if tabCell._selectLevelId then
    tabCell:SelectLevelById(nil)
    return 
  end
  if self._tabType == TabTypeEnum.Easy then
    (self:GetRootWindow()):PlayAnimation("MainLevelSwitch")
    self:SetTabType(TabTypeEnum.Hard)
  else
    if self._tabType == TabTypeEnum.Hard then
      self:SetTabType(TabTypeEnum.Easy)
    end
  end
end

SelectLevelMainDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_13
  if frame == self._currencyFrame then
    return #self._currencyList
  end
end

SelectLevelMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_14 , upvalues : TabTypeEnum
  if frame == self._currencyFrame then
    return "activity.starmirage.currencycell"
  else
    if frame == self._tabFrame then
      if index == TabTypeEnum.Easy then
        return "activity.starmirage.easytabcell"
      else
        if index == TabTypeEnum.Hard then
          return "activity.starmirage.hardtabcell"
        end
      end
    end
  end
end

SelectLevelMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_15
  if frame == self._currencyFrame then
    return (self._currencyList)[index]
  end
end

SelectLevelMainDialog.OnRootWindowClicked = function(self, args)
  -- function num : 0_16 , upvalues : UIManager
  local tabCell = (self._tabFrame):GetCellAtIndex(self._tabType)
  if not (UIManager.RectangleContainsScreenPoint)((tabCell._detail_back)._uiObject, (args.position).x, (args.position).y) then
    tabCell:SelectLevelById(nil)
  end
end

SelectLevelMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_17
  self:Destroy()
end

SelectLevelMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return SelectLevelMainDialog

