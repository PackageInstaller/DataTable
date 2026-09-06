local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TowerShrineDialog = class("TowerEventEffectTips", Dialog)
TowerShrineDialog.AssetBundleName = "ui/layouts.mainline"
TowerShrineDialog.AssetName = "TowerEventChancel"

function TowerShrineDialog:Ctor(...)
  TowerShrineDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TowerShrineDialog:OnCreate()
  self._title = self:GetChild("TitleBack/Title")
  self._name = self:GetChild("Title")
  self._img = self:GetChild("Model")
  self._txt = self:GetChild("Text")
  self._back = self:GetChild("BackBtn")
  self._back:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn = self:GetChild("ComfirmBtn")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.Destroy, Common.n_BattleStateEnter, nil)
end

function TowerShrineDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TowerShrineDialog:SetData(index)
  self._index = index
end

function TowerShrineDialog:OnConfirmBtnClicked()
  if self._freeze then
    return
  end
  NekoData.BehaviorManager.BM_Tower:ActivateShrine(self._index)
  self._freeze = true
end

function TowerShrineDialog:OnBackBtnClicked()
  if self._freeze then
    return
  end
  DialogManager.DestroySingletonDialog("tower.towershrinedialog")
end

return TowerShrineDialog
