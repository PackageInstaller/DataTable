local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CHexagonFunction = BeanManager.GetTableByName("activity.chexagonfunction")
local CHexagonChatConfig = BeanManager.GetTableByName("dialog.chexagonchatconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SwimSuitStoryBranchDialog = class("SwimSuitStoryBranchDialog", Dialog)
SwimSuitStoryBranchDialog.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitStoryBranchDialog.AssetName = "ActivitySummerStorybranch"

function SwimSuitStoryBranchDialog:Ctor(...)
  SwimSuitStoryBranchDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function SwimSuitStoryBranchDialog:OnCreate()
  self._name = self:GetChild("Name")
  self._panel = self:GetChild("MaterialFrame")
  self._frame = TableFrame.Create(self._panel, self, false)
  self._checkbtn = self:GetChild("Checkbtn")
  self._checkbtn:Subscribe_PointerClickEvent(self.OnCheckbtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function SwimSuitStoryBranchDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function SwimSuitStoryBranchDialog:SetData(data)
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local recorder = CHexagonFunction:GetRecorder(self._functionID)
  local chatRecorder = CHexagonChatConfig:GetRecorder(recorder.sectionID)
  self._chatdialogId = chatRecorder.id
  self._name:SetText(TextManager.GetText(chatRecorder.nameTextID))
  self._itemData = {}
  for i, v in ipairs(chatRecorder.itemID) do
    if v ~= 0 then
      local temp = {
        itemID = v,
        count = chatRecorder.itemNum[i]
      }
      table.insert(self._itemData, temp)
    end
  end
  self._frame:ReloadAllCell()
end

function SwimSuitStoryBranchDialog:OnCheckbtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
  if dialog then
    dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.SwimSuit)
  end
end

function SwimSuitStoryBranchDialog:OnNPCChatEnd(notification)
  local csend = LuaNetManager.CreateProtocol("protocol.activity.csummeractivityevent")
  csend.constructionID = self._constructionID
  csend.eventID = self._functionID
  csend:Send()
  self:Destroy()
end

function SwimSuitStoryBranchDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) and not DialogManager.GetDialog("npcchat.newnpcchatdialog") then
    self:OnBackBtnClicked()
  end
end

function SwimSuitStoryBranchDialog:OnBackBtnClicked()
  self:Destroy()
end

function SwimSuitStoryBranchDialog:NumberOfCell(frame)
  return #self._itemData
end

function SwimSuitStoryBranchDialog:CellAtIndex(frame, index)
  return "activity.swimsuit.swimsuitbattleitemcell"
end

function SwimSuitStoryBranchDialog:DataAtIndex(frame, index)
  return self._itemData[index]
end

return SwimSuitStoryBranchDialog
