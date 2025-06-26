-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/christmasstorymaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
local CChristmasChatConfig = (BeanManager.GetTableByName)("dialog.cchristmaschatconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ChristmasStoryMainDialog = class("ChristmasStoryMainDialog", Dialog)
ChristmasStoryMainDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasStoryMainDialog.AssetName = "ActivityChristmasStorymain"
ChristmasStoryMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChristmasStoryMainDialog
  ((ChristmasStoryMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

ChristmasStoryMainDialog.OnCreate = function(self)
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

ChristmasStoryMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ChristmasStoryMainDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CInterfaceFunction, CChristmasChatConfig, _ENV
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local recorder = CInterfaceFunction:GetRecorder(self._functionID)
  local chatRecorder = CChristmasChatConfig:GetRecorder(recorder.sectionID)
  self._chatdialogId = chatRecorder.id
  ;
  (self._Name):SetText((TextManager.GetText)(chatRecorder.nameTextID))
  ;
  (self._Detail):SetText((TextManager.GetText)(chatRecorder.destribeTextID))
end

ChristmasStoryMainDialog.OnCheckbtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
  if dialog then
    dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).Christmas)
  end
end

ChristmasStoryMainDialog.OnNPCChatEnd = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  if self._chatdialogId == notification.userInfo then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cchristmasactivityevent")
    csend.constructionID = self._constructionID
    csend.eventID = self._functionID
    csend:Send()
    self:OnBackBtnClicked()
  end
end

ChristmasStoryMainDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_6 , upvalues : UIManager, _ENV
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) and not (DialogManager.GetDialog)("npcchat.newnpcchatdialog") then
    self:OnBackBtnClicked()
  end
end

ChristmasStoryMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

return ChristmasStoryMainDialog

