-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/christmasstorybranchdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
local CInterEntry = (BeanManager.GetTableByName)("dungeonselect.cinterentry")
local CChristmasChatConfig = (BeanManager.GetTableByName)("dialog.cchristmaschatconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ChristmasStoryBranchDialog = class("ChristmasStoryBranchDialog", Dialog)
ChristmasStoryBranchDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasStoryBranchDialog.AssetName = "ActivityChristmasBranchInto"
local ClickedCell = function(self, select)
  -- function num : 0_0
  for i = 1, 3 do
    if i == select then
      if self._selectId ~= select then
        (((self._cell)[i]).animator):SetTrigger("Chick")
      else
        ;
        (((self._cell)[i]).animator):SetTrigger("Normal")
      end
    else
      ;
      (((self._cell)[i]).animator):SetTrigger("Normal")
    end
  end
  if self._selectId ~= select then
    self._selectId = select
  else
    self._selectId = 0
  end
end

local TriggerStory = function(self, select)
  -- function num : 0_1 , upvalues : CInterfaceFunction, CChristmasChatConfig, _ENV
  self._functionID = ((self._data).functionID)[select]
  local recorder = CInterfaceFunction:GetRecorder(self._functionID)
  local chatRecorder = CChristmasChatConfig:GetRecorder(recorder.sectionID)
  self._chatdialogId = chatRecorder.id
  local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
  if dialog then
    dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).Christmas)
  end
end

ChristmasStoryBranchDialog.Ctor = function(self, ...)
  -- function num : 0_2 , upvalues : ChristmasStoryBranchDialog, _ENV
  ((ChristmasStoryBranchDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)
end

ChristmasStoryBranchDialog.OnCreate = function(self)
  -- function num : 0_3 , upvalues : ClickedCell, _ENV
  self._cell = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

      (self._cell)[i] = {}
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._cell)[i]).cell = self:GetChild("Cell" .. i)
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._cell)[i]).name = self:GetChild("Cell" .. i .. "/nameBack/Name")
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._cell)[i]).text = self:GetChild("Cell" .. i .. "/TimeBack/Text")
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._cell)[i]).Num = self:GetChild("Cell" .. i .. "/TimeBack/Num1")
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._cell)[i]).backNormal = self:GetChild("Cell" .. i .. "/ImageBack")
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._cell)[i]).checkBtn = self:GetChild("Cell" .. i .. "/Checkbtn")
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._cell)[i]).animator = ((((self._cell)[i]).cell):GetUIObject()):GetComponent("Animator")
      ;
      (((self._cell)[i]).checkBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_3_0 , upvalues : i, self
    local index = i
    self:OnCheckbtnClicked(index)
  end
, self)
      ;
      (((self._cell)[i]).backNormal):Subscribe_PointerClickEvent(function()
    -- function num : 0_3_1 , upvalues : i, ClickedCell, self
    local index = i
    ClickedCell(self, index)
  end
, self)
    end
  end
  self._BackBtn = self:GetChild("BackBtn")
  ;
  (self._BackBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._bagBtn = self:GetChild("BagBtn")
  ;
  (self._bagBtn):Subscribe_PointerClickEvent(self.OnBagBtnClick, self)
  self._bagText = self:GetChild("BagBtn/Text")
  ;
  (self._bagText):SetText((TextManager.GetText)(1901204))
  self._tipText = self:GetChild("Text")
  self._title = self:GetChild("Text (1)")
  ;
  (self._title):SetText((TextManager.GetText)(1901391))
  ;
  (self._tipText):SetText((TextManager.GetText)(701689))
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
end

ChristmasStoryBranchDialog.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

ChristmasStoryBranchDialog.OnBagBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.christmas.christmasbagdialog")):SetData((self._bm):GetBuffInfo())
end

ChristmasStoryBranchDialog.SetData = function(self, data)
  -- function num : 0_6 , upvalues : _ENV, CInterfaceFunction
  self._data = data
  self._constructionID = data.constructionID
  local canGetList = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):GetCanGetBuffNum()
  for i = 1, 3 do
    local recorder = CInterfaceFunction:GetRecorder((data.functionID)[i])
    if recorder then
      (((self._cell)[i]).name):SetText((TextManager.GetText)(recorder.tagName))
      ;
      (((self._cell)[i]).text):SetText((TextManager.GetText)(1901440))
      local str = (TextManager.GetText)(1901441, canGetList[i])
      ;
      (((self._cell)[i]).Num):SetText(str)
    else
      do
        do
          LogErrorFormat("ChristmasStoryBranchDialog", "No Exist functionIDIndex %s In Construction %s", i, (data.functionID)[i])
          -- DECOMPILER ERROR at PC60: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC60: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC60: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

ChristmasStoryBranchDialog.OnCheckbtnClicked = function(self, select)
  -- function num : 0_7 , upvalues : _ENV, TriggerStory
  if ((self._data).functionID)[select] then
    local canGetList = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):GetCanGetBuffNum()
    if canGetList[select] <= 0 then
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(129, nil, function()
    -- function num : 0_7_0 , upvalues : TriggerStory, self, select
    TriggerStory(self, select)
  end
)
      return 
    end
    TriggerStory(self, select)
  else
    do
      LogErrorFormat("ChristmasStoryBranchDialog", "No Exist functionIDIndex %s In Construction %s", select, self._constructionID)
    end
  end
end

ChristmasStoryBranchDialog.OnNPCChatEnd = function(self, notification)
  -- function num : 0_8 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cchristmasactivityevent")
  csend.constructionID = self._constructionID
  csend.eventID = self._functionID
  csend:Send()
  self:OnBackBtnClicked()
end

ChristmasStoryBranchDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

ChristmasStoryBranchDialog.NumberOfCell = function(self, frame)
  -- function num : 0_10
  return #self._itemData
end

ChristmasStoryBranchDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_11
  return "activity.christmas.christmasbattleitemcell"
end

ChristmasStoryBranchDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_12
  return (self._itemData)[index]
end

return ChristmasStoryBranchDialog

