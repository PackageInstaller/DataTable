local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TowerV2EventDialog = class("TowerEventStoryTips", Dialog)
TowerV2EventDialog.AssetBundleName = "ui/layouts.mainline"
TowerV2EventDialog.AssetName = "TowerEventStory"
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

function TowerV2EventDialog:Ctor(...)
  TowerV2EventDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TowerV2EventDialog:OnCreate()
  self._title = self:GetChild("Title")
  self._name = self:GetChild("Title")
  self._story = self:GetChild("Story")
  self._select1Btn = self:GetChild("Select1")
  self._select1Txt = self:GetChild("Select1/Txt")
  self._select2Btn = self:GetChild("Select2")
  self._select2Txt = self:GetChild("Select2/Txt")
  self._select1Btn:Subscribe_PointerClickEvent(function()
    self:OnCellClick(1)
  end, self)
  self._select2Btn:Subscribe_PointerClickEvent(function()
    self:OnCellClick(2)
  end, self)
  self._result = {
    self:GetChild("Result1"),
    self:GetChild("Result2")
  }
  self._confirmBtn = self:GetChild("ComfirmBtn")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._back = self:GetChild("BackBtn")
  self._back:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnEventResult, Common.n_TowerV2Response, nil)
  LuaNotificationCenter.AddObserver(self, self.Destroy, Common.n_BattleStateEnter, nil)
end

function TowerV2EventDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._autoTimer then
    GameTimer.RemoveTask(self._autoTimer)
  end
end

function TowerV2EventDialog:SetData(index, id, controller)
  self._controller = controller
  self._index = index
  self._id = id
  self._cfg = BeanManager.GetTableByName("dungeonselect.cstairstorycfg"):GetRecorder(id)
  self._title:SetText(TextManager.GetText(self._cfg.storyNameTextID))
  self._story:SetText(TextManager.GetText(self._cfg.storyContentTextID))
  self._select1Txt:SetText(TextManager.GetText(self._cfg.optionOneTextID))
  self._select2Txt:SetText(TextManager.GetText(self._cfg.optionTwoTextID))
  for _, v in pairs(self._result) do
    v:SetActive(false)
  end
  if bm_towerv2:IsInAutoExplore() then
    self._autoTimer = GameTimer.AddTask(1.5, 0, function()
      if not self._selected then
        self:OnCellClick(1)
      end
      self:OnConfirmBtnClicked()
    end)
  end
end

function TowerV2EventDialog:OnConfirmBtnClicked()
  if self._freeze then
    return
  end
  if self._autoTimer then
    GameTimer.RemoveTask(self._autoTimer)
  end
  if not self._response then
    if self._selected then
      NekoData.BehaviorManager.BM_TowerV2:ChooseEvent(NekoData.BehaviorManager.BM_TowerV2:GetCurrentFloorID(), self._index - 1, self._selected)
    end
  else
    DialogManager.DestroySingletonDialog("towerv2.towerv2eventdialog")
    if self._awardItems then
      DialogManager.CreateSingletonDialog("bag.itemaccountdialog"):LoadData({
        items = self._awardItems
      })
    end
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if controller then
      controller:OnEventDialogDestroy()
    end
  end
end

function TowerV2EventDialog:OnCellClick(index)
  self._selected = index
  if index == 1 then
    self._select1Btn:SetSelected(true)
    self._select2Btn:SetSelected(false)
  elseif index == 2 then
    self._select1Btn:SetSelected(false)
    self._select2Btn:SetSelected(true)
  else
    self._select1Btn:SetSelected(false)
    self._select2Btn:SetSelected(false)
  end
end

function TowerV2EventDialog:OnEventResult(notification)
  self._response = notification
  self._story:SetActive(false)
  self._select1Btn:SetActive(false)
  self._select2Btn:SetActive(false)
  for _, v in pairs(self._result) do
    v:SetActive(true)
  end
  local recorder = BeanManager.GetTableByName("dungeonselect.cstairstoryoptioncfg"):GetRecorder(notification.userInfo.protocol.EventID)
  self._result[1]:SetText(TextManager.GetText(recorder.optionResultDescribeTextID))
  self._result[2]:SetText(TextManager.GetText(recorder.effectDescribeTextID))
  self._freeze = false
  if bm_towerv2:IsInAutoExplore() then
    self._autoTimer = GameTimer.AddTask(1.5, 0, function()
      self:OnConfirmBtnClicked()
    end)
  end
end

function TowerV2EventDialog:OnBackBtnClicked()
  if self._freeze then
    return
  end
  DialogManager.DestroySingletonDialog("tower.towerv2eventdialog")
  self._controller:OnDialogDestroy(self._index)
end

return TowerV2EventDialog
