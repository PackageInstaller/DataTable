-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/towereventdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TowerEventDialog = class("TowerEventStoryTips", Dialog)
TowerEventDialog.AssetBundleName = "ui/layouts.mainline"
TowerEventDialog.AssetName = "TowerEventStory"
TowerEventDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerEventDialog
  ((TowerEventDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerEventDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._title = self:GetChild("Title")
  self._name = self:GetChild("Title")
  self._story = self:GetChild("Story")
  self._select1Btn = self:GetChild("Select1")
  self._select1Txt = self:GetChild("Select1/Txt")
  self._select2Btn = self:GetChild("Select2")
  self._select2Txt = self:GetChild("Select2/Txt")
  ;
  (self._select1Btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:OnCellClick(1)
  end
, self)
  ;
  (self._select2Btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:OnCellClick(2)
  end
, self)
  self._result = {self:GetChild("Result1"), self:GetChild("Result2")}
  self._confirmBtn = self:GetChild("ComfirmBtn")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._back = self:GetChild("BackBtn")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEventResult, Common.n_TowerEventResponse, nil)
end

TowerEventDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TowerEventDialog.SetData = function(self, index, id)
  -- function num : 0_3 , upvalues : _ENV
  self._index = index
  self._cfg = ((BeanManager.GetTableByName)("dungeonselect.cstoryconfig")):GetRecorder(id)
  print(index, id, self._cfg, (debug.traceback)())
  ;
  (self._title):SetText((TextManager.GetText)((self._cfg).storyNameTextID))
  ;
  (self._story):SetText((TextManager.GetText)((self._cfg).storyContentTextID))
  ;
  (self._select1Txt):SetText((TextManager.GetText)((self._cfg).optionOneTextID))
  ;
  (self._select2Txt):SetText((TextManager.GetText)((self._cfg).optionTwoTextID))
  for _,v in pairs(self._result) do
    v:SetActive(false)
  end
  local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
end

TowerEventDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._freeze then
    return 
  end
  if not self._response and self._selected then
    ((NekoData.BehaviorManager).BM_Tower):TriggerEvent(self._index, self._selected)
    self._freeze = true
  end
  ;
  (DialogManager.DestroySingletonDialog)("tower.towereventdialog")
  if self._awardItems then
    ((DialogManager.CreateSingletonDialog)("bag.itemaccountdialog")):LoadData({items = self._awardItems})
  end
end

TowerEventDialog.OnCellClick = function(self, index)
  -- function num : 0_5
  self._selected = index
  if index == 1 then
    (self._select1Btn):SetSelected(true)
    ;
    (self._select2Btn):SetSelected(false)
  else
    if index == 2 then
      (self._select1Btn):SetSelected(false)
      ;
      (self._select2Btn):SetSelected(true)
    else
      ;
      (self._select1Btn):SetSelected(false)
      ;
      (self._select2Btn):SetSelected(false)
    end
  end
end

TowerEventDialog.OnEventResult = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  self._response = (notification.userInfo).result
  ;
  (self._story):SetActive(false)
  ;
  (self._select1Btn):SetActive(false)
  ;
  (self._select2Btn):SetActive(false)
  for _,v in pairs(self._result) do
    v:SetActive(true)
  end
  local recorder = ((BeanManager.GetTableByName)("dungeonselect.cstoryoptionconfig")):GetRecorder((notification.userInfo).result)
  ;
  ((self._result)[1]):SetText((TextManager.GetText)(recorder.optionResultDescribeTextID))
  ;
  ((self._result)[2]):SetText((TextManager.GetText)(recorder.effectDescribeTextID))
  self._freeze = false
  if #(notification.userInfo).awardItems ~= 0 then
    self._awardItems = (notification.userInfo).awardItems
  end
end

TowerEventDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self._freeze then
    return 
  end
  ;
  (DialogManager.DestroySingletonDialog)("tower.towereventdialog")
end

return TowerEventDialog

