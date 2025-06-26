-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitstorybranchdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CHexagonFunction = (BeanManager.GetTableByName)("activity.chexagonfunction")
local CHexagonChatConfig = (BeanManager.GetTableByName)("dialog.chexagonchatconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SwimSuitStoryBranchDialog = class("SwimSuitStoryBranchDialog", Dialog)
SwimSuitStoryBranchDialog.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitStoryBranchDialog.AssetName = "ActivitySummerStorybranch"
SwimSuitStoryBranchDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitStoryBranchDialog
  ((SwimSuitStoryBranchDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

SwimSuitStoryBranchDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._name = self:GetChild("Name")
  self._panel = self:GetChild("MaterialFrame")
  self._frame = (TableFrame.Create)(self._panel, self, false)
  self._checkbtn = self:GetChild("Checkbtn")
  ;
  (self._checkbtn):Subscribe_PointerClickEvent(self.OnCheckbtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

SwimSuitStoryBranchDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

SwimSuitStoryBranchDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CHexagonFunction, CHexagonChatConfig, _ENV
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local recorder = CHexagonFunction:GetRecorder(self._functionID)
  local chatRecorder = CHexagonChatConfig:GetRecorder(recorder.sectionID)
  self._chatdialogId = chatRecorder.id
  ;
  (self._name):SetText((TextManager.GetText)(chatRecorder.nameTextID))
  self._itemData = {}
  for i,v in ipairs(chatRecorder.itemID) do
    if v ~= 0 then
      local temp = {itemID = v, count = (chatRecorder.itemNum)[i]}
      ;
      (table.insert)(self._itemData, temp)
    end
  end
  ;
  (self._frame):ReloadAllCell()
end

SwimSuitStoryBranchDialog.OnCheckbtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
  if dialog then
    dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).SwimSuit)
  end
end

SwimSuitStoryBranchDialog.OnNPCChatEnd = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.csummeractivityevent")
  csend.constructionID = self._constructionID
  csend.eventID = self._functionID
  csend:Send()
  self:Destroy()
end

SwimSuitStoryBranchDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_6 , upvalues : UIManager, _ENV
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) and not (DialogManager.GetDialog)("npcchat.newnpcchatdialog") then
    self:OnBackBtnClicked()
  end
end

SwimSuitStoryBranchDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

SwimSuitStoryBranchDialog.NumberOfCell = function(self, frame)
  -- function num : 0_8
  return #self._itemData
end

SwimSuitStoryBranchDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  return "activity.swimsuit.swimsuitbattleitemcell"
end

SwimSuitStoryBranchDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return (self._itemData)[index]
end

return SwimSuitStoryBranchDialog

