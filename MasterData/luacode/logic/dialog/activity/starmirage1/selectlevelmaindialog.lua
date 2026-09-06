local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local TabTypeEnum = DataCommon.Anniversary.Type
local CategoryMap = {
  [1252] = 90,
  [1253] = 91
}
local UIManager = CS.PixelNeko.UI.UIManager
local LevelStateEnum = LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode")
local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local CAnniversaryDiffculty = BeanManager.GetTableByName("dungeonselect.canniversarydiffculty")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BGMEnum = {
  [TabTypeEnum.Easy] = CAnniversaryDiffculty:GetRecorder(TabTypeEnum.Easy).bgm,
  [TabTypeEnum.Hard] = CAnniversaryDiffculty:GetRecorder(TabTypeEnum.Hard).bgm
}
local AnniversaryMainDialog = class("AnniversaryMainDialog", Dialog)
AnniversaryMainDialog.AssetBundleName = "ui/layouts.activity1yearanniversary"
AnniversaryMainDialog.AssetName = "Activity1YearAnniversaryMain"

function AnniversaryMainDialog:Ctor(...)
  AnniversaryMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._tabType = nil
  self._currencyList = {}
  self._bm = NekoData.BehaviorManager.BM_Anniversary
end

function AnniversaryMainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backImage = self:GetChild("Background")
  self._currencyPanel = self:GetChild("TopGroup")
  self._switchBtns = {
    [TabTypeEnum.Easy] = self:GetChild("TypeBtn"),
    [TabTypeEnum.Hard] = self:GetChild("TypeBtn2")
  }
  self._switchBtns = {
    [TabTypeEnum.Easy] = {
      btn = self:GetChild("TypeBtn"),
      btnSelectImg = self:GetChild("TypeBtn/Img")
    },
    [TabTypeEnum.Hard] = {
      btn = self:GetChild("TypeBtn2"),
      btnSelectImg = self:GetChild("TypeBtn2/Img")
    }
  }
  for k, v in pairs(self._switchBtns) do
    v.btn:Subscribe_PointerClickEvent(function()
      self:OnSwitchTypeBtnClicked(k)
    end)
  end
  self._tabPanel = self:GetChild("LevelPanel")
  self._tabFrame = TabFrame.Create(self._tabPanel, self)
  self._hardOpenTime = self:GetChild("Time")
  self._hardOpenTime_txt = self:GetChild("Time/Text")
  self._activityEndTips = self:GetChild("EndTxt")
  self._activityEndTips_txt = self:GetChild("EndTxt/Text")
  self._width, self._height = self._currencyPanel:GetRectSize()
  self._anchoredx, self._anchoredy = self._currencyPanel:GetAnchoredPosition()
  self._currencyFrame = TableFrame.Create(self._currencyPanel, self, false, false)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
  self:Init()
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(6)
  LuaAudioManager.StopBGM(136)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyPanel, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyPanel, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshActivity, Common.n_RefreshActivity, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshLevelList, Common.n_RefreshLevelList, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEnterMianCity, Common.n_EnterMianCity, nil)
  self:GetChild("Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2106))
  self:GetChild("TypeBtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2107))
  self:GetChild("TypeBtn2/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2108))
end

function AnniversaryMainDialog:OnDestroy()
  if self._tabType then
    NekoData.BehaviorManager.BM_Game:SetLocalCache(DataCommon.LocalCache.AnniversaryOpenType, self._tabType)
    LuaAudioManager.StopBGM(BGMEnum[self._tabType])
  end
  LuaAudioManager.PlayBGM(NekoData.BehaviorManager.BM_Game:GetMainCityBgmID())
  UIBackManager.SetUIBackShow(false)
  LuaNotificationCenter.RemoveObserver(self)
  self._currencyFrame:Destroy()
  self._tabFrame:Destroy()
  DialogManager.DestroySingletonDialog("activity.starmirage.accumulaterewarddialog")
  DialogManager.DestroySingletonDialog("activity.starmirage.shopmaindialog")
  DialogManager.DestroySingletonDialog("bag.spiritrecoverdialog")
  DialogManager.DestroySingletonDialog("activity.starmirage.bossleveldetaildialog")
  DialogManager.DestroySingletonDialog("activity.starmirage.rankmaindialog")
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  DialogManager.DestroySingletonDialog("mainline.bossrush.checkotherroleinfodialog")
end

function AnniversaryMainDialog:Init()
  self._levelMap = self._bm:GetLevelMap()
  if self._bm:CanEnterBattle() then
    self._activityEndTips:SetActive(false)
  else
    self._activityEndTips:SetActive(true)
    self._activityEndTips_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2099))
  end
end

local function RefreshSwitchTypeBtnShow(self)
  local value = self._bm:IsUnlockFunctionById(DataCommon.Anniversary.Function.Hard)
  if value == 0 then
    self._hardOpenTime:SetActive(true)
    self._switchBtns[TabTypeEnum.Hard].btn:SetInteractable(false)
    local record = CAnniversaryDiffculty:GetRecorder(TabTypeEnum.Hard)
    local levelStartStr = string.sub(record.difficultystart, 6, 16)
    local monthStr = string.sub(levelStartStr, 1, 2)
    local dayStr = string.sub(levelStartStr, 4, 5)
    local hourStr = string.sub(levelStartStr, 7, -1)
    local str = string.gsub(TextManager.GetText(1900882), "%$parameter1%$", tonumber(monthStr))
    str = string.gsub(str, "%$parameter2%$", tonumber(dayStr))
    str = string.gsub(str, "%$parameter3%$", hourStr)
    self._hardOpenTime_txt:SetText(str)
  elseif value == -1 then
    self._hardOpenTime:SetActive(false)
    self._switchBtns[TabTypeEnum.Hard].btn:SetInteractable(true)
  elseif value == 1 then
    self._hardOpenTime:SetActive(false)
    if self._tabType == TabTypeEnum.Easy then
      self._switchBtns[TabTypeEnum.Hard].btn:SetInteractable(true)
    end
  end
  self._switchBtns[TabTypeEnum.Easy].btnSelectImg:SetActive(self._tabType == TabTypeEnum.Easy)
  self._switchBtns[TabTypeEnum.Hard].btnSelectImg:SetActive(self._tabType == TabTypeEnum.Hard)
  local record = CAnniversaryDiffculty:GetRecorder(self._tabType)
  local imageRecord = CImagePathTable:GetRecorder(record.eventmainbackground) or DataCommon.DefaultImageAsset
  self._backImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function AnniversaryMainDialog:RefreshCurrencyPanel()
  while self._currencyList[#self._currencyList] do
    table.remove(self._currencyList, #self._currencyList)
  end
  table.insert(self._currencyList, DataCommon.SpiritID)
  if self._tabType == TabTypeEnum.Hard then
    table.insert(self._currencyList, DataCommon.AnniversaryCoin_Hard)
  else
    table.insert(self._currencyList, DataCommon.AnniversaryCoin_Easy)
  end
  local cellPanelWidth = self._width / 5 * #self._currencyList
  self._currencyPanel:SetSize(0, cellPanelWidth, 0, self._height)
  self._currencyPanel:SetAnchoredPosition(self._anchoredx, self._anchoredy)
  self._currencyFrame:ReloadAllCell()
end

local function SetRefreshData(self, data)
  self._refreshData = data
end

function AnniversaryMainDialog:RefreshData()
  if self._refreshData then
    local easyTag, hardTag
    for i, info in ipairs(self._refreshData) do
      if info.battletype == DataCommon.Anniversary.Type.Hard then
        hardTag = true
      else
        easyTag = true
      end
    end
    if easyTag and self._tabFrame:IsCellExist(TabTypeEnum.Easy) then
      local tabCell = self._tabFrame:GetCellAtIndex(TabTypeEnum.Easy)
      tabCell:RefreshByProtocol(self._refreshData)
    end
    if hardTag and self._tabFrame:IsCellExist(TabTypeEnum.Hard) then
      local value = self._bm:IsUnlockFunctionById(DataCommon.Anniversary.Function.Hard)
      if value == 1 then
        local tabCell = self._tabFrame:GetCellAtIndex(TabTypeEnum.Hard)
        tabCell:RefreshByProtocol(self._refreshData)
      end
    end
    self._refreshData = nil
  end
end

function AnniversaryMainDialog:OnRefreshActivity(notification)
  if notification.userInfo.activityId == DataCommon.Activities.StarMirage then
    self:Init()
    RefreshSwitchTypeBtnShow(self)
    local tabCell = self._tabFrame:GetCellAtIndex(TabTypeEnum.Easy)
    tabCell:RefreshTabCell(TabTypeEnum.Easy, self._levelMap[TabTypeEnum.Easy], false, true)
    local value = self._bm:IsUnlockFunctionById(DataCommon.StarMirage.Function.Hard)
    if value == 1 then
      tabCell = self._tabFrame:GetCellAtIndex(TabTypeEnum.Hard)
      tabCell:RefreshTabCell(TabTypeEnum.Hard, self._levelMap[TabTypeEnum.Hard], false, true)
    end
  end
end

function AnniversaryMainDialog:OnRefreshLevelList(notification)
  if notification.userInfo.activityId == DataCommon.Activities.Anniversary then
    local onlyPlotChatStatusChanged
    if #notification.userInfo.battleNodes == 1 then
      local data = notification.userInfo.battleNodes[1]
      local list = self._levelMap[data.battletype]
      if data.battletype == self._tabType and list then
        local localData
        for i, v in ipairs(list) do
          if v.levelId == data.id then
            if v.status == LevelStateEnum.UNCLEAR and data.status == LevelStateEnum.BEFORE_CLEAR then
              onlyPlotChatStatusChanged = v.levelId
            end
            break
          end
        end
      end
    end
    self:Init()
    RefreshSwitchTypeBtnShow(self)
    SetRefreshData(self, notification.userInfo.battleNodes)
    if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCity" then
      self:OnEnterMianCity()
    end
    local tabCell = self._tabFrame:GetCellAtIndex(self._tabType)
    if not onlyPlotChatStatusChanged then
      tabCell:SelectLevelById(nil)
    else
      tabCell:BeforePlotFinished(onlyPlotChatStatusChanged)
    end
  end
end

function AnniversaryMainDialog:OnEnterMianCity()
  self:RefreshData()
  LuaAudioManager.PlayBGM(BGMEnum[self._tabType])
end

function AnniversaryMainDialog:SetTabType(type)
  if self._tabType ~= type then
    if type == TabTypeEnum.Hard and self._bm:IsUnlockFunctionById(DataCommon.Anniversary.Function.Hard) ~= 1 then
      LogError("未解锁强化难度模式")
      return
    end
    self._tabType = type
    self._refreshData = nil
    RefreshSwitchTypeBtnShow(self)
    self:RefreshCurrencyPanel()
    local tabCell = self._tabFrame:ToPage(self._tabType)
    tabCell:RefreshTabCell(self._tabType, self._levelMap[self._tabType], true)
    tabCell._rootWindow:PlayAnimation("MainLevel1Show")
    DialogManager.CreateSingletonDialog("guide.blockclickdialog")
    LuaAudioManager.PlayBGM(BGMEnum[self._tabType])
  end
end

function AnniversaryMainDialog:OnSwitchTypeBtnClicked(type)
  if self._tabType == type then
    return
  end
  if not self._bm:CanEnterBattle() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100298)
    return
  end
  if type == TabTypeEnum.Hard and self._bm:IsUnlockFunctionById(DataCommon.Anniversary.Function.Hard) == -1 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100297)
    return
  end
  local tabCell = self._tabFrame:GetCellAtIndex(self._tabType)
  if tabCell._selectLevelId then
    tabCell:SelectLevelById(nil)
    return
  end
  if self._tabType == TabTypeEnum.Easy then
    self:GetRootWindow():PlayAnimation("MainLevelSwitch")
    self:SetTabType(TabTypeEnum.Hard)
  elseif self._tabType == TabTypeEnum.Hard then
    self:SetTabType(TabTypeEnum.Easy)
  end
end

function AnniversaryMainDialog:NumberOfCell(frame, index)
  if frame == self._currencyFrame then
    return #self._currencyList
  end
end

function AnniversaryMainDialog:CellAtIndex(frame, index)
  if frame == self._currencyFrame then
    return "activity.starmirage.currencycell"
  elseif frame == self._tabFrame then
    return "activity.anniversary.leveldialog"
  end
end

function AnniversaryMainDialog:DataAtIndex(frame, index)
  if frame == self._currencyFrame then
    return self._currencyList[index]
  end
end

function AnniversaryMainDialog:OnRootWindowClicked(args)
  local tabCell = self._tabFrame:GetCellAtIndex(self._tabType)
  if not UIManager.RectangleContainsScreenPoint(tabCell._detail_back._uiObject, args.position.x, args.position.y) then
    tabCell:SelectLevelById(nil)
  end
end

function AnniversaryMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function AnniversaryMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return AnniversaryMainDialog
