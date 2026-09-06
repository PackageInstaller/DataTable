local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cinterfacefunction")
local CInterEntry = BeanManager.GetTableByName("dungeonselect.cinterentry")
local CChristmasChatConfig = BeanManager.GetTableByName("dialog.cchristmaschatconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ChristmasStoryBranchDialog = class("ChristmasStoryBranchDialog", Dialog)
ChristmasStoryBranchDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasStoryBranchDialog.AssetName = "ActivityChristmasBranchInto"

local function ClickedCell(self, select)
  for i = 1, 3 do
    if i == select then
      if self._selectId ~= select then
        self._cell[i].animator:SetTrigger("Chick")
      else
        self._cell[i].animator:SetTrigger("Normal")
      end
    else
      self._cell[i].animator:SetTrigger("Normal")
    end
  end
  if self._selectId ~= select then
    self._selectId = select
  else
    self._selectId = 0
  end
end

local function TriggerStory(self, select)
  self._functionID = self._data.functionID[select]
  local recorder = CInterfaceFunction:GetRecorder(self._functionID)
  local chatRecorder = CChristmasChatConfig:GetRecorder(recorder.sectionID)
  self._chatdialogId = chatRecorder.id
  local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
  if dialog then
    dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.Christmas)
  end
end

function ChristmasStoryBranchDialog:Ctor(...)
  ChristmasStoryBranchDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID)
end

function ChristmasStoryBranchDialog:OnCreate()
  self._cell = {}
  for i = 1, 3 do
    self._cell[i] = {}
    self._cell[i].cell = self:GetChild("Cell" .. i)
    self._cell[i].name = self:GetChild("Cell" .. i .. "/nameBack/Name")
    self._cell[i].text = self:GetChild("Cell" .. i .. "/TimeBack/Text")
    self._cell[i].Num = self:GetChild("Cell" .. i .. "/TimeBack/Num1")
    self._cell[i].backNormal = self:GetChild("Cell" .. i .. "/ImageBack")
    self._cell[i].checkBtn = self:GetChild("Cell" .. i .. "/Checkbtn")
    self._cell[i].animator = self._cell[i].cell:GetUIObject():GetComponent("Animator")
    self._cell[i].checkBtn:Subscribe_PointerClickEvent(function()
      local index = i
      self:OnCheckbtnClicked(index)
    end, self)
    self._cell[i].backNormal:Subscribe_PointerClickEvent(function()
      local index = i
      ClickedCell(self, index)
    end, self)
  end
  self._BackBtn = self:GetChild("BackBtn")
  self._BackBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._bagBtn = self:GetChild("BagBtn")
  self._bagBtn:Subscribe_PointerClickEvent(self.OnBagBtnClick, self)
  self._bagText = self:GetChild("BagBtn/Text")
  self._bagText:SetText(TextManager.GetText(1901204))
  self._tipText = self:GetChild("Text")
  self._title = self:GetChild("Text (1)")
  self._title:SetText(TextManager.GetText(1901391))
  self._tipText:SetText(TextManager.GetText(701689))
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
end

function ChristmasStoryBranchDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function ChristmasStoryBranchDialog:OnBagBtnClick()
  DialogManager.CreateSingletonDialog("activity.christmas.christmasbagdialog"):SetData(self._bm:GetBuffInfo())
end

function ChristmasStoryBranchDialog:SetData(data)
  self._data = data
  self._constructionID = data.constructionID
  local canGetList = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):GetCanGetBuffNum()
  for i = 1, 3 do
    local recorder = CInterfaceFunction:GetRecorder(data.functionID[i])
    if recorder then
      self._cell[i].name:SetText(TextManager.GetText(recorder.tagName))
      self._cell[i].text:SetText(TextManager.GetText(1901440))
      local str = TextManager.GetText(1901441, canGetList[i])
      self._cell[i].Num:SetText(str)
    else
      LogErrorFormat("ChristmasStoryBranchDialog", "No Exist functionIDIndex %s In Construction %s", i, data.functionID[i])
    end
  end
end

function ChristmasStoryBranchDialog:OnCheckbtnClicked(select)
  if self._data.functionID[select] then
    local canGetList = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):GetCanGetBuffNum()
    if canGetList[select] <= 0 then
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(129, nil, function()
        TriggerStory(self, select)
      end)
      return
    end
    TriggerStory(self, select)
  else
    LogErrorFormat("ChristmasStoryBranchDialog", "No Exist functionIDIndex %s In Construction %s", select, self._constructionID)
  end
end

function ChristmasStoryBranchDialog:OnNPCChatEnd(notification)
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cchristmasactivityevent")
  csend.constructionID = self._constructionID
  csend.eventID = self._functionID
  csend:Send()
  self:OnBackBtnClicked()
end

function ChristmasStoryBranchDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChristmasStoryBranchDialog:NumberOfCell(frame)
  return #self._itemData
end

function ChristmasStoryBranchDialog:CellAtIndex(frame, index)
  return "activity.christmas.christmasbattleitemcell"
end

function ChristmasStoryBranchDialog:DataAtIndex(frame, index)
  return self._itemData[index]
end

return ChristmasStoryBranchDialog
