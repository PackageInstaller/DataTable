local TowerV2RevertDialog = class("TowerEventBoxTips", Dialog)
TowerV2RevertDialog.AssetBundleName = "ui/layouts.stair"
TowerV2RevertDialog.AssetName = "StairRevert"
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

function TowerV2RevertDialog:Ctor(...)
  TowerV2RevertDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TowerV2RevertDialog:OnCreate()
  self._title = self:GetChild("BackImage/TitleBack/Title")
  self._restart = self:GetChild("RestartBtn")
  self._continue = self:GetChild("NearbyBTn")
  self._confirm = self:GetChild("ConfirmBtn")
  self._buff = self:GetChild("CardNum")
  self._count = self:GetChild("CardNum/ZhuFuNum")
  self._selected = {
    self:GetChild("RestartBtn/Choose1"),
    self:GetChild("NearbyBTn/Choose2")
  }
  LuaNotificationCenter.AddObserver(self, self.OnNewStairs, Common.n_TowerV2Refresh, nil)
  self._restart:Subscribe_PointerClickEvent(self.OnRestartClick, self)
  self._continue:Subscribe_PointerClickEvent(self.OnContinueClick, self)
  self._confirm:Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  self:OnRestartClick()
  self:Refresh()
end

function TowerV2RevertDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TowerV2RevertDialog:OnRestartClick()
  self._type = 1
  for i, v in pairs(self._selected) do
    v:SetActive(i == 1)
  end
end

function TowerV2RevertDialog:OnContinueClick()
  self._type = 2
  for i, v in pairs(self._selected) do
    v:SetActive(i == 2)
  end
end

function TowerV2RevertDialog:Refresh()
  local num = bm_towerv2:GetInitBuffChances()
  self._buff:SetActive(num ~= 0)
  self._count:SetText(num)
end

function TowerV2RevertDialog:OnConfirmClick()
  if self._clicked then
    return
  end
  bm_towerv2:Reset(self._type)
  self._clicked = true
end

function TowerV2RevertDialog:OnNewStairs()
  self:Destroy()
end

return TowerV2RevertDialog
