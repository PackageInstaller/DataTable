local TowerV2ShrineDialog = class("TowerV2ShrineDialog", Dialog)
TowerV2ShrineDialog.AssetBundleName = "ui/layouts.mainline"
TowerV2ShrineDialog.AssetName = "TowerEventChancel"
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

function TowerV2ShrineDialog:Ctor(...)
  TowerV2ShrineDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TowerV2ShrineDialog:OnCreate()
  self._title = self:GetChild("TitleBack/Title")
  self._name = self:GetChild("Title")
  self._img = self:GetChild("Model")
  self._txt = self:GetChild("Text")
  self._back = self:GetChild("BackBtn")
  self._back:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn = self:GetChild("ComfirmBtn")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnStairFinish, Common.n_TowerV2Response, nil)
  LuaNotificationCenter.AddObserver(self, self.Destroy, Common.n_BattleStateEnter, nil)
end

function TowerV2ShrineDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._autoTimer then
    GameTimer.RemoveTask(self._autoTimer)
  end
end

function TowerV2ShrineDialog:SetData(id, index, controller)
  self._controller = controller
  self._id = id
  self._index = index
  if bm_towerv2:IsInAutoExplore() then
    self._autoTimer = GameTimer.AddTask(1.5, 0, function()
      self:OnConfirmBtnClicked()
    end)
  end
end

function TowerV2ShrineDialog:OnConfirmBtnClicked()
  if self._freeze then
    return
  end
  NekoData.BehaviorManager.BM_TowerV2:ChooseEvent(NekoData.BehaviorManager.BM_TowerV2:GetCurrentFloorID(), self._index - 1, 0)
  self._freeze = true
end

function TowerV2ShrineDialog:OnBackBtnClicked()
  if self._freeze then
    return
  end
  DialogManager.DestroySingletonDialog("towerv2.towerv2shrinedialog")
  self._controller:OnDialogDestroy(self._index)
end

function TowerV2ShrineDialog:OnStairFinish()
  DialogManager.DestroySingletonDialog("towerv2.towerv2shrinedialog")
end

return TowerV2ShrineDialog
