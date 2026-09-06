local TableFrame = require("framework.ui.frame.table.tableframe")
local CentryConfig = BeanManager.GetTableByName("dungeonselect.centryconfig")
local CWeidingBattleConfig = BeanManager.GetTableByName("dungeonselect.cweidingbattleconfig")
local CWeidingTestBattleConfig = BeanManager.GetTableByName("dungeonselect.cweidingtestbattleconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BattleType = LuaNetManager.CreateBean("protocol.activity.challengerecord")
local UndecidedRoadEditDialog = class("UndecidedRoadEditDialog", Dialog)
UndecidedRoadEditDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadEditDialog.AssetName = "ActivityRoadEdit"
local EntryType = {Horizontal = 1, Vertical = 2}

function UndecidedRoadEditDialog:Ctor(...)
  UndecidedRoadEditDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = {}
  self._selectEntrys = {}
  self._entrys = {}
  self._score = 0
end

local function GetSupportVocationTable(self)
  local result = {}
  local temp = {}
  for _, v in pairs(self._selectEntrys) do
    local entry1
    if v <= 3 then
      entry1 = self._entrys[1][v]
    else
      entry1 = self._entrys[2][v - 3]
    end
    if entry1 and entry1.vocaid ~= 0 then
      table.insert(temp, entry1.vocaid)
    end
  end
  for i = 1, 7 do
    if not table.contain(temp, i) then
      table.insert(result, i)
    end
  end
  return result
end

function UndecidedRoadEditDialog:OnCreate()
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
    self._cell[i] = {}
    self._cell[i].cell = self:GetChild("Frame1/Cell" .. i)
    self._cell[i].desTxt = self:GetChild("Frame1/Cell" .. i .. "/Btn/Txt1")
    self._cell[i].scoreTxt = self:GetChild("Frame1/Cell" .. i .. "/Btn/Txt2")
    self._cell[i].selectBtn = self:GetChild("Frame1/Cell" .. i .. "/Btn")
    self._cell[i].no = self:GetChild("Frame1/Cell" .. i .. "/Btn/No")
    self._cell[i].yes = self:GetChild("Frame1/Cell" .. i .. "/Btn/Yes")
  end
  self._cell[1].selectBtn:Subscribe_PointerClickEvent(function()
    self:OnHorizontalCellClicked(1)
  end, self)
  self._cell[2].selectBtn:Subscribe_PointerClickEvent(function()
    self:OnHorizontalCellClicked(2)
  end, self)
  self._cell[3].selectBtn:Subscribe_PointerClickEvent(function()
    self:OnHorizontalCellClicked(3)
  end, self)
  self._panel = self:GetChild("Frame2")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._startBtn:Subscribe_PointerClickEvent(self.OnStartBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
end

function UndecidedRoadEditDialog:OnDestroy()
  self._frame:Destroy()
end

function UndecidedRoadEditDialog:Init(data)
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetSpirit()
  self._selectRequestSpirit = NekoData.BehaviorManager.BM_UndecidedRoad:GetCostNum(data.battletype)
  self._battledata = data
  self._costBack:SetActive(false)
  local battleRecorder
  if data.battletype == BattleType.TRAIN then
    battleRecorder = CWeidingTestBattleConfig:GetRecorder(data.battleId)
    self._modeTxt:SetText(TextManager.GetText(1901006))
  else
    battleRecorder = CWeidingBattleConfig:GetRecorder(data.battleId)
    if data.battletype == BattleType.WEEK then
      self._modeTxt:SetText(TextManager.GetText(1901007))
    elseif data.battletype == BattleType.DAILY then
      local curday = NekoData.BehaviorManager.BM_UndecidedRoad:GetCurDay()
      self._modeTxt:SetText(TextManager.GetText(1901008) .. curday)
    end
    self._costBack:SetActive(true)
    if self._selectRequestSpirit > self._spirit then
      self._power:SetActive(false)
      self._powerRed:SetActive(true)
    else
      self._power:SetActive(true)
      self._powerRed:SetActive(false)
    end
    self._power:SetText(self._selectRequestSpirit)
    self._powerRed:SetText(self._selectRequestSpirit)
  end
  if not battleRecorder then
    LogInfoFormat("UndecidedRoadEditDialog", "CWeidingBattleConfig  Not Exsit ID: %s", data)
    return
  end
  self._Tips:SetText(TextManager.GetText(1900982, battleRecorder.points))
  self._name:SetText(TextManager.GetText(battleRecorder.nameTextID))
  local imageRecord = CImagePathTable:GetRecorder(battleRecorder.image) or DataCommon.DefaultImageAsset
  self._bossImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._score = battleRecorder.points
  self._basicScore = battleRecorder.points
  self._totalScore:SetText(self._score)
  self._hScore:SetText(data.score)
  self._rScore:SetText(battleRecorder.recommendpoints)
  self._entrys = {}
  self._entrys[1] = {}
  self._entrys[2] = {}
  local allentrys
  if data.battletype == BattleType.TRAIN then
    allentrys = CentryConfig:GetAllIds()
  else
    allentrys = battleRecorder.entryId
  end
  for _, v in pairs(allentrys) do
    local entry = CentryConfig:GetRecorder(v)
    if not entry then
      LogInfoFormat("UndecidedRoadEditDialog", "CentryConfig  Not Exsit ID: %s", v)
    end
    if entry.entrygroup == EntryType.Horizontal then
      table.insert(self._entrys[1], entry)
    elseif entry.entrygroup == EntryType.Vertical then
      table.insert(self._entrys[2], entry)
    end
  end
  for i = 1, #self._entrys[1] do
    self._cell[i].desTxt:SetText(TextManager.GetText(self._entrys[1][i].textID))
    self._cell[i].scoreTxt:SetText(self._entrys[1][i].bonusPoints)
    self._cell[i].yes:SetActive(false)
    self._cell[i].no:SetActive(false)
  end
  while #self._data > 0 do
    table.remove(self._data, #self._data)
  end
  self._selectEntrys = {}
  for i = 1, #self._entrys[2] do
    local temp = {
      id = i + 3,
      entryId = self._entrys[2][i].id,
      entrytype = self._entrys[2][i].entrytype,
      textID = tonumber(self._entrys[2][i].textID),
      bonusPoints = self._entrys[2][i].bonusPoints,
      state = 0
    }
    table.insert(self._data, temp)
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function UndecidedRoadEditDialog:OnHorizontalCellClicked(id)
  self:SelectCalculate(id)
end

function UndecidedRoadEditDialog:OnVerticalCellClicked(id)
  self:SelectCalculate(id)
end

function UndecidedRoadEditDialog:SelectCalculate(id)
  local entry
  if id <= 3 then
    entry = self._entrys[1][id]
  else
    entry = self._entrys[2][id - 3]
  end
  if not entry then
    return
  end
  local removeList = {}
  for k = #self._selectEntrys, 1, -1 do
    local entry1
    local v = self._selectEntrys[k]
    if v <= 3 then
      entry1 = self._entrys[1][v]
    else
      entry1 = self._entrys[2][v - 3]
    end
    if entry.entrytype == entry1.entrytype and tonumber(v) ~= tonumber(id) then
      table.insert(removeList, k)
    end
  end
  for _, i in ipairs(removeList) do
    table.remove(self._selectEntrys, i)
  end
  local selectId = table.indexof(self._selectEntrys, id)
  if selectId then
    if id <= 3 then
      for i = 1, 3 do
        self._cell[i].no:SetActive(false)
        self._cell[i].yes:SetActive(false)
        self._cell[i].selectBtn:SetSelected(false)
      end
    else
      for k, v in pairs(self._data) do
        if self._data[k].entrytype == entry.entrytype then
          self._data[k].state = 0
        end
      end
      self._frame:FireEvent("CancelSelection", entry)
    end
    table.remove(self._selectEntrys, selectId)
  else
    if id <= 3 then
      for i = 1, 3 do
        self._cell[i].no:SetActive(true)
        self._cell[i].yes:SetActive(false)
        self._cell[i].selectBtn:SetSelected(false)
      end
      self._cell[id].no:SetActive(false)
      self._cell[id].yes:SetActive(true)
      self._cell[id].selectBtn:SetSelected(true)
    else
      for k, v in pairs(self._data) do
        if self._data[k].entrytype == entry.entrytype then
          self._data[k].state = 2
        end
        if self._data[k].entryId == entry.id then
          self._data[k].state = 1
        end
      end
      self._frame:FireEvent("Selection", entry)
    end
    table.insert(self._selectEntrys, id)
    self._score = self._score + entry.bonusPoints
  end
  local s = ""
  self._score = self._basicScore
  for k, v in pairs(self._selectEntrys) do
    s = s .. v .. ","
    local entry
    if v <= 3 then
      entry = self._entrys[1][v]
    else
      entry = self._entrys[2][v - 3]
    end
    if entry then
      self._score = self._score + entry.bonusPoints
    else
      LogErrorFormat("UndecidedRoadEditDialog", "Selection No Has :%s", s)
    end
  end
  self._totalScore:SetText(self._score)
  LogInfoFormat("UndecidedRoadEditDialog", "Selection:%s", s)
end

function UndecidedRoadEditDialog:NumberOfCell(frame)
  return #self._data
end

function UndecidedRoadEditDialog:CellAtIndex(frame, index)
  return "mainline.undecidedroad.undecidedroadeditcell"
end

function UndecidedRoadEditDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function UndecidedRoadEditDialog:OnStartBtnClicked()
  if self._selectRequestSpirit > self._spirit then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  else
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cconfirmentries")
    csend.battleType = self._battledata.battletype
    csend.battleId = self._battledata.battleId
    local entries = {}
    for k, v in pairs(self._selectEntrys) do
      local entry1
      if v <= 3 then
        entry1 = self._entrys[1][v]
      else
        entry1 = self._entrys[2][v - 3]
      end
      table.insert(entries, entry1.id)
    end
    csend.entries = entries
    csend:Send()
  end
end

function UndecidedRoadEditDialog:OpenTeam()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.undecidedroadteameditdialog")
  local supportVocationTable = GetSupportVocationTable(self)
  if #supportVocationTable == 7 then
    supportVocationTable = nil
  end
  if dialog then
    dialog:SetCopyInfo("UndecidedRoad", self._battledata.battleId, nil, supportVocationTable)
  end
end

function UndecidedRoadEditDialog:OnBackBtnClicked()
  self:Destroy()
end

function UndecidedRoadEditDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function UndecidedRoadEditDialog:RefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
  if self._selectRequestSpirit > self._spirit then
    self._power:SetActive(false)
    self._powerRed:SetActive(true)
  else
    self._power:SetActive(true)
    self._powerRed:SetActive(false)
  end
end

return UndecidedRoadEditDialog
