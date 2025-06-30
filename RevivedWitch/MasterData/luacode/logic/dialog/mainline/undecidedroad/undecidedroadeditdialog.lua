-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/undecidedroad/undecidedroadeditdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CentryConfig = (BeanManager.GetTableByName)("dungeonselect.centryconfig")
local CWeidingBattleConfig = (BeanManager.GetTableByName)("dungeonselect.cweidingbattleconfig")
local CWeidingTestBattleConfig = (BeanManager.GetTableByName)("dungeonselect.cweidingtestbattleconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BattleType = (LuaNetManager.CreateBean)("protocol.activity.challengerecord")
local UndecidedRoadEditDialog = class("UndecidedRoadEditDialog", Dialog)
UndecidedRoadEditDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadEditDialog.AssetName = "ActivityRoadEdit"
local EntryType = {Horizontal = 1, Vertical = 2}
UndecidedRoadEditDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UndecidedRoadEditDialog
  ((UndecidedRoadEditDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
  self._selectEntrys = {}
  self._entrys = {}
  self._score = 0
end

local GetSupportVocationTable = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local result = {}
  local temp = {}
  for _,v in pairs(self._selectEntrys) do
    local entry1 = nil
    if v <= 3 then
      entry1 = ((self._entrys)[1])[v]
    else
      entry1 = ((self._entrys)[2])[v - 3]
    end
    if entry1 and entry1.vocaid ~= 0 then
      (table.insert)(temp, entry1.vocaid)
    end
  end
  for i = 1, 7 do
    if not (table.contain)(temp, i) then
      (table.insert)(result, i)
    end
  end
  return result
end

UndecidedRoadEditDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : TableFrame, _ENV
  self._costBack = self:GetChild("CostBack")
  self._power = self:GetChild("CostBack/Txt2")
  self._powerRed = self:GetChild("CostBack/Txt2Red")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._totalScore = self:GetChild("NumPanel/Num")
  self._Tips = self:GetChild("Tips")
  self._bossImg = self:GetChild("Cell/Boss")
  self._modeTxt = self:GetChild("Cell/TitleBack/Txt")
  self._name = self:GetChild("Cell/Name")
  self._hScore = self:GetChild("Cell/Num1")
  self._rScore = self:GetChild("Cell/Num2")
  self._startBtn = self:GetChild("Cell/StartBtn")
  self._Frame1 = self:GetChild("Frame1")
  self._cell = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

    (self._cell)[i] = {}
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._cell)[i]).cell = self:GetChild("Frame1/Cell" .. i)
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._cell)[i]).desTxt = self:GetChild("Frame1/Cell" .. i .. "/Btn/Txt1")
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._cell)[i]).scoreTxt = self:GetChild("Frame1/Cell" .. i .. "/Btn/Txt2")
    -- DECOMPILER ERROR at PC99: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._cell)[i]).selectBtn = self:GetChild("Frame1/Cell" .. i .. "/Btn")
    -- DECOMPILER ERROR at PC108: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._cell)[i]).no = self:GetChild("Frame1/Cell" .. i .. "/Btn/No")
    -- DECOMPILER ERROR at PC117: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._cell)[i]).yes = self:GetChild("Frame1/Cell" .. i .. "/Btn/Yes")
  end
  ;
  (((self._cell)[1]).selectBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_0 , upvalues : self
    self:OnHorizontalCellClicked(1)
  end
, self)
  ;
  (((self._cell)[2]).selectBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_1 , upvalues : self
    self:OnHorizontalCellClicked(2)
  end
, self)
  ;
  (((self._cell)[3]).selectBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_2 , upvalues : self
    self:OnHorizontalCellClicked(3)
  end
, self)
  self._panel = self:GetChild("Frame2")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._startBtn):Subscribe_PointerClickEvent(self.OnStartBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
end

UndecidedRoadEditDialog.OnDestroy = function(self)
  -- function num : 0_3
  (self._frame):Destroy()
end

UndecidedRoadEditDialog.Init = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, BattleType, CWeidingTestBattleConfig, CWeidingBattleConfig, CImagePathTable, CentryConfig, EntryType
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  self._selectRequestSpirit = ((NekoData.BehaviorManager).BM_UndecidedRoad):GetCostNum(data.battletype)
  self._battledata = data
  ;
  (self._costBack):SetActive(false)
  local battleRecorder = nil
  if data.battletype == BattleType.TRAIN then
    battleRecorder = CWeidingTestBattleConfig:GetRecorder(data.battleId)
    ;
    (self._modeTxt):SetText((TextManager.GetText)(1901006))
  else
    battleRecorder = CWeidingBattleConfig:GetRecorder(data.battleId)
    if data.battletype == BattleType.WEEK then
      (self._modeTxt):SetText((TextManager.GetText)(1901007))
    else
      if data.battletype == BattleType.DAILY then
        local curday = ((NekoData.BehaviorManager).BM_UndecidedRoad):GetCurDay()
        ;
        (self._modeTxt):SetText((TextManager.GetText)(1901008) .. curday)
      end
    end
    do
      ;
      (self._costBack):SetActive(true)
      if self._spirit < self._selectRequestSpirit then
        (self._power):SetActive(false)
        ;
        (self._powerRed):SetActive(true)
      else
        ;
        (self._power):SetActive(true)
        ;
        (self._powerRed):SetActive(false)
      end
      ;
      (self._power):SetText(self._selectRequestSpirit)
      ;
      (self._powerRed):SetText(self._selectRequestSpirit)
      if not battleRecorder then
        LogInfoFormat("UndecidedRoadEditDialog", "CWeidingBattleConfig  Not Exsit ID: %s", data)
        return 
      end
      ;
      (self._Tips):SetText((TextManager.GetText)(1900982, battleRecorder.points))
      ;
      (self._name):SetText((TextManager.GetText)(battleRecorder.nameTextID))
      if not CImagePathTable:GetRecorder(battleRecorder.image) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._bossImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._score = battleRecorder.points
      self._basicScore = battleRecorder.points
      ;
      (self._totalScore):SetText(self._score)
      ;
      (self._hScore):SetText(data.score)
      ;
      (self._rScore):SetText(battleRecorder.recommendpoints)
      self._entrys = {}
      -- DECOMPILER ERROR at PC160: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self._entrys)[1] = {}
      -- DECOMPILER ERROR at PC163: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self._entrys)[2] = {}
      local allentrys = nil
      if data.battletype == BattleType.TRAIN then
        allentrys = CentryConfig:GetAllIds()
      else
        allentrys = battleRecorder.entryId
      end
      for _,v in pairs(allentrys) do
        local entry = CentryConfig:GetRecorder(v)
        if not entry then
          LogInfoFormat("UndecidedRoadEditDialog", "CentryConfig  Not Exsit ID: %s", v)
        end
        if entry.entrygroup == EntryType.Horizontal then
          (table.insert)((self._entrys)[1], entry)
        else
          if entry.entrygroup == EntryType.Vertical then
            (table.insert)((self._entrys)[2], entry)
          end
        end
      end
      for i = 1, #(self._entrys)[1] do
        (((self._cell)[i]).desTxt):SetText((TextManager.GetText)((((self._entrys)[1])[i]).textID))
        ;
        (((self._cell)[i]).scoreTxt):SetText((((self._entrys)[1])[i]).bonusPoints)
        ;
        (((self._cell)[i]).yes):SetActive(false)
        ;
        (((self._cell)[i]).no):SetActive(false)
      end
      do
        while #self._data > 0 do
          (table.remove)(self._data, #self._data)
        end
        self._selectEntrys = {}
        for i = 1, #(self._entrys)[2] do
          local temp = {id = i + 3, entryId = (((self._entrys)[2])[i]).id, entrytype = (((self._entrys)[2])[i]).entrytype, textID = tonumber((((self._entrys)[2])[i]).textID), bonusPoints = (((self._entrys)[2])[i]).bonusPoints, state = 0}
          ;
          (table.insert)(self._data, temp)
        end
        ;
        (self._frame):ReloadAllCell()
        ;
        (self._frame):MoveToTop()
      end
    end
  end
end

UndecidedRoadEditDialog.OnHorizontalCellClicked = function(self, id)
  -- function num : 0_5
  self:SelectCalculate(id)
end

UndecidedRoadEditDialog.OnVerticalCellClicked = function(self, id)
  -- function num : 0_6
  self:SelectCalculate(id)
end

UndecidedRoadEditDialog.SelectCalculate = function(self, id)
  -- function num : 0_7 , upvalues : _ENV
  local entry = nil
  if id <= 3 then
    entry = ((self._entrys)[1])[id]
  else
    entry = ((self._entrys)[2])[id - 3]
  end
  if not entry then
    return 
  end
  local removeList = {}
  for k = #self._selectEntrys, 1, -1 do
    local entry1 = nil
    local v = (self._selectEntrys)[k]
    if v <= 3 then
      entry1 = ((self._entrys)[1])[v]
    else
      entry1 = ((self._entrys)[2])[v - 3]
    end
    if entry.entrytype == entry1.entrytype and tonumber(v) ~= tonumber(id) then
      (table.insert)(removeList, k)
    end
  end
  for _,i in ipairs(removeList) do
    (table.remove)(self._selectEntrys, i)
  end
  local selectId = (table.indexof)(self._selectEntrys, id)
  if selectId then
    if id <= 3 then
      for i = 1, 3 do
        (((self._cell)[i]).no):SetActive(false)
        ;
        (((self._cell)[i]).yes):SetActive(false)
        ;
        (((self._cell)[i]).selectBtn):SetSelected(false)
      end
    else
      do
        for k,v in pairs(self._data) do
          -- DECOMPILER ERROR at PC107: Confused about usage of register: R10 in 'UnsetPending'

          if ((self._data)[k]).entrytype == entry.entrytype then
            ((self._data)[k]).state = 0
          end
        end
        ;
        (self._frame):FireEvent("CancelSelection", entry)
        ;
        (table.remove)(self._selectEntrys, selectId)
        if id <= 3 then
          for i = 1, 3 do
            (((self._cell)[i]).no):SetActive(true)
            ;
            (((self._cell)[i]).yes):SetActive(false)
            ;
            (((self._cell)[i]).selectBtn):SetSelected(false)
          end
          ;
          (((self._cell)[id]).no):SetActive(false)
          ;
          (((self._cell)[id]).yes):SetActive(true)
          ;
          (((self._cell)[id]).selectBtn):SetSelected(true)
        else
          for k,v in pairs(self._data) do
            -- DECOMPILER ERROR at PC177: Confused about usage of register: R10 in 'UnsetPending'

            if ((self._data)[k]).entrytype == entry.entrytype then
              ((self._data)[k]).state = 2
            end
            -- DECOMPILER ERROR at PC186: Confused about usage of register: R10 in 'UnsetPending'

            if ((self._data)[k]).entryId == entry.id then
              ((self._data)[k]).state = 1
            end
          end
          ;
          (self._frame):FireEvent("Selection", entry)
        end
        ;
        (table.insert)(self._selectEntrys, id)
        self._score = self._score + entry.bonusPoints
        local s = ""
        self._score = self._basicScore
        for k,v in pairs(self._selectEntrys) do
          s = s .. v .. ","
          local entry = nil
          if v <= 3 then
            entry = ((self._entrys)[1])[v]
          else
            entry = ((self._entrys)[2])[v - 3]
          end
          if entry then
            self._score = self._score + entry.bonusPoints
          else
            LogErrorFormat("UndecidedRoadEditDialog", "Selection No Has :%s", s)
          end
        end
        ;
        (self._totalScore):SetText(self._score)
        LogInfoFormat("UndecidedRoadEditDialog", "Selection:%s", s)
      end
    end
  end
end

UndecidedRoadEditDialog.NumberOfCell = function(self, frame)
  -- function num : 0_8
  return #self._data
end

UndecidedRoadEditDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  return "mainline.undecidedroad.undecidedroadeditcell"
end

UndecidedRoadEditDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return (self._data)[index]
end

UndecidedRoadEditDialog.OnStartBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if self._spirit < self._selectRequestSpirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cconfirmentries")
    csend.battleType = (self._battledata).battletype
    csend.battleId = (self._battledata).battleId
    local entries = {}
    for k,v in pairs(self._selectEntrys) do
      local entry1 = nil
      if v <= 3 then
        entry1 = ((self._entrys)[1])[v]
      else
        entry1 = ((self._entrys)[2])[v - 3]
      end
      ;
      (table.insert)(entries, entry1.id)
    end
    csend.entries = entries
    csend:Send()
  end
end

UndecidedRoadEditDialog.OpenTeam = function(self)
  -- function num : 0_12 , upvalues : _ENV, GetSupportVocationTable
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.undecidedroadteameditdialog")
  local supportVocationTable = GetSupportVocationTable(self)
  if #supportVocationTable == 7 then
    supportVocationTable = nil
  end
  if dialog then
    dialog:SetCopyInfo("UndecidedRoad", (self._battledata).battleId, nil, supportVocationTable)
  end
end

UndecidedRoadEditDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13
  self:Destroy()
end

UndecidedRoadEditDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

UndecidedRoadEditDialog.RefreshSpirit = function(self, notification)
  -- function num : 0_15
  self._spirit = (notification.userInfo).spirit
  if self._spirit < self._selectRequestSpirit then
    (self._power):SetActive(false)
    ;
    (self._powerRed):SetActive(true)
  else
    ;
    (self._power):SetActive(true)
    ;
    (self._powerRed):SetActive(false)
  end
end

return UndecidedRoadEditDialog

