local UIManager = CS.PixelNeko.UI.UIManager
local CSRFunction = BeanManager.GetTableByName("activity.csrfunction")
local CSRChatConfig = BeanManager.GetTableByName("dialog.csrchatconfig")
local SwimSuitStoryMainDialog = class("SwimSuitStoryMainDialog", Dialog)
SwimSuitStoryMainDialog.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitStoryMainDialog.AssetName = "ActivitySummer2Storymain"

function SwimSuitStoryMainDialog:Ctor(...)
  SwimSuitStoryMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function SwimSuitStoryMainDialog:OnCreate()
  self._Checkbtn = self:GetChild("Checkbtn")
  self._Item = self:GetChild("Item")
  self._Detail = self:GetChild("Detail")
  self._Title = self:GetChild("Title")
  self._Name = self:GetChild("Name")
  self._Checkbtn:Subscribe_PointerClickEvent(self.OnCheckbtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function SwimSuitStoryMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function SwimSuitStoryMainDialog:SetData(data)
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local recorder = CSRFunction:GetRecorder(self._functionID)
  local chatRecorder = CSRChatConfig:GetRecorder(recorder.sectionID)
  self._chatdialogId = chatRecorder.id
  self._Name:SetText(TextManager.GetText(recorder.tagName))
  self._Detail:SetText(TextManager.GetText(recorder.destribeTextID))
end

function SwimSuitStoryMainDialog:OnCheckbtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
  if dialog then
    dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.SummerEchoes)
  end
end

function SwimSuitStoryMainDialog:OnNPCChatEnd(notification)
  if self._chatdialogId == notification.userInfo then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.csummerechoevent")
    csend.constructionID = self._constructionID
    csend.eventID = self._functionID
    csend:Send()
    self:Destroy()
  end
end

function SwimSuitStoryMainDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) and not DialogManager.GetDialog("npcchat.newnpcchatdialog") then
    self:OnBackBtnClicked()
  end
end

function SwimSuitStoryMainDialog:OnBackBtnClicked()
  self:Destroy()
end

return SwimSuitStoryMainDialog
