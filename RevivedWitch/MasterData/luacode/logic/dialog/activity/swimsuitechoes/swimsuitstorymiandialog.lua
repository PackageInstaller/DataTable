-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/swimsuitstorymiandialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CSRFunction = (BeanManager.GetTableByName)("activity.csrfunction")
local CSRChatConfig = (BeanManager.GetTableByName)("dialog.csrchatconfig")
local SwimSuitStoryMainDialog = class("SwimSuitStoryMainDialog", Dialog)
SwimSuitStoryMainDialog.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitStoryMainDialog.AssetName = "ActivitySummer2Storymain"
SwimSuitStoryMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitStoryMainDialog
  ((SwimSuitStoryMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

SwimSuitStoryMainDialog.OnCreate = function(self)
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

SwimSuitStoryMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SwimSuitStoryMainDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CSRFunction, CSRChatConfig, _ENV
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local recorder = CSRFunction:GetRecorder(self._functionID)
  local chatRecorder = CSRChatConfig:GetRecorder(recorder.sectionID)
  self._chatdialogId = chatRecorder.id
  ;
  (self._Name):SetText((TextManager.GetText)(recorder.tagName))
  ;
  (self._Detail):SetText((TextManager.GetText)(recorder.destribeTextID))
end

SwimSuitStoryMainDialog.OnCheckbtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
  if dialog then
    dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).SummerEchoes)
  end
end

SwimSuitStoryMainDialog.OnNPCChatEnd = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  if self._chatdialogId == notification.userInfo then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.csummerechoevent")
    csend.constructionID = self._constructionID
    csend.eventID = self._functionID
    csend:Send()
    self:Destroy()
  end
end

SwimSuitStoryMainDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_6 , upvalues : UIManager, _ENV
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) and not (DialogManager.GetDialog)("npcchat.newnpcchatdialog") then
    self:OnBackBtnClicked()
  end
end

SwimSuitStoryMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

return SwimSuitStoryMainDialog

