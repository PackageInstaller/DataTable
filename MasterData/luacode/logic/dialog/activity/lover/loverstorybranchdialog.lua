local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CLoverInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cvalentineinterfacefunction")
local CLoverInterEntry = BeanManager.GetTableByName("dungeonselect.cvalentineinterentry")
local cvalentinechatconfig = BeanManager.GetTableByName("dialog.cvalentinechatconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local LoverStoryBranchDialog = class("LoverStoryBranchDialog", Dialog)
LoverStoryBranchDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverStoryBranchDialog.AssetName = "ActivityValentinesBranchInto"

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
  local recorder = CLoverInterfaceFunction:GetRecorder(self._functionID)
  local chatRecorder = cvalentinechatconfig:GetRecorder(recorder.sectionID)
  self._chatdialogId = chatRecorder.id
  local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
  if dialog then
    dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.Lover)
  end
end

function LoverStoryBranchDialog:Ctor(...)
  LoverStoryBranchDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function LoverStoryBranchDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._back:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
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
  self._tipText = self:GetChild("Text")
  self._tipText:SetText(TextManager.GetText(701689))
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function LoverStoryBranchDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function LoverStoryBranchDialog:SetData(data)
  self._data = data
  self._constructionID = data.constructionID
  local canGetList = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.LoverActivityManagerID):GetCanGetBuffNum()
  for i = 1, 3 do
    local recorder = CLoverInterfaceFunction:GetRecorder(data.functionID[i])
    if recorder then
      self._cell[i].name:SetText(TextManager.GetText(recorder.tagName))
      self._cell[i].text:SetText(TextManager.GetText(1901440))
      local str = TextManager.GetText(1901441, canGetList[i])
      self._cell[i].Num:SetText(str)
    else
      LogErrorFormat("LoverStoryBranchDialog", "No Exist functionIDIndex %s In Construction %s", i, data.functionID[i])
    end
  end
end

function LoverStoryBranchDialog:OnCheckbtnClicked(select)
  if self._data.functionID[select] then
    local canGetList = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.LoverActivityManagerID):GetCanGetBuffNum()
    if canGetList[select] <= 0 then
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(129, nil, function()
        TriggerStory(self, select)
      end)
      return
    end
    TriggerStory(self, select)
  else
    LogErrorFormat("LoverStoryBranchDialog", "No Exist functionIDIndex %s In Construction %s", select, self._constructionID)
  end
end

function LoverStoryBranchDialog:OnNPCChatEnd(notification)
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cloveractivityevent")
  csend.constructionID = self._constructionID
  csend.eventID = self._functionID
  csend:Send()
  self:OnBackBtnClicked()
end

function LoverStoryBranchDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self._cell[1].backNormal._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) and not UIManager.RectangleContainsScreenPoint(self._cell[2].backNormal._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) and not UIManager.RectangleContainsScreenPoint(self._cell[3].backNormal._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) and not DialogManager.GetDialog("npcchat.newnpcchatdialog") then
    self:OnBackBtnClicked()
  end
end

function LoverStoryBranchDialog:OnBackBtnClicked()
  self:Destroy()
end

function LoverStoryBranchDialog:NumberOfCell(frame)
  return #self._itemData
end

function LoverStoryBranchDialog:CellAtIndex(frame, index)
  return "activity.lover.loverbattleitemcell"
end

function LoverStoryBranchDialog:DataAtIndex(frame, index)
  return self._itemData[index]
end

return LoverStoryBranchDialog
