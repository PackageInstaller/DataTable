-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/lover/loverstorymaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CLoverInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cvalentineinterfacefunction")
local cvalentinechatconfig = (BeanManager.GetTableByName)("dialog.cvalentinechatconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local LoverStoryMainDialog = class("LoverStoryMainDialog", Dialog)
LoverStoryMainDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverStoryMainDialog.AssetName = "ActivityValentinesStorymain"
LoverStoryMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoverStoryMainDialog
  ((LoverStoryMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

LoverStoryMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._Checkbtn = self:GetChild("Checkbtn")
  self._Item = self:GetChild("Item")
  self._Detail = self:GetChild("Detail")
  self._Title = self:GetChild("Title")
  self._Name = self:GetChild("Name")
  ;
  (self._Checkbtn):Subscribe_PointerClickEvent(self.OnCheckbtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

LoverStoryMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

LoverStoryMainDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CLoverInterfaceFunction, cvalentinechatconfig, _ENV
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local recorder = CLoverInterfaceFunction:GetRecorder(self._functionID)
  local chatRecorder = cvalentinechatconfig:GetRecorder(recorder.sectionID)
  self._chatdialogId = chatRecorder.id
  ;
  (self._Name):SetText((TextManager.GetText)(chatRecorder.nameTextID))
  ;
  (self._Detail):SetText((TextManager.GetText)(chatRecorder.destribeTextID))
end

LoverStoryMainDialog.OnCheckbtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
  if dialog then
    dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).Lover)
  end
end

LoverStoryMainDialog.OnNPCChatEnd = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  if self._chatdialogId == notification.userInfo then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cloveractivityevent")
    csend.constructionID = self._constructionID
    csend.eventID = self._functionID
    csend:Send()
    self:OnBackBtnClicked()
  end
end

LoverStoryMainDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_6 , upvalues : UIManager, _ENV
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) and not (DialogManager.GetDialog)("npcchat.newnpcchatdialog") then
    self:OnBackBtnClicked()
  end
end

LoverStoryMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

return LoverStoryMainDialog

