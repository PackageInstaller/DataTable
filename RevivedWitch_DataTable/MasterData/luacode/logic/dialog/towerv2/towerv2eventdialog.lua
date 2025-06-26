-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2eventdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TowerV2EventDialog = class("TowerEventStoryTips", Dialog)
TowerV2EventDialog.AssetBundleName = "ui/layouts.mainline"
TowerV2EventDialog.AssetName = "TowerEventStory"
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
TowerV2EventDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2EventDialog
  ((TowerV2EventDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerV2EventDialog.OnCreate = function(self)
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
  (LuaNotificationCenter.AddObserver)(self, self.OnEventResult, Common.n_TowerV2Response, nil)
end

TowerV2EventDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._autoTimer then
    (GameTimer.RemoveTask)(self._autoTimer)
  end
end

TowerV2EventDialog.SetData = function(self, index, id, controller)
  -- function num : 0_3 , upvalues : _ENV, bm_towerv2
  self._controller = controller
  self._index = index
  self._id = id
  self._cfg = ((BeanManager.GetTableByName)("dungeonselect.cstairstorycfg")):GetRecorder(id)
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
  if bm_towerv2:IsInAutoExplore() then
    self._autoTimer = (GameTimer.AddTask)(1.5, 0, function()
    -- function num : 0_3_0 , upvalues : self
    if not self._selected then
      self:OnCellClick(1)
    end
    self:OnConfirmBtnClicked()
  end
)
  end
end

TowerV2EventDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._freeze then
    return 
  end
  if self._autoTimer then
    (GameTimer.RemoveTask)(self._autoTimer)
  end
  if not self._response and self._selected then
    ((NekoData.BehaviorManager).BM_TowerV2):ChooseEvent(((NekoData.BehaviorManager).BM_TowerV2):GetCurrentFloorID(), self._index - 1, self._selected)
  end
  ;
  (DialogManager.DestroySingletonDialog)("towerv2.towerv2eventdialog")
  if self._awardItems then
    ((DialogManager.CreateSingletonDialog)("bag.itemaccountdialog")):LoadData({items = self._awardItems})
  end
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if controller then
    controller:OnEventDialogDestroy()
  end
end

TowerV2EventDialog.OnCellClick = function(self, index)
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

TowerV2EventDialog.OnEventResult = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV, bm_towerv2
  self._response = notification
  ;
  (self._story):SetActive(false)
  ;
  (self._select1Btn):SetActive(false)
  ;
  (self._select2Btn):SetActive(false)
  for _,v in pairs(self._result) do
    v:SetActive(true)
  end
  local recorder = ((BeanManager.GetTableByName)("dungeonselect.cstairstoryoptioncfg")):GetRecorder(((notification.userInfo).protocol).EventID)
  ;
  ((self._result)[1]):SetText((TextManager.GetText)(recorder.optionResultDescribeTextID))
  ;
  ((self._result)[2]):SetText((TextManager.GetText)(recorder.effectDescribeTextID))
  self._freeze = false
  if bm_towerv2:IsInAutoExplore() then
    self._autoTimer = (GameTimer.AddTask)(1.5, 0, function()
    -- function num : 0_6_0 , upvalues : self
    self:OnConfirmBtnClicked()
  end
)
  end
end

TowerV2EventDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self._freeze then
    return 
  end
  ;
  (DialogManager.DestroySingletonDialog)("tower.towerv2eventdialog")
  ;
  (self._controller):OnDialogDestroy(self._index)
end

return TowerV2EventDialog

