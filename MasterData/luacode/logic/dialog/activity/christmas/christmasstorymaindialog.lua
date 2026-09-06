local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cinterfacefunction")
local CChristmasChatConfig = BeanManager.GetTableByName("dialog.cchristmaschatconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ChristmasStoryMainDialog = class("ChristmasStoryMainDialog", Dialog)
ChristmasStoryMainDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasStoryMainDialog.AssetName = "ActivityChristmasStorymain"

function ChristmasStoryMainDialog:Ctor(...)
  ChristmasStoryMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function ChristmasStoryMainDialog:OnCreate()
  self._Checkbtn = self:GetChild("Checkbtn")
  self._Item = self:GetChild("Item")
  self._Detail = self:GetChild("Detail")
  self._Title = self:GetChild("Title")
  self._Name = self:GetChild("Name")
  self._Checkbtn:Subscribe_PointerClickEvent(self.OnCheckbtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function ChristmasStoryMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ChristmasStoryMainDialog:SetData(data)
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local recorder = CInterfaceFunction:GetRecorder(self._functionID)
  local chatRecorder = CChristmasChatConfig:GetRecorder(recorder.sectionID)
  self._chatdialogId = chatRecorder.id
  self._Name:SetText(TextManager.GetText(chatRecorder.nameTextID))
  self._Detail:SetText(TextManager.GetText(chatRecorder.destribeTextID))
end

function ChristmasStoryMainDialog:OnCheckbtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
  if dialog then
    dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.Christmas)
  end
end

function ChristmasStoryMainDialog:OnNPCChatEnd(notification)
  if self._chatdialogId == notification.userInfo then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cchristmasactivityevent")
    csend.constructionID = self._constructionID
    csend.eventID = self._functionID
    csend:Send()
    self:OnBackBtnClicked()
  end
end

function ChristmasStoryMainDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) and not DialogManager.GetDialog("npcchat.newnpcchatdialog") then
    self:OnBackBtnClicked()
  end
end

function ChristmasStoryMainDialog:OnBackBtnClicked()
  self:Destroy()
end

return ChristmasStoryMainDialog
