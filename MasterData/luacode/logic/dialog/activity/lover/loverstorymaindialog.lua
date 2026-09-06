local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CLoverInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cvalentineinterfacefunction")
local cvalentinechatconfig = BeanManager.GetTableByName("dialog.cvalentinechatconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local LoverStoryMainDialog = class("LoverStoryMainDialog", Dialog)
LoverStoryMainDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverStoryMainDialog.AssetName = "ActivityValentinesStorymain"

function LoverStoryMainDialog:Ctor(...)
  LoverStoryMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function LoverStoryMainDialog:OnCreate()
  self._Checkbtn = self:GetChild("Checkbtn")
  self._Item = self:GetChild("Item")
  self._Detail = self:GetChild("Detail")
  self._Title = self:GetChild("Title")
  self._Name = self:GetChild("Name")
  self._Checkbtn:Subscribe_PointerClickEvent(self.OnCheckbtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function LoverStoryMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function LoverStoryMainDialog:SetData(data)
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local recorder = CLoverInterfaceFunction:GetRecorder(self._functionID)
  local chatRecorder = cvalentinechatconfig:GetRecorder(recorder.sectionID)
  self._chatdialogId = chatRecorder.id
  self._Name:SetText(TextManager.GetText(chatRecorder.nameTextID))
  self._Detail:SetText(TextManager.GetText(chatRecorder.destribeTextID))
end

function LoverStoryMainDialog:OnCheckbtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
  if dialog then
    dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.Lover)
  end
end

function LoverStoryMainDialog:OnNPCChatEnd(notification)
  if self._chatdialogId == notification.userInfo then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cloveractivityevent")
    csend.constructionID = self._constructionID
    csend.eventID = self._functionID
    csend:Send()
    self:OnBackBtnClicked()
  end
end

function LoverStoryMainDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) and not DialogManager.GetDialog("npcchat.newnpcchatdialog") then
    self:OnBackBtnClicked()
  end
end

function LoverStoryMainDialog:OnBackBtnClicked()
  self:Destroy()
end

return LoverStoryMainDialog
